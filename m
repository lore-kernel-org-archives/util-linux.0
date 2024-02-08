Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265579941
	for <util-linux@vger.kernel.org>; Thu,  8 Feb 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402285; cv=none; b=ldOZOejN5VWrOdXL6hgQnHibVMc+pSc83pXtPqtdGpURblBdlFMwD1irJmnUZjMVmJjRH57gzV5v5juaeE9+9TWVqHMcSjYvFGxVszLCnxXg8R2kNRNsWSqVUFfj/42eMKSS8EpuZvEsIJBRTRO8CK1Zj2rDD8+tY6zSRVrbxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402285; c=relaxed/simple;
	bh=WrNtPcKTDKZkZxIMCgmCYkdy5I20WZFB10YNxh+VQoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKzgX/bsntdA1yItFMuJhnsV9YcTZvprqQPnrcSjdE1ZzOMNbVnA+uszOWr7h3H/4LxUpHMGm6odendQdVXUW9jFSnQ1wOIf+JpUYzp6/QTcrHd28inbHPgtKSMo+1Jkjs/+cbTeHW1rjeGFWLL9F9g5rw6rDYRbCg0woAo0ovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=Q6YyRaQr; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Q6YyRaQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1707402275;
	bh=WrNtPcKTDKZkZxIMCgmCYkdy5I20WZFB10YNxh+VQoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6YyRaQrdq4iTTbBLzlt6A23C2fJzP/xaGgd5JKHhmrE2p4lrWRZG8P73pbNouBL3
	 tEObXVpk3ETbWLp8eR730Uiele1V7hjAESbCzSPOxzXgom089cdkyZ59GnkZ22riJR
	 MFkrS/zFOdp/0zrhyxuR1+qYCph5qhNTwbUWWCYJgpV2QXzouoBUToYVPcfP+IqSG3
	 VPBg9lMniZIcN6jBK0K/tMp/K/DecqHZzk1th9qrlUQaB8RbLIhXnhRp1IKWyn4jk/
	 Qi1SssfA/c32WhzqTZrvOGLkNcUyhDgiUDJX2X4lKiTZREV4rzQA/YACX2zBVTcZ/l
	 jsTaOFQpdfAHg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id AB72C124C;
	Thu,  8 Feb 2024 15:24:35 +0100 (CET)
Date: Thu, 8 Feb 2024 15:24:35 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fsck exits 0 with no output (just version) when it doesn't find
 a type-specific fsck
Message-ID: <z4ddhuuxh3wquorqohlbec5m6talui6wuwuu5wy4gjw4wg6ltv@tarta.nabijaczleweli.xyz>
References: <f63r2qpu2tzoaabfsuq5yjlqguystzu4tyjvok3etadzy4ouk6@tarta.nabijaczleweli.xyz>
 <20240208115549.4iucrphww74l5zna@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="siirdq3q4gq35pi5"
Content-Disposition: inline
In-Reply-To: <20240208115549.4iucrphww74l5zna@ws.net.home>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--siirdq3q4gq35pi5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 12:55:49PM +0100, Karel Zak wrote:
> On Wed, Feb 07, 2024 at 06:52:47PM +0100, =D0=BD=D0=B0=D0=B1 wrote:
> > I think in -A mode it makes sense to silently ignore a lack of type-spe=
cific fsck.
> > But when explicitly requesting fsck /dev/whatever, that condition
> > should at /least/ warn (I'm assuming erroring out would be too invasive=
),
> > because right now fsck cleared my potentially-broken filesystem w/o che=
cks.
>  Good idea, possible improvements:
>  https://github.com/util-linux/util-linux/pull/2777
Looks good, works for me.

(The warning is in slavic word order, though;=20
 ought to be "fsck.%s not found".)

Best,
=D0=BD=D0=B0=D0=B1

--siirdq3q4gq35pi5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmXE5CAACgkQvP0LAY0m
WPGAqA//dfk4IGfcXrPL7aZPBGFL5BjeDjww0Xt9tszR1ZJpq0D2QccytuYQR5Yo
S/NWdwo+CSfeyBh0O7kuWYcQFnYA7LIwtU4oDHB60gh96O2ND6qu2iSNLFrLDPT4
MRqvcl8vrYRd1tkCGAJDWX9G5Nvs4+0yHJfnmI8L0YB1s3jfM4Amr9p9zFsOEYr3
Cbrbiu4kjOB9zqQ68zntpgfZcCf+/AqamCoycnxoT/+dPvIq6AxAN+1LyAg/Ueln
T/Q0hgVlc3cgVzsOcoZVKVMRyf8dm+1wWixwqZgMmZIUCBg5FprcYCipHUk0dkTK
rtluwLrovI1WJmDrXf8aQKSVxv5X/mskDvlSDd++Xn3QaK+tEtBBMcXOXhlunQm1
JvyMY53tHI2bqYD5BZHrl1FcVxoiJc0bKPgCWx75ixt2I55kA0Y9Q2ZsGzFBKZ3x
pTe82C42BEWaDDaXnhNoKI/oZ+XIJKduuzsx/Q7Y9D6IyjaH8SdgrCacp0CX/55d
izG6i3oVJXFj0AmoPF9thiL2Ma4xyRrTXkHLrts+Gi26Ac/hrJxarcNmkpr1xLIS
NU0HWkPN19HTJ4af2o1yZroPLP2n1cI88oXg0kRdaCcKudZG9KK0jnXEpN/0jDDt
ui/megUo0x/9QQR3JW9hN0n/M3J0MdIWWH7BX5ov7Thk8O5Y/Xs=
=xbS8
-----END PGP SIGNATURE-----

--siirdq3q4gq35pi5--
