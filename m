Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:55148 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbaBGQwu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Feb 2014 11:52:50 -0500
Message-ID: <52F50F60.3010103@ubuntu.com>
Date: Fri, 07 Feb 2014 11:52:48 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: please document alternate "bind" syntax in mount(8)
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Forwarded from debian bug #409942:

At the moment, neither mount(8) nor fstab(5) tells us how to do bind
mounts with fstab, or even that it's possible.  We have to *guess* that
doing this in fstab works:
/some/old/dir   /some/new/mountpoint   ???   bind   ???   ???
and it's not clear what is or isn't permitted for ???.

Please consider amending mount(8) so the options listed under -o include
something like this:
        bind     same as --bind (other mount options are silently ignored)
        [...]
	rbind    same as --rbind (other mount options are silently ignored)

Isn't it also time to update the SYNOPSIS in mount(8), now that linux
versions >=2.4.0 will be standard ?  I suggest adding two lines
like this:
         mount { --bind | -o bind } olddir newdir
         mount { --rbind | -o rbind } olddir newdir
or, possibly, just one line
         mount { --bind | --rbind | -o bind | -o rbind } olddir newdir

Thanks for your work.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS9Q9fAAoJEI5FoCIzSKrwvJcIAJAzpyfRhoqBUred3klaeoVC
MKxWyFlKmfj0qf18KrWcqxdDG2wssXPLkDexCOfD32ZPDUbnJol8BCc237b7TNVe
gU3NJQXZ3WrmwzeGO6+0HVHdSiu0QR2vgMHYda7q+xHhyIyEhZFwl2vHoRf4HXNm
3hd5CeINnz9eu8Zh/h7BFbj+bZFMu7HVlb/IoTT7aByMqCLv+yJvB0+vOOSHFkmU
AEBvEJix8DxwNDyXcq4LniifvrvxeG70B6AY8ZGLumano3I2BpYYu9a/LdUNv+lN
JtiRffmEXk+joeTy8rosKWj7XI12Jabb5+PXUAHg4nxZKzP3I0HUF6UcAiDsoJY=
=WglM
-----END PGP SIGNATURE-----
