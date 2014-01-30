Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:47678 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaA3Ou5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 30 Jan 2014 09:50:57 -0500
Message-ID: <52EA66CC.9070107@archlinux.org>
Date: Thu, 30 Jan 2014 15:50:52 +0100
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>, Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: pivot_root depreciated?
References: <52E91888.4080601@ubuntu.com> <20140130081651.GE22884@x2.net.home> <52EA5E6F.6040203@ubuntu.com>
In-Reply-To: <52EA5E6F.6040203@ubuntu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AeLvfDkbB6RcDdBs5GnieHSi5lb0CW5XR"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AeLvfDkbB6RcDdBs5GnieHSi5lb0CW5XR
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 30.01.2014 15:15, schrieb Phillip Susi:
> On 1/30/2014 3:16 AM, Karel Zak wrote:
>> everyone switched to our switch_root :-)
>=20
> Except apparently for the systemd folks, which for some odd reason
> like the idea of keeping around the initrd for the life of the system
> so init can "return" to it ( yuck! ).

That is false. In order to keep the initramfs around, you have to copy
it to a tmpfs, since you can't pivot rootfs. In order to free the memory
occupied by the original initramfs, you still need to run switch_root or
an equivalent.

In particular, if systemd is used in the initramfs, it will do an
equivalent to util-linux's switch_root, but it will use an internal
reimplementation to be able to pass some internal state from the
initrd's systemd to the system's systemd (which would be lost if systemd
would exec an external binary other than systemd).

At least mkinitcpio now generates a fresh "initrd" to return to during
system shutdown instead of keeping around the actual initrd.

>> Anyway, I don't see any info about pivot_root syscall deprecation
>> in Linux kernel source tree.
>=20
> Me neither, but then why switch_root?  I thought the whole reason it
> came about was because Linus et al considered pivot_root() to have
> been a terrible idea.

No idea what Linus said or didn't say about it, but here are the facts:

Initrd is a bad idea. It's a ramdisk of fixed size with an actual file
system on it. Instead, we now use initramfs, which is simply an archive
which is extracted directly into rootfs. And as I said above, you can't
pivot rootfs.

So, the old method was:
1) Mount "initrd" on /.
2) Do stuff, mount root on /realroot.
3) Pivot /realroot to / and / to /initrd
4) Exec /sbin/init
5) Unmount /initrd.

The new method is:
1) Extract "initramfs" into rootfs.
2) Do stuff, mount root on /realroot.
3) Delete all contents of / using unlink/rmdir
4) chdir("/realroot"); mount --move /realroot ., chroot(".");
5) Exec /sbin/init.

Step 3)-5) is what switch_root does. Somewhere in those steps, you also
move all API file system mount into /realroot, and maybe some details
which I forgot.

This doesn't mean that pivot_root should be deprecated, it just means
that you cannot use it for switchting from initramfs to the system.

Detailed explanations:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docu=
mentation/filesystems/ramfs-rootfs-initramfs.txt

http://git.busybox.net/busybox/tree/util-linux/switch_root.c#n132


--AeLvfDkbB6RcDdBs5GnieHSi5lb0CW5XR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJS6mbOAAoJEChPw0yOSxolOx0QAIsygP5GBAhCnzCgQMkH5j5+
XhnZOVIDgg3oWiMO7rtGrrKIqJ+O8Bxdm+uhp/u8aoUueu/oLbMPw9iBP6+8CrcE
EnYkI2p/cVLLKv8g/0kEwUhRWDYYaCl+toR7bqG6wtgQv+tNoObHv+MSTo2R8xRs
cBzEREpjh5TIW5/u7BwL2KEpgs3LgWldO+aIXYRa1IN+QpnqSpvceluM8cy6TsG/
FgAgucqRUZ5kxF3krYrcbB0scwfiaTPOGasstarHQ5KhABnA0M8NkEw2mOn8nVjA
OOLwiJ95gm8xamotN+5PqK32fNc9GlEDs+PxJ97HkRsNCTKexUK+d4PAq58kFgjZ
AR1mq9SJoz4I1rF7t6pNnS1f03wI8YKf+q/acbI/eZXizXekhtUmXYW/LKFtFsfQ
8AoHiV8lu5yVojoFYEMIIobSrb3ry048SNZMcwkzTtZ9N5rCyS3Dug499xzGCyuS
B2b4Pe3tZhdRlPjsQuQBy0VQqTQdVRxCeWdjVB+ZO53dwmQ6Ago0NlW8j/5Gb5W0
iTJ779nnhdCiFOPMEng9duyYHImR0uwh9Flf+yLGgahVpWs4NFwOalWnK+SPOr/Q
fJGA6UWDMM+n+XBsTLaUKutbMZWDJedkz6dZi+HOTx57TkOZNCK2dIo76e2Mv7HI
57o+M2R+bxIN+w3Ffob7
=dDwt
-----END PGP SIGNATURE-----

--AeLvfDkbB6RcDdBs5GnieHSi5lb0CW5XR--
