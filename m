Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:44725 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab2ECEme (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 00:42:34 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Phillip Susi <psusi@ubuntu.com>
Subject: Re: losetup -d --force for zombie loop devices?
Date: Thu, 3 May 2012 00:43:20 -0400
Cc: Thomas Orgis <thomas-forum@orgis.org>, util-linux@vger.kernel.org
References: <20120417100346.2a0b8301@orgis.org> <201204301607.22712.vapier@gentoo.org> <4F9FFFFE.5070404@ubuntu.com>
In-Reply-To: <4F9FFFFE.5070404@ubuntu.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12387512.gOekFQpOtD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201205030043.21697.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart12387512.gOekFQpOtD
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 01 May 2012 11:23:42 Phillip Susi wrote:
> On 4/30/2012 4:07 PM, Mike Frysinger wrote:
> > `umount -l` has its place -- there are cases where you want those
> > semantics. granted, most people actually want a `umount -f`, but the two
> > aren't mutually exclusive.
>=20
> If you want to prevent processes from opening new files on the mount
> point, it would be much more sane to mount --move it somewhere hidden.

there's really no difference at all here.  the active process will still ha=
ve=20
the same capabilities to modify their open handles, and attempting to open =
new=20
paths in the fs will fail because they'll be expecting the mount at one pla=
ce=20
but you relocated it elsewhere  (ignoring the accesses down via the *at fun=
cs=20
which will work the same).

> When you detach it entirely from the namespace, you can't even be aware
> that the mount still exists, let alone change your mind and reattach it.

you can re-attach it by mounting it again

>   Having a device that is still mounted, but appears not to be to all
> tools that normally check for such things ( partitioning tools, auto
> mounters, etc ) is broken.

conversely, having a mount point removed from the perspective of userspace =
can=20
be useful.  like with tools that stubbornly enumerate all mounts, or=20
attempting to shutdown your system with known unreachable network mounts. =
=20
you, as the admin, know these things are gone and beyond accessible, so hav=
ing=20
the ability to remove them all manually and reboot cleanly (w/out ridiculou=
s=20
long retries/timeouts) is a good thing.

> It is very confusing when you later try to change the cd in the drive
> and can't mount it because the old one is still mounted, yet lsof,
> mount, etc offer no evidence that this is the case, and you can't track
> down the process that is still holding an open fd and kill it.

are you sure that's true ?  `lsof -n` seems to report open handles to=20
unmounted filesystems to me.
=2Dmike

--nextPart12387512.gOekFQpOtD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPogzpAAoJEEFjO5/oN/WB+lEP/1dD2f+WXTfTRvCoEfSbMQ+N
uEH7iQNIx5Cpecv+JZfFNKW82j1IgtBRToUyOarnQLwJm6URaWNcegWPDt3teHEZ
d/wgST1bzeucXape6lD/HvehnRTMfy2X+VxHPD/E0ViWDOisw27UqWNYeQgDyK72
mMtwEdQrBdNWh4elxaohkO8jF989sh4jjDFMi3FYdVVN5h55CC8DSVp1TDlLncK9
W4u6ZDEYoZ539BLYGaemlDbhkFY0ZNIJbi5dH5DKvcFWWaso6JCreIBhIRBNcuhC
qNAMpTeh19zS+I/uVuE9xAguTsUwJkc7tOqrOTd+OlhuMzaXx+o1aj8LCz0bPKOJ
yr2Zf2/bijyMclP4IG0FsxjrQmQLMBLZ9VrgDCZ/amxqvIQPi0DRjt/mAlzFP65w
8Mo276JfttepOek33yBlipHDYzjHMFl6xPLUCX9Rt537AgMzCUglR4eEtr4m20hZ
PpN0076xKwxjXVKwdglEiMqdUlDtnida3Vav7Yyuf4N1LGeMWEoy6fWEZKdebqOp
HdFDb4cxA+vjY0r5RwHKWmI7g8lH+xrxz/ukN8cL/Az6kMa126cWSQ/yhjWHCS4M
qpnLUoBCPgFsSGFyUwAebyGEEvRCqtwZUiTHW9ysOai+Pq7eqzPaOOnIWg2nw+US
zjzvCMzoDb1vF7Qzr1i8
=uJZW
-----END PGP SIGNATURE-----

--nextPart12387512.gOekFQpOtD--
