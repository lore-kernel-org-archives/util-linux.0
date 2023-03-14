Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3105C7618D
	for <util-linux@archiver.kernel.org>; Tue, 14 Mar 2023 22:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCNWC1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Mar 2023 18:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCNWC0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Mar 2023 18:02:26 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BF1A2798D
        for <util-linux@vger.kernel.org>; Tue, 14 Mar 2023 15:02:25 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5AE1D31AA
        for <util-linux@vger.kernel.org>; Tue, 14 Mar 2023 23:02:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1678831344;
        bh=rQxs+bqeidk9lOi7GM8WtlEZtN8MXoI8D03Ot4cqv0s=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=bVTDNzZbHmhKTgcll1s0JlFRkngTYJ6KxgQO+SSVoXciVSiqr692i0a7u/KYSEAeI
         obkw++DAAQ9HOxYnSZe1hZJoGc2On1R++pB5CTwnCqdovcKIZA6Dlm/z+P5SNVteaD
         J5KC9FNbXVN6L3U1+OIRsAmbnpUsSjKq25AC6QsyfuJj1vnZIIlEJ83twBGHr9B0Oh
         S4Ss9JxovW6yJscH6dEvJff8aXHjsp1FUDvwS/mydlzPPU0v38SNrBiKcMNpYBacyL
         +KKECNtlKKRBVVzJn5ucGqpbqF6WBn08dSTX9tHGTW0F7HpFXpiZCO2Tat15NMzAY5
         YrknhvYIciZSw==
Date:   Tue, 14 Mar 2023 23:02:23 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 2/3] wall: convert homebrew buffering to open_memstream()
Message-ID: <758025e9d17be986196f97cb2d5d3183f82cb79c.1678831302.git.nabijaczleweli@nabijaczleweli.xyz>
References: <5d68dce11f61b85743c36d57e2bd0d90e978a197.1678831302.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jkjwxlarx5eitm26"
Content-Disposition: inline
In-Reply-To: <5d68dce11f61b85743c36d57e2bd0d90e978a197.1678831302.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--jkjwxlarx5eitm26
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The struct buffer system duplicates a plethora of standard I/O
functions (including a fork of fputc_careful())
and adds a lot of complexity =E2=80=92 open_memstream() is standard,
and fits perfectly into this niche
---
Please keep me in CC, as I'm not subscribed.

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


--jkjwxlarx5eitm26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQQ7u4ACgkQvP0LAY0m
WPEivg/+ImJk4gZ770jmqGIBGJ1+xsRsi63zfGHV7d8fnnFZAuL1mSG+4SbCN3Ho
BQamMmmGgMzJZAJD6owh3zjcFVqDP2OUEohQT7q66ptEamST/wNTvhfmrs10p5/P
hx6VQvy6Wev97KXZOWTWTdIuWWyX4IOh92eO89/CBj1hJCgGBg0FZDjgybVxQwFr
Ds/g0GohE6SPQ9ZFS8U8YQiWqJlnRRucx5b5NPw1g5pC8cVrbfDeFCBKvsCTUGIv
ny/C5h15vPCUP5qIjA3Hc2anXfFxrsfi6Kl8upJ87XAd5JoFErpt7cjh51H5h43B
uG+/qCwniKZ4vEV1bmMSYA+zpgPSy2ype0ckcmmZotKwVEc3WulfWklNux+ruWWD
nwN4o/Vprab0nFQDo0E3he0xcQjcDr/lpumqmDyBA0Aa9rPgdMFcNED5ipQwzLce
d8+iNqJKAcTN+bHt2VqDKYb3FMP0QKtTh06ENY9duGorE9wTxebvozh2zb4i/Kfi
YJxaRLUSUkjpNBCidH27nnxa9IsiYC0RIPdqXcomdtM0RVcbBoTBmC64oU22cbuP
OXlBiR0+fZlkkfBkvv5P8pgtxkpS2Z7+F4e+mMh1L5a5bIltgb50fOlGfiHyVM2f
4X0A15+p9fnn3yTkSbjNBu2Fn4Fsb3e/06aeZsfgVT62I9eUWnk=
=bb79
-----END PGP SIGNATURE-----

--jkjwxlarx5eitm26--
