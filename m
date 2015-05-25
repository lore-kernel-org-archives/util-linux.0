Return-Path: sbrabec@suse.cz
Message-ID: <55634C10.5090700@suse.cz>
Date: Mon, 25 May 2015 18:21:36 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH] Fix /sys to /dev node name translation
References: <555A3E16.6090003@suse.cz> <20150519080829.GO4834@ws.net.home> <555B2E2A.6000003@suse.cz> <20150521111134.GB4730@ws.net.home> <555F349D.7080706@suse.cz>
In-Reply-To: <555F349D.7080706@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

linux/drivers/base/core.c: device_get_devnode() defines a translation of
'!' in sysfs nodes to '/' in /dev nodes. The same translation has to be
done to properly support device nodes with slash (e. g. device nodes of
cciss driver and several other drivers).

Introduce new helper sysfs_devname_to_devno() and use it where
appropriate.

Fixes for example lsblk -f on devices using cciss driver.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 include/sysfs.h      | 18 ++++++++++++++++++
 lib/sysfs.c          |  2 ++
 libblkid/src/devno.c |  1 +
 misc-utils/lsblk.c   |  1 +
 4 files changed, 22 insertions(+)

diff --git a/include/sysfs.h b/include/sysfs.h
index 1de624a..4564124 100644
--- a/include/sysfs.h
+++ b/include/sysfs.h
@@ -91,4 +91,22 @@ extern int sysfs_scsi_host_is(struct sysfs_cxt *cxt, const char *type);
 extern int sysfs_scsi_has_attribute(struct sysfs_cxt *cxt, const char *attr);
 extern int sysfs_scsi_path_contains(struct sysfs_cxt *cxt, const char *pattern);
 
+/**
+ * sysfs_devname_to_dev_name:
+ * @name: devname to be converted in place
+ *
+ * Linux kernel linux/drivers/base/core.c: device_get_devnode()
+ * defines a replacement of '!' in the /sys device name by '/' in the
+ * /dev device name. This helper replaces all ocurrences of '!' in
+ * @name by '/'.
+ */
+static inline void sysfs_devname_to_dev_name (char *name)
+{
+	char *c;
+
+	if (name)
+		while ((c = strchr(name, '!')))
+			c[0] = '/';
+}
+
 #endif /* UTIL_LINUX_SYSFS_H */
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 759d97b..8417d2d 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -131,6 +131,7 @@ char *sysfs_devno_to_devpath(dev_t devno, char *buf, size_t bufsiz)
 		return NULL;
 
 	/* create the final "/dev/<name>" string */
+	sysfs_devname_to_dev_name(name);
 	memmove(buf + 5, name, sz + 1);
 	memcpy(buf, "/dev/", 5);
 
@@ -789,6 +790,7 @@ int sysfs_devno_to_wholedisk(dev_t dev, char *diskname,
         if (!name)
             goto err;
 
+	sysfs_devname_to_dev_name(name);
         if (diskname && len) {
             strncpy(diskname, name, len);
             diskname[len - 1] = '\0';
diff --git a/libblkid/src/devno.c b/libblkid/src/devno.c
index f4a36e4..3c08227 100644
--- a/libblkid/src/devno.c
+++ b/libblkid/src/devno.c
@@ -208,6 +208,7 @@ static char *scandev_devno_to_devpath(dev_t devno)
 			new_list = NULL;
 		}
 	}
+	sysfs_devname_to_dev_name(devname);
 	free_dirlist(&list);
 	free_dirlist(&new_list);
 
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 1b4ffc1..d826c77 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -421,6 +421,7 @@ static char *get_device_path(struct blkdev_cxt *cxt)
 		return canonicalize_dm_name(cxt->name);
 
 	snprintf(path, sizeof(path), "/dev/%s", cxt->name);
+	sysfs_devname_to_dev_name(path);
 	return xstrdup(path);
 }
 
-- 
2.4.1

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
