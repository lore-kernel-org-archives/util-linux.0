Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13484 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080Ab2KSPlU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 Nov 2012 10:41:20 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qAJFfKsf021024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 19 Nov 2012 10:41:20 -0500
Received: from localhost (vpn1-6-3.ams2.redhat.com [10.36.6.3])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qAJFfIl1000433
	for <util-linux@vger.kernel.org>; Mon, 19 Nov 2012 10:41:19 -0500
Date: Mon, 19 Nov 2012 15:41:16 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] wipefs: Add --force option
Message-ID: <20121119154116.GA28909@rhmail.home.annexia.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

https://bugzilla.redhat.com/show_bug.cgi?id=872831
https://bugzilla.redhat.com/show_bug.cgi?id=865961

Unfortunately this means you nearly always need to use the --force
option with wipefs when trying to wipe something which is not an
unmounted filesystem.

Tested using a modified version of libguestfs which detects if wipefs
supports the --force option, and if it does unconditionally adds it.
I verified that this fixes the virt-format utility on Fedora 18.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
New in Fedora 11: Fedora Windows cross-compiler. Compile Windows
programs, test, and build Windows installers. Over 70 libraries supprt'd
http://fedoraproject.org/wiki/MinGW http://www.annexia.org/fedora_mingw

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-wipefs-Add-force-option-to-force-it-to-erase.patch"

>From 87d3843615d2ada2f474e2804acfe5a7d7529d72 Mon Sep 17 00:00:00 2001
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Mon, 19 Nov 2012 15:02:13 +0000
Subject: [PATCH] wipefs: Add --force option to force it to erase.

Commit c550f728f724360f99aae0fdb45b0589d9a347e0 added O_EXCL when
opening the thing to erase.  This broke the wipefs utility when used
on anything which isn't an unmounted filesystem.  eg. If you use it on
a block device containing partitions, then it won't work because the
kernel recognizes the partitions and so thinks the device is in use.

This change adds the --force option which, when used, undoes the above
flag change.  However you still have to use --force most of the time
when erasing something that isn't a plain unmounted filesystem.
---
 misc-utils/wipefs.8 |  3 +++
 misc-utils/wipefs.c | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index 05a5496..67261ee 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -38,6 +38,9 @@ erased.
 .IP "\fB\-a, \-\-all\fP"
 Erase all available signatures. This set of erased signatures could be
 restricted by \fB\-t <list>\fP option.
+.IP "\fB\-f, \-\-force\fP"
+Force erasure, even if the filesystem is mounted.  This is required in
+order to erase the partition table on a block device.
 .IP "\fB\-h, \-\-help\fP"
 Print help and exit.
 .IP "\fB\-n, \-\-no\-act\fP"
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 0ddc148..a29f3cc 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -307,12 +307,17 @@ static void do_wipe_real(blkid_probe pr, const char *devname, struct wipe_desc *
 }
 
 static struct wipe_desc *
-do_wipe(struct wipe_desc *wp, const char *devname, int noact, int all, int quiet)
+do_wipe(struct wipe_desc *wp, const char *devname, int noact, int all, int quiet, int force)
 {
-	blkid_probe pr = new_probe(devname, O_RDWR | O_EXCL);
+	int flags;
+	blkid_probe pr;
 	struct wipe_desc *w, *wp0 = clone_offset(wp);
 	int zap = all ? 1 : wp->zap;
 
+	flags = O_RDWR;
+	if (!force)
+		flags |= O_EXCL;
+	pr = new_probe(devname, flags);
 	if (!pr)
 		return NULL;
 
@@ -362,6 +367,7 @@ usage(FILE *out)
 
 	fputs(_("\nOptions:\n"), out);
 	fputs(_(" -a, --all           wipe all magic strings (BE CAREFUL!)\n"
+		" -f, --force         force erasure\n"
 		" -h, --help          show this help text\n"
 		" -n, --no-act        do everything except the actual write() call\n"
 		" -o, --offset <num>  offset to erase, in bytes\n"
@@ -380,11 +386,12 @@ int
 main(int argc, char **argv)
 {
 	struct wipe_desc *wp0 = NULL, *wp;
-	int c, all = 0, has_offset = 0, noact = 0, quiet = 0;
+	int c, all = 0, force = 0, has_offset = 0, noact = 0, quiet = 0;
 	int mode = WP_MODE_PRETTY;
 
 	static const struct option longopts[] = {
 	    { "all",       0, 0, 'a' },
+	    { "force",     0, 0, 'f' },
 	    { "help",      0, 0, 'h' },
 	    { "no-act",    0, 0, 'n' },
 	    { "offset",    1, 0, 'o' },
@@ -414,6 +421,9 @@ main(int argc, char **argv)
 		case 'a':
 			all++;
 			break;
+		case 'f':
+			force++;
+			break;
 		case 'h':
 			usage(stdout);
 			break;
@@ -463,7 +473,8 @@ main(int argc, char **argv)
 		 */
 		while (optind < argc) {
 			wp = clone_offset(wp0);
-			wp = do_wipe(wp, argv[optind++], noact, all, quiet);
+			wp = do_wipe(wp, argv[optind++], noact, all, quiet,
+				     force);
 			free_wipe(wp);
 		}
 	}
-- 
1.7.11.4


--cWoXeonUoKmBZSoM--
