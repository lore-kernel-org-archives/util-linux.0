Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F57D35F8D1
	for <util-linux@vger.kernel.org>; Thu, 21 May 2026 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354770; cv=none; b=OYuxSbtuvYfwiyN1Y+WouzTngajjx8i0yVy8v8xCq7v/yrHEJlPRnjcYC/umh0RXZ+OqD4p5/B82Dtsy++uw45AumPSHRV85Jm77c8dR0vyZSE1eJk6DzSWf55MJExJqC1dqT+Jhd5qmBNJ3AzETBP6dZ3u3u3109fgtHvnEvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354770; c=relaxed/simple;
	bh=N5d7wfdAjFTHLbrWtFXq3dgUNsXSY1ea9Xc3H5z4J5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQmkM3Xpsz2p1g9fCHWbi5Fk1F8MBIA4tnIciSvy/d45LGNcW+bhJniQK/wK/B7IebkE8NUMZhoH05cOanXprronm5fJLclWFEz0ecPz6oQUDzLrqDCJPrXSux+UuGMDRp8+mb+EEtN10b86SR1hIM88AK/gGH1HpNQzJyJWrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DD/PTOha; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2FGDZ0Gi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DD/PTOha; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2FGDZ0Gi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DD/PTOha";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2FGDZ0Gi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DD/PTOha";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2FGDZ0Gi"
Received: from boole.nue2.suse.org (unknown [IPv6:2a07:de40:a101:3:21c:c0ff:fea4:1c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68DE46B42E;
	Thu, 21 May 2026 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779354766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6Hi9zTyTwVBzAZt0YGGI60cIxyMxxgMIabnszWBDn4=;
	b=DD/PTOha/Hi7lUc9+ySRyO24u0c1iZO8gbg92Q+mnmYbsFDW8z8nYt/ALO5uYTFoHkfMF3
	om6LVdIygRco/5jp8JIKeluu6JHFu2fkM3E9kwyoHQLB4FywaFsnnQsYymmC0i9SO+ob3j
	evjyFmFa7Nk93XMRWtR4sPzLIIB1Cnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779354766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6Hi9zTyTwVBzAZt0YGGI60cIxyMxxgMIabnszWBDn4=;
	b=2FGDZ0GiPOoY/EpkHmXqKDcw9S+S7yBFWy3WGdvLlm9zTiT18Xxy2CnUZ1Ko6MCidG0fmB
	puGN8YEtszYpDpAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DD/PTOha";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2FGDZ0Gi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779354766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6Hi9zTyTwVBzAZt0YGGI60cIxyMxxgMIabnszWBDn4=;
	b=DD/PTOha/Hi7lUc9+ySRyO24u0c1iZO8gbg92Q+mnmYbsFDW8z8nYt/ALO5uYTFoHkfMF3
	om6LVdIygRco/5jp8JIKeluu6JHFu2fkM3E9kwyoHQLB4FywaFsnnQsYymmC0i9SO+ob3j
	evjyFmFa7Nk93XMRWtR4sPzLIIB1Cnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779354766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6Hi9zTyTwVBzAZt0YGGI60cIxyMxxgMIabnszWBDn4=;
	b=2FGDZ0GiPOoY/EpkHmXqKDcw9S+S7yBFWy3WGdvLlm9zTiT18Xxy2CnUZ1Ko6MCidG0fmB
	puGN8YEtszYpDpAw==
Received: from boole.nue2.suse.org (localhost [127.0.0.1])
	by boole.nue2.suse.org (8.18.1/8.18.1/SUSE Linux 0.8) with ESMTPS id 64L9Chph010875
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 11:12:46 +0200
Received: (from werner@localhost)
	by boole.nue2.suse.org (8.18.1/8.18.1/Submit) id 64L9ChDn010874;
	Thu, 21 May 2026 11:12:43 +0200
Date: Thu, 21 May 2026 11:12:39 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: Repost: [PATCH] Secure login and sulogin on S390x
Message-ID: <ag7Mi1xhgyHjWhNn@boole.nue2.suse.org>
Mail-Followup-To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
References: <20260429092825.17623-2-werner@suse.de>
 <afjqh57bXkLJ_FKr@zeha.at>
 <afm64TLjowwedG4l@boole.nue2.suse.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C45Z/BgH72QhlrEm"
Content-Disposition: inline
In-Reply-To: <afm64TLjowwedG4l@boole.nue2.suse.org>
X-GPG-Fingerprint: 1B06 BF5A 3829 90FB CBA2  75BE 50E9 0D55 1DC1 6B2E
X-MS-Reactions: disallow
X-Spamd-Result: default: False [0.19 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SIGNED_PGP(-2.00)[];
	RDNS_NONE(2.00)[];
	FROM_NAME_HAS_TITLE(1.00)[dr];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_IP_A(1.00)[boole.nue2.suse.org];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[boole.nue2.suse.org];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain,text/x-patch];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:21c:c0ff:fea4:1c14:from];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 68DE46B42E
X-Spam-Flag: NO
X-Spam-Score: 0.19
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 


--C45Z/BgH72QhlrEm
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="hOqMEJ4xrNXeRz3w"
Content-Disposition: inline
Date: Thu, 21 May 2026 11:12:39 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: Repost: [PATCH] Secure login and sulogin on S390x


--hOqMEJ4xrNXeRz3w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

just to be sure that this change for s390x does not fall down behind.
Are there some changes required?

Werner

--=20
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--hOqMEJ4xrNXeRz3w
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: attachment; filename=resend.patch
Content-Transfer-Encoding: quoted-printable

=46rom e307759459f58a5d36d879bdf838e8319580a7bd Mon Sep 17 00:00:00 2001
=46rom: Werner Fink <werner@suse.de>
Date: Thu, 21 May 2026 10:46:13 +0200
Subject: [PATCH] Secure login and sulogin on S390x

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

Ensure to detect all special console case on S390x

Signed-off-by: Werner Fink <werner@suse.de>
---
 lib/ttyutils.c                 |   5 +-
 login-utils/Makemodule.am      |   9 +-
 login-utils/login.c            |  85 +++++++++++-
 login-utils/meson.build        |   5 +
 login-utils/sulogin-consoles.c |  44 ++++--
 login-utils/sulogin-consoles.h |   4 +
 login-utils/sulogin.c          |  64 +++++++--
 login-utils/vmcp.c             | 236 +++++++++++++++++++++++++++++++++
 login-utils/vmcp.h             |  29 ++++
 9 files changed, 460 insertions(+), 21 deletions(-)
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
@@ -176,7 +176,8 @@ char *get_terminal_default_type(const char *ttyname, in=
t is_serial)
 		 * Special terminal on first serial line on a S/390(x) which
 		 * is due legacy reasons a block terminal of type 3270 or
 		 * higher.  Whereas the second serial line on a S/390(x) is
-		 * a real character terminal which is compatible with VT220.
+		 * a real character terminal which is compatible with "sclp"
+		 * since ncurses 6.5-20250405 for e.g. color support.
 		 */
 		if (strcmp(ttyname, "ttyS0") =3D=3D 0)		/* linux/drivers/s390/char/con32=
15.c */
 			return strdup(DEFAULT_TTYS0);
diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index a82e4b70f..4e3205577 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -33,7 +33,9 @@ dist_noinst_DATA +=3D login-utils/sulogin.8.adoc
 sulogin_SOURCES =3D \
 	login-utils/sulogin.c \
 	login-utils/sulogin-consoles.c \
-	login-utils/sulogin-consoles.h
+	login-utils/sulogin-consoles.h \
+	login-utils/vmcp.c \
+	login-utils/vmcp.h
 if USE_PLYMOUTH_SUPPORT
 sulogin_SOURCES +=3D lib/plymouth-ctrl.c
 endif
@@ -58,7 +60,10 @@ bin_PROGRAMS +=3D login
 MANPAGES +=3D login-utils/login.1
 dist_noinst_DATA +=3D login-utils/login.1.adoc
 login_SOURCES =3D \
-	login-utils/login.c
+	login-utils/login.c \
+	login-utils/vmcp.c \
+	login-utils/vmcp.h \
+	lib/logindefs.c
 login_LDADD =3D $(LDADD) libcommon.la libcommon_logindefs.la libcommon_she=
lls.la -lpam
 if HAVE_LINUXPAM
 login_LDADD +=3D -lpam_misc
diff --git a/login-utils/login.c b/login-utils/login.c
index da119ee98..5730c449b 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -85,6 +85,7 @@
 #include "pwdutils.h"
=20
 #include "logindefs.h"
+#include "vmcp.h"
=20
 #if defined (HAVE_LIBECONF) && defined (USE_VENDORDIR)
 # include "shells.h"
@@ -165,6 +166,85 @@ static int is_consoletty(int fd)
 }
 #endif
=20
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
+	struct s390con con =3D { .flags =3D 0, .vmcpfd =3D -1 };
+
+	if ((fstat(fd, &stb) >=3D 0)) {
+		if (major(stb.st_rdev) =3D=3D 4 && minor(stb.st_rdev) =3D=3D 64)
+			con.flags |=3D CON_3215;
+		if (major(stb.st_rdev) =3D=3D 4 && minor(stb.st_rdev) >=3D 65)
+			con.flags |=3D CON_SCLP;
+		else if (major(stb.st_rdev) =3D=3D 227 && minor(stb.st_rdev) >=3D 1)
+			con.flags |=3D CON_3270;
+	}
+	if (con.flags & (CON_3215|CON_3270)) {
+		con.vmcpfd =3D openvmcp();
+		if (con.vmcpfd >=3D 0) {
+			char *msg =3D queryspool(con.vmcpfd);
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
+		if (con.vmcpfd >=3D 0) {
+			char *msg =3D queryterm(con.vmcpfd);
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
+	if (con->vmcpfd >=3D 0) {
+		if (con->flags & CON_3215)
+			restoreterm(con->vmcpfd);
+		if (con->flags & (CON_3215|CON_3270))
+			restorespool(con->vmcpfd);
+		clearvmcp();
+		close(con->vmcpfd);
+		con->vmcpfd =3D -1;
+	}
+}
+# define PREPARE_CONSOLE(fd)	struct s390con con =3D s390_console_spool_sto=
p(fd)
+# define RESTORE_CONSOLE()	s390_console_spool_restore(&con)
+#else
+# define PREPARE_CONSOLE(fd)	/* */
+# define RESTORE_CONSOLE()	/* */
+#endif
+
 /*
  * Robert Ambrose writes:
  * A couple of my users have a problem with login processes hanging around
@@ -1584,8 +1664,11 @@ int main(int argc, char **argv)
 	/* login -f, then the user has already been authenticated */
 	cxt.noauth =3D cxt.noauth && getuid() =3D=3D 0 ? 1 : 0;
=20
-	if (!cxt.noauth)
+	if (!cxt.noauth) {
+		PREPARE_CONSOLE(0);
 		loginpam_auth(&cxt);
+		RESTORE_CONSOLE();
+        }
=20
 	/*
 	 * Authentication may be skipped (for example, during krlogin, rlogin,
diff --git a/login-utils/meson.build b/login-utils/meson.build
index 251d8de46..5f6310b01 100644
--- a/login-utils/meson.build
+++ b/login-utils/meson.build
@@ -49,6 +49,7 @@ test_islocal_sources =3D files(
=20
 test_consoles_sources =3D files(
   'sulogin-consoles.c',
+  'vmcp.c',
 )
=20
 last_sources =3D files(
@@ -59,6 +60,8 @@ last_manadocs =3D files('last.1.adoc')
=20
 login_sources =3D files(
   'login.c',
+  'vmcp.c',
+  'vmcp.h',
 )
 login_manadocs =3D files('login.1.adoc')
=20
@@ -66,6 +69,8 @@ sulogin_sources =3D files(
   'sulogin.c',
   'sulogin-consoles.c',
   'sulogin-consoles.h',
+  'vmcp.c',
+  'vmcp.h',
 )
 sulogin_manadocs =3D files('sulogin.8.adoc')
=20
diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index c8156bfec..2d838f20e 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -312,7 +312,7 @@ static
 #ifdef __GNUC__
 __attribute__((__hot__))
 #endif
-int append_console(struct list_head *consoles, const char * const name)
+int append_console(struct list_head *consoles, const char * const name, de=
v_t dev)
 {
 	struct console *restrict tail;
 	const struct console *last =3D NULL;
@@ -343,7 +343,29 @@ int append_console(struct list_head *consoles, const c=
har * const name)
 	tail->reset_tty_context =3D NULL;
 	tail->user_tty_context =3D NULL;
 #endif
-
+#if defined(__s390__) || defined(__s390x__)
+	/*
+	 * Stat the device path to determine its major/minor numbers.=20
+	 * This ensures we detect s390x terminal types regardless of whether=20
+	 * the console was found via /proc, /sys, cmdline, or a direct stdin=20
+	 * fallback (e.g. sulogin < /dev/ttyS0).
+	 */
+	if (!dev) {
+		struct stat st;
+		if (stat(name, &st) =3D=3D 0 && S_ISCHR(st.st_mode))
+			dev =3D st.st_rdev;
+	}
+	if (dev) {
+		unsigned int maj =3D major(dev);
+		unsigned int min =3D minor(dev);
+		if (maj =3D=3D 4 && min =3D=3D 64)
+			tail->flags |=3D CON_3215;
+		else if (maj =3D=3D 4 && min >=3D 65)
+			tail->flags |=3D CON_SCLP;
+		else if (maj =3D=3D 227 && min >=3D 1)
+			tail->flags |=3D CON_3270;
+	}
+#endif
 	return 0;
 }
=20
@@ -385,10 +407,16 @@ static int detect_consoles_from_proc(struct list_head=
 *consoles)
 		name =3D scandev(dir, comparedev);
 		if (!name)
 			continue;
-		rc =3D append_console(consoles, name);
+		rc =3D append_console(consoles, name, comparedev);
 		free(name);
 		if (rc < 0)
 			goto done;
+		if (!list_empty(consoles)) {
+			struct console *last;
+			last =3D list_last_entry(consoles, struct console, entry);
+			if (!strchr(fbuf, 'C'))
+				last->flags |=3D CON_CONSDEV;
+		}
 	}
=20
 	rc =3D list_empty(consoles) ? 1 : 0;
@@ -447,7 +475,7 @@ static int detect_consoles_from_sysfs(struct list_head =
*consoles)
 		name =3D scandev(dir, comparedev);
 		if (!name)
 			continue;
-		rc =3D append_console(consoles, name);
+		rc =3D append_console(consoles, name, comparedev);
 		free(name);
 		if (rc < 0)
 			goto done;
@@ -535,7 +563,7 @@ static int detect_consoles_from_cmdline(struct list_hea=
d *consoles)
 		name =3D scandev(dir, comparedev);
 		if (!name)
 			continue;
-		rc =3D append_console(consoles, name);
+		rc =3D append_console(consoles, name, comparedev);
 		free(name);
 		if (rc < 0)
 			goto done;
@@ -593,7 +621,7 @@ static int detect_consoles_from_tiocgdev(struct list_he=
ad *consoles,
 			goto done;
 		}
 	}
-	rc =3D append_console(consoles, name);
+	rc =3D append_console(consoles, name, comparedev);
 	free(name);
 	if (rc < 0)
 		goto done;
@@ -707,7 +735,7 @@ int detect_consoles(const char *device, const int fallb=
ack, struct list_head *co
 		closedir(dir);
=20
 		if (name) {
-			rc =3D append_console(consoles, name);
+			rc =3D append_console(consoles, name, comparedev);
 			free(name);
 			if (rc < 0)
 				return rc;
@@ -784,7 +812,7 @@ fallback:
 		n =3D strdup(name);
 		if (!n)
 			return -ENOMEM;
-		rc =3D append_console(consoles, n);
+		rc =3D append_console(consoles, n, 0);
 		free(n);
 		if (rc < 0)
 			return rc;
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
=20
 static unsigned int timeout;
@@ -218,7 +219,7 @@ static void tcinit(struct console *con)
 #endif
=20
 #ifdef KDGKBMODE
-	if (!(con->flags & CON_SERIAL)
+	if (!(con->flags & (CON_SERIAL|CON_3215|CON_3270|CON_SCLP))
 	    && ioctl(fd, KDGKBMODE, &mode) < 0)
 		con->flags |=3D CON_SERIAL;
 	errno =3D 0;
@@ -265,6 +266,13 @@ static void tcinit(struct console *con)
 		}
 	}
=20
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
=20
 #ifdef HAVE_STRUCT_TERMIOS_C_LINE
-		tio->c_line         =3D 0;
+		tio->c_line	 =3D 0;
 #endif
 		tio->c_cc[VTIME]    =3D 0;
 		tio->c_cc[VMIN]     =3D 1;
@@ -364,6 +372,10 @@ static void tcfinal(struct console *con)
 		free(term);
 	}
=20
+#if defined(__s390__) || defined(__s390x__)
+	if (con->flags & (CON_3215|CON_3270))
+		return;
+#endif
 	if (!(con->flags & CON_SERIAL) || (con->flags & CON_NOTTY))
 		return;
=20
@@ -983,9 +995,9 @@ static void usage(void)
 	fputs(_("Single-user login.\n"), out);
=20
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -p, --login-shell        start a login shell\n"
+	fputs(_(" -p, --login-shell	start a login shell\n"
 		" -t, --timeout <seconds>  max time to wait for a password (default: no =
limit)\n"
-		" -e, --force              examine password files directly if getpwnam(3=
) fails\n"),
+		" -e, --force	      examine password files directly if getpwnam(3) fails=
\n"),
 		out);
=20
 	fputs(USAGE_SEPARATOR, out);
@@ -1012,8 +1024,8 @@ int main(int argc, char **argv)
 	static const struct option longopts[] =3D {
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
 				int doshell =3D 0;
 				int deny =3D !opt_e && locked_account_password(pwd->pw_passwd);
-
+#if defined(__s390__) || defined(__s390x__)
+				int vmcpfd =3D -1;
+				if (con->flags & (CON_3215|CON_3270)) {
+					vmcpfd =3D openvmcp();
+					if (vmcpfd >=3D 0) {
+						char *msg =3D queryspool(vmcpfd);
+						if (msg) {
+							parsespool(msg);
+							free(msg);
+						}
+						stopspool(vmcpfd);
+					}
+				}
+				if (con->flags & CON_3215) {
+					if (vmcpfd >=3D 0) {
+						char *msg =3D queryterm(vmcpfd);
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
=20
-				if ((answer =3D getpasswd(con)) =3D=3D NULL)
+				answer =3D getpasswd(con);
+#if defined(__s390__) || defined(__s390x__)
+				if (vmcpfd >=3D 0) {
+					if (con->flags & CON_3215)
+						restoreterm(vmcpfd);
+					if (con->flags & (CON_3215|CON_3270))
+						restorespool(vmcpfd);
+					clearvmcp();
+					close(vmcpfd);
+					vmcpfd =3D -1;
+				}
+#endif
+				if (answer =3D=3D NULL)
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
+    int errs =3D errno, ret =3D 1;
+    long __attribute__((__unused__)) val;
+    char *endptr;
+
+    errno =3D 0;
+    val =3D strtol(str, &endptr, 10);
+
+    /* Check if no digits were found at all */
+    if (str =3D=3D endptr)
+	ret =3D 0;
+
+    /* Check for overflow or underflow */
+    if (errno =3D=3D ERANGE)
+	ret =3D 0;
+
+    /* Check for trailing non-numeric characters (e.g., "123abc") */
+    if (*endptr !=3D '\0')
+	ret =3D 0;
+
+    errno =3D errs;
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
+	more =3D NULL;
+    }
+    if (hold) {
+	free(hold);
+	hold =3D NULL;
+    }
+}
+
+static char* askvmcp(int fd, const char *question)
+{
+    long pagesize =3D sysconf(_SC_PAGESIZE);
+    int rc =3D 0, num, buffersize;
+    char* ret =3D NULL;
+
+    num =3D (strlen(question) + pagesize - 1)/pagesize;
+    buffersize =3D num * pagesize;
+
+    if (ioctl(fd, VMCP_SETBUF, &buffersize) =3D=3D -1)
+	goto out;
+    do {
+	rc =3D write(fd, question, strlen(question));
+	if (rc < 0) {
+	    if (errno !=3D EINTR)
+		goto out;
+	}
+    } while (rc < 0);
+    if (ioctl(fd, VMCP_GETCODE, &rc) =3D=3D -1)
+	goto out;
+    if (ioctl(fd, VMCP_GETSIZE, &buffersize) =3D=3D -1)
+	goto out;
+    ret =3D (char*)malloc(buffersize);
+    if (!ret)
+	goto out;
+    do {
+	rc =3D read(fd, ret, buffersize);
+	if (rc < 0) {
+	    if (errno !=3D EINTR)
+		goto out;
+	}
+    } while (rc < 0);
+out:
+    return ret;
+}
+
+char* queryterm(int fd)
+{
+    const char* question =3D "QUERY TERMINAL";
+    return askvmcp(fd, question);
+}
+
+char* queryspool(int fd)
+{
+    const char* question =3D "QUERY VIRTUAL CONSOLE";
+    return askvmcp(fd, question);
+}
+
+static int writevmcp(int fd, char *instruction)
+{
+    long pagesize =3D sysconf(_SC_PAGESIZE);
+    int rc =3D 0, num, buffersize;
+    int ret =3D -1;
+
+    num =3D (strlen(instruction) + pagesize - 1)/pagesize;
+    buffersize =3D num * pagesize;
+
+    if (ioctl(fd, VMCP_SETBUF, &buffersize) =3D=3D -1)
+	goto out;
+    do {
+	rc =3D write(fd, instruction, strlen(instruction));
+	if (rc < 0) {
+	    if (errno !=3D EINTR)
+		goto out;
+	}
+    } while (rc < 0);
+    if (ioctl(fd, VMCP_GETCODE, &rc) =3D=3D -1)
+	goto out;
+    if (ioctl(fd, VMCP_GETSIZE, &buffersize) =3D=3D -1)
+	goto out;
+    if (rc =3D=3D 0 && buffersize =3D=3D 0)
+	ret =3D 0;
+out:
+    return ret;
+}
+
+int setterm(int fd, char *tout)
+{
+    char *instruction;
+    int ret =3D -1;
+
+    if (asprintf(&instruction, "TERMINAL MORE %s 0 HOLD OFF", tout) =3D=3D=
 -1)
+	goto out;
+
+    ret =3D writevmcp(fd, instruction);
+    free(instruction);
+out:
+    return ret;
+}
+
+int restoreterm(int fd)
+{
+    char* instruction;
+    int ret =3D -1;
+
+    if (!more || !hold)
+	goto out;
+    if (asprintf(&instruction, "TERMINAL %s %s", more, hold) =3D=3D -1)
+	goto out;
+
+    ret =3D writevmcp(fd, instruction);
+    free(instruction);
+out:
+    return ret;
+}
+
+int stopspool(int fd)
+{
+    char* instruction =3D "SPOOL CONSOLE STOP";
+    if (!spooling)
+	return 1;
+    return writevmcp(fd, instruction);
+}
+
+int restorespool(int fd)
+{
+    char* instruction =3D "SPOOL CONSOLE START";
+    if (!spooling)
+	return 1;
+    return writevmcp(fd, instruction);
+}
+
+void parseterm(char *msg)
+{
+    int n;
+    char *token, *ptr;
+    for (n =3D 1, ptr =3D msg; ; n++, ptr =3D NULL) {
+	token =3D strtok(ptr, ",\n");
+	if (!token)
+	    break;
+	if (hold && more)
+	    break;
+	while (*token =3D=3D ' ')
+	    token++;
+	if (strncmp("MORE ", token, 5) =3D=3D 0)
+	    more =3D strdup(token);
+	if (strncmp("HOLD ", token, 5) =3D=3D 0)
+	    hold =3D strdup(token);
+    }
+}
+
+void parsespool(char *msg)
+{
+    spooling =3D 0;
+    if (strstr(msg, " TERM START ") !=3D NULL)
+	spooling =3D 1;
+}
+
+void warning3215(int fd)
+{
+    /*
+     * Warning: Do not translate this test as it might inlude then so call=
ed
+     * umlauts which in fact can not be encoded for the 3215 console inter=
face.
+     * The 3215 console driver work in fact with EBCDIC codepage and the
+     * kernel has to translate such umlauts (multi or single bytes) with t=
he
+     * correct EBCDIC character table (for german e.g. IBM-1141 or IBM-273=
).
+     */
+    (void) writevmcp(fd, "MESSAGE * WARNING: 3215 mode. Password visible!"=
);
+    (void) writevmcp(fd, "MESSAGE * Ensure nobody is watching the screen."=
);
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
--=20
2.51.0


--hOqMEJ4xrNXeRz3w--

--C45Z/BgH72QhlrEm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJgBAABCABKFiEEGwa/WjgpkPvLonW+UOkNVR3Bay4FAmoOzIcsFIAAAAAAFQAO
cGthLWFkZHJlc3NAZ251cGcub3Jnd2VybmVyQHN1c2UuZGUACgkQUOkNVR3Bay5C
iA//dAT2pbRR4bq93VX4rK51WEDIQpb9D4oxmJNtsWitOvhWJDLZQIaCMkBvTYmk
8/7NsU1qWzFLzopEYLOHdMrSr7TjPEbRJ5eCtGfImjedC/w3NOoMfmRgaEuZHR9X
ATZ9Z9tHpVeCwQon0rHUypeUt4z8j1dKB8KoA+Bzg7bPz7l0lyw5a0sJ+d4BptTW
HSHbb7E21Qk/A0tQ7POPkx6b790B7sWGAZNigsnx8ChwXLhh8KCVAJ5sCaNKcz5U
PlFuH5VparMpxRDkiHuhtjGOXw9YdtBIiatA/lNhlMQdftvVghiid+HS8XH6XpU8
4qz5hQTpn8cFT35BfcCjzd49qsvpanoFLxU+hxVdeT4YAFRJSWpcZmNbwxeJ1Q3U
8bnAay+Hz8DJcsB7ydEBj8iYSCS+VySrlJWp+7mvXuE/aDO3nQycNHrWsHTu1BD7
8+4nCdFYd8tsqmkdr+kk79XSSZvHr2dWeOwdBJvs3HilHaiPQvHf4j7jf9UgsRmo
p2xodruf1fdGGUXdmXHeDmcg8JpvpBkTbM1IPP/a1mGUSsjTu0Ik1U+IpXREfMso
fphaJpEOaCL10EQI5fi64NumhHEa7JzEUb8jxnkoTzuoyL+zwnCSGxBConb1rvuc
ME/iamGzGMDZcSZYElsY/+mpyREl6XEGefsLnmsK/hLZFxw=
=N9AH
-----END PGP SIGNATURE-----

--C45Z/BgH72QhlrEm--
