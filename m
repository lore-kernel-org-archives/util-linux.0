Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651B3BF69A
	for <util-linux@vger.kernel.org>; Wed, 29 Apr 2026 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454938; cv=none; b=bdghObd+E1DpYNr/tPOwHFE21p/Iw55C+i9v8HUgv7pYtIPVEQGTxE5xRedAvEeOuPmOtgTorDXwulMDyXTkyN+fJb0H9U+eiN+Emp0A+MaK736cbQdyyYraPQgj+8Rey8L81July6EbwSLP2yyGqVnpSCW2yQptLUU7/Q8iahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454938; c=relaxed/simple;
	bh=EQQE1X8M9yIlPUuqWgG+K+3H8EfwhAbZxr0a6CfUdrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ov58aRSYOcr8Faqqr3btHN6usWaW+FJCyAxY6IhyAaARWucnAHLRwSVcTTt6Q/xkaGfNuceiTbxvuEtnwNlQSAblpft1sIQdMBaPWzwoLA8XNmMzsaZ8I+/jI59h4kXUuCaNX/RXHsuLjg5X5ljtckdcGcIo3LlGx4IgYy3YBsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0PkRWDK8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vQ4W4h68; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1xpBtOlZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vByMt7Vk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0PkRWDK8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vQ4W4h68";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1xpBtOlZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vByMt7Vk"
Received: from boole.nue2.suse.org (unknown [IPv6:2a07:de40:a101:3:21c:c0ff:fea4:1c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17BBC5BCCE;
	Wed, 29 Apr 2026 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777454928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GFpzV5uAdEPTMFxdEARHHepetKqE1rZ65TTLIJ8RcW4=;
	b=0PkRWDK8NjIdGOvAW7kZMW0sDkyaLiVLb2GPEow6G6B2dreBcWxIEPJQBuNjdEfBSH3rEo
	YsbyeFFaApD9UGvwMlpeI5GKFS9MYmsXGxrRIEwuWHetUh19uZz1sDPaARA/iWL6aoAFyK
	xp93XeF+14euKZSuWroqImnrNuZRKEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777454928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GFpzV5uAdEPTMFxdEARHHepetKqE1rZ65TTLIJ8RcW4=;
	b=vQ4W4h682FJGRagt9aSICqDNzGGhKC5gME+74IcHy/DrQ5Cg9XrJaIOinAZcknfzhGZXs8
	5VYWecRacq3gHrAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1xpBtOlZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vByMt7Vk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777454927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GFpzV5uAdEPTMFxdEARHHepetKqE1rZ65TTLIJ8RcW4=;
	b=1xpBtOlZuM+nR79/D/UQj1g9LojexCDbrVqjsRC6o6l5X3dPCJsYK89ieAT+l0aZF7lJOA
	D4NY9/JAG3MeIDfI1WZ9lN+jq8vxBm85ctbei4qsDM9gPyfkVBV+dDR4N/TzuJ7tYDmg/7
	90nf1kCAK13+PRZ2O+o5bxAhQmDA3r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777454927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GFpzV5uAdEPTMFxdEARHHepetKqE1rZ65TTLIJ8RcW4=;
	b=vByMt7VkpZm/2R1PU4qjtEF3hsHvK8/JWZq3mPhARt3OKBQuBS2C6z2Rlk9jpoIHTRf22l
	9BhChOned5h545BQ==
Received: from boole.nue2.suse.org (localhost [127.0.0.1])
	by boole.nue2.suse.org (8.18.1/8.18.1/SUSE Linux 0.8) with ESMTPS id 63T9SihE017698
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 11:28:46 +0200
Received: (from werner@localhost)
	by boole.nue2.suse.org (8.18.1/8.18.1/Submit) id 63T9SiuW017697;
	Wed, 29 Apr 2026 11:28:44 +0200
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>
Subject: [PATCH] Secure login and sulogin on S390x
Date: Wed, 29 Apr 2026 11:28:26 +0200
Message-ID: <20260429092825.17623-2-werner@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: 17BBC5BCCE
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 2.79
X-Spam-Level: **
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	HFILTER_HELO_IP_A(1.00)[boole.nue2.suse.org];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[boole.nue2.suse.org];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[boole.nue2.suse.org:helo,libcommon.la:url,suse.de:mid,suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:a101:3:21c:c0ff:fea4:1c14:from];
	FROM_EQ_ENVFROM(0.00)[]

Some remarks: on S390x architecture of modern zSeries the hypervisor
does log the console I/O.  For both the 3215 half duplex line mode as
well as the 3270 full-screen/block mode console type the I/O is logged
on the hypervisor's side.  To control this there are command send via
/dev/vmcp to tell the  z/VM control program of the hypervisor not to
log during entering the password.  For the 3215 console also automatic
scroll is enabled which avoid to press CLEAR to get the password prompt
if on the next block.

Beside this for the ttysclp0, the serial ASCII terminal accessed via
a websocket has since ncurses 6.5-20250405 a new terminfo entry called
"sclp" to support not only the vt220 like behaviour but also the
colouring feature of ttysclp0.

Signed-off-by: Werner Fink <werner@suse.de>
---
 lib/ttyutils.c                 |   5 +-
 login-utils/Makemodule.am      |   6 +-
 login-utils/login.c            |  85 +++++++++++-
 login-utils/meson.build        |   5 +
 login-utils/sulogin-consoles.c |  14 ++
 login-utils/sulogin-consoles.h |   4 +
 login-utils/sulogin.c          |  64 +++++++--
 login-utils/vmcp.c             | 236 +++++++++++++++++++++++++++++++++
 login-utils/vmcp.h             |  29 ++++
 9 files changed, 436 insertions(+), 12 deletions(-)
 create mode 100644 login-utils/vmcp.c
 create mode 100644 login-utils/vmcp.h

diff --git a/lib/ttyutils.c b/lib/ttyutils.c
index bacd73077..3085419bd 100644
--- a/lib/ttyutils.c
+++ b/lib/ttyutils.c
@@ -21,7 +21,7 @@
 #  if defined (__s390__) || defined (__s390x__)
 #    define DEFAULT_TTYS0  "dumb"
 #    define DEFAULT_TTY32  "ibm327x"
-#    define DEFAULT_TTYS1  "vt220"
+#    define DEFAULT_TTYS1  "sclp"
 #  endif
 #  ifndef DEFAULT_STERM
 #    define DEFAULT_STERM  "vt102"
@@ -176,7 +176,8 @@ char *get_terminal_default_type(const char *ttyname, int is_serial)
 		 * Special terminal on first serial line on a S/390(x) which
 		 * is due legacy reasons a block terminal of type 3270 or
 		 * higher.  Whereas the second serial line on a S/390(x) is
-		 * a real character terminal which is compatible with VT220.
+		 * a real character terminal which is compatible with "sclp"
+		 * since ncurses 6.5-20250405 for e.g. color support.
 		 */
 		if (strcmp(ttyname, "ttyS0") == 0)		/* linux/drivers/s390/char/con3215.c */
 			return strdup(DEFAULT_TTYS0);
diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index d288a06c3..599547f7b 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -33,7 +33,9 @@ dist_noinst_DATA += login-utils/sulogin.8.adoc
 sulogin_SOURCES = \
 	login-utils/sulogin.c \
 	login-utils/sulogin-consoles.c \
-	login-utils/sulogin-consoles.h
+	login-utils/sulogin-consoles.h \
+	login-utils/vmcp.c \
+	login-utils/vmcp.h
 if USE_PLYMOUTH_SUPPORT
 sulogin_SOURCES += lib/plymouth-ctrl.c
 endif
@@ -59,6 +61,8 @@ MANPAGES += login-utils/login.1
 dist_noinst_DATA += login-utils/login.1.adoc
 login_SOURCES = \
 	login-utils/login.c \
+	login-utils/vmcp.c \
+	login-utils/vmcp.h \
 	lib/logindefs.c
 login_LDADD = $(LDADD) libcommon.la -lpam
 if HAVE_LINUXPAM
diff --git a/login-utils/login.c b/login-utils/login.c
index d9e93d0dd..5b10cb83d 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -85,6 +85,7 @@
 #include "pwdutils.h"
 
 #include "logindefs.h"
+#include "vmcp.h"
 
 #define LOGIN_MAX_TRIES        3
 #define LOGIN_EXIT_TIMEOUT     5
@@ -161,6 +162,85 @@ static int is_consoletty(int fd)
 }
 #endif
 
+#if defined(__s390__) || defined(__s390x__)
+/* Avoid that passwords are logged on the hypervisors console log */
+
+#define CON_3215	0x0010	/* s390x 3215 halfduplex console */
+#define CON_3270	0x0020	/* s390x 3270 console */
+#define CON_SCLP	0x0040	/* s390x sclp terminals */
+
+struct s390con {
+	int flags;
+	int vmcpfd;
+};
+
+static struct s390con s390_console_spool_stop(int fd)
+{
+	struct stat stb;
+	struct s390con con = { .flags = 0, .vmcpfd = -1 };
+
+	if ((fstat(fd, &stb) >= 0)) {
+		if (major(stb.st_rdev) == 4 && minor(stb.st_rdev) == 64)
+			con.flags |= CON_3215;
+		if (major(stb.st_rdev) == 4 && minor(stb.st_rdev) >= 65)
+			con.flags |= CON_SCLP;
+		else if (major(stb.st_rdev) == 227 && minor(stb.st_rdev) >= 1)
+			con.flags |= CON_3270;
+	}
+	if (con.flags & (CON_3215|CON_3270)) {
+		con.vmcpfd = openvmcp();
+		if (con.vmcpfd >= 0) {
+			char *msg = queryspool(con.vmcpfd);
+			if (msg) {
+				parsespool(msg);
+				free(msg);
+			}
+			/*
+			 * Avoid that console log during
+			 * password input
+			 */
+			stopspool(con.vmcpfd);
+		}
+	}
+	if (con.flags & CON_3215) {
+		if (con.vmcpfd >= 0) {
+			char *msg = queryterm(con.vmcpfd);
+			if (msg) {
+				parseterm(msg);
+				free(msg);
+			}
+			/*
+			 * Avoid that CLEAR has to be pressed for
+			 * password input
+			 */
+			setterm(con.vmcpfd, "0");
+# ifdef WARN_WITH_VMCP
+			warning3215(con.vmcpfd);
+# endif
+		}
+	}
+	return con;
+}
+
+static void s390_console_spool_restore(struct s390con *con)
+{
+	if (con->vmcpfd >= 0) {
+		if (con->flags & CON_3215)
+			restoreterm(con->vmcpfd);
+		if (con->flags & (CON_3215|CON_3270))
+			restorespool(con->vmcpfd);
+		clearvmcp();
+		close(con->vmcpfd);
+		con->vmcpfd = -1;
+	}
+}
+# define PREPARE_CONSOLE(fd)	struct s390con con = s390_console_spool_stop(fd)
+# define RESTORE_CONSOLE()	s390_console_spool_restore(&con)
+#else
+# define PREPARE_CONSOLE(fd)	/* */
+# define RESTORE_CONSOLE()	/* */
+#endif
+
 /*
  * Robert Ambrose writes:
  * A couple of my users have a problem with login processes hanging around
@@ -1580,8 +1660,11 @@ int main(int argc, char **argv)
 	/* login -f, then the user has already been authenticated */
 	cxt.noauth = cxt.noauth && getuid() == 0 ? 1 : 0;
 
-	if (!cxt.noauth)
+	if (!cxt.noauth) {
+		PREPARE_CONSOLE(0);
 		loginpam_auth(&cxt);
+		RESTORE_CONSOLE();
+        }
 
 	/*
 	 * Authentication may be skipped (for example, during krlogin, rlogin,
diff --git a/login-utils/meson.build b/login-utils/meson.build
index 251d8de46..5f6310b01 100644
--- a/login-utils/meson.build
+++ b/login-utils/meson.build
@@ -49,6 +49,7 @@ test_islocal_sources = files(
 
 test_consoles_sources = files(
   'sulogin-consoles.c',
+  'vmcp.c',
 )
 
 last_sources = files(
@@ -59,6 +60,8 @@ last_manadocs = files('last.1.adoc')
 
 login_sources = files(
   'login.c',
+  'vmcp.c',
+  'vmcp.h',
 )
 login_manadocs = files('login.1.adoc')
 
@@ -66,6 +69,8 @@ sulogin_sources = files(
   'sulogin.c',
   'sulogin-consoles.c',
   'sulogin-consoles.h',
+  'vmcp.c',
+  'vmcp.h',
 )
 sulogin_manadocs = files('sulogin.8.adoc')
 
diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index c35922ff1..f09d90ece 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -389,6 +389,20 @@ static int detect_consoles_from_proc(struct list_head *consoles)
 		free(name);
 		if (rc < 0)
 			goto done;
+		if (!list_empty(consoles)) {
+			struct console *last;
+			last = list_last_entry(consoles, struct console, entry);
+			if (!strchr(fbuf, 'C'))
+				last->flags |= CON_CONSDEV;
+#if defined(__s390__) || defined(__s390x__)
+			if (maj == 4 && min == 64)
+				last->flags |= CON_3215;
+			if (maj == 4 && min >= 65)
+				last->flags |= CON_SCLP;
+			else if (maj == 227 && min >= 1)
+				last->flags |= CON_3270;
+#endif
+		}
 	}
 
 	rc = list_empty(consoles) ? 1 : 0;
diff --git a/login-utils/sulogin-consoles.h b/login-utils/sulogin-consoles.h
index d3b4298e4..10fdf612c 100644
--- a/login-utils/sulogin-consoles.h
+++ b/login-utils/sulogin-consoles.h
@@ -39,6 +39,10 @@ struct console {
 #define	CON_SERIAL	0x0001
 #define	CON_NOTTY	0x0002
 #define	CON_EIO		0x0004
+#define	CON_CONSDEV	0x0008	/* Last on the kernel command line */
+#define	CON_3215	0x0010	/* s390x 3215 halfduplex console */
+#define	CON_3270	0x0020  /* s390x 3270 console */
+#define	CON_SCLP	0x0040	/* s390x sclp terminals */
 	pid_t pid;
 	struct chardata cp;
 	struct termios tio;
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 23f5164e6..1984e6912 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -66,6 +66,7 @@
 #include "strutils.h"
 #include "ttyutils.h"
 #include "sulogin-consoles.h"
+#include "vmcp.h"
 #define CONMAX		16
 
 static unsigned int timeout;
@@ -218,7 +219,7 @@ static void tcinit(struct console *con)
 #endif
 
 #ifdef KDGKBMODE
-	if (!(con->flags & CON_SERIAL)
+	if (!(con->flags & (CON_SERIAL|CON_3215|CON_3270|CON_SCLP))
 	    && ioctl(fd, KDGKBMODE, &mode) < 0)
 		con->flags |= CON_SERIAL;
 	errno = 0;
@@ -265,6 +266,13 @@ static void tcinit(struct console *con)
 		}
 	}
 
+#if defined(__s390__) || defined(__s390x__)
+	if (con->flags & (CON_3215|CON_3270)) {
+		setlocale(LC_CTYPE, "POSIX");
+		setlocale(LC_MESSAGES, "POSIX");
+		goto setattr;
+	}
+#endif
 	/* Handle lines other than virtual consoles here */
 #if defined(KDGKBMODE) || defined(TIOCGSERIAL)
 	if (con->flags & CON_SERIAL)
@@ -292,7 +300,7 @@ static void tcinit(struct console *con)
 		cfsetospeed(tio, ospeed);
 
 #ifdef HAVE_STRUCT_TERMIOS_C_LINE
-		tio->c_line         = 0;
+		tio->c_line	 = 0;
 #endif
 		tio->c_cc[VTIME]    = 0;
 		tio->c_cc[VMIN]     = 1;
@@ -364,6 +372,10 @@ static void tcfinal(struct console *con)
 		free(term);
 	}
 
+#if defined(__s390__) || defined(__s390x__)
+	if (con->flags & (CON_3215|CON_3270))
+		return;
+#endif
 	if (!(con->flags & CON_SERIAL) || (con->flags & CON_NOTTY))
 		return;
 
@@ -983,9 +995,9 @@ static void usage(void)
 	fputs(_("Single-user login.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -p, --login-shell        start a login shell\n"
+	fputs(_(" -p, --login-shell	start a login shell\n"
 		" -t, --timeout <seconds>  max time to wait for a password (default: no limit)\n"
-		" -e, --force              examine password files directly if getpwnam(3) fails\n"),
+		" -e, --force	      examine password files directly if getpwnam(3) fails\n"),
 		out);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -1012,8 +1024,8 @@ int main(int argc, char **argv)
 	static const struct option longopts[] = {
 		{ "login-shell",  no_argument,       NULL, 'p' },
 		{ "timeout",      required_argument, NULL, 't' },
-		{ "force",        no_argument,       NULL, 'e' },
-		{ "help",         no_argument,       NULL, 'h' },
+		{ "force",	no_argument,       NULL, 'e' },
+		{ "help",	 no_argument,       NULL, 'h' },
 		{ "version",      no_argument,       NULL, 'V' },
 		{ NULL, 0, NULL, 0 }
 	};
@@ -1193,10 +1205,46 @@ int main(int argc, char **argv)
 				char *answer;
 				int doshell = 0;
 				int deny = !opt_e && locked_account_password(pwd->pw_passwd);
-
+#if defined(__s390__) || defined(__s390x__)
+				int vmcpfd = -1;
+				if (con->flags & (CON_3215|CON_3270)) {
+					vmcpfd = openvmcp();
+					if (vmcpfd >= 0) {
+						char *msg = queryspool(vmcpfd);
+						if (msg) {
+							parsespool(msg);
+							free(msg);
+						}
+						stopspool(vmcpfd);
+					}
+				}
+				if (con->flags & CON_3215) {
+					if (vmcpfd >= 0) {
+						char *msg = queryterm(vmcpfd);
+						if (msg) {
+							parseterm(msg);
+							free(msg);
+						}
+						setterm(vmcpfd, "0");
+						warning3215(vmcpfd);
+					}
+				}
+#endif
 				doprompt(passwd, con, deny);
 
-				if ((answer = getpasswd(con)) == NULL)
+				answer = getpasswd(con);
+#if defined(__s390__) || defined(__s390x__)
+				if (vmcpfd >= 0) {
+					if (con->flags & CON_3215)
+						restoreterm(vmcpfd);
+					if (con->flags & (CON_3215|CON_3270))
+						restorespool(vmcpfd);
+					clearvmcp();
+					close(vmcpfd);
+					vmcpfd = -1;
+				}
+#endif
+				if (answer == NULL)
 					break;
 				if (deny) {
 #ifdef HAVE_EXPLICIT_BZERO
diff --git a/login-utils/vmcp.c b/login-utils/vmcp.c
new file mode 100644
index 000000000..52c2d4a6b
--- /dev/null
+++ b/login-utils/vmcp.c
@@ -0,0 +1,236 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * vmcp.c - s390x 3215 console spool and terminal management
+ *
+ * Copyright 2026 Werner Fink, SUSE Software Solutions Germany GmbH
+ *
+ * Based on:
+ *
+ * Copyright IBM Corp. 2018
+ * s390-tools is free software; you can redistribute it and/or modify
+ * it under the terms of the MIT license. See LICENSE for details.
+ *
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+
+int isinteger(const char *str)
+{
+    int errs = errno, ret = 1;
+    long __attribute__((__unused__)) val;
+    char *endptr;
+
+    errno = 0;
+    val = strtol(str, &endptr, 10);
+
+    /* Check if no digits were found at all */
+    if (str == endptr)
+	ret = 0;
+
+    /* Check for overflow or underflow */
+    if (errno == ERANGE)
+	ret = 0;
+
+    /* Check for trailing non-numeric characters (e.g., "123abc") */
+    if (*endptr != '\0')
+	ret = 0;
+
+    errno = errs;
+    return ret;
+}
+
+#if defined(__s390__) || defined(__s390x__)
+
+#define	VMCP_DEVICE_NODE	"/dev/vmcp"
+#define	VMCP_GETSIZE		_IOR(0x10, 3, int)
+#define	VMCP_SETBUF		_IOW(0x10, 2, int)
+#define	VMCP_GETCODE		_IOR(0x10, 1, int)
+
+static char *more, *hold;
+static int spooling;
+
+int openvmcp(void)
+{
+    return open(VMCP_DEVICE_NODE, O_RDWR|O_NOCTTY);
+}
+
+void clearvmcp(void)
+{
+    if (more) {
+	free(more);
+	more = NULL;
+    }
+    if (hold) {
+	free(hold);
+	hold = NULL;
+    }
+}
+
+static char* askvmcp(int fd, const char *question)
+{
+    long pagesize = sysconf(_SC_PAGESIZE);
+    int rc = 0, num, buffersize;
+    char* ret = NULL;
+
+    num = (strlen(question) + pagesize - 1)/pagesize;
+    buffersize = num * pagesize;
+
+    if (ioctl(fd, VMCP_SETBUF, &buffersize) == -1)
+	goto out;
+    do {
+	rc = write(fd, question, strlen(question));
+	if (rc < 0) {
+	    if (errno != EINTR)
+		goto out;
+	}
+    } while (rc < 0);
+    if (ioctl(fd, VMCP_GETCODE, &rc) == -1)
+	goto out;
+    if (ioctl(fd, VMCP_GETSIZE, &buffersize) == -1)
+	goto out;
+    ret = (char*)malloc(buffersize);
+    if (!ret)
+	goto out;
+    do {
+	rc = read(fd, ret, buffersize);
+	if (rc < 0) {
+	    if (errno != EINTR)
+		goto out;
+	}
+    } while (rc < 0);
+out:
+    return ret;
+}
+
+char* queryterm(int fd)
+{
+    const char* question = "QUERY TERMINAL";
+    return askvmcp(fd, question);
+}
+
+char* queryspool(int fd)
+{
+    const char* question = "QUERY VIRTUAL CONSOLE";
+    return askvmcp(fd, question);
+}
+
+static int writevmcp(int fd, char *instruction)
+{
+    long pagesize = sysconf(_SC_PAGESIZE);
+    int rc = 0, num, buffersize;
+    int ret = -1;
+
+    num = (strlen(instruction) + pagesize - 1)/pagesize;
+    buffersize = num * pagesize;
+
+    if (ioctl(fd, VMCP_SETBUF, &buffersize) == -1)
+	goto out;
+    do {
+	rc = write(fd, instruction, strlen(instruction));
+	if (rc < 0) {
+	    if (errno != EINTR)
+		goto out;
+	}
+    } while (rc < 0);
+    if (ioctl(fd, VMCP_GETCODE, &rc) == -1)
+	goto out;
+    if (ioctl(fd, VMCP_GETSIZE, &buffersize) == -1)
+	goto out;
+    if (rc == 0 && buffersize == 0)
+	ret = 0;
+out:
+    return ret;
+}
+
+int setterm(int fd, char *tout)
+{
+    char *instruction;
+    int ret = -1;
+
+    if (asprintf(&instruction, "TERMINAL MORE %s 0 HOLD OFF", tout) == -1)
+	goto out;
+
+    ret = writevmcp(fd, instruction);
+    free(instruction);
+out:
+    return ret;
+}
+
+int restoreterm(int fd)
+{
+    char* instruction;
+    int ret = -1;
+
+    if (!more || !hold)
+	goto out;
+    if (asprintf(&instruction, "TERMINAL %s %s", more, hold) == -1)
+	goto out;
+
+    ret = writevmcp(fd, instruction);
+    free(instruction);
+out:
+    return ret;
+}
+
+int stopspool(int fd)
+{
+    char* instruction = "SPOOL CONSOLE STOP";
+    if (!spooling)
+	return 1;
+    return writevmcp(fd, instruction);
+}
+
+int restorespool(int fd)
+{
+    char* instruction = "SPOOL CONSOLE START";
+    if (!spooling)
+	return 1;
+    return writevmcp(fd, instruction);
+}
+
+void parseterm(char *msg)
+{
+    int n;
+    char *token, *ptr;
+    for (n = 1, ptr = msg; ; n++, ptr = NULL) {
+	token = strtok(ptr, ",\n");
+	if (!token)
+	    break;
+	if (hold && more)
+	    break;
+	while (*token == ' ')
+	    token++;
+	if (strncmp("MORE ", token, 5) == 0)
+	    more = strdup(token);
+	if (strncmp("HOLD ", token, 5) == 0)
+	    hold = strdup(token);
+    }
+}
+
+void parsespool(char *msg)
+{
+    spooling = 0;
+    if (strstr(msg, " TERM START ") != NULL)
+	spooling = 1;
+}
+
+void warning3215(int fd)
+{
+    /*
+     * Warning: Do not translate this test as it might inlude then so called
+     * umlauts which in fact can not be encoded for the 3215 console interface.
+     * The 3215 console driver work in fact with EBCDIC codepage and the
+     * kernel has to translate such umlauts (multi or single bytes) with the
+     * correct EBCDIC character table (for german e.g. IBM-1141 or IBM-273).
+     */
+    (void) writevmcp(fd, "MESSAGE * WARNING: 3215 mode. Password visible!");
+    (void) writevmcp(fd, "MESSAGE * Ensure nobody is watching the screen.");
+}
+#endif
diff --git a/login-utils/vmcp.h b/login-utils/vmcp.h
new file mode 100644
index 000000000..50ef1ba90
--- /dev/null
+++ b/login-utils/vmcp.h
@@ -0,0 +1,29 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * vmcp.c - s390x 3215 console spool and terminal management
+ *
+ * Copyright 2026 Werner Fink, SUSE Software Solutions Germany GmbH
+ *
+ * Based on:
+ *
+ * Copyright IBM Corp. 2018
+ * s390-tools is free software; you can redistribute it and/or modify
+ * it under the terms of the MIT license. See LICENSE for details.
+ *
+ */
+
+extern int isinteger(const char *str);
+#if defined(__s390__) || defined(__s390x__)
+extern int openvmcp(void);
+extern void clearvmcp(void);
+extern char* queryterm(int fd);
+extern char* queryspool(int fd);
+extern int setterm(int fd, char *tout);
+extern int stopspool(int fd);
+extern int restoreterm(int fd);
+extern int restorespool(int fd);
+extern void parseterm(char *msg);
+extern void parsespool(char *msg);
+extern void warning3215(int fd);
+#endif
-- 
2.51.0

