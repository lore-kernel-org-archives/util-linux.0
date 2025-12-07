Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4DEACD
	for <util-linux@vger.kernel.org>; Sun,  7 Dec 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110880; cv=none; b=BZam8EvVThjOnEmSfCg9rGFljEhwmaPBHIgAQtevHGrHcC+4Zzgxva0v7/VURDODexYIN8Ht5haE6x6y8uwVPa33ptNJdntxHYo0ZOeF3ZiXIebLKJ6Rp3TQVDBqlGmaxweLtFfSHkpHhLemadAlEFCvCcduHpcadL+FmCJxHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110880; c=relaxed/simple;
	bh=GctnYz4fW+upJZu1BhQv+gaSWUh+jx6P4rwBrW0Au+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3lJLIbds/UhxLCCV7FNwIG7DvAilJ/E3lkP9fitGYVCW+vqR+Xc4lMsNyItrcBnAeoG1lXUPg/PEyqY1gxQlhfo4sZZT9EZAi8FPvDPXGRVY84y7uftMRj1rRsR7gjsDYjmWmJvyYYr61j0QYPoT1zy6C7ywwZYyYzVBXBSY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3hHuaOC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3hHuaOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF572C4CEFB;
	Sun,  7 Dec 2025 12:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765110880;
	bh=GctnYz4fW+upJZu1BhQv+gaSWUh+jx6P4rwBrW0Au+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3hHuaOC8xs+r4z0ab6ZkMhtksYoCvf9kK0+c/0h2Q90lZ7qvZrezcKkPp/4YLR30
	 E90K2M2Z8u6/hKrLIJ0jn/87R54jpdqzT91ufsMpyH9EjIL2uduigxRAIQDvgEoDK9
	 PS4NKa88Gwcru5i4a31NF6qp99gguSjbN4ZWJSeHxaBGYvr1tPxR4sK1Uesz7gihjS
	 C1S9pwZQWT2imw9rJUoToFr8CpKSVd19KrL5r4ePx3WWzuY2gX/nUaZ7u9iRe4Ikh2
	 CrsXdPy4rT77U/ryXPvTXJcKsWFZRpRWSoV8j8Tn6svaERTQXnlOxJicFaNAJDwzkE
	 QlczVXscMAfaQ==
Date: Sun, 7 Dec 2025 13:34:36 +0100
From: Alejandro Colomar <alx@kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	GNU C Library <libc-alpha@sourceware.org>
Subject: Re: [PATCH] x32: Switch back to assembly syscall wrapper for prctl
Message-ID: <blmb25wi2xskdsfkkgsm25uzacnn3kjny3if2uaazwfivzsdlw@siix5jfad7yj>
References: <20240601093150.16912-1-alx@kernel.org>
 <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
 <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
 <5272b875-bec8-4b28-84e8-05606db83120@linaro.org>
 <CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jlsuwwbrfcknbqwk"
Content-Disposition: inline
In-Reply-To: <CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>


--jlsuwwbrfcknbqwk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	GNU C Library <libc-alpha@sourceware.org>
Subject: Re: [PATCH] x32: Switch back to assembly syscall wrapper for prctl
Message-ID: <blmb25wi2xskdsfkkgsm25uzacnn3kjny3if2uaazwfivzsdlw@siix5jfad7yj>
References: <20240601093150.16912-1-alx@kernel.org>
 <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
 <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
 <5272b875-bec8-4b28-84e8-05606db83120@linaro.org>
 <CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>

Hi H.J.,

On Sun, Dec 07, 2025 at 11:52:08AM +0800, H.J. Lu wrote:
> On Thu, Dec 4, 2025 at 10:06=E2=80=AFPM Adhemerval Zanella Netto
> <adhemerval.zanella@linaro.org> wrote:
> >
> > The x32 and or1k (which also uses similar implementation) does seems br=
oken
> > without checking the 'option' argument to see which arg we can va_arg.
> >
> > The problem is adding this logic on libc will add some forward-compatib=
ility
> > that we try to avoid (newer kernel prctl additions might now work corre=
ctly).
> >
> > I am not sure why we haven't switch x32 back to the assembly wrappers
> > with 6a04404521ac4119ae36827eeb288ea84eee7cf6 fix (BZ#29770).  H.J, can
> > use remove the x32 C version (and also or1k as well)?
>=20
> Since the variadic prctl function takes at most 5 integer arguments which
> are passed in the same integer registers on x32 as the function with 5
> integer arguments, we can safely use assembly syscall wrapper for prctl
> for x32.
>=20
> Tested on x32.  I leave or1k alone since I don't know if it is safe to
> do the same.

Thanks!  Would you mind adding the following tag?

	Reported-by: Alejandro Colomar <alx@kernel.org>

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--jlsuwwbrfcknbqwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmk1dFYACgkQ64mZXMKQ
wqlO+w/9HX5xnpevbACUg0n6Oo2cLwqAnRD4vXW3ARVx10gU3diUmRMBHFxnls4K
LDwkf4a2XnaKqzg91ggdgzYxQqSZPbokc44x7fjJS6+LrlJaPRetPE9YZ6OSUsRt
r9ReWDBzunB5xHGYeDtg6C+0fxl7+uQEF7kUlDOx7lMaKYUDO74mZIFXSgoYE2cE
2nfNqcq9x+b8w2CE9xq3pYN5Zzoq7INB/wSr961q46uhbAnBc5YEkvEfOB/wJyi8
3VkXXyxLBO/4sslGLLEitZWY03tkaMYm7lekPf1qam23G3X3OnCE/UJDREzaXxuh
3je0bGXFJGALha8QKKumCAcU41OTsPSoqehgBRYTvxJYjohwFTj49TwCB9VMhFNX
0g8GbUi56rtEvzpxAQu91l2qDuQ4sy+XJ+bGGiW2Z9w1vkiKbi2tMh5O42rbtztv
O9uDXO4YKxt7rac0xYH30bVaXMaejmeZZnX+TF8rq7/8ULLeYFYUk344Z+ltEmYs
9e9AW2YsUQ3bcqxI6wiUhfyMg5wHS4fGCfBO57VvFDsqZiBD6SNTWDs9fqUeqArt
WEDkQRz4o4rcmmmi3s/fGX9nlC5dSN1EutUyXiEKJutP1z5Js66xXmS3CgyP+piD
gVv4SpeFsPA+H6DZo6kKgwxrVnqg7Y3SkJNv4tWg3OKeXmdu6Ac=
=685+
-----END PGP SIGNATURE-----

--jlsuwwbrfcknbqwk--
