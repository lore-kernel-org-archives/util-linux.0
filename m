Return-Path: util-linux-owner@vger.kernel.org
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40453 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757376AbdDSA2M (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 18 Apr 2017 20:28:12 -0400
From: damien.lemoal@wdc.com
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@justemail.net>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2] lsblk: add ZONED column
Date: Wed, 19 Apr 2017 09:25:58 +0900
Message-Id: <20170419002558.2829-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Damien Le Moal <damien.lemoal@wdc.com>

Add the column "ZONED" to the output to display block devices zone
model information.

Example output:

> lsblk -o+ZONED
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT ZONED
sda      8:0    0 111.8G  0 disk            none
├─sda1   8:1    0   500M  0 part /boot      none
├─sda2   8:2    0  87.3G  0 part /          none
└─sda3   8:3    0    24G  0 part [SWAP]     none
sdb      8:16   0  12.8T  0 disk            host-managed
sdc      8:32   0   5.5T  0 disk            host-managed

or:

> lsblk --zoned
NAME   ZONED
sda    none
├─sda1 none
├─sda2 none
└─sda3 none
sdb    host-managed
sdc    host-managed

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---

Changes from v1:
* Option list and commit message were using the "--zone" option name instead of
  the correst "--zoned"

 misc-utils/lsblk.8 |  3 +++
 misc-utils/lsblk.c | 15 +++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index ee1d873..d9fc1c0 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -49,6 +49,9 @@ Print the SIZE column in bytes rather than in a human-readable format.
 .BR \-D , " \-\-discard"
 Print information about the discarding capabilities (TRIM, UNMAP) for each device.
 .TP
+.BR \-z , " \-\-zoned"
+Print the zone model for each device.
+.TP
 .BR \-d , " \-\-nodeps"
 Do not print holder devices or slaves.  For example, \fBlsblk --nodeps /dev/sda\fR prints
 information about the sda device only.
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 4742a4d..12a6b2d 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -124,7 +124,8 @@ enum {
 	COL_TRANSPORT,
 	COL_SUBSYS,
 	COL_REV,
-	COL_VENDOR
+	COL_VENDOR,
+	COL_ZONED,
 };
 
 /* basic table settings */
@@ -200,6 +201,7 @@ static struct colinfo infos[] = {
 	[COL_SUBSYS] = { "SUBSYSTEMS", 0.1, SCOLS_FL_NOEXTREMES, N_("de-duplicated chain of subsystems") },
 	[COL_REV]    = { "REV",   4, SCOLS_FL_RIGHT, N_("device revision") },
 	[COL_VENDOR] = { "VENDOR", 0.1, SCOLS_FL_TRUNC, N_("device vendor") },
+	[COL_ZONED]  = { "ZONED", 0.3, 0, N_("zone model") },
 };
 
 struct lsblk {
@@ -1148,6 +1150,9 @@ static void set_scols_data(struct blkdev_cxt *cxt, int col, int id, struct libsc
 		if (!str)
 			str = xstrdup("0");
 		break;
+	case COL_ZONED:
+		str = sysfs_strdup(&cxt->sysfs, "queue/zoned");
+		break;
 	};
 
 	if (str)
@@ -1626,6 +1631,7 @@ static void __attribute__((__noreturn__)) help(FILE *out)
 	fputs(_(" -b, --bytes          print SIZE in bytes rather than in human readable format\n"), out);
 	fputs(_(" -d, --nodeps         don't print slaves or holders\n"), out);
 	fputs(_(" -D, --discard        print discard capabilities\n"), out);
+	fputs(_(" -z, --zoned          print zone model\n"), out);
 	fputs(_(" -e, --exclude <list> exclude devices by major number (default: RAM disks)\n"), out);
 	fputs(_(" -f, --fs             output info about filesystems\n"), out);
 	fputs(_(" -i, --ascii          use ascii characters only\n"), out);
@@ -1676,6 +1682,7 @@ int main(int argc, char *argv[])
 		{ "bytes",      no_argument,       NULL, 'b' },
 		{ "nodeps",     no_argument,       NULL, 'd' },
 		{ "discard",    no_argument,       NULL, 'D' },
+		{ "zoned",      no_argument,       NULL, 'z' },
 		{ "help",	no_argument,       NULL, 'h' },
 		{ "json",       no_argument,       NULL, 'J' },
 		{ "output",     required_argument, NULL, 'o' },
@@ -1721,7 +1728,7 @@ int main(int argc, char *argv[])
 	lsblk_init_debug();
 
 	while((c = getopt_long(argc, argv,
-			       "abdDe:fhJlnmo:OpPiI:rstVSx:", longopts, NULL)) != -1) {
+			       "abdDze:fhJlnmo:OpPiI:rstVSx:", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1742,6 +1749,10 @@ int main(int argc, char *argv[])
 			add_column(columns, ncolumns++, COL_DMAX);
 			add_column(columns, ncolumns++, COL_DZERO);
 			break;
+		case 'z':
+			add_column(columns, ncolumns++, COL_NAME);
+			add_column(columns, ncolumns++, COL_ZONED);
+			break;
 		case 'e':
 			parse_excludes(optarg);
 			break;
-- 
2.9.3

