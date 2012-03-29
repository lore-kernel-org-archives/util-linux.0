Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50613 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759115Ab2C2Qpo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:44 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2BBCD906EB
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:43 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 11/20] uuidd: introduce --keep-privs option
Date: Thu, 29 Mar 2012 18:45:19 +0200
Message-Id: <1333039528-24784-12-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This option makes uuidd _not_ to drop its privileges if installed suid
and exectued by root.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.8 |    5 +++++
 misc-utils/uuidd.c |    7 ++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/misc-utils/uuidd.8 b/misc-utils/uuidd.8
index f5fb5f0..892f236 100644
--- a/misc-utils/uuidd.8
+++ b/misc-utils/uuidd.8
@@ -48,6 +48,11 @@ process.  Implies --no-fork and --no-pid.  As of this writing, this option is
 supposed to be used only with systemd. It needs to enabled with configure
 option --enable--uuid-socket-activation.
 .TP
+.BR \-K , " \-\-keep-privs "
+If uuidd is installed set-uid and executed by root, it by default drops its
+privileges to match the owner and group of the binary.  This option makes uuidd
+keep its privileges.
+.TP
 .B \-q
 Suppress some failure messages.
 .TP
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 4b04390..54978aa 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -70,6 +70,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" -P, --no-pid            do not create pid file\n"
 		" -F, --no-fork           do not daemonize using double-fork\n"
 		" -S, --socket-activation do not create listening socket\n"
+		" -K, --keep-privs 	  do not drop privileges\n"
 		" -d, --debug             run in debugging mode\n"
 		" -q, --quiet             turn on quiet mode\n"
 		" -V, --version           output version information and exit\n"
@@ -546,6 +547,7 @@ int main(int argc, char **argv)
 		{"no-pid", no_argument, NULL, 'P'},
 		{"no-fork", no_argument, NULL, 'F'},
 		{"socket-activation", no_argument, NULL, 'S'},
+		{"keep-privs", no_argument, NULL, 'K'},
 		{"debug", no_argument, NULL, 'd'},
 		{"quiet", no_argument, NULL, 'q'},
 		{"version", no_argument, NULL, 'V'},
@@ -558,7 +560,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 
 	while ((c =
-		getopt_long(argc, argv, "p:s:T:krtn:PFSdqVh", longopts,
+		getopt_long(argc, argv, "p:s:T:krtn:PFSKdqVh", longopts,
 			    NULL)) != -1) {
 		switch (c) {
 		case 'd':
@@ -595,6 +597,9 @@ int main(int argc, char **argv)
 			return EXIT_FAILURE;
 #endif
 			break;
+		case 'K':
+			drop_privs = 0;
+			break;
 		case 'q':
 			quiet++;
 			break;
-- 
1.7.7

