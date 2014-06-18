Return-Path: util-linux-owner@vger.kernel.org
Received: from toccata.ens-lyon.org ([140.77.166.68]:58321 "EHLO
	toccata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611AbaFRSY1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 Jun 2014 14:24:27 -0400
Date: Wed, 18 Jun 2014 20:17:28 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.25-rc1
Message-ID: <20140618181728.GI6076@type.youpi.perso.aquilenet.fr>
References: <20140618134616.GA25885@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <20140618134616.GA25885@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Here are some fixes for non-Linux systems

Thanks,
Samuel

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/configure.ac b/configure.ac
index cf29f6b..fff06fb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -324,6 +324,7 @@ AC_CHECK_FUNCS([ \
 	strnlen \
 	strtoull \
 	sysconf \
+	sysinfo \
 	updwtmp \
 	usleep \
 	warn \
diff --git a/lib/boottime.c b/lib/boottime.c
index a2869a5..3043905 100644
--- a/lib/boottime.c
+++ b/lib/boottime.c
@@ -14,7 +14,9 @@ int get_boot_time(struct timeval *boot_time)
 	struct timeval lores_uptime;
 #endif
 	struct timeval now;
+#ifdef HVAE_SYSINFO
 	struct sysinfo info;
+#endif
 
 	if (gettimeofday(&now, NULL) != 0) {
 		warn(_("gettimeofday failed"));
@@ -27,6 +29,7 @@ int get_boot_time(struct timeval *boot_time)
 		return 0;
 	}
 #endif
+#ifdef HAVE_SYSINFO
 	/* fallback */
 	if (sysinfo(&info) != 0)
 		warn(_("sysinfo failed"));
@@ -34,4 +37,7 @@ int get_boot_time(struct timeval *boot_time)
 	boot_time->tv_sec = now.tv_sec - info.uptime;
 	boot_time->tv_usec = 0;
 	return 0;
+#else
+	return -ENOSYS;
+#endif
 }
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 222d40e..15fb28b 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -81,6 +81,7 @@ static volatile sig_atomic_t sigchild;
 # define IUCLC		0
 #endif
 
+#ifdef TIOCGLCKTRMIOS
 /*
  * For the case plymouth is found on this system
  */
@@ -111,6 +112,7 @@ static int plymouth_command(const char* arg)
 	}
 	return 1;
 }
+#endif
 
 /*
  * Fix the tty modes and set reasonable defaults.
@@ -120,7 +122,9 @@ static void tcinit(struct console *con)
 	int mode = 0, flags = 0;
 	struct termios *tio = &con->tio;
 	struct termios lock;
-	int fd = con->fd, i = (plymouth_command("--ping")) ? 20 : 0;
+	int fd = con->fd;
+#ifdef TIOCGLCKTRMIOS
+	int i = (plymouth_command("--ping")) ? 20 : 0;
 
 	while (i-- > 0) {
 		/*
@@ -138,6 +142,7 @@ static void tcinit(struct console *con)
 	}
 	memset(&lock, 0, sizeof(struct termios));
 	ioctl(fd, TIOCSLCKTRMIOS, &lock);
+#endif
 
 	errno = 0;
 
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index e12b272..2b5932d 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -942,6 +942,9 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 {
 	const pid_t pid = getpid();
 	int closed = 0;
+#ifndef KDGKBMODE
+	int serial;
+#endif
 
 	/* Set up new standard input, unless we are given an already opened port. */
 
@@ -1090,12 +1093,19 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 	 * In case of a virtual console the ioctl KDGKBMODE succeeds
 	 * whereas on other lines it will fails.
 	 */
-	if (ioctl(STDIN_FILENO, KDGKBMODE, &op->kbmode) == 0) {
+#ifdef KDGKBMODE
+	if (ioctl(STDIN_FILENO, KDGKBMODE, &op->kbmode) == 0)
+#else
+	if (ioctl(STDIN_FILENO, TIOCMGET, &serial) < 0 && (errno == EINVAL))
+#endif
+	{
 		op->flags |= F_VCONSOLE;
 		if (!op->term)
 			op->term = DEFAULT_VCTERM;
 	} else {
+#ifdef K_RAW
 		op->kbmode = K_RAW;
+#endif
 		if (!op->term)
 			op->term = DEFAULT_STERM;
 	}
@@ -1109,6 +1119,7 @@ static void termio_init(struct options *op, struct termios *tp)
 	speed_t ispeed, ospeed;
 	struct winsize ws;
 	struct termios lock;
+#ifdef TIOCGLCKTRMIOS
 	int i =  (plymouth_command("--ping") == 0) ? 30 : 0;
 
 	while (i-- > 0) {
@@ -1129,6 +1140,7 @@ static void termio_init(struct options *op, struct termios *tp)
 	}
 	memset(&lock, 0, sizeof(struct termios));
 	ioctl(STDIN_FILENO, TIOCSLCKTRMIOS, &lock);
+#endif
 
 	if (op->flags & F_VCONSOLE) {
 #if defined(IUTF8) && defined(KDGKBMODE)

--UugvWAfsgieZRqgk--
