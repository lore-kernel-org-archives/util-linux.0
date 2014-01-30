Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:46550 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbaA3PU2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 30 Jan 2014 10:20:28 -0500
Message-ID: <52EA6DBA.6000903@ubuntu.com>
Date: Thu, 30 Jan 2014 10:20:26 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>,
        Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: pivot_root depreciated?
References: <52E91888.4080601@ubuntu.com> <20140130081651.GE22884@x2.net.home> <52EA5E6F.6040203@ubuntu.com> <52EA66CC.9070107@archlinux.org>
In-Reply-To: <52EA66CC.9070107@archlinux.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/30/2014 9:50 AM, Thomas Bächler wrote:
> At least mkinitcpio now generates a fresh "initrd" to return to
> during system shutdown instead of keeping around the actual
> initrd.

I see, so at shutdown the initramfs is re-loaded into a tmpfs that is
then pivot_root()ed to?  And at boot time, pivot_root is not used?

> Initrd is a bad idea. It's a ramdisk of fixed size with an actual
> file system on it. Instead, we now use initramfs, which is simply
> an archive which is extracted directly into rootfs. And as I said
> above, you can't pivot rootfs.

Ok, that sounds like it is what I was trying to remember.  They said
hell no, rootfs is rootfs, and there will be no pivoting it.  I guess
I assumed that meant pivot_root() was dead, not thinking you could
still use it after chrooting to a non rootfs.

> 4) chdir("/realroot"); mount --move /realroot ., chroot(".");

Wait, how do you move a mount into itself?  I thought this was just
the chdir and chroot.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS6m26AAoJEI5FoCIzSKrwUIcH/0Gq64aC4Sr0bb9vqhNYTgeY
TiSxsR4lx3r0g3Oja91j0az8TXeCdpb2LakY+TOxMYEtA6JyJ5rF9kFeo5imbVT4
XYj/40gmirs4m021gGNgAXIqyt7+RDMZh2KGSFN6zuUTX39HlvIqjBrPzDp2Howa
ASCfcOn6LujS5F1iaBK7aSkBdSQhq3WhsQAJN4OJ3DAjOoO74F07AoziPc0vG0Cn
66bkvEvMHTYpKULoJOB7YPTtkDqp3IjyrBx5kKPB1DKYGDKXQX2y4I0ZNb/VRkWn
RUvnFneULyWIWZRWb0z2Rf+NfdpkYU+Bfkg6TpnGquE4hKHZpTw5DrUB6Uv3UX4=
=Sgny
-----END PGP SIGNATURE-----
