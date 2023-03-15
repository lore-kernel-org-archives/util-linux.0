Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C575C61DA4
	for <util-linux@archiver.kernel.org>; Wed, 15 Mar 2023 15:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjCOPQr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Mar 2023 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCOPQr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Mar 2023 11:16:47 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72B096133C
        for <util-linux@vger.kernel.org>; Wed, 15 Mar 2023 08:16:45 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id BA7DA24DC;
        Wed, 15 Mar 2023 16:16:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1678893404;
        bh=7MhQ7MMIcgpmk+RJkfcXYELJL7n8kHlf8wIOXieEUn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMweQRRVQJEC+o6oIsBqZBJOkxYXnbn6HFCu3qAisUKYIpcRkXrEL5/WZAhzwX9g/
         yp0Tcy8Uai4+rfXSPnLszjeA5wMHxWhp7xRpsdDhjX6z8YTgJgK6hfFNtLDh4CFcCs
         tNgmHArDQlR5BBfpCztUJ4L1q4inIGvT47jUAdHH8m11OlMNefdgNf9PON5mD27om2
         eEHRQCWxruJmvXFO6WRPODBlyQxDuOXQKi5vEz39okrLbE+AIgVgw4B3AW3TlDtFBf
         rvrD+DoyoAIb4fHh4f4h8o6m2PJAjIFF6viiN7nin0wNH4vsPG5VwHkxMwJtUa1wvk
         uwLPKOpKtcL/w==
Date:   Wed, 15 Mar 2023 16:16:43 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH v2 2/3] wall: convert homebrew buffering to open_memstream()
Message-ID: <c32fd319151d5a87e3840cb75e3d92d18000119b.1678893303.git.nabijaczleweli@nabijaczleweli.xyz>
References: <20230315141649.d7d4ybcg3evyelpo@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dsazhwcmhk3vux2h"
Content-Disposition: inline
In-Reply-To: <20230315141649.d7d4ybcg3evyelpo@ws.net.home>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--dsazhwcmhk3vux2h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The struct buffer system duplicates a plethora of standard I/O
functions (including a fork of fputc_careful())
and adds a lot of complexity =E2=80=92 open_memstream() is standard,
and fits perfectly into this niche
---
 term-utils/wall.c | 95 ++++++++++-------------------------------------
 1 file changed, 20 insertions(+), 75 deletions(-)

diff --git a/term-utils/wall.c b/term-utils/wall.c
index c601d3e5b..a51a92829 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -274,74 +274,22 @@ int main(int argc, char **argv)
 	exit(EXIT_SUCCESS);
 }
=20
-struct buffer {
-	size_t	sz;
-	size_t	used;
-	char	*data;
-};
-
-static void buf_enlarge(struct buffer *bs, size_t len)
+static void buf_putc_careful(FILE *fs, int c)
 {
-	if (bs->sz =3D=3D 0 || len > bs->sz - bs->used) {
-		bs->sz +=3D len < 128 ? 128 : len;
-		bs->data =3D xrealloc(bs->data, bs->sz);
-	}
-}
-
-static void buf_puts(struct buffer *bs, const char *s)
-{
-	size_t len =3D strlen(s);
-
-	buf_enlarge(bs, len + 1);
-	memcpy(bs->data + bs->used, s, len + 1);
-	bs->used +=3D len;
-}
-
-static void __attribute__((__format__ (__printf__, 2, 3)))
-	buf_printf(struct buffer *bs, const char *fmt, ...)
-{
-	int rc;
-	va_list ap;
-	size_t limit;
-
-	buf_enlarge(bs, 0);	/* default size */
-	limit =3D bs->sz - bs->used;
-
-	va_start(ap, fmt);
-	rc =3D vsnprintf(bs->data + bs->used, limit, fmt, ap);
-	va_end(ap);
-
-	if (rc >=3D 0 && (size_t) rc >=3D limit) {	/* not enough, enlarge */
-		buf_enlarge(bs, (size_t)rc + 1);
-		limit =3D bs->sz - bs->used;
-		va_start(ap, fmt);
-		rc =3D vsnprintf(bs->data  + bs->used, limit, fmt, ap);
-		va_end(ap);
-	}
-
-	if (rc > 0)
-		bs->used +=3D rc;
-}
-
-static void buf_putc_careful(struct buffer *bs, int c)
-{
-	if (isprint(c) || c =3D=3D '\a' || c =3D=3D '\t' || c =3D=3D '\r' || c =
=3D=3D '\n') {
-		buf_enlarge(bs, 1);
-		bs->data[bs->used++] =3D c;
-	} else if (!c_isascii(c))
-		buf_printf(bs, "\\%3o", (unsigned char)c);
-	else {
-		char tmp[] =3D { '^', c ^ 0x40, '\0' };
-		buf_puts(bs, tmp);
-	}
+	if (isprint(c) || c =3D=3D '\a' || c =3D=3D '\t' || c =3D=3D '\r' || c =
=3D=3D '\n')
+		fputc(c, fs);
+	else if (!c_isascii(c))
+		fprintf(fs, "\\%3o", (unsigned char)c);
+	else
+		fputs((char[]){ '^', c ^ 0x40, '\0' }, fs);
 }
=20
 static char *makemsg(char *fname, char **mvec, int mvecsz,
 		     size_t *mbufsize, int print_banner)
 {
-	struct buffer _bs =3D {.used =3D 0}, *bs =3D &_bs;
 	register int ch, cnt;
-	char *p, *lbuf;
+	char *p, *lbuf, *retbuf;
+	FILE * fs =3D open_memstream(&retbuf, mbufsize);
 	long line_max;
=20
 	line_max =3D sysconf(_SC_LINE_MAX);
@@ -379,15 +327,15 @@ static char *makemsg(char *fname, char **mvec, int mv=
ecsz,
 		 */
 		/* snprintf is not always available, but the sprintf's here
 		   will not overflow as long as %d takes at most 100 chars */
-		buf_printf(bs, "\r%*s\r\n", TERM_WIDTH, " ");
+		fprintf(fs, "\r%*s\r\n", TERM_WIDTH, " ");
=20
 		snprintf(lbuf, line_max,
 				_("Broadcast message from %s@%s (%s) (%s):"),
 				whom, hostname, where, date);
-		buf_printf(bs, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH, lbuf);
+		fprintf(fs, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH, lbuf);
 		free(hostname);
 	}
-	buf_printf(bs, "%*s\r\n", TERM_WIDTH, " ");
+	fprintf(fs, "%*s\r\n", TERM_WIDTH, " ");
=20
 	 if (mvec) {
 		/*
@@ -396,11 +344,11 @@ static char *makemsg(char *fname, char **mvec, int mv=
ecsz,
 		int i;
=20
 		for (i =3D 0; i < mvecsz; i++) {
-			buf_puts(bs, mvec[i]);
+			fputs(mvec[i], fs);
 			if (i < mvecsz - 1)
-				buf_puts(bs, " ");
+				fputc(' ', fs);
 		}
-		buf_puts(bs, "\r\n");
+		fputs("\r\n", fs);
 	} else {
 		/*
 		 * read message from <file>
@@ -428,23 +376,20 @@ static char *makemsg(char *fname, char **mvec, int mv=
ecsz,
 		while (fgets(lbuf, line_max, stdin)) {
 			for (cnt =3D 0, p =3D lbuf; (ch =3D *p) !=3D '\0'; ++p, ++cnt) {
 				if (cnt =3D=3D TERM_WIDTH || ch =3D=3D '\n') {
-					for (; cnt < TERM_WIDTH; ++cnt)
-						buf_puts(bs, " ");
-					buf_puts(bs, "\r\n");
+					fprintf(fs, "%*s\r\n", TERM_WIDTH - cnt, "");
 					cnt =3D 0;
 				}
 				if (ch =3D=3D '\t')
 					cnt +=3D (7 - (cnt % 8));
 				if (ch !=3D '\n')
-					buf_putc_careful(bs, ch);
+					buf_putc_careful(fs, ch);
 			}
 		}
 	}
-	buf_printf(bs, "%*s\r\n", TERM_WIDTH, " ");
+	fprintf(fs, "%*s\r\n", TERM_WIDTH, " ");
=20
 	free(lbuf);
=20
-	bs->data[bs->used] =3D '\0';	/* be paranoid */
-	*mbufsize =3D bs->used;
-	return bs->data;
+	fclose(fs);
+	return retbuf;
 }
--=20
2.30.2


--dsazhwcmhk3vux2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQR4VsACgkQvP0LAY0m
WPEZ7Q/8CoxFcILhffB8dX3N3sRWEA5a0P0yLGyG22Xt+oP9oKNOCSg//GLVGP9Z
xamxq7MwOgAvXYiSw5JFsIg+HLfUE3dQ7DonXkBZmjn/GAvzLcFA86aMKndCxO1/
CuSq+vpMt0twxp2SuiOGqbtyeTzVrm/iF8XHdayGpAokYBdZ6kvis1/2c4jBGHBk
gp0/1gmScwBKXBnkcRxJQVk/dac4Y87oEivnkFRuwsnZgdQTniI4e9pEraIovlEo
0bfhumOlsxYG/B/hDJkLcbyF50cA+Do/a/WW3ZWxkVCy3s/aMogYkm/St4sSoL+5
GCFM0RUz6ocJMMTvnMyhO42TNKSDH+19zW352q4/485ERtXJ7+97VqZqOjX182ge
ExdKh6pCqVwOYLvZTZYs4mCUfSBSoiMqKz1mC8JYr8TOqb73LZYh2Vvvzo75RPso
QzSPoLqMeSHDF0/PIGJn/l+chCTW/vxLj1ZggOcQm+R5sQNG1q90XQwaoqrn9Hxh
xzJrFzQxIB6QEGiKDXnJwDxwESpt4+Nvq7/FBTfVlHGTwQcvC21gxjbk6sIISta4
g3YdY+55PojoWZeCvtWkacZrZssdbbGClgX0OhcWe3pX/0VdisV1X9tmD0XZle9c
duDDVOJfMfT+dhVPibGcI//9lIc9bNTHhEHSHMiLmghgKKKENdA=
=5O+K
-----END PGP SIGNATURE-----

--dsazhwcmhk3vux2h--
