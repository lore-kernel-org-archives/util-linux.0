Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:39907 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753919AbbERTbg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 May 2015 15:31:36 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 903DCABB3
	for <util-linux@vger.kernel.org>; Mon, 18 May 2015 19:31:34 +0000 (UTC)
Message-ID: <555A3E16.6090003@suse.cz>
Date: Mon, 18 May 2015 21:31:34 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix /sys to /dev node name translation
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

linux/drivers/base/core.c: device_get_devnode() defines a translation of
'!' in sysfs nodes to '/' in /dev nodes. The same translation has to be
done to properly support device nodes with slash (e. g. device nodes of
cciss driver and several other drivers).

Replace '!' by '/' in sysfs_devno_to_devpath() exactly like kernel does.

The problem is spread across more places of the code.

One of the chunks fixes lsblk -f, other chunks fixes code that apparently
assumes that /sys/block and /dev node names are the same, however I do
not have any reproducer for them. I fixed all places I found, but it is
possible that there are even more occurrences.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 lib/sysfs.c          | 14 ++++++++++++--
 libblkid/src/devno.c |  7 ++++++-
 misc-utils/lsblk.c   |  7 +++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 759d97b..ffdc8a1 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -112,7 +112,7 @@ dev_t sysfs_devname_to_devno(const char *name, const char *parent)
 char *sysfs_devno_to_devpath(dev_t devno, char *buf, size_t bufsiz)
 {
 	struct sysfs_cxt cxt;
-	char *name;
+	char *name, *s;
 	size_t sz;
 	struct stat st;
 
@@ -130,6 +130,11 @@ char *sysfs_devno_to_devpath(dev_t devno, char *buf, size_t bufsiz)
 	if (sz + sizeof("/dev/") > bufsiz)
 		return NULL;
 
+	/* replace '!' in the name with '/', see
+	 * linux/drivers/base/core.c: device_get_devnode() */
+	while ((s = strchr(name, '!')))
+		s[0] = '/';
+
 	/* create the final "/dev/<name>" string */
 	memmove(buf + 5, name, sz + 1);
 	memcpy(buf, "/dev/", 5);
@@ -776,7 +781,7 @@ int sysfs_devno_to_wholedisk(dev_t dev, char *diskname,
          *  - basename ../../block/sda      = sda
          */
         char linkpath[PATH_MAX];
-        char *name;
+        char *name, *s;
 	ssize_t	linklen;
 
 	linklen = sysfs_readlink(&cxt, NULL, linkpath, sizeof(linkpath) - 1);
@@ -789,6 +794,11 @@ int sysfs_devno_to_wholedisk(dev_t dev, char *diskname,
         if (!name)
             goto err;
 
+	/* replace '!' in the name with '/', see
+	 * linux/drivers/base/core.c: device_get_devnode() */
+	while ((s = strchr(name, '!')))
+		s[0] = '/';
+
         if (diskname && len) {
             strncpy(diskname, name, len);
             diskname[len - 1] = '\0';
diff --git a/libblkid/src/devno.c b/libblkid/src/devno.c
index f4a36e4..cedd2db 100644
--- a/libblkid/src/devno.c
+++ b/libblkid/src/devno.c
@@ -179,7 +179,7 @@ static const char *devdirs[] = { "/devices", "/devfs", "/dev", NULL };
 static char *scandev_devno_to_devpath(dev_t devno)
 {
 	struct dir_list *list = NULL, *new_list = NULL;
-	char *devname = NULL;
+	char *devname = NULL, *s;
 	const char **dir;
 
 	/*
@@ -208,6 +208,11 @@ static char *scandev_devno_to_devpath(dev_t devno)
 			new_list = NULL;
 		}
 	}
+	/* replace '!' in the name with '/', see
+	 * linux/drivers/base/core.c: device_get_devnode() */
+	if (devname)
+		while ((s = strchr(devname, '!')))
+			s[0] = '/';
 	free_dirlist(&list);
 	free_dirlist(&new_list);
 
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 1b4ffc1..5cdae7d 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -413,6 +413,7 @@ static struct dirent *xreaddir(DIR *dp)
 static char *get_device_path(struct blkdev_cxt *cxt)
 {
 	char path[PATH_MAX];
+	char *s;
 
 	assert(cxt);
 	assert(cxt->name);
@@ -421,6 +422,12 @@ static char *get_device_path(struct blkdev_cxt *cxt)
 		return canonicalize_dm_name(cxt->name);
 
 	snprintf(path, sizeof(path), "/dev/%s", cxt->name);
+
+	/* replace '!' in the name with '/', see
+	 * linux/drivers/base/core.c: device_get_devnode() */
+	while ((s = strchr(path, '!')))
+		s[0] = '/';
+
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
