Return-Path: util-linux-owner@vger.kernel.org
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54545 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461Ab2KHEdI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 7 Nov 2012 23:33:08 -0500
Message-ID: <1352349174.4728.55.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH] lscpu: Fix issue found on CPU hot-remove
From: Ben Hutchings <ben@decadent.org.uk>
To: Toshi Kani <toshi.kani@hp.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        heiko.carstens@de.ibm.com, kerolasa@iki.fi
Date: Thu, 08 Nov 2012 04:32:54 +0000
In-Reply-To: <1352330975.19172.124.camel@misato.fc.hp.com>
References: <1351021786-3362-1-git-send-email-toshi.kani@hp.com>
	 <20121107114714.GA29982@x2.net.home>
	 <1352330975.19172.124.camel@misato.fc.hp.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Gke2Aa2O3wdqM26SPzBh"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-Gke2Aa2O3wdqM26SPzBh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-11-07 at 16:29 -0700, Toshi Kani wrote:
> On Wed, 2012-11-07 at 12:47 +0100, Karel Zak wrote:
> > On Tue, Oct 23, 2012 at 01:49:46PM -0600, Toshi Kani wrote:
> > > 1) The system has 4 CPUs
> > >   $ lscpu -a -e
> > >   CPU NODE SOCKET CORE L1d:L1i:L2 ONLINE
> > >   0   0    0      0    0:0:0      yes
> > >   1   0    1      1    1:1:1      yes
> > >   2   0    2      2    2:2:2      yes
> > >   3   0    3      3    3:3:3      yes
> > >=20
> > > 2) Eject cpu2
> > >   # echo 1 > /sys/bus/acpi/devices/LNXCPU:02/eject
> > >=20
> > > 3) lscpu no longer recognizes cpu3 after cpu2 is ejected
> > >   $ lscpu -a -e
> > >   CPU NODE SOCKET CORE L1d:L1i:L2 ONLINE
> > >   0   0    0      0    0:0:0      yes
> > >   1   0    1      1    1:1:1      yes
> > >=20
> > > The following changes are made to address this issue.
> > >  - Use maxcpus to allocate and parse bitmaps.
> > >  - Set desc->ncpu from cpu/present, which includes both on-line
> > >    and off-line CPUs.
> >=20
> >  In the directory tests we have a dump from some strange machine
> >=20
> >     tests/ts/lscpu/dumps/sparc64-UltraSparc-T1.tar.gz
> >=20
> >  where is 32 /sys/devices/system/cpu/cpu[0-9]* subdirectories, but the
> >  present mask is 0-23, all the masks from the dump:
> >=20
> >  present: 0-23
> >  possible: 0-31
> >  online: 0-23
> >  offline: 24-31
> >  count: 32      (means ls -d sys/devices/system/cpu/cpu[0-9]* | wc -l)
> >=20
> >  strange, right? But I guess we can ignore this dump, according to
> >  kernel Documentation/cpu-hotplug.txt the cpu[0-9]* subdirectories
> >  have to follow the present mask. Maybe the dump is broken or so..
>=20
> Hi Karel,
>=20
> Thanks for the updated patch.  It looks good.  I have tested it on my
> setup and it worked fine as well.
>=20
> I agree that the present mask and cpu directories need to be consistent.
> I looked at the kernel code and found the following change, which might
> be the cause of this issue.
>=20
> =3D=3D=3D=3D
> commit 9f13a1fd452f11c18004ba2422a6384b424ec8a9
> Author: Ben Hutchings <ben@decadent.org.uk>
> Date:   Tue Jan 10 03:04:32 2012 +0000
>=20
>     cpu: Register a generic CPU device on architectures that currently
> do not
>    =20
>     frv, h8300, m68k, microblaze, openrisc, score, um and xtensa
> currently
>     do not register a CPU device.  Add the config option
> GENERIC_CPU_DEVICES
>     which causes a generic CPU device to be registered for each present
> CPU,
>     and make all these architectures select it.
>    =20
>     Richard Weinberger <richard@nod.at> covered UML and suggested using
>     per_cpu.
>    =20
>     Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> =3D=3D=3D=3D
>=20
>=20
> Hi Ben,
>=20
> In the change log above, you described that a generic CPU device to be
> registered for each "present" CPU.  However, in the code below, it used
> for_each_possible_cpu(), instead of for_each_present_cpu().  Is this
> what you intended?
[...]

I think the distinction doesn't matter - the GENERIC_CPU_DEVICES code
does not support hotplug and therefore can only be used if present =3D=3D
possible.

Ben.

--=20
Ben Hutchings
The program is absolutely right; therefore, the computer must be wrong.

--=-Gke2Aa2O3wdqM26SPzBh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUJs19ue/yOyVhhEJAQpeGQ/9F6ZsN0gI2NxB9mEEwTJJUkTVMLIIvJTA
4EA8R+KcZJpNkSsr8xDlKvZn2ZWT2CDwuCD9+NyY4HJabwrUOV0Sku5Rh4rwaTZS
dcY/BfOpT3u+oSbHz/SERL4h4pl/xtw72as4QXFcR+GyK+ZLKGyyceJ/jPgScnbG
v79w93Hvu3RgYD/I5pf24qN6wP6h2S/86qZfJY10FOqE+gp46PRTy5/IoVh5CU5J
gZ3Qh7uCFfn3Xi5NglnRnBeDBRYkGnjnbdYNx22XZbWP4nS/QgeIfAyG+QzchDc2
UCReGOIEeHdYHCi3jq+RJuensoCosOcn+Eu7Fzzt96gedzSIqJ6uweyuQs4dkWkA
cbqWKioM0dDefBXFldIt8TspEq2W4MQoCVFO+acjrRSYsd25A6T8q/HN8Ttjd5++
xrFBxGjZiA+mFYvgxRpRY4l+ACUxHN8UEQ+QdVfWEsbxagfbM27kbiG9sC9hfA7v
USfX2F5VFmXNhJ6mVbPwgadwKnN+37Z2eamQx8C6esoJKKLv8wRoEPTovLsSCfEo
wBQPTN+24cda6Yb7k3Zn6QTy7c3kLzlMX42CJBqPdgh6+JEH4S9GyWP0DiUqjTaI
hc/Fi/+O8Z6TNYThszMZVnXt51CDzy8nnQKxyqNKAdtpgB1bdUYrua8BU2KAsnJa
OVhj4TyaQEU=
=YIng
-----END PGP SIGNATURE-----

--=-Gke2Aa2O3wdqM26SPzBh--
