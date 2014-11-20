Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f177.google.com ([209.85.216.177]:34820 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbaKTQnR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 20 Nov 2014 11:43:17 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so2382868qcv.36
        for <util-linux@vger.kernel.org>; Thu, 20 Nov 2014 08:43:16 -0800 (PST)
Message-ID: <546E1A16.6050102@ubuntu.com>
Date: Thu, 20 Nov 2014 11:43:02 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>, 770211@bugs.debian.org,
        Drake Wilson <drake@dasyatidae.net>
CC: util-linux@vger.kernel.org
Subject: Re: Bug#770211: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com>
In-Reply-To: <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/19/2014 5:24 PM, Dale R. Worley wrote:
> This raises the related question of whether there should be codes
> to identify the partition type inside the LUKS partition.  That is,
> the partition table code identifies the partition as a LUKS
> partition, but once one has supplied the keys for LUKS encryption,
> is there any way to tell the type of the encrypted partition
> without testing for magic numbers (using "file" or the like)?

Linux doesn't pay any attention to partition type codes anyhow and
just uses blkid to identify the contents.

> I suppose there aren't enough type codes in MBR to allow
> separately identifying "ext4 inside LUKS", but with GPT it would be
> possible, and even could be done systematically.  E.g., if the UUID
> for a partition type is XXX, then the partition type for that type
> inside of LUKS is MD5("LUKS" XXX)...
> 
> Then again, perhaps you would not want to reveal the type of the 
> encrypted partition.

That too.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUbhoWAAoJEI5FoCIzSKrwfZAH/AnTDFG8Nes4Sa+cKebZs9D/
Atf7SrWYQFy++p0o0sNKcSIrdjHghIGEzq8oTZ5pBgnEfu94/uTATUSGSFum7bqL
3ZYPgKNGi7SOj/Oc03p+Tzadjk01gpHUQMcj8jcHJUbrJheLCssPyB558vA5Vqrz
D8bLbOz9JmoDQ+zpWrachKv3+7XAfh0ri54tKsEmNFKN3LOhrxyoVfIGIJf+MFQK
kssPT/ZKD3W/PEBTaI/pcwaCo1+vdR2JYiy4ODBQy7LMfvvw97N3aZEKgRGgLudF
NWApQR7AZLxjD2YllE0NI2NBeq4/8DgLicwnnJSqdHvKFKlbwC0Iq5wIugNjSds=
=s8LS
-----END PGP SIGNATURE-----
