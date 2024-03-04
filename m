Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE3224D5
	for <util-linux@vger.kernel.org>; Mon,  4 Mar 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560753; cv=none; b=S+FvdJl67h0NcssjVsDleBUf1E2tyfdIu7HQvW3grlptv1LAizuhip6fyjamD2uHciI/LmhbwtsNsOEK8k9qEVCCP4C1B2p00cAorPpoPeYWha5kIoaNUhjf/4P7q3Cdt4zGDjgKU5IIrA3sGIlLPSpa65fSed4+VQZlvnK/zmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560753; c=relaxed/simple;
	bh=TKJ7CEYN0tsIj+tcMm4IRbpcPXANeodzbvu/OyzSPqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqCg4GBMAdR2Go8mft0PTBiTnbl41fvTq88wTfnjbnuRN8Y4nInupNsmt2iHY0SiUw849EYFo+KogPbq5WQznwwo80HHdVl1SRcbe8XmM4obqmErljRUX28fe7X/BKS9F4SC47QIDeUV8FWi1CPEdUxSQi3OpRIwsr4xe8MQ7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG67YGcw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG67YGcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95976C433F1;
	Mon,  4 Mar 2024 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709560752;
	bh=TKJ7CEYN0tsIj+tcMm4IRbpcPXANeodzbvu/OyzSPqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RG67YGcwk5Ki2zUF/3tNU6RhviCUF3km68pbXkdZxFqDsH0v8Ed/kONeg1NRr9rzd
	 GFaELFzM+NwHZ80kMmogjD+SlKqYFOYmwpos2lBEXRPoZadfYp7xutBdahK0Li+gJT
	 uyhPXPg/HPOpCe+IVDw83oGtLHVpN8BYlIFIWt+AyBsVxCFuE0saTraPsJ4z5o6YVK
	 Ybc5IUyhyqpwCxdVL1BjH8grAJD1xNdJWzwrcVdtMHTwW6VtZfXANwZ+DiekVtqLfT
	 WfS6BubmtDa33yrw1PgoS4qvO2j/tnfwDODbmMehNKqk6Yo2/nFpb61RArpuGsN+Vs
	 bSWn4XNKarIaQ==
Date: Mon, 4 Mar 2024 14:59:08 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Karel Zak <kzak@redhat.com>,
	"Skyler Ferrante (RIT Student)" <sjf5462@rit.edu>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, util-linux@vger.kernel.org
Subject: Re: Escape sequences in /var/log/auth.log
Message-ID: <ZeXTragrroBXGgUw@debian>
References: <CAEOG19pNSdEMjyoo_=s8-WqVs+jrmaaU=CjRb0oxKw1FG00xSA@mail.gmail.com>
 <20240302173316.GA1508977@mail.hallyn.com>
 <ZeRYJ6HD77humJzg@debian>
 <20240304123359.ruh64pobvg53r7f7@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yakaQGcnW55dvWi2"
Content-Disposition: inline
In-Reply-To: <20240304123359.ruh64pobvg53r7f7@ws.net.home>


--yakaQGcnW55dvWi2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Mar 2024 14:59:08 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Karel Zak <kzak@redhat.com>,
	"Skyler Ferrante (RIT Student)" <sjf5462@rit.edu>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, util-linux@vger.kernel.org
Subject: Re: Escape sequences in /var/log/auth.log

[TO +=3D Skyler]

Hi Karel, Skyler,

On Mon, Mar 04, 2024 at 01:33:59PM +0100, Karel Zak wrote:
> On Sun, Mar 03, 2024 at 11:59:51AM +0100, Alejandro Colomar wrote:
> > This seems to be a bug in util-linux, not shadow, so I've added
> > util-linux@ to the thread.
>=20
> Fixed. Thanks for your report.

Thank you.

Skyler, it's been fixed here:
<https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=
=3D677a3168b261f3289e282a02dfd85d7f37de0447>

Have a lovely day!
Alex

>     Karel
>=20
>=20
> --=20
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--yakaQGcnW55dvWi2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXl060ACgkQnowa+77/
2zLhJA//UPeRyDWvqE2zm6jS3jaAYRuysYcpAuqCs+sjktTVCHf7hi2diFDliQ87
LPTI+V93HJsUvs803pk8YJMyrG2HyZfVr/KCknxuLc3IDo5X+4J4RInqwCltNBRf
PbIO8G2iXO7Ra0/KcDV97wAGk+GXGcls7VoCrbp7uav4adhc02nA6AzNZFaNTDao
s0Xdproofufpq7OQ3Znd5BeSvKDLi8wwohEK8fPx42q5GHVDAjyMptfnqHuFVErT
VZcTn2W78VkLMnz2rJenNBPUzS/RCv/J4xpeSPbsGQ5QEYt3eJ0zPP3BxfTDkMOB
fzSiJWy8v1Dl8Q+WMeAGUz9s4tBzxg2QvC36ZwlPG/ivQeARcQUPfFpxoPufalom
W9Tu6z2mzbwUkF6h7Ot3jTGouNheX8Stc8YYQTjk56D5BeYQ5UEVUHOvZkar5e5r
26VVbK83FnDm5Hp0MXJsmdrZFY4495JdGonlfyX9HmrrKxK2JVYMEEXAAUrVRyNB
64ahaDqc8hOwo/L2WRpW6Ff3mOaAEhXSrnCwSH/bUAkE04wbs36YC7AWTKnGXcAp
lPxtmKGa9R2tZ5qY8Cs3yB/rUZi+DCX27t8lnnu5O7Ess+9wtV0F6GOl2DDxjKeX
lO3YVHWH544UwbUrnM4YIC9rpf0MpAN7w3Iuj3VX2dcz6pthB2E=
=5pVI
-----END PGP SIGNATURE-----

--yakaQGcnW55dvWi2--
