Return-Path: g.esp@free.fr
Date: Tue, 18 Sep 2012 23:31:43 +0200 (CEST)
From: g.esp@free.fr
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <992520660.214095430.1348003903474.JavaMail.root@zimbra33-e6.priv.proxad.net>
In-Reply-To: <20120918092926.GA20576@x2.net.home>
Subject: Re: util-linux-2.22 regression on umount with loop and /etc/mtab
 real file
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>



----- Mail original -----
> De: "Karel Zak" <kzak@redhat.com>
> =C3=80: "g esp" <g.esp@free.fr>
> Cc: util-linux@vger.kernel.org
> Envoy=C3=A9: Mardi 18 Septembre 2012 11:29:26
> Objet: Re: util-linux-2.22 regression on umount with loop and /etc/mtab r=
eal file
>=20
> On Tue, Sep 18, 2012 at 07:50:29AM +0200, g.esp@free.fr wrote:
> > The loop is cleaned on umount with 2.21.2
> > With 2.22, unmounting /tmp/foo_fs no more remove the loop
> >=20
> > [chroot-i486] root:/$ mount --version
> > mount from util-linux 2.22 (libmount 2.22.0: debug)
> > [chroot-i486] root:/$ losetup -a
> > [chroot-i486] root:/$ mount -oloop /tmp/foo_fs /tmp/bar_dir
> > [chroot-i486] root:/$ umount /tmp/foo_fs
> > [chroot-i486] root:/$ losetup -a
> > /dev/loop0: [2051]:387175 (/tmp/foo_fs)
> >=20
> > The loop remain.
>=20
> Kernel version? I guess something old... :-)
>=20
> Since kernel 2.6.37 we use autoclear flag:
>=20
>   $ cat /sys/block/loop0/loop/autoclear
>   1
>=20
The kernel running on the machine is debian v6 (squeeze) 2.6.32, so this is=
 not something brand new.

> if the flags is enabled (should be always by mount(8)) then the loop
> device is automatically detached by kernel after successful
> umount(2).
> It means that we don't have to store any extra information in
> userspace or do any magic around loopdevs in umount(8) command.
>=20
>=20
> I found a bug in libmount umount code, it does not check for the
> option "loop" in mtab -- this bug is invisible on systems where
> autoclear flags is usable. Fixed. Try the code from upstream tree:
>=20

Thank, git tree fixed the issue.

Gilles
