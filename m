Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33167 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755129Ab1I3KF2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Sep 2011 06:05:28 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id AB0428EE5B
	for <util-linux@vger.kernel.org>; Fri, 30 Sep 2011 12:05:27 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 2/2] losetup: new -D option to delete all used loop devices
Date: Fri, 30 Sep 2011 12:05:26 +0200
Message-Id: <1317377126-13302-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1317377126-13302-1-git-send-email-petr.uzel@suse.cz>
References: <1317377126-13302-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/lomount.c |   45 +++++++++++++++++++++++++++++++++++++++++----
 mount/losetup.8 |    6 ++++++
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/mount/lomount.c b/mount/lomount.c
index 441860b..ae49157 100644
--- a/mount/lomount.c
+++ b/mount/lomount.c
@@ -938,6 +938,32 @@ set_loop(const char *device, const char *file, unsigned long long offset,
 	return 0;
 }
 
+static int
+delete_all_devices (void)
+{
+	struct looplist ll;
+	int fd;
+	int ok;
+
+	if (looplist_open(&ll, LLFLG_USEDONLY) == -1) {
+		error(_("%s: /dev directory does not exist."), progname);
+		return 1;
+	}
+
+	while((fd = looplist_next(&ll)) != -1) {
+		close(fd);
+		ok |= del_loop(ll.name);
+	}
+	looplist_close(&ll);
+
+	if (!ll.ct_succ && ll.ct_perm) {
+		error(_("%s: no permission to look at /dev/loop%s<N>"), progname,
+				(ll.flag & LLFLG_SUBDIR) ? "/" : "");
+		return 1;
+	}
+	return ok;
+}
+
 int
 del_loop (const char *device) {
 	int fd, errsv;
@@ -1015,6 +1041,7 @@ usage(FILE *out) {
 	_(" %1$s loop_device                             give info\n"
 	  " %1$s -a | --all                              list all used\n"
 	  " %1$s -d | --detach <loopdev> [<loopdev> ...] delete\n"
+	  " %1$s -D | --detach-all                       delete all used\n"
 	  " %1$s -f | --find                             find unused\n"
 	  " %1$s -c | --set-capacity <loopdev>           resize\n"
 	  " %1$s -j | --associated <file> [-o <num>]     list all associated with <file>\n"
@@ -1037,7 +1064,7 @@ usage(FILE *out) {
 int
 main(int argc, char **argv) {
 	char *p, *offset, *sizelimit, *encryption, *passfd, *device, *file, *assoc;
-	int delete, find, c, all, capacity;
+	int delete, delete_all, find, c, all, capacity;
 	int res = 0;
 	int showdev = 0;
 	int ro = 0;
@@ -1048,6 +1075,7 @@ main(int argc, char **argv) {
 		{ "all", 0, 0, 'a' },
 		{ "set-capacity", 0, 0, 'c' },
 		{ "detach", 0, 0, 'd' },
+		{ "detach-all", 0, 0, 'D' },
 		{ "encryption", 1, 0, 'e' },
 		{ "find", 0, 0, 'f' },
 		{ "help", 0, 0, 'h' },
@@ -1065,14 +1093,14 @@ main(int argc, char **argv) {
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	capacity = delete = find = all = 0;
+	capacity = delete = delete_all = find = all = 0;
 	assoc = offset = sizelimit = encryption = passfd = NULL;
 
 	progname = argv[0];
 	if ((p = strrchr(progname, '/')) != NULL)
 		progname = p+1;
 
-	while ((c = getopt_long(argc, argv, "acde:E:fhj:o:p:rsv",
+	while ((c = getopt_long(argc, argv, "acdDe:E:fhj:o:p:rsv",
 				longopts, NULL)) != -1) {
 		switch (c) {
 		case 'a':
@@ -1087,6 +1115,9 @@ main(int argc, char **argv) {
 		case 'd':
 			delete = 1;
 			break;
+		case 'D':
+			delete_all = 1;
+			break;
 		case 'E':
 		case 'e':
 			encryption = optarg;
@@ -1128,10 +1159,14 @@ main(int argc, char **argv) {
 		if (argc < optind+1 || encryption || offset || sizelimit ||
 		    capacity || find || all || showdev || assoc || ro)
 			usage(stderr);
+	} else if (delete_all) {
+		if (argc > optind || encryption || offset || sizelimit ||
+		    capacity || find || all || showdev || assoc || ro)
+			usage(stderr);
 	} else if (find) {
 		if (capacity || all || assoc || argc < optind || argc > optind+1)
 			usage(stderr);
-	} else if (all) {
+	} else if (all || delete_all) {
 		/* only -v is allowed */
 		if ((argc == 3 && verbose == 0) || argc > 3)
 			usage(stderr);
@@ -1159,6 +1194,8 @@ main(int argc, char **argv) {
 
 	if (all)
 		return show_used_loop_devices();
+	else if (delete_all)
+		return delete_all_devices();
 	else if (assoc)
 		return show_associated_loop_devices(assoc, off, offset ? 1 : 0);
 	else if (find) {
diff --git a/mount/losetup.8 b/mount/losetup.8
index f1db80b..a6b45a0 100644
--- a/mount/losetup.8
+++ b/mount/losetup.8
@@ -24,6 +24,12 @@ Delete loop:
 .IR loopdev ...
 .sp
 .in -5
+Delete all used loop devices:
+.sp
+.in +5
+.B "losetup \-D"
+.sp
+.in -5
 Print name of first unused loop device:
 .sp
 .in +5
-- 
1.7.3.4

