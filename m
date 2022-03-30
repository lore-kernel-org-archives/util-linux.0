Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8419C433F5
	for <util-linux@archiver.kernel.org>; Wed, 30 Mar 2022 17:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbiC3Rv5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbiC3Rv4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 30 Mar 2022 13:51:56 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 10:50:10 PDT
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B19A1EAFD
        for <util-linux@vger.kernel.org>; Wed, 30 Mar 2022 10:50:09 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3F49890C
        for <util-linux@vger.kernel.org>; Wed, 30 Mar 2022 19:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1648662207;
        bh=8m6IHErKj9evJ1A/6iM5zNPOo/w5J/vO3Dk2yvu4XX0=;
        h=Date:From:To:Subject:From;
        b=HZBcAHO7E9l/UG8CgwJj5QNgUZqsW4Vv9XGZNbmGn3v0C0BEGQ7e7BXxPFudbYt5I
         NQY8cqMx7yfwntAsIdIB40F/nmdE/ZtPFBTfoYVjopilrIX4ER7tBFtzaByq3RcMMi
         LDoSIzEA6AzyMsqJOeF/gzy/fhYRtcHfCjrmQLfpmfM4fUi846j7zV0syZ2bdVqqZg
         M8roLvfGGFLEZ3bBXZ3f1KZBo4YufiM2SbjjwlVLmW1w1TDWGhiyLyRUH0K7Am24f+
         N+7syKzaJ5C/hgUc/VxxwJkvwSgMbJ7BWOWHawbj57pg1FnJ2atNYfJ1gDi4f2dwRV
         /S0+Hwd8RUnKw==
Date:   Wed, 30 Mar 2022 19:43:26 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     util-linux@vger.kernel.org
Subject: [PATCH] libmount: fix typos
Message-ID: <20220330174326.uowsx3tludonu35i@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ecyichi7ka6fajvd"
Content-Disposition: inline
User-Agent: NeoMutt/20211029-519-ac10a7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--ecyichi7ka6fajvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

---
Please keep me in CC, as I'm not subscribed

 libmount/src/optstr.c | 2 +-
 libmount/src/utils.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
--=20
2.30.2

--ecyichi7ka6fajvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJElr0ACgkQvP0LAY0m
WPEreBAAs2aHWo5yifpMSCvhmmP0qVOKXkz8SdzR782jyhkMZk9cmBbzqtBFr5B3
YMOoQY1eLo+D84MUW1ZyZPfeBhJWzJnsCTKcidELfnObLeFooyRlAX4suL49QzpA
timrvl8RSLVc4X/5xp0bXssykAMCb0qmhY6Jc3+UW/KsE+00UqGcSSnvlQzXXaoQ
s3B9FH74naLS4UIj6/0w3l00s36mjusF2gcRiIAbo0ev3/QYF2+YSjtofkSZqjF4
FwctExN/POM9iCY1BbAPaYjFSXtqtvsge3ttPa46LrdVItuVp/p/YaK9Kn+8A+8j
N04/vDUU8j7417WZEuwd4StnKAggYBtBqh6mirKFTvyg/dEZq3jxGssBAU9P5fWT
z3tF1RPbcQ5hQfuM2O1fvKBNWuco1Uit8ISrFNXywKyE9fXPbV7hEqTQghYdq5VG
XtKdKHN3e1Q30LrLDcMNBJK103MTlXQuNJ2T2x9RrFSQwOd0eBxWKczw/sAnfzY7
7CMRb4vYXppeVIMcbF6WDGriWu01nCi8YUndy/3B6VtS3NrtXt6hFRAfiXgeI/4L
N+6nWVjSEcdsXTY1J5AFVebL1C+k8NRHXbYX4BAcpJ7C4rUEywjLJr/1kk07Lbuy
9RZzKCHWqD6ZL6YuUaxO81KhYOSQymh9WLU93EbhFZdwDADfdag=
=I13L
-----END PGP SIGNATURE-----

--ecyichi7ka6fajvd--
