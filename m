Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:64124 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757215AbcK3OXy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Nov 2016 09:23:54 -0500
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lq9Ma-1cglmR0HYG-00djnP for
 <util-linux@vger.kernel.org>; Wed, 30 Nov 2016 15:23:51 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] misc: spelling, always use "cannot" instead of "can not"
Date: Wed, 30 Nov 2016 15:23:49 +0100
Message-Id: <1480515830-1408-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Just to be consistent ...

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.8              | 2 +-
 lib/plymouth-ctrl.c            | 6 +++---
 libblkid/src/tag.c             | 2 +-
 libfdisk/src/dos.c             | 2 +-
 login-utils/login.1            | 2 +-
 login-utils/sulogin-consoles.c | 2 +-
 login-utils/sulogin.c          | 4 ++--
 misc-utils/getopt.1            | 2 +-
 sys-utils/lscpu.c              | 4 ++--
 term-utils/agetty.8            | 2 +-
 term-utils/setterm.c           | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index df007f1..819c69f 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -197,7 +197,7 @@ Normally, the filesystem type is deduced by searching for
 in the
 .I /etc/fstab
 file and using the corresponding entry.
-If the type can not be deduced, and there is only a single filesystem
+If the type cannot be deduced, and there is only a single filesystem
 given as an argument to the
 .B \-t
 option,
diff --git a/lib/plymouth-ctrl.c b/lib/plymouth-ctrl.c
index 6cda7c8..75d8b93 100644
--- a/lib/plymouth-ctrl.c
+++ b/lib/plymouth-ctrl.c
@@ -69,13 +69,13 @@ static int open_un_socket_and_connect(void)
 
 	fd = socket(PF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0);
 	if (fd < 0) {
-		warnx(_("can not open UNIX socket"));
+		warnx(_("cannot open UNIX socket"));
 		goto err;
 	}
 
 	ret = setsockopt(fd, SOL_SOCKET, SO_PASSCRED, &one, (socklen_t)sizeof(one));
 	if (ret < 0) {
-		warnx(_("can not set option for UNIX socket"));
+		warnx(_("cannot set option for UNIX socket"));
 		close(fd);
 		fd = -1;
 		goto err;
@@ -88,7 +88,7 @@ static int open_un_socket_and_connect(void)
 	ret = connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1 + strlen(su.sun_path+1));
 	if (ret < 0) {
 		if (errno != ECONNREFUSED)
-			warnx(_("can not connect on UNIX socket"));
+			warnx(_("cannot connect on UNIX socket"));
 		close(fd);
 		fd = -1;
 		goto err;
diff --git a/libblkid/src/tag.c b/libblkid/src/tag.c
index 9b131ae..f07d058 100644
--- a/libblkid/src/tag.c
+++ b/libblkid/src/tag.c
@@ -441,7 +441,7 @@ int main(int argc, char **argv)
 
 	dev = blkid_get_dev(cache, devname, flags);
 	if (!dev) {
-		fprintf(stderr, "%s: Can not find device in blkid cache\n",
+		fprintf(stderr, "%s: cannot find device in blkid cache\n",
 			devname);
 		exit(1);
 	}
diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index 5ea56c2..b2c6a58 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -346,7 +346,7 @@ static void dos_init(struct fdisk_context *cxt)
 					   | SIZE_SUFFIX_3LETTER, bytes);
 		fdisk_warnx(cxt,
 		_("The size of this disk is %s (%ju bytes). DOS "
-		  "partition table format can not be used on drives for "
+		  "partition table format cannot be used on drives for "
 		  "volumes larger than %lu bytes for %lu-byte "
 		  "sectors. Use GUID partition table format (GPT)."),
 			szstr, bytes,
diff --git a/login-utils/login.1 b/login-utils/login.1
index 551d3b2..d74e962 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -233,7 +233,7 @@ item is empty, then all the checks are disabled.
 .B DEFAULT_HOME
 (boolean)
 .RS 4
-Indicate if login is allowed if we can not change directory to the
+Indicate if login is allowed if we cannot change directory to the
 home directory.  If set to
 .IR yes ,
 the user will login in the root (/) directory if it is not possible
diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index 595b516..532e7e7 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -113,7 +113,7 @@ void emergency_do_mounts(void)
 	}
 
 	if (stat("/", &rt) != 0) {
-		warn("can not get file status of root file system\n");
+		warn("cannot get file status of root file system\n");
 		return;
 	}
 
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 1c4313a..a44216b 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -1012,7 +1012,7 @@ int main(int argc, char **argv)
 				mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
 
 				if (failed) {
-					fprintf(stderr, _("Can not execute su shell\n\n"));
+					fprintf(stderr, _("cannot execute su shell\n\n"));
 					break;
 				}
 				fprintf(stderr, _("Login incorrect\n\n"));
@@ -1051,7 +1051,7 @@ int main(int argc, char **argv)
 				continue;
 		}
 
-		errx(EXIT_FAILURE, _("Can not wait on su shell\n\n"));
+		errx(EXIT_FAILURE, _("cannot wait on su shell\n\n"));
 
 	} while (1);
 
diff --git a/misc-utils/getopt.1 b/misc-utils/getopt.1
index 7cde033..62fd8aa 100644
--- a/misc-utils/getopt.1
+++ b/misc-utils/getopt.1
@@ -437,7 +437,7 @@ to use the first calling format as specified in the
 .SH BUGS
 .BR getopt (3)
 can parse long options with optional arguments that are given an
-empty optional argument (but can not do this for short options).
+empty optional argument (but cannot do this for short options).
 This
 .BR getopt (1)
 treats optional arguments that are empty as if they were not present.
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index bd702b0..e3e6ff6 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -886,12 +886,12 @@ is_vmware_platform(void)
 	act.sa_flags = SA_SIGINFO;
 
 	if (sigaction(SIGSEGV, &act, &oact))
-		err(EXIT_FAILURE, _("error: can not set signal handler"));
+		err(EXIT_FAILURE, _("cannot set signal handler"));
 
 	vmware_bdoor(&eax, &ebx, &ecx, &edx);
 
 	if (sigaction(SIGSEGV, &oact, NULL))
-		err(EXIT_FAILURE, _("error: can not restore signal handler"));
+		err(EXIT_FAILURE, _("cannot restore signal handler"));
 
 	return eax != (uint32_t)-1 && ebx == VMWARE_BDOOR_MAGIC;
 }
diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 446f389..3dbbb89 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -305,7 +305,7 @@ which then get passed to the used login program.  Agetty does check
 for a leading "\-" and makes sure the logname gets passed as one parameter
 (so embedded spaces will not create yet another parameter), but depending
 on how the login binary parses the command line that might not be sufficient.
-Check that the used login program can not be abused this way.
+Check that the used login program cannot be abused this way.
 .PP
 Some  programs use "\-\-" to indicate that the rest of the commandline should
 not be interpreted as options.  Use this feature if available by passing "\-\-"
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index e2c627a..f1cdd24 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -768,7 +768,7 @@ static void screendump(struct setterm_control *ctl)
 		ctl->opt_sn_name = "screen.dump";
 	out = fopen(ctl->opt_sn_name, ctl->opt_snap ? "w" : "a");
 	if (!out)
-		err(EXIT_DUMPFILE, _("can not open dump file %s for output"), ctl->opt_sn_name);
+		err(EXIT_DUMPFILE, _("cannot open dump file %s for output"), ctl->opt_sn_name);
 	/* determine snapshot size */
 	if (read(fd, header, 4) != 4)
 		err(EXIT_DUMPFILE, _("cannot read %s"), ctl->in_device);
-- 
1.8.5.6

