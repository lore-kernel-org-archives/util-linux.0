Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:58585 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbbDCXQo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Apr 2015 19:16:44 -0400
Date: Fri, 3 Apr 2015 19:16:42 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150403231632.GN22171@vapier>
References: <201504011817.48428.sweet_f_a@gmx.de>
 <20150401201051.GP25224@vapier>
 <201504012306.52737.sweet_f_a@gmx.de>
 <20150401213800.GB2097@ws.net.home>
 <20150402011230.GA22171@vapier>
 <20150402082000.GC2097@ws.net.home>
 <20150402161952.GB22171@vapier>
 <20150402191530.GG2097@ws.net.home>
 <20150403011522.GH22171@vapier>
 <20150403085203.GA3923@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kERJ49nCKmnv470N"
In-Reply-To: <20150403085203.GA3923@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--kERJ49nCKmnv470N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03 Apr 2015 10:52, Karel Zak wrote:
> On Thu, Apr 02, 2015 at 09:15:22PM -0400, Mike Frysinger wrote:
> > On 02 Apr 2015 21:15, Karel Zak wrote:
> > > On Thu, Apr 02, 2015 at 12:19:52PM -0400, Mike Frysinger wrote:
> > > > On 02 Apr 2015 10:20, Karel Zak wrote:
> > > > > If I good remember then the reason is that the helpers does not h=
ave
> > > > > to be installed in standard PATH. Well, you're author of this thi=
ng
> > > > > :-)
> > > >=20
> > > > i wrote the code to make it a configure option, but the actual beha=
vior predates=20
> > > > me.  i'm interested more in the behavior, not the exact configure o=
ption.
> > >=20
> > >  So, the basis question is if we really need to support non-standard
> > >  paths for the helpers. IMHO it's unnecessary legacy and I don't see a
> > >  problem to drop this feature and require $PATH, and for critical
> > >  things like fsck fallback to /sbin if $PATH is undefined.
> >=20
> > the reason for adding that configure option was to support packages tha=
t install=20
> > both into /bin and /usr/bin.  i understand some distros will override t=
hose=20
>=20
> I have talked about crazy things like /sbin/fs.d or /sbin/fs. The standard
> paths like [/usr]/bin, [/usr]/sbin are not problem.

i have no problem with punting fd.d & fs subdirs.  i don't recall ever seei=
ng a=20
Linux system use them, although i've only been running things since the 2.4=
=20
days, so maybe i'm not old enough.

> > settings of upstream packages, but Gentoo has opted not to since there'=
s no=20
> > reason at all to force them all into /sbin (and even existing tools in =
/sbin are=20
> > pretty pointless).  although it mattered more when the code was only se=
arching=20
> > that list and not $PATH at all.
> >=20
> > my preference would be just to do execvp() and be done so we can stop t=
hese=20
> > distro bikesheddings (/bin & /usr-merge and such).
>=20
> Yes, I thought about it too... just move the problem with PATH to libc ;-)
>=20
> For example mkfs already uses execvp(), I guess we can do the same in
> fsck. For mount(8) it would be better to follow the current behaviour,=20
> but remove nonsenses from FS_SEARCH_PATH (and rename to LIBMOUNT_HELPERS_=
PATH).
>=20
> Volunteers? ;-)

i'll take a stab at mkfs first
-mike

--kERJ49nCKmnv470N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVHx9aAAoJEEFjO5/oN/WBk64QALnuuMAEV2UJwd9QtwVTl9Ee
yDhqz6/EHW6KxPqOmrppnDP2NNKK+HJuDsavcTzeOdqRUocvbdCqdQQEoSW5IZ1s
3k8/FJ2EqXRiHjA01C/6EiM/HUENrcHgupJvFZFwh2j7Up1JioFoopQjCzlRbpOT
NP40Y9NVO58pDd4QVuqzWDJd3ndfsFh/PoPYdQZQFoU3btE0TVFhX7JWpy07f8YN
AzLq38P2NBl+KXi8lI21uLqldh6ceTm8fEP7A9WbmQadXQ0yHenQ+Ev8KPVlF97m
hK+vRI9wxFvfvjidwxWkyZT0LMvue6LX4oSdUO7Tfav6VmF/zEq6/nibyO/mR38t
TfnzSaAWWLISj8VzJhMIB7/WsluziLKWPq6Bi+648E8LToB3amcgeRf50BMmDwTl
3nr82ZWTZmeEoSzl2chTKD7GwPa+hBKu4XqfrzFLUqN/BDEw5KUCiWFfyhTwQgsM
5HbSlifCMq7jjff4T+kqWzBzpQdduur/PBfpy6SXa8vX+tdsPltpgH1+IJUEpNUF
B3LphhWQPhOza2JP93I0CfzlN9SoPbasibDVFMhayfW7Z8yd3a/ulT+PF0FSPtbD
ZPq+/kPQUbcNjoRR3SmkOPTW5EOCySt/l3IPVqxTFknkY/bkMGysROFM0XRBFI/a
BhaSw11xOvhhja6OS2H8
=yLsa
-----END PGP SIGNATURE-----

--kERJ49nCKmnv470N--
