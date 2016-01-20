Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:53267 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933127AbcATE66 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Jan 2016 23:58:58 -0500
Date: Tue, 19 Jan 2016 23:58:57 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "Wayne R. Roth" <wayneroth42@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mkswap: Add warnings for insecure device
 permissions/owners Logic modified from sys-utils/swapon.c
Message-ID: <20160120045857.GP14840@vapier.lan>
References: <20160119194443.GD14840@vapier.lan>
 <1453263459-19555-1-git-send-email-wayneroth42@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xXygN3QAmJYWdGtb"
In-Reply-To: <1453263459-19555-1-git-send-email-wayneroth42@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--xXygN3QAmJYWdGtb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 19 Jan 2016 20:17, Wayne R. Roth wrote:
> +        permMask = S_ISBLK(ctl.devstat.st_mode) ? 07007 : 07077;

pretty sure you want to indent w/tabs, not spaces

> +        if (getuid()==0 && S_ISREG(ctl.devstat.st_mode) && ctl.devstat.st_uid != 0)

there should be spaces around the ==
-mike

--xXygN3QAmJYWdGtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnxQRAAoJEEFjO5/oN/WBUhoP/i5tt2h+K7OZ0TbilMNYUvgf
Mh3t5PwtTvQ4LXW9dGM9HHlXeFBLas52dqlU91qZ7vG3mAYV0xJUR+4Oxav4KVTv
1sqqDztfVXApkWtm6P4l3cc7PGKIAL0QIlfKiuKLcojiNDQA1NLgwH0XRbp9aSZE
Qq9yUL+1oQ2qWoT/LoV9qYyVJoecFJt+k1lBn8Y3H43L1X6SjmTly+Qz4R8QdP6w
0QVNAmZbG9clDHrCkBYD2y+D+rn1smLoPQB258jL/nwRoXSn8gBu1iRWB+3nqKWE
KIR8Fsr+IYAqNQ5v8mU/7tmVXfPBBECBAwmRidExTrqC4y/RRSwZJK2qV57G73Sx
yOxIazfUFhT4jM7Q56P+AGwI/4mDp4+m5RO4lQ1+jZL0m3U9qxtVIEZf7zLi1xaI
rfCzEYc5iWBtSLr5zHfgG4WN/oPuc/bKFz5HW0cXWBFP1TFd86KSchWyzqYk/Hsv
TH/tsZZefXWLHUlFzeV7DgWLOtmLfc3AKJk0AfymWL8z6PVne7BgdBFARGSvgtf5
FRH68ywUMHftzOW8D58dQ3WESSnoYVHp+57BK7Hcz/OmdH9rTTr2DHpPGdIpMyUQ
CSv8CPvujtGcx/PuuzwLZ16i8mkAWCBjet8B8yjNO1WJ/3vI7kPggXqTTz7N9Fy3
SFPQAuKizWZUJl1xTuSc
=EiXa
-----END PGP SIGNATURE-----

--xXygN3QAmJYWdGtb--
