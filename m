Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:59819 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbbJ3QtU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Oct 2015 12:49:20 -0400
Date: Fri, 30 Oct 2015 12:49:18 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare -m for non-root user
Message-ID: <20151030164918.GL5154@vapier.lan>
References: <n0ujgc$tll$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
In-Reply-To: <n0ujgc$tll$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 30 Oct 2015 03:09, U.Mutlu wrote:
> I wonder why "unshare -m" doesn't work for an unpriviledged user:

look into the -U flag if you want to use these features as non-root
-mike

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWM5+OAAoJEEFjO5/oN/WBvqkQAMNfUte4GIOny10FsKE6YCds
FhFC8UKdqQ9Fc5dbdvp1PbWCDgGr4/U3DAcwI87Taf6pYDZRbZ+iS1d5r0l0X20m
UOw4YpSyZ7giJhrOHTsg6iIZAjEY2n/ff/wB24cfLeMyOuo6M5ZCiDRMYS6JW4Iq
YoOI/VcXtDTuCDXUcewgsLFVYE9YQWhJZLDHqwUtFHnLvhkn0ovQfcMftFwUXaU4
tNi4Uf48keBTfenAkCGiZV1ki1soY1At4hX6zBHePBHEJRx/xBX5YJCTf5DEgU7p
WEgl7MhcmP1e5/HmIXQtVtquxAGmSkfeK8TkIQiSB7ojPZzXz6z4Bl67X29cqM7R
j0a1nazMuO2RzL3R3DQQDDVLVDEKmNvOGAW6zi5W+SlG5ef1s2yQZV+9lz+ccE1i
dcIXkEmyUnXn9b5/fU4rZD2NBT5WjvCjNBLAEwuN5MyxotwXIR1TWadEKc/nDDBP
Y4tmf2lm3AgbbVeRtNay55QAa1x0h0caK/3GHrmmL9dnq4+VPDSSod43rD+LW7zB
1B2QRWAM8zNuZn5t6YR205RgxeSCqnJsTiJ1hrhJbWxljHWzR8MZYrbHX3RW7JQJ
m+sigfDW4jWEe6WWiDe47wW0nHlruQp7Kqv8LIHx68zqDYDvutT+XmT1LeVNpA3m
HgY/niottvW3egxedH0m
=uXHn
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--
