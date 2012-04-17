Return-Path: util-linux-owner@vger.kernel.org
Received: from basal.nesselzelle.de ([88.198.40.36]:49079 "EHLO
	basal.nesselzelle.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab2DQILr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Apr 2012 04:11:47 -0400
Received: from localhost ([127.0.0.1]:46803)
	by localhost with [XMail 1.27 ESMTP Server]
	id <S33FEC> for <util-linux@vger.kernel.org> from <thomas-forum@orgis.org>;
	Tue, 17 Apr 2012 10:03:44 +0200
Date: Tue, 17 Apr 2012 10:03:46 +0200
From: Thomas Orgis <thomas-forum@orgis.org>
To: util-linux@vger.kernel.org
Subject: losetup -d --force for zombie loop devices?
Message-ID: <20120417100346.2a0b8301@orgis.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/zbkNb.+29ueqM6PpLgjVCGj"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--Sig_/zbkNb.+29ueqM6PpLgjVCGj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

I am having an issue with a loop device that used to be connected to a file=
 on NFS.
Not sure if this is actually a kernel bug, but I assume (perhaps ignorantly=
 so)
that losetup could resolve the situation anyways.

0. have NFS share on /mnt/nfs  (rw,users,noexec,nosuid,nodev,hard,intr)
1. losetup --show -f /mnt/nfs/file.img
   /dev/loop0
# actually, it was using cryptsetup luksOpen/Close
2. mount /dev/loop0 && do_work && umount /dev/loop0
3. loose connection to NFS server (it went offline, client machine (laptop)=
 switched networks ...)
4. umount -l /mnt/nfs
5. be reminded about stale loop device because of
  losetup --show -f /some/other.img
hanging (at accessing /dev/loop0, I presume), in need of kill -9
6. reconnect to NFS server, mount /mnt/nfs, hoping that that resolves the h=
ang
7. does resolve hang, but now any operation on /dev/loop0 failing with "dev=
ice or resource busy"

Well, at this point I just want to get rid of the stale loop device and I b=
ump against this:

# strace losetup -d /dev/loop0
execve("/sbin/losetup", ["losetup", "-d", "/dev/loop0"], [/* 44 vars */]) =
=3D 0
brk(0)                                  =3D 0x1494000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x2ac8a5568000
access("/etc/ld.so.preload", R_OK)      =3D 0
open("/etc/ld.so.preload", O_RDONLY)    =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D23, ...}) =3D 0
mmap(NULL, 23, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) =3D 0x2ac8a5569000
close(3)                                =3D 0
munmap(0x2ac8a5569000, 23)              =3D 0
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D194473, ...}) =3D 0
mmap(NULL, 194473, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x2ac8a5569000
close(3)                                =3D 0
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0p\354\1\0\0\0\0\0@".=
.., 832) =3D 832
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D8820786, ...}) =3D 0
mmap(NULL, 3524616, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0x2ac8a576a000
mprotect(0x2ac8a58bd000, 2097152, PROT_NONE) =3D 0
mmap(0x2ac8a5abd000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_DENYWRITE, 3, 0x153000) =3D 0x2ac8a5abd000
mmap(0x2ac8a5ac2000, 18440, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x2ac8a5ac2000
close(3)                                =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x2ac8a5ac7000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x2ac8a5ac8000
arch_prctl(ARCH_SET_FS, 0x2ac8a5ac7b20) =3D 0
mprotect(0x2ac8a5abd000, 16384, PROT_READ) =3D 0
mprotect(0x2ac8a5767000, 4096, PROT_READ) =3D 0
munmap(0x2ac8a5569000, 194473)          =3D 0
brk(0)                                  =3D 0x1494000
brk(0x14b5000)                          =3D 0x14b5000
close(0)                                =3D 0
close(0)                                =3D -1 EBADF (Bad file descriptor)
uname({sys=3D"Linux", node=3D"dunkelstern", ...}) =3D 0
stat("/dev/loop-control", {st_mode=3DS_IFCHR|0600, st_rdev=3Dmakedev(10, 23=
7), ...}) =3D 0
open("/dev/loop0", O_RDONLY)            =3D 0
ioctl(0, 0x4c01, 0)                     =3D -1 EBUSY (Device or resource bu=
sy)
write(2, "losetup: "..., 9losetup: )             =3D 9
write(2, "/dev/loop0: detach failed"..., 25/dev/loop0: detach failed) =3D 25
write(2, ": "..., 2: )                    =3D 2
write(2, "Device or resource busy\n"..., 24Device or resource busy
) =3D 24
close(0)                                =3D 0
exit_group(1)                           =3D ?

So I see that it might be tricky for losetup to decide on itself that the f=
ile
is not busy but actually a zombie. but is there a way to enforce deletion
of the loop device, ignoring the failing ioctl?

# I know what I'm doing, just get rid of the loop device.
losetup --force -d /dev/loop0

I did notice that this must be something peculiar with NFS ...=20
well, for completeness, I am on vanilla linux 3.2.1 (plus ASPM patch for
that power management regression) on x86-64 and until-linux 2.21.1.
Distro is rather custom (it's an install of Source Mage).

In the case this is an obscure kernel/NFS bug/feature, I still would like to
know if such enforced delete could work from losetup ... sometimes we
have to live with bugs in other software.


Alrighty then,

Thomas

--Sig_/zbkNb.+29ueqM6PpLgjVCGj
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk+NI+IACgkQm0xSvNRG1SSfTQCfX8wM1jgSdm45uRhuFEvjDFQT
tToAoI7QnePyWAzN6ZikMe9ynt9KfrLA
=otfN
-----END PGP SIGNATURE-----

--Sig_/zbkNb.+29ueqM6PpLgjVCGj--
