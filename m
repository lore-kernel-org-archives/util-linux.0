Return-Path: util-linux-owner@vger.kernel.org
Received: from shell.v3.sk ([90.176.6.54]:58937 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeIXQRF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Sep 2018 12:17:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CD98EBA29F
        for <util-linux@vger.kernel.org>; Mon, 24 Sep 2018 12:15:42 +0200 (CEST)
From: Lubomir Rintel <lkundrak@v3.sk>
To: util-linux@vger.kernel.org
Cc: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] agetty: don't put the VC into canonical mode
Date: Mon, 24 Sep 2018 12:15:35 +0200
Message-Id: <20180924101535.511758-1-lkundrak@v3.sk>
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The wait_for_term_input()'s select() needs to be tripped when the user
starts typing. Otherwise the reloads can abort an already in-progress log=
in.

Coupled with \4 and \6 expansions that happen to be there on Fedora Serve=
r,
this means reload on every netlink event. With a couple of IPv6 routers
announcing their networks and temporary addresses in use can make it
sometimes virtually impossible to log in.

Seems like zero lflags do the job just fine on a Linux VT. Reset it to
canonical mode before running login though.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 term-utils/agetty.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index e22600e28..b82faab8d 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -303,7 +303,7 @@ static void parse_speeds(struct options *op, char *ar=
g);
 static void update_utmp(struct options *op);
 static void open_tty(char *tty, struct termios *tp, struct options *op);
 static void termio_init(struct options *op, struct termios *tp);
-static void reset_vc (const struct options *op, struct termios *tp);
+static void reset_vc (const struct options *op, struct termios *tp, int =
canon);
 static void auto_baud(struct termios *tp);
 static void list_speeds(void);
 static void output_special_char (unsigned char c, struct options *op,
@@ -482,13 +482,14 @@ int main(int argc, char **argv)
 	if (options.timeout)
 		alarm(0);
=20
-	if ((options.flags & F_VCONSOLE) =3D=3D 0) {
-		/* Finalize the termios settings. */
+	/* Finalize the termios settings. */
+	if ((options.flags & F_VCONSOLE) =3D=3D 0)
+		reset_vc(&options, &termios, 1);
+	else
 		termio_final(&options, &termios, &chardata);
=20
-		/* Now the newline character should be properly written. */
-		write_all(STDOUT_FILENO, "\r\n", 2);
-	}
+	/* Now the newline character should be properly written. */
+	write_all(STDOUT_FILENO, "\r\n", 2);
=20
 	sigaction(SIGQUIT, &sa_quit, NULL);
 	sigaction(SIGINT, &sa_int, NULL);
@@ -1231,7 +1232,7 @@ static void termio_init(struct options *op, struct =
termios *tp)
 		setlocale(LC_CTYPE, "POSIX");
 		op->flags &=3D ~F_UTF8;
 #endif
-		reset_vc(op, tp);
+		reset_vc(op, tp, 0);
=20
 		if ((tp->c_cflag & (CS8|PARODD|PARENB)) =3D=3D CS8)
 			op->flags |=3D F_EIGHTBITS;
@@ -1341,7 +1342,7 @@ static void termio_init(struct options *op, struct =
termios *tp)
 }
=20
 /* Reset virtual console on stdin to its defaults */
-static void reset_vc(const struct options *op, struct termios *tp)
+static void reset_vc(const struct options *op, struct termios *tp, int c=
anon)
 {
 	int fl =3D 0;
=20
@@ -1350,6 +1351,15 @@ static void reset_vc(const struct options *op, str=
uct termios *tp)
=20
 	reset_virtual_console(tp, fl);
=20
+#ifdef AGETTY_RELOAD
+	/*
+	 * Discard all the flags that makes the line go canonical with echoing.
+	 * We need to know when the user starts typing.
+	 */
+	if (canon =3D=3D 0)
+		tp->c_lflag =3D 0;
+#endif
+
 	if (tcsetattr(STDIN_FILENO, TCSADRAIN, tp))
 		log_warn(_("setting terminal attributes failed: %m"));
=20
--=20
2.19.0
