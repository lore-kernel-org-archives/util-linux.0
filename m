Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:56976 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753170AbcKJEOM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 9 Nov 2016 23:14:12 -0500
Date: Wed, 9 Nov 2016 20:14:10 -0800
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, Petr Uzel <petr.uzel@suse.cz>,
        util-linux@vger.kernel.org
Subject: Re: lscpu VMWARE bdoor patch
Message-ID: <20161110040953.GB21655@vapier.lan>
References: <20161027102515.qw47rdgn72qingfi@ws.net.home>
 <201610280006.36584.sweet_f_a@gmx.de>
 <20161102123004.nclgs4hdnccmjzma@ws.net.home>
 <201611030804.43544.sweet_f_a@gmx.de>
 <20161103094151.zufg6x2i3dth6nhe@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cseAwlqrBzmhRTxO"
In-Reply-To: <20161103094151.zufg6x2i3dth6nhe@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--cseAwlqrBzmhRTxO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03 Nov 2016 10:41, Karel Zak wrote:
> On Thu, Nov 03, 2016 at 09:04:42AM +0200, Ruediger Meier wrote:
> > On Wednesday 02 November 2016, Karel Zak wrote:
> > > On Fri, Oct 28, 2016 at 12:06:36AM +0200, Ruediger Meier wrote:
> > > > On Thursday 27 October 2016, Karel Zak wrote:
> > > > > this is lscpu output on my machine:
> > > > >
> > > > >     Virtualization:        VT-x
> > > > >     Hypervisor vendor:     VMware
> > > > >     Virtualization type:   full
> > > > >
> > > > >
> > > > > I have nothing like VMWARE. It seem the code (commit b7744730)
> > > > > does not work as expected for non-root users. What about to add
> > > >
> > > > Have you checked whether the original code in b7744730 is alreaday
> > > > broken? Not something about the later PIC/PIE patches?
> > >
> > > It's Mike's PIC/PIE patch :-(
> > >
> > > Maybe we can ifdef more precise and add getuid() check, if I good
> > > understand Mike's commit message then the problem is 32bit system.
> >=20
> > BTW vmware runs on 64bit only since a few years. Maybe just disable=20
> > bdoor for 32bit if it helps to make it simple.
>=20
> but you can use 32bit system (guest) inside vmware.=20
>=20
> I'll will add getuid() for now. Maybe someone (Mike?:-) will help us
> with a better solution later.

i don't think getuid helps.  seems like if you run it on a system even as
root it'll still fail randomly.

my guess is that when the inl is run, it triggers the segfault (since it
isn't run under vmware) which happens after the ebx/esi exchange.  but the
ebx/esi aren't swapped back, and for some reason the siglongjmp doesn't
make things right (but that doesn't make sense to me either).

if you revert my patch, then you can't build lscpu as PIE on x86, which
means you're worse off than you are now :).

when i trace it in gdb by putting a break on vmware_bdoor, i see:
(gdb) info r
eax            0xa      0xa
ecx            0x5658   0x5658
edx            0x0      0x0
ebx            0x564d5868       0x564d5868
esp            0xffffb540       0xffffb540
ebp            0xffffb548       0xffffb548
esi            0x564d5868       0x564d5868
edi            0xffffd81c       0xffffd81c
eip            0x5655873a       0x5655873a <vmware_bdoor+37>
(gdb) dis
Dump of assembler code from 0x5655873a to 0x5655877a:
=3D> 0x5655873a <vmware_bdoor+37>:        xchg   %ebx,%esi
   0x5655873c <vmware_bdoor+39>:        in     (%dx),%eax
   0x5655873d <vmware_bdoor+40>:        xchg   %esi,%ebx
(gdb) stepi
0x5655873c      827             __asm__(
(gdb) stepi

Program received signal SIGSEGV, Segmentation fault.
0x5655873c in vmware_bdoor (eax=3D0xffffb574, ebx=3D0xffffb578, ecx=3D0xfff=
fb57c, edx=3D0xffffb580) at sys-utils/lscpu.c:827
827             __asm__(
(gdb) stepi
segv_handler (sig=3D0xb, info=3D0xffffb04c, ignored=3D0xffffb0cc) at sys-ut=
ils/lscpu.c:854
854     {
(gdb) c
Continuing.
Architecture:          i686
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                4
On-line CPU(s) list:   0-3
Thread(s) per core:    2
Core(s) per socket:    2
Socket(s):             1
Vendor ID:             AuthenticAMD
CPU family:            21
Model:                 2
Model name:            AMD FX(tm)-4350 Quad-Core Processor
Stepping:              0
CPU MHz:               2000.000
CPU max MHz:           4200.0000
CPU min MHz:           1400.0000
BogoMIPS:              8427.36
Virtualization:        AMD-V
=2E..

so the siglongjmp call hit the sigsetjmp point and made the func
return 0 which means it didn't detect as vmware at all.
-mike

--cseAwlqrBzmhRTxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYI/QRAAoJEEFjO5/oN/WBTKgP/ju4rJ706+qedOJTr+PKqFV9
VEReXKaOpcrlbMMLYlFIYmP9kOXt8cnDtYkoNQHruErAj2qAnoXecc3Qfg1dvsJz
C1Xd9GqluA8cCUrMeLDdE9L56zGN8cRLNEFWzvOLA2AgD3eqtandsCQIH7H+c+Qh
+DSwbVQzml2dNTnDZKAcqpuQlzwvvH+dy2fTuA6BrZridXOZ4zhyucQHTWk+XmhO
nxa0JhZ0IFvFc58E6DK1NZn36Mcmc+HI/WdO2s1ZBr7EhyvgnhfSZKvRVBW3v2X0
TVkvfa3iHpA6QX8FyTJEoFfmSBFrXJblaaxYhtyldVJQrSpHGlQavxU49Nru20ld
GEaoOcsk6n5O5GgGd5DQO/v16D5xzGFQ6sTJrsbJFskv85wacpxKzf55yc3YNYET
NlxberateC5mF6kE01KzVVbPx/qMjabNMrt4uNBkfwlx9Ad+T8mJhWlzAELM8BOS
Pq2iT+dfzRlCIGNzvz523qJKDWcvKTRHTuEHIarcxkHo676fnvpvkLwmqYsOcSKA
MGbgChMFNYQMs/B2h3Y6e0NZp+c4Ue3G+FJJ2n0pBSuihrkLbhjGG11AM04WzdWA
8A+J5Eqn3BlVU277GL04OSUkd0bTaeM9utwsisB7EZYEQFp4zMq4H+TcDEdqqm/7
y+fl+/b0m0rS6U7ug4Wn
=KpA6
-----END PGP SIGNATURE-----

--cseAwlqrBzmhRTxO--
