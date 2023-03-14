Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C53C7618B
	for <util-linux@archiver.kernel.org>; Tue, 14 Mar 2023 22:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCNWCY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Mar 2023 18:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCNWCX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Mar 2023 18:02:23 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA1E119BD
        for <util-linux@vger.kernel.org>; Tue, 14 Mar 2023 15:02:20 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 81F0931A8
        for <util-linux@vger.kernel.org>; Tue, 14 Mar 2023 23:02:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1678831336;
        bh=6eaXn0VTepjIeUrgotGwh2LZ2TsYxmaleuGPOPSnQ4s=;
        h=Date:From:Cc:Subject:From;
        b=UHiNFCeN5MKFNVPENxiQyEaMy/n3hdfcw4PDxoo7vMCjgpVbSKqKodpVurI4GRT/E
         NmfWHd9fEfnRU57Humh6FgKKa0DGQP6yLbA7Fcj/uKqKxiiy+XolzJ3wAokzd3jXML
         n27cUoKwrREI8IjxAkccQOEjQqcbcI94GgyjrFmLB+w6Zu8+wT3QCUjk16hTCmxvFk
         QagfN9UnCnVhALHHgFWay4ukOKqnNdlsEqRkmCCbDZxAQqBN6B4xlpJnqpynbivXGB
         RZ1peEE8qbmtFcMJ02JlQcmQXMcd6UKgnLsLEO5mUCeyV9M+VEW4EWhenI4Ixjm9Qh
         JoSTytwFLVnMQ==
Date:   Tue, 14 Mar 2023 23:02:15 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 1/3] write: correctly handle wide characters
Message-ID: <5d68dce11f61b85743c36d57e2bd0d90e978a197.1678831302.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2kcjkwaeo4asgdwl"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--2kcjkwaeo4asgdwl
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
Please keep me in CC, as I'm not subscribed.

 include/carefulputc.h | 54 ++++++++++++++++++++++++++++++-------------
 login-utils/last.c    |  4 +---
 term-utils/write.c    | 25 ++++++--------------
 3 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/include/carefulputc.h b/include/carefulputc.h
index 8860b1234..416a347bf 100644
--- a/include/carefulputc.h
+++ b/include/carefulputc.h
@@ -1,31 +1,53 @@
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
+#include <wctype.h>
+#include <stdbool.h>
=20
 #include "cctype.h"
=20
-static inline int fputc_careful(int c, FILE *fp, const char fail)
+/*
+ * A puts() for use in write and wall (that sometimes are sgid tty).
+ * It avoids control and invalid characters.
+ * The locale of the recipient is nominally unknown,
+ * but it's a solid bet that it's compatible with the author's.
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
+			ret =3D fputs(&"\r\n"[!cr_lf], fp);
+		else if (isprint(*s) || *s =3D=3D '\a' || *s =3D=3D '\t' || *s =3D=3D '\=
r')
+			ret =3D putc(*s, fp);
+		else if (!c_isascii(*s)) {
+			wchar_t w;
+			size_t clen =3D mbtowc(&w, s, slen);
+			switch(clen) {
+				case (size_t)-2:  // incomplete
+				case (size_t)-1:  // EILSEQ
+				nonprint:
+					ret =3D fprintf(fp, "\\%3hho", *s);
+					mbtowc(NULL, NULL, 0);
+					break;
+				default:
+					if(!iswprint(w))
+						goto nonprint;
+					ret =3D fwrite(s, 1, clen, fp);
+					s +=3D clen - 1;
+					slen -=3D clen - 1;
+					break;
+			}
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


--2kcjkwaeo4asgdwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQQ7uYACgkQvP0LAY0m
WPGa6Q/+MAAgRoDxNL2UZIRIUnVLDN0Wwr0HLH7E5JsHUYKNOSKSC8HH4Vmnr+9n
ZolekquvyCdQnzEzVVI/3rQXqLaBH5MzRLStjUMh1F9liEXFTjMyKHf4YEaHV3GE
sdaocLGnatlRvn78w09N+TxXHpthvv+0LirneV7INOoc9LY2VOVatcS4yKYJLA19
Swzq35OVTfd+RVndnOTQv8PAN+5aJfUjaiWENeMiiuK78whzpT4e4In4ENgAmUDM
z1CTkLEJCLXxLI8bR1vPFgf4U+2EwBiAbFXJLXQctFe5/24Oo6gtoojN01y3tDru
Xx1pbC4G99WIifjbnn+RFN0GjK+RkB6XyurfR6PqOA7M0n3lVcdfkpB2qcOzV8As
83LeQNIxP/1ZiSBhovcHxHTXxFq18XaHCCeB1S4G0KWRGCxbdJue8OE0PVpl0a1d
WtWsgH3o9aGiAkpaYZNKaeWlq6pd6n8llweqcrPNHcWUroVetu8GYPIWzbh0KGqt
nFVIGzin0k7ehAzVYGGg43Yx1/lNqJ/Lzv3echW7I5homIG/QphZ6xX7TN2WVBut
ilgGSF6YvSYVht0iZ17KUraFfocSwWlNx/4T01pAGH8JAkdN4b1wFMEHfHIHHA1A
9wmxOSp08TTPw31ZAi5154oT6CVDV1xonGBI9Cq2Rzm3+I14eus=
=N1RQ
-----END PGP SIGNATURE-----

--2kcjkwaeo4asgdwl--
