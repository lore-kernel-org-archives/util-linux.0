Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:35739 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbaA1V2s (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jan 2014 16:28:48 -0500
Message-ID: <52E8210F.2000007@ubuntu.com>
Date: Tue, 28 Jan 2014 16:28:47 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Christoph Anton Mitterer <calestyo@scientia.net>,
        util-linux@vger.kernel.org
Subject: Re: fdisk: add GPT partition types for plain dm-crypt and LUKS
References: <1390934933.15213.17.camel@heisenberg.scientia.net>	 <52E819BF.4090503@ubuntu.com> <1390943356.7021.7.camel@heisenberg.scientia.net>
In-Reply-To: <1390943356.7021.7.camel@heisenberg.scientia.net>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 01/28/2014 04:09 PM, Christoph Anton Mitterer wrote:
> - for plain dm-crypt it's a "good" way to make it recognisable

Or use LUKS instead.

> - partitioning tools can use it to hint what a partition contains

The problem with hints is that they often tend to be wrong, which is
why Linux ignores them and goes straight to looking at what is in the
partition.

> - and after all, partition types do exist, whether they make sense
> and are used or not... and I think it's better to have some
> standardised value which people may set (if they want) even if it's
> nowhere used,.. instead of having them set something which may
> actually cause issues even if only in the future.

If it isn't used then why have it?  All it does is add confusion.

>> Linux doesn't use partition IDs.
> Phew... that's not fully true... not even for the kernel which I
> think still contains the code to do MD auto assembly with 0.9
> superblocks when some MBR partition type is set...

That's the exception and is depreciated/legacy behavior from the days
before initrd/initramfs.

> And there are probably many tools (fdisk ;-) ) out there which some
> how use or at least display the types.

Displaying useless esoteric information is useless and esoteric ;)

>> Also isn't plain dm-crypt depreciated?
> Why should it be?

For all of the reasons that LUKS was created.  In particular, the lack
of the ability to identify the thing.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJS6CEPAAoJEI5FoCIzSKrw0A0IAIFc9xGVzg39lBkFGJlQAsan
diBUVDYwaxhZRcHMIkpw3QNHlPnz9XbzJGlE6BZgL3m/v3FVQ5EL/XyEnqftafBO
W2rAk+qiXvmopO9B3I+UkQhDN7z2sOXR1x59FQC2uY/Fn+mJs6dTwKS3NbQZD1Z3
wHVN0k0xWWDjFRDXZ7LIqc3Uw+XplUv4cvuM9BLWpkB8Qc2y2hxoPNiemDtuN7N3
cdGzaN/8c6I+sAclbqQpak0ElCdO/1MP3cC39S0tnTcnGPOP1F66I7RBiJFWYKIW
Q1NrjVUy090TgEEEB8AhHLWPY5BFN5m3qci0Kpq/0Yla8x80thoHnibbI98jZw0=
=GFnU
-----END PGP SIGNATURE-----
