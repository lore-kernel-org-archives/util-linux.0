Return-Path: util-linux-owner@vger.kernel.org
Received: from mta04.eastlink.ca ([24.224.136.10]:57961 "EHLO
        mta04.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbdBODbY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Feb 2017 22:31:24 -0500
Received: from cmgw04.eastlink.ca ([71.7.199.170])
 by mta04.eastlink.ca (Oracle Communications Messaging Server 7.0.5.37.0 64bit
 (built Jan 25 2016)) with ESMTP id <0OLE00E2P74ZLAJ1@mta04.eastlink.ca> for
 util-linux@vger.kernel.org; Tue, 14 Feb 2017 23:01:22 -0400 (AST)
Date: Tue, 14 Feb 2017 23:01:21 -0400
To: Tilman Schmidt <tilman@imap.cc>
Cc: Yuri Chornoivan <yurchor@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix word repetitions
Message-id: <20170215030121.GW8687@cordes.ca>
References: <1486724704-8127-1-git-send-email-yurchor@gmail.com>
 <4628c807-c74f-fe57-2cab-6690fa94d4d7@imap.cc>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary=vOmOzSkFvhd7u8Ms
In-reply-to: <4628c807-c74f-fe57-2cab-6690fa94d4d7@imap.cc>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 11:40:34PM +0100, Tilman Schmidt wrote:
> Am 10.02.2017 um 12:05 schrieb Yuri Chornoivan:
> > -	/* Reformat string string to avoid doing it multiple times later. */
> > +	/* Reformat string to avoid doing it multiple times later. */
>
> Actually I don't think this is a word repetition. It looks to me like
> it's really talking about "string string" - the string held in the
> variable named "string".

 That sounds like a valid interpretation, but the new version reads
better.

> > - * If anything goes wrong (and many things can), we return return code=
 10
> > + * If anything goes wrong (and many things can), we return code 10
>=20
> Nor is this, as it talks about the return code that will be returned.

 Good point here.  The original version works, but is more verbose
than it needs to be.

"we return code 10" is a valid way to describe the return value, but just
"we return 10" is simpler and unambiguous.  I don't think the comment
needs to explicitly call it a code.


--=20
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iLwEAQEIAAYFAlijxIEACgkQBaSaEuRa5FN14AT/YK4o5TOE7DIFd6jdjHUtyzqs
rxKmNFBcTT+/j5GP1Ml2ParkwvS4M+EaYj1bzeW34yCYhZ0vNyue8PPtRhneCovN
JE2/hx9A6jjmEVZehN6DPVnwI/hnk+jXYlp6hY6hK+RCB+RS0Wf5zEMG/F0qEPL6
ZsEuZqCBgZaEq76fmmdISAgGRlWqXnfNtLOyvnq00phPGXRLBLllIAGttESapw==
=4fUZ
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
