Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B527C433EF
	for <util-linux@archiver.kernel.org>; Thu, 31 Mar 2022 16:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiCaQ53 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiCaQ53 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 31 Mar 2022 12:57:29 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ED0B232126
        for <util-linux@vger.kernel.org>; Thu, 31 Mar 2022 09:55:40 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E0832A8;
        Thu, 31 Mar 2022 18:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1648745736;
        bh=/iTbYa35jd9uty3CShBAhlENnCo0dYFRo/RU62vylug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vu0znrM5p5EG2wRU91TqDyGdAaBfQlqJK2Xj0QOv2qRFW8MYx+/KSk8fktSkUf06a
         2FcUzAQgwJyx50aD7ljibpyLr+gEt96h3Xv5IIDxNmSfLI3JiCXMi++sClW+D+Ef49
         zJV7tqwrij2We4xgrGmq0KLs4TnwbUdg+eBKfnseFCcIJdm/LU+UGBTc/gtChnLs+1
         D0qmupfnmEUj2aIW42weqLUEr18y9KkAWrjO8tNbzQypDsRSL7wRy+Ft9wG6ptEeWg
         P7Yx+FvtlY4tAONSti1jAb+uywOcWKW7zdeQvCJEqYQE8RNqDfCEmjjvYUcUCJHWBI
         3jBD8OajAVnRg==
Date:   Thu, 31 Mar 2022 18:55:35 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH v2] libmount: fix typos
Message-ID: <20220331165535.ug2wqtifl37d63en@tarta.nabijaczleweli.xyz>
References: <CADxRZqwk7_9KiQrJV5_KvUP4KEy_fPZu13papeg3A6fzhsCC9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jt2rc6xpwf3uafm5"
Content-Disposition: inline
In-Reply-To: <CADxRZqwk7_9KiQrJV5_KvUP4KEy_fPZu13papeg3A6fzhsCC9Q@mail.gmail.com>
User-Agent: NeoMutt/20211029-519-ac10a7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--jt2rc6xpwf3uafm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

---
Few more pointed out by Anatoly

Please keep me in CC, as I'm not subscribed

 lib/colors.c                   |  4 ++--
 lib/idcache.c                  |  2 +-
 libmount/src/optstr.c          |  2 +-
 libmount/src/utils.c           |  4 ++--
 login-utils/sulogin-consoles.c |  2 +-
 misc-utils/lsfd-filter.c       | 10 +++++-----
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/colors.c b/lib/colors.c
index e31751912..c4bc08d0f 100644
--- a/lib/colors.c
+++ b/lib/colors.c
@@ -230,8 +230,8 @@ static int filename_to_tokens(const char *str,
=20
 	/* parse utilname */
 	p =3D term_start ? term_start : type_start;
-	*name =3D  str;
-	*namesz	=3D p - str - 1;
+	*name =3D str;
+	*namesz =3D p - str - 1;
=20
 	return 0;
 }
diff --git a/lib/idcache.c b/lib/idcache.c
index 55502238d..c63cca25d 100644
--- a/lib/idcache.c
+++ b/lib/idcache.c
@@ -97,7 +97,7 @@ static void add_id(struct idcache *ic, char *name, unsign=
ed long int id)
=20
 void add_uid(struct idcache *cache, unsigned long int id)
 {
-	struct identry *ent=3D get_id(cache, id);
+	struct identry *ent =3D get_id(cache, id);
=20
 	if (!ent) {
 		struct passwd *pw =3D getpwuid((uid_t) id);
diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index 5daa511a0..43b983ebb 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -887,7 +887,7 @@ static int set_uint_value(char **optstr, unsigned int n=
um,
  * @value: pointer to the beginning of the uid value
  * @valsz: size of the value
  * @next: returns pointer to the next option (optional argument)
-
+ *
  * Translates "username" or "useruid" to the real UID.
  *
  * For example:
diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 74815055b..ff3acfb55 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -596,7 +596,7 @@ int mnt_get_uid(const char *username, uid_t *uid)
 		return -ENOMEM;
=20
 	if (!getpwnam_r(username, &pwd, buf, UL_GETPW_BUFSIZ, &pw) && pw) {
-		*uid=3D pw->pw_uid;
+		*uid =3D pw->pw_uid;
 		rc =3D 0;
 	} else {
 		DBG(UTILS, ul_debug(
@@ -623,7 +623,7 @@ int mnt_get_gid(const char *groupname, gid_t *gid)
 		return -ENOMEM;
=20
 	if (!getgrnam_r(groupname, &grp, buf, UL_GETPW_BUFSIZ, &gr) && gr) {
-		*gid=3D gr->gr_gid;
+		*gid =3D gr->gr_gid;
 		rc =3D 0;
 	} else {
 		DBG(UTILS, ul_debug(
diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index facb1ffbb..9ae4b2eba 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -475,7 +475,7 @@ static int detect_consoles_from_cmdline(struct list_hea=
d *consoles)
 		goto done;
 	}
=20
-	words=3D cmdline;
+	words =3D cmdline;
 	dir =3D opendir("/dev");
 	if (!dir)
 		goto done;
diff --git a/misc-utils/lsfd-filter.c b/misc-utils/lsfd-filter.c
index 8de512286..de0775620 100644
--- a/misc-utils/lsfd-filter.c
+++ b/misc-utils/lsfd-filter.c
@@ -573,7 +573,7 @@ static struct token *parser_read(struct parser *parser)
 		c0 =3D parser_getc(parser);
 		if (c0 =3D=3D '|') {
 			t->type =3D TOKEN_OP2;
-			t->val.op2=3D OP2_OR;
+			t->val.op2 =3D OP2_OR;
 			break;
 		}
 		snprintf(parser->errmsg, ERRMSG_LEN,
@@ -597,19 +597,19 @@ static struct token *parser_read(struct parser *parse=
r)
 			} else if (strcmp(t->val.str, "or") =3D=3D 0) {
 				free(t->val.str);
 				t->type =3D TOKEN_OP2;
-				t->val.op2=3D OP2_OR;
+				t->val.op2 =3D OP2_OR;
 			} else if (strcmp(t->val.str, "and") =3D=3D 0) {
 				free(t->val.str);
 				t->type =3D TOKEN_OP2;
-				t->val.op2=3D OP2_AND;
+				t->val.op2 =3D OP2_AND;
 			} else if (strcmp(t->val.str, "eq") =3D=3D 0) {
 				free(t->val.str);
 				t->type =3D TOKEN_OP2;
-				t->val.op2=3D OP2_EQ;
+				t->val.op2 =3D OP2_EQ;
 			} else if (strcmp(t->val.str, "ne") =3D=3D 0) {
 				free(t->val.str);
 				t->type =3D TOKEN_OP2;
-				t->val.op2=3D OP2_NE;
+				t->val.op2 =3D OP2_NE;
 			} else if (strcmp(t->val.str, "lt") =3D=3D 0) {
 				free(t->val.str);
 				t->type =3D TOKEN_OP2;
--=20
2.30.2

--jt2rc6xpwf3uafm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJF3QcACgkQvP0LAY0m
WPE5Kw//T7fxLjqacD35B4ymQ5arEjkmCKrA9lYMzBzPnabqAinpevp8UhBvjEJG
+KaX0rnJ3g6ejpsJjwcTyDWgbjUFn8RUMCShtsIreHDRC/tyx2f8djN2gfb9e+HT
IZS8Z/Q5ha1mLyV/QdZdJdnQxGexV+OCiYzzNG0xMgYii6SoiohEGx5Z0GNjRnQ4
ACYTCSVwsRxzKHx17oVZKGzNGjv1JK5oFj1X+2HX0QfyAIzcZB+esumYc9RLm4wM
La0fo8K7xmpsHc7UeeW8HNpDTzCBt16eOGmMMW4SG2fziwEw9OdpY43V+wuO6mSY
RyUOaLXqXlJxzNKAYrVAS58Af7IeGtui039IyF+qJtbS2v34G/If29JxcS92ENaC
ZSVCCtydOIY/PiHRDz4D66WmryMhQ2A9932vkUFaCggh3EsC3IWZRzXJmdfeBFPP
lMUJnx1hbpFmHAMEHjtop4HG0+AunPUMJo63YCyvM2GwK3QOwAeLWF1o4X6TNiDy
JaQ15vTTN+jAT2V5g0KIJAWvmRFDC6ovLi5teZw5HE/6FeXA26ZOwwMIWvxwP3YE
QRnQXqtsM/MPv87kBCYGWsVDMhzQUN459mjXq6jZU0MH+/slK81482nZ12ZxWv79
vTi6nyQzTcebweuFe9u9uGEMhVQEGOCbh7V+XhyozgmdhP4uy6Y=
=xQrj
-----END PGP SIGNATURE-----

--jt2rc6xpwf3uafm5--
