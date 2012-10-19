Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051Ab2JSMKv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Oct 2012 08:10:51 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9JCApKn016289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 19 Oct 2012 08:10:51 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 3/3] lsblk: add SCSI transport type attribute
Date: Fri, 19 Oct 2012 14:10:41 +0200
Message-Id: <1350648641-19388-3-git-send-email-mbroz@redhat.com>
In-Reply-To: <1350648641-19388-1-git-send-email-mbroz@redhat.com>
References: <1350648641-19388-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Patch adds "SCSI transport layer" similar attribute to "lsscsi -t".

This is useful for script where you want to distinguish e.g. FC, iSCSI
or USB devices from local disks.

Detection logic is quite simplified in comparison to lsscsi but it
should provide the same output (except detailed transport attributes).

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/lsblk.c |  131 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 7101eed..547723c 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -99,6 +99,7 @@ enum {
 	COL_RAND,
 	COL_PKNAME,
 	COL_HCTL,
+	COL_TRANSPORT,
 };
 
 /* column names */
@@ -148,6 +149,7 @@ static struct colinfo infos[] = {
 	[COL_DZERO]  = { "DISC-ZERO", 1, TT_FL_RIGHT, N_("discard zeroes data") },
 	[COL_WWN]    = { "WWN",     18, 0, N_("unique storage identifier") },
 	[COL_HCTL]   = { "HCTL", 10, 0, N_("Host:Channel:Target:Lun for SCSI") },
+	[COL_TRANSPORT] = { "TRAN", 6, 0, N_("device transport type") },
 };
 
 struct lsblk {
@@ -596,6 +598,130 @@ static int get_hctl(struct blkdev_cxt *cxt, int *h, int *c, int *t, int *l)
 	return 1;
 }
 
+static char *_sysfs_host_string(const char *type, int host, const char *attr)
+{
+	char path[PATH_MAX], tmp[64] = {0};
+	int fd, r;
+
+	if (snprintf(path, sizeof(path), "/sys/class/%s_host/host%d/%s",
+			type, host, attr) < 0)
+		return NULL;
+	if ((fd = open(path, O_RDONLY)) < 0)
+                return NULL;
+	r = read(fd, tmp, sizeof(tmp));
+	close(fd);
+
+	if (r <= 0)
+		return NULL;
+
+	return xstrdup(tmp);
+}
+
+static int _sysfs_host_exists(const char *type, int host)
+{
+	char buf[PATH_MAX];
+	struct stat st;
+
+	if (snprintf(buf, sizeof(buf), "/sys/class/%s_host/host%d",
+		     type, host) < 0)
+		return 0;
+
+	if (!stat(buf, &st) && S_ISDIR(st.st_mode))
+		return 1;
+
+	return 0;
+}
+
+static int _sysfs_scsi_attr_exists(const char *attr, int h, int c, int t, int l)
+{
+	char buf[PATH_MAX];
+	struct stat st;
+
+	if (snprintf(buf, sizeof(buf), "/sys/bus/scsi/devices/%d:%d:%d:%d/%s",
+		     h, c, t, l, attr) < 0)
+		return 0;
+
+	if (!stat(buf, &st))
+		return 1;
+
+	return 0;
+}
+
+static int _sysfs_scsi_path_contains(const char *pattern, int h, int c, int t, int l)
+{
+	char buf[PATH_MAX], linkc[PATH_MAX];
+	struct stat st;
+
+	if (snprintf(buf, sizeof(buf), "/sys/bus/scsi/devices/%d:%d:%d:%d",
+		     h, c, t, l) < 0)
+		return 0;
+
+	if (stat(buf, &st) || readlink(buf, linkc, sizeof(linkc)) <= 0)
+		return 0;
+
+	if (strstr(linkc, pattern))
+		return 1;
+
+	return 0;
+}
+
+/* Thanks to lsscsi code for idea of detection logic used here */
+static char *get_transport(struct blkdev_cxt *cxt)
+{
+	int host, channel, target, lun;
+	char *attr;
+
+	if (!get_hctl(cxt, &host, &channel, &target, &lun))
+		return NULL;
+
+	/* SPI - Serial Peripheral Interface */
+	if (_sysfs_host_exists("spi", host))
+		return xstrdup("spi");
+
+	/* FC/FCoE - Fibre Channel / Fibre Channel over Ethernet */
+	if (_sysfs_host_exists("fc", host)) {
+		if (!(attr = _sysfs_host_string("fc", host, "symbolic_name")))
+			return NULL;
+		if (strstr(attr, " over "))
+			return xstrdup("fcoe");
+		return xstrdup("fc");
+	}
+
+	/* SAS - Serial Attached SCSI */
+	if (_sysfs_host_exists("sas", host))
+		return xstrdup("sas");
+
+	if (_sysfs_scsi_attr_exists("sas_device", host, channel, target, lun))
+		return xstrdup("sas");
+
+	/* SBP - Serial Bus Protocol (FireWire) */
+	if (_sysfs_scsi_attr_exists("ieee1394_id", host, channel, target, lun))
+		return xstrdup("sbp");
+
+	/* iSCSI */
+	if (_sysfs_host_exists("iscsi", host))
+		return xstrdup("iscsi");
+
+	/* USB - Universal Serial Bus */
+	if (_sysfs_scsi_path_contains("usb", host, channel, target, lun))
+		return xstrdup("usb");
+
+	/* ATA, SATA */
+	if (_sysfs_host_exists("scsi", host)) {
+		if (!(attr = _sysfs_host_string("scsi", host, "proc_name")))
+			return NULL;
+		if (!strncmp(attr, "ahci", 4) ||
+		    !strncmp(attr, "sata", 4))
+			return xstrdup("sata");
+
+		if (strstr(attr, "ata"))
+			return xstrdup("ata");
+		return NULL;
+	}
+
+	return NULL;
+}
+
 #define is_parsable(_l)	(((_l)->tt->flags & TT_FL_RAW) || \
 			 ((_l)->tt->flags & TT_FL_EXPORT))
 
@@ -803,6 +929,11 @@ static void set_tt_data(struct blkdev_cxt *cxt, int col, int id, struct tt_line
 		}
 		break;
 	}
+	case COL_TRANSPORT:
+		p = get_transport(cxt);
+		if (p)
+			tt_line_set_data(ln, col, p);
+		break;
 	case COL_DALIGN:
 		p = sysfs_strdup(&cxt->sysfs, "discard_alignment");
 		if (cxt->discard && p)
-- 
1.7.10.4

