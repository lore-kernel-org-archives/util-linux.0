Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62393C61DA4
	for <util-linux@archiver.kernel.org>; Wed, 15 Mar 2023 15:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjCOPQn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Mar 2023 11:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCOPQl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Mar 2023 11:16:41 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FF6562860
        for <util-linux@vger.kernel.org>; Wed, 15 Mar 2023 08:16:36 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id A241A24DA;
        Wed, 15 Mar 2023 16:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1678893392;
        bh=KQa+IT4mDx1xbBpaS/D4VAXQxcDc0vsT5jpfwfN5y+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdpgINbolCZeqXtfokRO4va/SVgHBwf1xowcVG+7pLtq7A+QHfcP4KtyMxuKRekul
         dure5/lf0QqQQc5NDrFOPuTQ/OLiNbo229F7JmNbgf/VCX1XrV5vFhQiIGWJT+re8q
         lV3iKss1gqwrrsTsH9QWJ9LXs30OaUCu2QFxcl3cJEkXEo8KKNjZtxHXVfcbMQbUH8
         4F55WROldOObe4JjdQNzeLjiUIwG9OGOLJ+SxUKQopa4sQSxL7UuVHKtlvVeyfXkdA
         5K6WL0akxVUFOh6Zd2b+Se1cUIy7EG3bXHIZ3tCvM177Mc/fr0LtHpaBL4R4htXno5
         CPkSDUufKMWrA==
Date:   Wed, 15 Mar 2023 16:16:31 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH v2 1/3] write: correctly handle wide characters
Message-ID: <3b606a113f36256be6486bd3130944acf88777d7.1678893303.git.nabijaczleweli@nabijaczleweli.xyz>
References: <20230315141649.d7d4ybcg3evyelpo@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="anuwdw7d6shtfch7"
Content-Disposition: inline
In-Reply-To: <20230315141649.d7d4ybcg3evyelpo@ws.net.home>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--anuwdw7d6shtfch7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Do this by replacing fputc_careful() (notice that the description said
it's locale-aware =E2=80=92 it very much is /not/), with a fputs_careful() =
which
does the same thing, but if it were to output a byte in the \123 format,
first it checks whether this byte starts a valid multibyte character.

If it does, and that character is printable, write it verbatim.
This means that
  echo 'foo =C3=A5=C3=A4=C3=B6 =C4=85=C4=99=C4=87=C5=BA=C5=BC=C5=84 bar' | =
write nabijaczleweli pts/4
instead of
  foo \303\245\303\244\303\266
  \304\205\304\231\304\207\305\272\305\274\305\204 bar
yields
  foo =C3=A5=C3=A4=C3=B6 =C4=85=C4=99=C4=87=C5=BA=C5=BC=C5=84 bar
or, more realistically, from a message I got earlier today,
  Filip powiedzia\305\202 \305\274e zap\305\202aci jutro
becomes
  Filip powiedzia=C5=82 =C5=BCe zap=C5=82aci jutro

Invalid/non-printable sequences get processed as before.

Line reading in write must become getline() to avoid dealing with
partial characters: for example on input consisting solely of
=C4=85=C4=99=C4=87=C5=BA=C5=BC=C5=84, where every {1} is an instance, the o=
utput would be
  {42}=C4=85=C4=99=C4=87\305\272=C5=BC=C5=84{84}=C4=85=C4=99=C4=87=C5=BA\30=
5\274=C5=84{84}=C4=85=C4=99=C4=87=C5=BA=C5=BC\305\204{39}
with just fixed-512 fgets()

Bug-Debian: https://bugs.debian.org/826596
---
 include/carefulputc.h | 60 +++++++++++++++++++++++++++++++------------
 login-utils/last.c    |  4 +--
 term-utils/write.c    | 25 +++++-------------
 3 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/include/carefulputc.h b/include/carefulputc.h
index 8860b1234..740add68e 100644
--- a/include/carefulputc.h
+++ b/include/carefulputc.h
@@ -1,31 +1,59 @@
 #ifndef UTIL_LINUX_CAREFULPUTC_H
 #define UTIL_LINUX_CAREFULPUTC_H
=20
-/*
- * A putc() for use in write and wall (that sometimes are sgid tty).
- * It avoids control characters in our locale, and also ASCII control
- * characters.   Note that the locale of the recipient is unknown.
-*/
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
+#ifdef HAVE_WIDECHAR
+#include <wctype.h>
+#endif
+#include <stdbool.h>
=20
 #include "cctype.h"
=20
-static inline int fputc_careful(int c, FILE *fp, const char fail)
+/*
+ * A puts() for use in write and wall (that sometimes are sgid tty).
+ * It avoids control and invalid characters.
+ * The locale of the recipient is nominally unknown,
+ * but it's a solid bet that the encoding is compatible with the author's.
+ */
+static inline int fputs_careful(const char * s, FILE *fp, const char ctrl,=
 bool cr_lf)
 {
-	int ret;
+	int ret =3D 0;
=20
-	if (isprint(c) || c =3D=3D '\a' || c =3D=3D '\t' || c =3D=3D '\r' || c =
=3D=3D '\n')
-		ret =3D putc(c, fp);
-	else if (!c_isascii(c))
-		ret =3D fprintf(fp, "\\%3o", (unsigned char)c);
-	else {
-		ret =3D putc(fail, fp);
-		if (ret !=3D EOF)
-			ret =3D putc(c ^ 0x40, fp);
+	for (size_t slen =3D strlen(s); *s; ++s, --slen) {
+		if (*s =3D=3D '\n')
+			ret =3D fputs(cr_lf ? "\r\n" : "\n", fp);
+		else if (isprint(*s) || *s =3D=3D '\a' || *s =3D=3D '\t' || *s =3D=3D '\=
r')
+			ret =3D putc(*s, fp);
+		else if (!c_isascii(*s)) {
+#ifdef HAVE_WIDECHAR
+			wchar_t w;
+			size_t clen =3D mbtowc(&w, s, slen);
+			switch(clen) {
+				case (size_t)-2:  // incomplete
+				case (size_t)-1:  // EILSEQ
+					mbtowc(NULL, NULL, 0);
+				nonprint:
+					ret =3D fprintf(fp, "\\%3hho", *s);
+					break;
+				default:
+					if(!iswprint(w))
+						goto nonprint;
+					ret =3D fwrite(s, 1, clen, fp);
+					s +=3D clen - 1;
+					slen -=3D clen - 1;
+					break;
+			}
+#else
+			ret =3D fprintf(fp, "\\%3hho", *s);
+#endif
+		} else
+			ret =3D fputs((char[]){ ctrl, *s ^ 0x40, '\0' }, fp);
+		if (ret < 0)
+			return EOF;
 	}
-	return (ret < 0) ? EOF : 0;
+	return 0;
 }
=20
 static inline void fputs_quoted_case(const char *data, FILE *out, int dir)
diff --git a/login-utils/last.c b/login-utils/last.c
index d3eeed4b6..1b45dbf24 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -392,7 +392,6 @@ static int list(const struct last_control *ctl, struct =
utmpx *p, time_t logout_t
 	char		final[512];
 	char		utline[sizeof(p->ut_line) + 1];
 	char		domain[256];
-	char		*s;
 	int		mins, hours, days;
 	int		r, len;
 	struct last_timefmt *fmt;
@@ -548,8 +547,7 @@ static int list(const struct last_control *ctl, struct =
utmpx *p, time_t logout_t
 	/*
 	 *	Print out "final" string safely.
 	 */
-	for (s =3D final; *s; s++)
-		fputc_careful(*s, stdout, '*');
+	fputs_careful(final, stdout, '*', false);
=20
 	if (len < 0 || (size_t)len >=3D sizeof(final))
 		putchar('\n');
diff --git a/term-utils/write.c b/term-utils/write.c
index 8b86e9a9d..b485e28fd 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -223,21 +223,6 @@ static void signal_handler(int signo)
 	signal_received =3D signo;
 }
=20
-/*
- * write_line - like fputs(), but makes control characters visible and
- *     turns \n into \r\n.
- */
-static void write_line(char *s)
-{
-	while (*s) {
-		const int c =3D *s++;
-
-		if ((c =3D=3D '\n' && fputc_careful('\r', stdout, '^') =3D=3D EOF)
-		    || fputc_careful(c, stdout, '^') =3D=3D EOF)
-			err(EXIT_FAILURE, _("carefulputc failed"));
-	}
-}
-
 /*
  * do_write - actually make the connection
  */
@@ -247,7 +232,8 @@ static void do_write(const struct write_control *ctl)
 	struct passwd *pwd;
 	time_t now;
 	struct tm *tm;
-	char *host, line[512];
+	char *host, *line =3D NULL;
+	size_t linelen =3D 0;
 	struct sigaction sigact;
=20
 	/* Determine our login name(s) before the we reopen() stdout */
@@ -286,11 +272,14 @@ static void do_write(const struct write_control *ctl)
 	free(host);
 	printf("\r\n");
=20
-	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
+	while (getline(&line, &linelen, stdin) >=3D 0) {
 		if (signal_received)
 			break;
-		write_line(line);
+
+		if (fputs_careful(line, stdout, '^', true) =3D=3D EOF)
+			err(EXIT_FAILURE, _("carefulputc failed"));
 	}
+	free(line);
 	printf("EOF\r\n");
 }
=20
--=20
2.30.2


--anuwdw7d6shtfch7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQR4U8ACgkQvP0LAY0m
WPH8kw/8C+YsQEpR2mCSiPAbnrIxApdkY6nqg0WUxbeV28M+QsakTkLTFwLa2d25
TmiS4mBUMDd4i+VjifnmZOPO9386+QfIKN7PFaXwoAczaXCVifKNj1bi2wMqj/Vb
dEJgBdO+xAa0u8/pY/lEOAPxGXcczmbNj5+gqBPSJqOJz/C5dRricrphrRleSL5f
SJEGpIL1gSoRucXQ/Var1+LuiT8RUg9tqjJ4OdbGuaFWFO8Un2rtp7kFSxC8DFSq
U9E9XjD4zbsIBhkS6Jw+YjG1VrEFqcgZ+QxQg8xtn1SS5w9sXHLst0z13w7+Oxzm
v+3NO/UhGhPIo+5xXWGiS15YeuunHidmuDRVAmxyyoi8HvoZPXEdYx18knCUx4hE
su4IdtVDc0+LIJJegajWvEdXyO0ZtS0I0bddebLxz9czdG0QvfPLrDOaTvL893b2
bHM9nOplLKNiTOlddilQMkjGzG0JcfKV538izmGqu1IeQ4zd/rU0oyS6azroVl6E
wpnJxL3GP6h5or/c8rGKJhheJ5/9V50UZHDZvYQbGQj+nAwKPFaJZEWG9CJ5GQWC
CDR5Z1W3ZAchHnbo1fIBHGVE5KU2v2pbza3TiZKSmTPnYY9bd76f+sSwH2ufZ9YF
zbBhQnle8sPro5eEpeYJsMh04WSqFBx0fR9deD37y7Z98Mcxl2g=
=WWNt
-----END PGP SIGNATURE-----

--anuwdw7d6shtfch7--
