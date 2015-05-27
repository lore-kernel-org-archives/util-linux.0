Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:42549 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbbE0NML (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 27 May 2015 09:12:11 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 7C322AC8D
	for <util-linux@vger.kernel.org>; Wed, 27 May 2015 13:12:09 +0000 (UTC)
Message-ID: <5565C2A8.1070505@suse.cz>
Date: Wed, 27 May 2015 15:12:08 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix /dev to /sys node name translation
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

d0dc6c1 introduced translation of /sys names to /dev names, as required
by the kernel linux/drivers/base/core.c: device_get_devnode(). But there
are other places of code that use /dev names in /sys. They need reverse
translation from '/' to '!'.

For example, fdisk -l returns empty list since a22c6eb for device nodes
in subdirectories (used e. g. by cciss driver).

Introduce yet another helper sysfs_dev_name_to_devname() and use it where
appropriate.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 include/sysfs.h | 20 +++++++++++++++++++-
 lib/sysfs.c     |  8 ++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/sysfs.h b/include/sysfs.h
index 4564124..6b08bbe 100644
--- a/include/sysfs.h
+++ b/include/sysfs.h
@@ -98,7 +98,7 @@ extern int sysfs_scsi_path_contains(struct sysfs_cxt *cxt, const char *pattern);
  * Linux kernel linux/drivers/base/core.c: device_get_devnode()
  * defines a replacement of '!' in the /sys device name by '/' in the
  * /dev device name. This helper replaces all ocurrences of '!' in
- * @name by '/'.
+ * @name by '/' to convert from /sys to /dev.
  */
 static inline void sysfs_devname_to_dev_name (char *name)
 {
@@ -109,4 +109,22 @@ static inline void sysfs_devname_to_dev_name (char *name)
 			c[0] = '/';
 }
 
+/**
+ * sysfs_dev_name_to_devname:
+ * @name: devname to be converted in place
+ *
+ * Linux kernel linux/drivers/base/core.c: device_get_devnode()
+ * defines a replacement of '!' in the /sys device name by '/' in the
+ * /dev device name. This helper replaces all ocurrences of '/' in
+ * @name by '!' to convert from /dev to /sys.
+ */
+static inline void sysfs_dev_name_to_devname (char *name)
+{
+	char *c;
+
+	if (name)
+		while ((c = strchr(name, '/')))
+			c[0] = '!';
+}
+
 #endif /* UTIL_LINUX_SYSFS_H */
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 8417d2d..34a5207 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -74,10 +74,14 @@ dev_t sysfs_devname_to_devno(const char *name, const char *parent)
 
 	} else if (!dev) {
 		/*
-		 * Create path to /sys/block/<name>/dev
+		 * Create path to /sys/block/<sysname>/dev
 		 */
+		char sysname[PATH_MAX];
+
+		strncpy(sysname, name, sizeof(sysname));
+		sysfs_dev_name_to_devname(sysname);
 		int len = snprintf(buf, sizeof(buf),
-				_PATH_SYS_BLOCK "/%s/dev", name);
+				_PATH_SYS_BLOCK "/%s/dev", sysname);
 		if (len < 0 || (size_t) len + 1 > sizeof(buf))
 			return 0;
 		path = buf;
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
