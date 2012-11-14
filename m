Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27767 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161178Ab2KNM0N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Nov 2012 07:26:13 -0500
Date: Wed, 14 Nov 2012 13:26:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: vlock command
Message-ID: <20121114122610.GF1835@x2.net.home>
References: <20121114103509.GD1835@x2.net.home>
 <50A37AD8.6060601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50A37AD8.6060601@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 14, 2012 at 03:04:56PM +0400, Alexey Gladkov wrote:
> We have another version of vlock, which is being supported by Dmitry
> V. Levin.
> 
> http://git.altlinux.org/people/ldv/packages/vlock.git

 Alexey, just today I added --erase option to Fedora version. Maybe
 you can apply the patch below to your repository too. Author of the
 patch is Petr Pisar <ppisar@redhat.com>.

    Karel


diff -up vlock-1.3/help.c.kzak vlock-1.3/help.c
--- vlock-1.3/help.c.kzak	2012-11-14 11:12:08.378692002 +0100
+++ vlock-1.3/help.c	2012-11-14 11:13:10.038998321 +0100
@@ -26,6 +26,7 @@ void print_help(int exitcode) {
 	  "       switch to other virtual consoles.\n"
 	  "-a or --all: lock all virtual consoles by preventing other users\n"
 	  "       from switching virtual consoles.\n"
+	  "-e or --erase: erase current virtual console content\n"
 	  "-v or --version: Print the version number of vlock and exit.\n"
 	  "-h or --help: Print this help message and exit.\n"
 	  );
diff -up vlock-1.3/vlock.1.kzak vlock-1.3/vlock.1
--- vlock-1.3/vlock.1.kzak	1999-01-14 01:19:14.000000000 +0100
+++ vlock-1.3/vlock.1	2012-11-14 11:12:58.745935657 +0100
@@ -38,6 +38,10 @@ Lock all console sessions and disable VC
 .IP
 Lock the current session (this is the default).
 .PP
+.B -e,--erase
+.IP
+Erase current console content to prevent from leaking sensitive data.
+.PP
 .B -h,--help
 .IP
 Print a brief help message.
diff -up vlock-1.3/vlock.c.kzak vlock-1.3/vlock.c
--- vlock-1.3/vlock.c.kzak	2012-11-14 11:12:08.379692007 +0100
+++ vlock-1.3/vlock.c	2012-11-14 11:12:58.745935657 +0100
@@ -29,6 +29,9 @@
   /* This determines whether the default behavior is to lock only the */
   /* current VT or all of them.  0 means current, 1 means all. */
   int o_lock_all = 0;
+  /* This determines whether to erase terminal content after the locking.
+   * 0 means do not erase, 1 means to erase. */
+  int o_erase_terminal = 0;
 
 /* Other globals */
   struct vt_mode ovtm;
@@ -41,6 +44,7 @@ int main(int argc, char **argv) {
   static struct option long_options[] = { /* For parsing long arguments */
     {"current", 0, &o_lock_all, 0},
     {"all", 0, &o_lock_all, 1},
+    {"erase", no_argument, &o_erase_terminal, 1},
     {"version", no_argument, 0, O_VERSION},
     {"help", no_argument, 0, O_HELP},
     {0, 0, 0, 0},
@@ -51,7 +55,7 @@ int main(int argc, char **argv) {
   char *env;
 
   /* First we parse all the command line arguments */
-  while ((c = getopt_long(argc, argv, "acvh",
+  while ((c = getopt_long(argc, argv, "acevh",
 			  long_options, &option_index)) != -1) {
     switch(c) {
     case 'c':
@@ -60,6 +64,9 @@ int main(int argc, char **argv) {
     case 'a':
       o_lock_all = 1;
       break;
+    case 'e':
+      o_erase_terminal = 1;
+      break;
     case 'v':
     case O_VERSION:
       fprintf(stderr, VERSION);
@@ -116,6 +123,12 @@ int main(int argc, char **argv) {
     ioctl(vfd, VT_SETMODE, &vtm);
   }
 
+  /* Erase console. 2J erases display; 3J, since Linux 3.0, erases scroll-back
+   * buffer too. */
+  if (o_erase_terminal) {
+    puts("\E[3J\E[2J");
+  }
+
   /* get_password() sets the terminal characteristics and does not */
   /* return until the correct password has been read.              */
   get_password();

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
