Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEDFC7618B
	for <util-linux@archiver.kernel.org>; Tue, 14 Mar 2023 22:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCNWCe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Mar 2023 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCNWCe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Mar 2023 18:02:34 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96F8328205
        for <util-linux@vger.kernel.org>; Tue, 14 Mar 2023 15:02:32 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E13E3324C
        for <util-linux@vger.kernel.org>; Tue, 14 Mar 2023 23:02:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1678831351;
        bh=OzZeKPWHiQDf9Tg0tERermzrRiNs4muBuBODjalTH38=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=GhD6iFYExA4HoNFInq6ScGi9QUPgDUklQ0CctjtTJ2Rq7Px8uHlkr9b8huoCPThMX
         LqdexN215MfHclWj7pJRjUXhrrI4gstDPKnb5xo4yvJeUokVwQeLRaKC7BQHkbuVXp
         +kRXTQyRbdQbh9qcqTkHvsOzwlE2dfwgPtIcH4i+3yPTjQfRl+5B2hWJLaA4C3iP5Y
         P8PQy+ja0zYGE4K9qdvc4N17w89gstZyGStmUvzJrzEvmC1x6zGu5k+F5IKk3KHB5l
         6AX/6ohZpGjEsSCwcJTCUTKq2isBw1TeYoiXalkC3o2PSJG9LZ7mAbLFZak1q6yECH
         ErguWDw4yK7lg==
Date:   Tue, 14 Mar 2023 23:02:30 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 3/3] wall: use fputs_careful()
Message-ID: <f5b2384ae97efec2884ce9c34d591cc6b84c43a7.1678831302.git.nabijaczleweli@nabijaczleweli.xyz>
References: <5d68dce11f61b85743c36d57e2bd0d90e978a197.1678831302.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gwqdxensacrolbp4"
Content-Disposition: inline
In-Reply-To: <5d68dce11f61b85743c36d57e2bd0d90e978a197.1678831302.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--gwqdxensacrolbp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

LINE_MAX only applies to teletypes in canonical mode: when stdin is a
file, it could still very much tear; start off at 512 for the sprintf(),
then use getline() like in write.

The line wrapping has one suboptimal edge-case:
  $ wall < all

  Broadcast message from nabijaczleweli@tarta (pts/4) (Tue Mar 14 22:31:25
  2023):

  ^N^O^P^Q^R^S^T^U^V^W^X^Y^Z^[^\^]^^^_
  !"#$%&'()*+,-./0123456789:;<=3D>?@ABCDEFGHIJ
  KLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~^?\200\201\202\203\20=
4\205\206
  \207\210\211\212\213\214\215\216\217\220\221\222\223\224\225\226\227\230\=
231\232
  \233\234\235\236\237\240\241\242\243\244\245\246\247\250\251\252\253\254\=
255\256
  \257\260\261\262\263\264\265\266\267\270\271\272\273\274\275\276\277\300\=
301\302
  \303\304\305\306\307\310\311\312\313\314\315\316\317\320\321\322\323\324\=
325\326
  \327\330\331\332\333\334\335\336\337\340\341\342\343\344\345\346\347\350\=
351\352
  \353\354\355\356\357\360\361\362\363\364\365\366\367\370\371\372\373\374\=
375\376
  \377
but that's a pathological input, and the result is still infinitely
better than it was before, so fixing that is more trouble than it's
worth.

Bug-Debian: https://bugs.debian.org/826596
---
Please keep me in CC, as I'm not subscribed.

 include/carefulputc.h | 37 ++++++++++++++++++++++++++++++-------
 login-utils/last.c    |  2 +-
 term-utils/wall.c     | 38 ++++++--------------------------------
 term-utils/write.c    |  2 +-
 4 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/include/carefulputc.h b/include/carefulputc.h
index 416a347bf..589318bb0 100644
--- a/include/carefulputc.h
+++ b/include/carefulputc.h
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <wctype.h>
+#include <wchar.h>
 #include <stdbool.h>
=20
 #include "cctype.h"
@@ -15,35 +16,57 @@
  * The locale of the recipient is nominally unknown,
  * but it's a solid bet that it's compatible with the author's.
  */
-static inline int fputs_careful(const char * s, FILE *fp, const char ctrl,=
 bool cr_lf)
+static inline int fputs_careful(const char * s, FILE *fp, const char ctrl,=
 bool cr_lf, int soft_width)
 {
-	int ret =3D 0;
+	int ret =3D 0, col =3D 0;
=20
 	for (size_t slen =3D strlen(s); *s; ++s, --slen) {
-		if (*s =3D=3D '\n')
+		if (*s =3D=3D '\t')
+			col +=3D (7 - (col % 8)) - 1;
+		else if (*s =3D=3D '\r')
+			col =3D -1;
+		else if (*s =3D=3D '\a')
+			--col;
+
+		if ((soft_width && col >=3D soft_width) || *s =3D=3D '\n') {
+			if (soft_width) {
+				fprintf(fp, "%*s", soft_width - col, "");
+				col =3D 0;
+			}
 			ret =3D fputs(&"\r\n"[!cr_lf], fp);
-		else if (isprint(*s) || *s =3D=3D '\a' || *s =3D=3D '\t' || *s =3D=3D '\=
r')
+			if (*s =3D=3D '\n' || ret < 0)
+				goto wrote;
+		}
+
+		if (isprint(*s) || *s =3D=3D '\a' || *s =3D=3D '\t' || *s =3D=3D '\r') {
 			ret =3D putc(*s, fp);
-		else if (!c_isascii(*s)) {
+			++col;
+		} else if (!c_isascii(*s)) {
 			wchar_t w;
 			size_t clen =3D mbtowc(&w, s, slen);
 			switch(clen) {
 				case (size_t)-2:  // incomplete
 				case (size_t)-1:  // EILSEQ
 				nonprint:
-					ret =3D fprintf(fp, "\\%3hho", *s);
+					col +=3D ret =3D fprintf(fp, "\\%3hho", *s);
 					mbtowc(NULL, NULL, 0);
 					break;
 				default:
 					if(!iswprint(w))
 						goto nonprint;
 					ret =3D fwrite(s, 1, clen, fp);
+					if (soft_width)
+						col +=3D wcwidth(w);
 					s +=3D clen - 1;
 					slen -=3D clen - 1;
 					break;
 			}
-		} else
+		} else {
 			ret =3D fputs((char[]){ ctrl, *s ^ 0x40, '\0' }, fp);
+			col +=3D 2;
+		}
+
+	wrote:
 		if (ret < 0)
 			return EOF;
 	}
diff --git a/login-utils/last.c b/login-utils/last.c
index 1b45dbf24..d52148758 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -547,7 +547,7 @@ static int list(const struct last_control *ctl, struct =
utmpx *p, time_t logout_t
 	/*
 	 *	Print out "final" string safely.
 	 */
-	fputs_careful(final, stdout, '*', false);
+	fputs_careful(final, stdout, '*', false, false);
=20
 	if (len < 0 || (size_t)len >=3D sizeof(final))
 		putchar('\n');
diff --git a/term-utils/wall.c b/term-utils/wall.c
index a51a92829..377db4518 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -274,29 +274,13 @@ int main(int argc, char **argv)
 	exit(EXIT_SUCCESS);
 }
=20
-static void buf_putc_careful(FILE *fs, int c)
-{
-	if (isprint(c) || c =3D=3D '\a' || c =3D=3D '\t' || c =3D=3D '\r' || c =
=3D=3D '\n')
-		fputc(c, fs);
-	else if (!c_isascii(c))
-		fprintf(fs, "\\%3o", (unsigned char)c);
-	else
-		fputs((char[]){ '^', c ^ 0x40, '\0' }, fs);
-}
-
 static char *makemsg(char *fname, char **mvec, int mvecsz,
 		     size_t *mbufsize, int print_banner)
 {
-	register int ch, cnt;
-	char *p, *lbuf, *retbuf;
+	char *lbuf, *retbuf;
 	FILE * fs =3D open_memstream(&retbuf, mbufsize);
-	long line_max;
-
-	line_max =3D sysconf(_SC_LINE_MAX);
-	if (line_max <=3D 0)
-		line_max =3D 512;
-
-	lbuf =3D xmalloc(line_max);
+	size_t lbuflen =3D 512;
+	lbuf =3D xmalloc(lbuflen);
=20
 	if (print_banner =3D=3D TRUE) {
 		char *hostname =3D xgethostname();
@@ -329,7 +313,7 @@ static char *makemsg(char *fname, char **mvec, int mvec=
sz,
 		   will not overflow as long as %d takes at most 100 chars */
 		fprintf(fs, "\r%*s\r\n", TERM_WIDTH, " ");
=20
-		snprintf(lbuf, line_max,
+		snprintf(lbuf, lbuflen,
 				_("Broadcast message from %s@%s (%s) (%s):"),
 				whom, hostname, where, date);
 		fprintf(fs, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH, lbuf);
@@ -373,18 +357,8 @@ static char *makemsg(char *fname, char **mvec, int mve=
csz,
 		/*
 		 * Read message from stdin.
 		 */
-		while (fgets(lbuf, line_max, stdin)) {
-			for (cnt =3D 0, p =3D lbuf; (ch =3D *p) !=3D '\0'; ++p, ++cnt) {
-				if (cnt =3D=3D TERM_WIDTH || ch =3D=3D '\n') {
-					fprintf(fs, "%*s\r\n", TERM_WIDTH - cnt, "");
-					cnt =3D 0;
-				}
-				if (ch =3D=3D '\t')
-					cnt +=3D (7 - (cnt % 8));
-				if (ch !=3D '\n')
-					buf_putc_careful(fs, ch);
-			}
-		}
+		while (getline(&lbuf, &lbuflen, stdin) >=3D 0)
+			fputs_careful(lbuf, fs, '^', true, TERM_WIDTH);
 	}
 	fprintf(fs, "%*s\r\n", TERM_WIDTH, " ");
=20
diff --git a/term-utils/write.c b/term-utils/write.c
index b485e28fd..79d4e4758 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -276,7 +276,7 @@ static void do_write(const struct write_control *ctl)
 		if (signal_received)
 			break;
=20
-		if (fputs_careful(line, stdout, '^', true) =3D=3D EOF)
+		if (fputs_careful(line, stdout, '^', true, false) =3D=3D EOF)
 			err(EXIT_FAILURE, _("carefulputc failed"));
 	}
 	free(line);
--=20
2.30.2

--gwqdxensacrolbp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQQ7vYACgkQvP0LAY0m
WPGwsA/+JMke8UMYp5QUJYuoRHMZUy6L23BmkcEzwZnLbEoWDDU7z8kyNXDGmvUL
7MOE/pCxKmYvefdmLORx+h7dWCXqpegkD5ygDt0tynl2aX/CITyxNtwPD87PQyHn
EpZQXiKK2IggxG4uZSoI4eCdbCL2mOPAD9mu+J4Xjbs04r6tQjCmJkcJAxjtbn/m
g16hdAAkuhw7CQI21+BlM7IFoezbTOWwiUV0l9BVOsieQ6hwUV+rCIr4LlOPgOkd
TzvyoJsj9EubmRYF1cLFaSDMn1qHico6Cry2enS4L0PqtJ9dzzvC+jVHJa8B4zxl
qbMiWYpXcV6ozgVh9bYn2wqYRSd7gZut9eFyy/srSklUhucwtiRIZNAaGEhywaNU
CnHMsJl5+RhqQ6nfECNTCP8kgJzE2Ba6W8NUUlbtlGGSbDplNmF34MupaN69HyRE
hcjGKkc9QdIGlMVbb3AobtjknaN15MmhgvxSCKbrY0uGU1pFepyEEG6me+V3YzLd
IbEyLm1O1tpVK88If/XMJn/MShgfQZ+33gvNR4nMgj9Shunn+UegM46i46F8PvB8
neFn2dfn+5jU8XAH7bIRGBBv8b8uRF09d33PRJXctf25lTXLS3NnCbdPcwElMPD1
PnDAXD1qUkEce4lL6vdUEIIwGqI/ZVoh54D63HHylwJ5OJ1kQN8=
=nGqe
-----END PGP SIGNATURE-----

--gwqdxensacrolbp4--
