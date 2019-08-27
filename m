Return-Path: <SRS0=xJlx=WX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ED7C3A5A3
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 11:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3419E20828
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 11:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fzkaD6ET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zm0RJKHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfH0LzP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:55:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50875 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbfH0LzP (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Aug 2019 07:55:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 96619222A6;
        Tue, 27 Aug 2019 07:55:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 27 Aug 2019 07:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Afv1jbk3q1WG4ayViaZdnyNxG6T
        D/re9TlPvcepm6hE=; b=fzkaD6ETV75PwNIP7riE3iCt3uyyFQRIjhTR1gXOSXP
        2cB7XM72zSNNs35ng6bGezFOQotJTOEz88MG8eLmiz/hS/0zmtHeFiXXCzpVHJmO
        TJKtgtwUj1LQbYd8hUbN034Sdun0bqKjBZR2uEutTz+5NlF7DeuW+BPRBiSN25mo
        YT+WbdAbbd4RAgu1QuWgsTWXyPwrYNf9607Bqc//7p/XphSmVIbVm3DjkoTLbBMO
        tROdAWt+Lwvq0W0kkPk7kPUREgChhfcsvboXDtTuHwRmPQue+R7Y2dbtBZTBhEi3
        W6S4nHL/as7y8ZcRoRrBitMj01AWFkQBJFxu/zq8auA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Afv1jb
        k3q1WG4ayViaZdnyNxG6TD/re9TlPvcepm6hE=; b=zm0RJKHFjxR1BJ8iaQaAau
        JLmAT0PErB6PvpwJhnxQy/tkouskDLcfUeio8dIoH8QnKEKd7UMm0K9Hchr5mlo+
        D6swv9Eumv9EOIlS8wIWOcZSjyCYQy1wN+QL2Yy7kXr7+p6E1DeyVHddkGlIIa8q
        C9i15EwmAurje1ifuazNr7RPCaZ4HPOhvbYILSKJMDOy7fQhVQOZajoE4fwjgVfS
        3z+pCFTkmL3UHdQ1pSLRckkcPL51aL4Lz2SNET5IA9SV7/S/kN9OFIZeHqehcYZ6
        4oYh523yf95IyQEcimv/cYGQoVTFWMYOOFbmbbz9g84NDLk+LTVzLdxiyj0ATpWg
        ==
X-ME-Sender: <xms:IhplXVCsZmdjKaA0drv3Ju-cP8B2UXhYJMrZSN9LlCAgjOWX1FLz4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehjecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuffhomhgrihhnpehgihhthh
    husgdrtghomhenucfkphepjeejrdduuddrvdegvddruddvleenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:IhplXXwzbCCjup7gCiXqs1hAOQuXCKf3cDxCRLhHFEe1MauzVRk9zA>
    <xmx:IhplXblATsTHSLazVUEOMqBydIRm6V5aqX6Sn6Yj7jvIjAeiDfBKKg>
    <xmx:IhplXUHOAgsorb_Ot0YkQbdzMeR4LPF8D8L-a1MEiKBScPMsZBUhcg>
    <xmx:IhplXSMEd5KMZAbhN7WZcfERKQoVCq0ZmLq4BZFqUxvj1_XacvrfIg>
Received: from NSJAIL (x4d0bf281.dyn.telefonica.de [77.11.242.129])
        by mail.messagingengine.com (Postfix) with ESMTPA id 84BB9D6005E;
        Tue, 27 Aug 2019 07:55:13 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 9e3bfd13 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 27 Aug 2019 11:55:12 +0000 (UTC)
Date:   Tue, 27 Aug 2019 13:55:12 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/6] tests: remove reliance on buffer behaviour of
 stderr/stdout streams
Message-ID: <20190827115512.GB131601@ncase>
References: <cover.1566555078.git.ps@pks.im>
 <cover.1566566906.git.ps@pks.im>
 <d503b30d13c847040a8343f0e7299ae1bf7cb120.1566566906.git.ps@pks.im>
 <20190827111748.g4o375ya2shfrivs@10.255.255.10>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <20190827111748.g4o375ya2shfrivs@10.255.255.10>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 01:17:48PM +0200, Karel Zak wrote:
> On Fri, Aug 23, 2019 at 03:32:53PM +0200, Patrick Steinhardt wrote:
> > +	if [ "$TS_ENABLE_ASAN" =3D=3D "yes" ]; then
> > +		args+=3D(ASAN_OPTIONS=3D'detect_leaks=3D1')
> > +	fi
> > +
> >  	#
> > -	# ASAN mode
> > +	# Disable buffering of stdout
> >  	#
> > -	elif [ "$TS_ENABLE_ASAN" =3D=3D "yes" ]; then
> > -		ASAN_OPTIONS=3D'detect_leaks=3D1' "$@"
> > +	if [ -n "$UNBUFFERED" ]; then
> > +		if type stdbuf >/dev/null 2>&1; then
> > +			args+=3D(stdbuf --output=3D0)
> > +		fi
> > +	fi
> > =20
> >  	#
> > -	# Default mode
> > +	# valgrind mode
> >  	#
> > -	else
> > -		"$@"
> > +	if [ -n "$TS_VALGRIND_CMD" ]; then
> > +		args+=3D(libtool --mode=3Dexecute "$TS_VALGRIND_CMD" --tool=3Dmemche=
ck --leak-check=3Dfull)
> > +		args+=3D(--leak-resolution=3Dhigh --num-callers=3D20 --log-file=3D"$=
TS_VGDUMP")
> >  	fi
> > +
> > +	"${args[@]}" "$@"
> >  }
>=20
> Unfortunately, it seems "${args[@]}" does not work when environment
> variable used:
>=20
>   ASAN_OPTIONS=3Ddetect_leaks=3D1 stdbuf --output=3D0 /home/projects/util=
-linux/util-linux/mkswap --label 1234567890abcdef --uuid 12345678-abcd-abcd=
-abcd-1234567890ab /dev/sdc
>=20
> ends with
>=20
>   ./tests/ts/misc/../../functions.sh: line 465: ASAN_OPTIONS=3Ddetect_lea=
ks=3D1: command not found
>=20
>=20
> And it's more tricky, it seems ASAN binary cannot be executed by stdbuf
>=20
>   # stdbuf --output=3D0 /home/projects/util-linux/util-linux/mkswap --lab=
el 1234567890abcdef --uuid 12345678-abcd-abcd-abcd-1234567890ab /dev/sdc
>   =3D=3D28469=3D=3DASan runtime does not come first in initial library li=
st; you should either link runtime to your application or manually preload =
it with LD_PRELOAD.
>=20
> it's because stdbuf is hack based on LD_PRELOAD which makes it
> difficult to use with ASAN...
>=20
> I have tried to fix it by
> https://github.com/karelzak/util-linux/commit/f612c4c674e8e07fc40644432d8=
147a05c62058e

Noticed one more thing. In the parameter parsing step, we check
`type stdbuf` while we actually use unbuffer later. I guess the
first check should now be `type unbuffer`, right?

Patrick

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAl1lGiAACgkQEXxntp6r
8Sx4Uw/5AVQaXXy0UkVQgE00Pg7ksa/tK7TzrI1+amlvtwcEQoXBQKoASf9AW2Zb
HLGYzXeTak1oTkVN9nsdoKsaAm6VPdOupunWl1AJMUfp4/vBOQDrXoFi4rPEJeIe
Nma6HUgy6smj7IOgUa+iHrth/LIAXZwbdbBrx/EMuRCrbVq/TeywgHG2YkXx4YQ8
waaOVW0uUCoDflBwORvNdpU88y90Fa+bx21u6Ym0R9+CH98BkVNsUz7Foi34CPVj
EztRq8+6LRT4sCfmvyTOCl2WrpV+nUF391n5QGFnTbbixPbZD219hmhvloCkVEGv
QN3zzEJZjdJgzhaYj48sV9PKBHjNoTAV2+6rs+JXz1iU1XYXLWrhm5SqvOnIp5TS
P7KKBxbMQ0oQbKedxnq8sWp6rJlgXX9PshEYb+OdKmgbByLsWsaTY5xE/euaatCY
Fuu+VoIWHd0TPcnoY6BhfHvTqJcW8/50FgM4ZuQRlhPxZ0fNPruArczLzGeQQ7Yg
WIUtJDexgikRpRO9o+wxYyJKfazkc6AXZwIGUcm4T+f6f4b1MVkDcfGM5SBNDGDs
FHbdN2b7lTtRoRDrYdvOQ31g1lFqtfiqhmYEuu0Pu5HtFYbl0C7Zj9kzknSPX3gl
PNEqTp9/rdwt83n47Rjnnh/xP9EWOglBV/qX8LVKkTg07mlXTr0=
=bOjR
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
