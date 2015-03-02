Return-Path: util-linux-owner@vger.kernel.org
Received: from mta03.eastlink.ca ([24.224.136.9]:58555 "EHLO mta03.eastlink.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172AbbCBWbN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Mar 2015 17:31:13 -0500
Received: from cmgw04.eastlink.ca ([71.7.199.170])
 by mta03.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NKL00M4R8EA13S0@mta03.eastlink.ca> for
 util-linux@vger.kernel.org; Mon, 02 Mar 2015 18:31:10 -0400 (AST)
Date: Mon, 02 Mar 2015 18:31:10 -0400
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: sfdisk problem with a partition starting early on a GPT disk
Message-id: <20150302223110.GB3933@cordes.ca>
References: <20150301155610.GW3933@cordes.ca>
 <20150302100652.GI8046@ws.net.home> <20150302161932.GX3933@cordes.ca>
 <20150302201311.GM8046@ws.net.home>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary=vKFfOv5t3oGVpiF+
In-reply-to: <20150302201311.GM8046@ws.net.home>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2015 at 09:13:11PM +0100, Karel Zak wrote:
> On Mon, Mar 02, 2015 at 12:19:32PM -0400, Peter Cordes wrote:
> >  If libfdisk doesn't actually store anything after sector 33, it would
> > be nice if it wrote a GPT to disk that that has sector 34 as the
> > first-usable.=20
>=20
>  I'm not sure, the common consensus is to use 1MiB offset for the
>  first partition -- then it does not make sense to define
>  FirstUsableLBA smaller, because the extra space between the first
>  partition may be interpreted as gap and later (inadvertently)
>  partitioned.

 If libfdisk-based tools depend on this to avoid showing the user
there's partitionable space before the first partition, then they'll
behave differently when editting GPT partitions written by other tools.
(The widely-used parted sets FirstUsableLBA =3D 34, and I assume so do
most others.)

 If that's just for the benefit of "other tools", then parted doesn't
need this help.  gparted doesn't seem to offer a way to create
non-1MiB-aligned partitions even if you wanted to.  (IDK about the CLI).

 If a tool doesn't try to enforce alignment, the 2nd partition a user
creates could be un-aligned, if the first partition doesn't end on a
1MiB boundary.  Anyway, IDK how useful this theoretical benefit is to
anyone.

>  Note the I'm talking about default layout, your example with=20
>  --dump and restore is different -- sfdisk has to be able to=20
>  copy existing partition tables.
> =20
>  BTW, the problem should be fixed in git tree, you have to --dump with
>  new sfdisk and then it will add "first-lba" number to scrit header.

 Ok, cool.  It might not be hard to detect scripted partitions
starting below 2048, but above 33, and set first-lba to the lowest
number found.  Or to 34, if a partition before 2048 is found at all.

 Requiring scripts to have a first-lba: 34 is a non-obvious extra step
that might take some debugging time for someone generating a script
=66rom scratch in a program, rather than with sfdisk -d.

>  It would be better to learn partitioning tools to modify
         <englishlesson> teach </englishlesson>  :)
>  FirstUsableLBA in GPT header. I'll probably implement it for v2.27
>  fdisk, so creative users like you will be able to tune up their
>  partition tables :-)

 Yeah, neat.  That could be useful either way, for setting to 2048 in
other tables, as well.

 Thanks again for the quick response and getting a fix in.  I'll use
it to re-copy my partition tables now, before I'm booting from them.
So it should be easy to fix anything that happens because of different
UUIDs.

--=20
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iLwEAQEIAAYFAlT05K4ACgkQBaSaEuRa5FNo0gT/Yez79ksBJ4bA80Nuu9TMQz2E
jTIVycHP+xXg7tIweVsO4Ies3Aqjzo8xjpHKJIavm8hBavickdGFh+XB9okLRemq
hHnaPFk6Inn3I60OKYJUS8EzvpRgwk7hSOmmZdAlo4mj8BVUXLOLSOFhFKnl71sB
FQ6lSBpo3/iP7YjP8RyisGdFkoMFhYSb1Rq65QN5NYil2H9B0QSNvk+ha4fCfw==
=yAc2
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--
