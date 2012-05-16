Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48134 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757233Ab2EPJYO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 May 2012 05:24:14 -0400
Date: Wed, 16 May 2012 11:24:09 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] blkid: introduce symbolic names for different blkid
 exit codes
Message-ID: <20120516092408.GA3670@foxbat.suse.cz>
References: <1337157512-31920-1-git-send-email-petr.uzel@suse.cz>
 <1337157512-31920-2-git-send-email-petr.uzel@suse.cz>
 <7856072A9D04C24B82DFE2B1112FE38A0F1E5D2336@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0F1E5D2336@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2012 at 10:52:40AM +0200, Voelker, Bernhard wrote:
> Petr Uzel wrote:
>=20
> >  #include "ismounted.h"
> > =20
> > -#define STRTOXX_EXIT_CODE	4		/* strtoxx_or_err() */
> > +#define STRTOXX_EXIT_CODE	BLKID_EXIT_OTHER	/* strtoxx_or_err() */
>=20
> STRTOXX_EXIT_CODE is not used in blkid.c. Remove it?
> ... or if it used in strutils.h, then this is not a nice interface.

Yep, it is used in strutils.h.

>=20
> >  #include "strutils.h"
> >  #include "closestream.h"
> >  #include "ttyutils.h"
> > @@ -484,7 +488,7 @@ static int lowprobe_device(blkid_probe pr, const ch=
ar *devname,
> >  	fd =3D open(devname, O_RDONLY);
> >  	if (fd < 0) {
> >  		fprintf(stderr, "error: %s: %m\n", devname);
> > -		return 2;
> > +		return BLKID_EXIT_NOTFOUND;
> >  	}
> >  	if (blkid_probe_set_device(pr, fd, offset, size))
> >  		goto done;
> > @@ -551,9 +555,9 @@ done:
> >  	close(fd);
> > =20
> >  	if (rc =3D=3D -2)
> > -		return 8;	/* ambivalent probing result */
> > +		return BLKID_EXIT_AMBIVAL;	/* ambivalent probing result */
> >  	if (!nvals)
> > -		return 2;	/* nothing detected */
> > +		return BLKID_EXIT_NOTFOUND;	/* nothing detected */
> > =20
> >  	return 0;		/* success */
> >  }
>=20
> These are not exit() codes, but return codes.=20

Strictly speaking, yes. But the idea is that those codes are (or
rather should be) propagated as exit value anyways...

> That value doesn't seem
> to be of much interest anyway, because it's used only here in main()
> in a for-loop, forgetting the return value of the previous iteration:
>=20
>                for (i =3D 0; i < numdev; i++)
>                         err =3D lowprobe_device(pr, devices[i], lowprobe,=
 show,
>                                         output_format,
>                                         (blkid_loff_t) offset,
>                                         (blkid_loff_t) size);

Hmm, the return value depends only on the last argument (device). I
don't think this is intentional. Karel?

        # blkid -p /dev/sda /dev/sdb ; echo $?
        /dev/sda: PTTYPE=3D"gpt"=20
        error: /dev/sdb: No such file or directory
        2
       =20
        # blkid -p /dev/sdb /dev/sda ; echo $?
        error: /dev/sdb: No such file or directory
        /dev/sda: PTTYPE=3D"gpt"=20
        0


>=20
> Have a nice day,
> Berny
=20
Thanks,=20

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+zcjgACgkQnZxG0T6qDD1WvwCfVIJmOn95VXFN2yWK9CTpekYC
Y5YAn1qR1tAvcltsU+ZSPBZ8DizO7mxv
=PNUg
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
