Return-Path: <SRS0=SH8e=M4=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22826C04EBD
	for <util-linux@archiver.kernel.org>; Tue, 16 Oct 2018 06:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A9820881
	for <util-linux@archiver.kernel.org>; Tue, 16 Oct 2018 06:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A9820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJPObD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:31:03 -0400
Received: from shell.v3.sk ([90.176.6.54]:50743 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbeJPObD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 Oct 2018 10:31:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D8246B8D64;
        Tue, 16 Oct 2018 08:42:03 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bAUZH0qN1o8o; Tue, 16 Oct 2018 08:41:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 959F5BD75D;
        Tue, 16 Oct 2018 08:41:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KiZWOAI9nk43; Tue, 16 Oct 2018 08:41:56 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6DB89B8D64;
        Tue, 16 Oct 2018 08:41:56 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     util-linux@vger.kernel.org
Cc:     Karel Zak <kzak@redhat.com>, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2] agetty: don't put the VC into canonical mode
Date:   Tue, 16 Oct 2018 08:41:49 +0200
Message-Id: <20181016064149.2698-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The wait_for_term_input()'s select() needs to be tripped when the user
starts typing. Otherwise the reloads can abort an already in-progress log=
in.

Coupled with \4 and \6 expansions that happen to be there on Fedora Serve=
r,
this means reload on every netlink event. With a couple of IPv6 routers
announcing their networks and temporary addresses in use can make it
sometimes virtually impossible to log in.

Seems like zero lflags do the job just fine on a Linux VT. Reset it to
canonical mode before running login.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Unreversed the logic in termio_final()/reset_vc() conditional

Tested on a vc and serial console on a stock Fedora installation:

  /sbin/agetty -o -p -- \u --noclear tty1 linux
  /sbin/agetty -o -p -- \u --keep-baud 115200,38400,9600 ttyS2 vt220

 term-utils/agetty.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 3c87ec64e..3834813f1 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -303,7 +303,7 @@ static void parse_speeds(struct options *op, char *ar=
g);
 static void update_utmp(struct options *op);
 static void open_tty(char *tty, struct termios *tp, struct options *op);
 static void termio_init(struct options *op, struct termios *tp);
-static void reset_vc (const struct options *op, struct termios *tp);
+static void reset_vc(const struct options *op, struct termios *tp, int c=
anon);
 static void auto_baud(struct termios *tp);
 static void list_speeds(void);
 static void output_special_char (unsigned char c, struct options *op,
@@ -485,13 +485,14 @@ int main(int argc, char **argv)
 	if (options.timeout)
 		alarm(0);
=20
-	if ((options.flags & F_VCONSOLE) =3D=3D 0) {
-		/* Finalize the termios settings. */
+	/* Finalize the termios settings. */
+	if ((options.flags & F_VCONSOLE) =3D=3D 0)
 		termio_final(&options, &termios, &chardata);
+	else
+		reset_vc(&options, &termios, 1);
=20
-		/* Now the newline character should be properly written. */
-		write_all(STDOUT_FILENO, "\r\n", 2);
-	}
+	/* Now the newline character should be properly written. */
+	write_all(STDOUT_FILENO, "\r\n", 2);
=20
 	sigaction(SIGQUIT, &sa_quit, NULL);
 	sigaction(SIGINT, &sa_int, NULL);
@@ -1234,7 +1235,7 @@ static void termio_init(struct options *op, struct =
termios *tp)
 		setlocale(LC_CTYPE, "POSIX");
 		op->flags &=3D ~F_UTF8;
 #endif
-		reset_vc(op, tp);
+		reset_vc(op, tp, 0);
=20
 		if ((tp->c_cflag & (CS8|PARODD|PARENB)) =3D=3D CS8)
 			op->flags |=3D F_EIGHTBITS;
@@ -1344,7 +1345,7 @@ static void termio_init(struct options *op, struct =
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
@@ -1353,6 +1354,15 @@ static void reset_vc(const struct options *op, str=
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
2.19.1

