Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636CDC61DA4
	for <util-linux@archiver.kernel.org>; Wed, 15 Mar 2023 15:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCOPQw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Mar 2023 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjCOPQv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Mar 2023 11:16:51 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5F665FE96
        for <util-linux@vger.kernel.org>; Wed, 15 Mar 2023 08:16:49 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 2DFFE33C2;
        Wed, 15 Mar 2023 16:16:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1678893409;
        bh=cq7I9LOd6uHY0HAfAHrQiS2lEqtB4sWBBQwIcwAgesc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4KAibYDkJM993hei00DDaSX1d6iKEQ1CCcXUiHewbNQWlcDRwfnTAtNKAuNODPdA
         Vc8tdLRYk1M+Ph5zXjitiH5gNXkPj7XVzxsLqKZryRhV5V41FH/VazhCw9sDAjMdcs
         aNNxCRXXEnSz3L2B3RQxDLKFIf0/wxLrfqueD4+tnHe08DCEOlFzOOGtz49ND6v1Zn
         fZVUEj+m1H4kk5TgebUSBsDyhxDW1vz4ELathkE5/1HR6/+bfvViycs6TR2+VgTOY/
         /cTbhx9EN5DsFY8k625ZAJ+ZX73z15x6vGINCACRzZxmzXCdhZt62OuQnV7ii5Mtjv
         y2XPOvTiobWpQ==
Date:   Wed, 15 Mar 2023 16:16:48 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH v2 3/3] wall: use fputs_careful()
Message-ID: <27c05ab3b8c265e00ca149d2c55caaadf0dfddf6.1678893303.git.nabijaczleweli@nabijaczleweli.xyz>
References: <20230315141649.d7d4ybcg3evyelpo@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxxjvolybaa5rzrs"
Content-Disposition: inline
In-Reply-To: <20230315141649.d7d4ybcg3evyelpo@ws.net.home>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--wxxjvolybaa5rzrs
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
 include/carefulputc.h | 42 +++++++++++++++++++++++++++++++++---------
 login-utils/last.c    |  2 +-
 term-utils/wall.c     | 38 ++++++--------------------------------
 term-utils/write.c    |  2 +-
 4 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/include/carefulputc.h b/include/carefulputc.h
index 740add68e..3cc6f7ff9 100644
--- a/include/carefulputc.h
+++ b/include/carefulputc.h
@@ -6,6 +6,7 @@
 #include <ctype.h>
 #ifdef HAVE_WIDECHAR
 #include <wctype.h>
+#include <wchar.h>
 #endif
 #include <stdbool.h>
=20
@@ -15,18 +16,35 @@
  * A puts() for use in write and wall (that sometimes are sgid tty).
  * It avoids control and invalid characters.
  * The locale of the recipient is nominally unknown,
- * but it's a solid bet that the encoding is compatible with the author's.
+ * but it's a solid bet that it's compatible with the author's.
+ * Use soft_width=3D0 to disable wrapping.
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
 			ret =3D fputs(cr_lf ? "\r\n" : "\n", fp);
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
 #ifdef HAVE_WIDECHAR
 			wchar_t w;
 			size_t clen =3D mbtowc(&w, s, slen);
@@ -35,21 +53,27 @@ static inline int fputs_careful(const char * s, FILE *f=
p, const char ctrl, bool
 				case (size_t)-1:  // EILSEQ
 					mbtowc(NULL, NULL, 0);
 				nonprint:
-					ret =3D fprintf(fp, "\\%3hho", *s);
+					col +=3D ret =3D fprintf(fp, "\\%3hho", *s);
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
 #else
-			ret =3D fprintf(fp, "\\%3hho", *s);
+			col +=3D ret =3D fprintf(fp, "\\%3hho", *s);
 #endif
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
index 1b45dbf24..37c6abe97 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -547,7 +547,7 @@ static int list(const struct last_control *ctl, struct =
utmpx *p, time_t logout_t
 	/*
 	 *	Print out "final" string safely.
 	 */
-	fputs_careful(final, stdout, '*', false);
+	fputs_careful(final, stdout, '*', false, 0);
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
index b485e28fd..a5a21280c 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -276,7 +276,7 @@ static void do_write(const struct write_control *ctl)
 		if (signal_received)
 			break;
=20
-		if (fputs_careful(line, stdout, '^', true) =3D=3D EOF)
+		if (fputs_careful(line, stdout, '^', true, 0) =3D=3D EOF)
 			err(EXIT_FAILURE, _("carefulputc failed"));
 	}
 	free(line);
--=20
2.30.2

--wxxjvolybaa5rzrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQR4V8ACgkQvP0LAY0m
WPGdsQ//VNhZ8flV6Rp/yi4vWHaM0mSkeptWIugeFHd5o+bnRhsCa8jWs+XWeaCr
jGweje0bMl6RBl9X/gryK+AHmcvlZ7D6eo+B0ZNbhA81b6Ktd/BvAk4WXqqd9MPI
2xJfc8RROVL1t7UGuGU1KVot2f29W2rNTdaHVclowS/Ok+OcGhZ9+v+TMlLFd5Re
1uAudXO0penz/1rID4AnixlBSblzR4/auJYbskNrsk6vFLOw0tIPwSh7IAicoTkq
6alflaJX4Jr6qEt7a5PrX6XlpVvrh6wGcl28L7GNAwZ4zAUfh6DCbld6/GAaFhvB
d834kp6FkmrrV107f7ChEqX2qvoedsOdOjjr80CHJs7wbI5pOX9+Dzb0l+SV6ttA
05FOfVuDGeNVMFfmLEDA511d+FDBmp9cTpnMDI76czihdBKIiigMAPdzi597A/d7
LjMY0UhuayYibEcnQ2FiVpYhKjaO6WgqMSjm8kFP7SnzBO5/r8Ig/+ozurWDfzhw
wc5zPyEpyKV3c1k1Qq+0JIPn1C5j3vohidhOv0U/gMncKvIbcRkVfSpqKBasG7NV
q6eRCG5e6EbsaO/IJOIYoe4Ll13LczDCKeUpoRJfeaBoWKUgoAVJlJNT5/glZunA
yMQ5efNh4QQshqHM1eU9mV2vzztv4/nusBKLKYkn3vXIwjVA+Wo=
=Zl5Q
-----END PGP SIGNATURE-----

--wxxjvolybaa5rzrs--
