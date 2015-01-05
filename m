Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f176.google.com ([209.85.216.176]:36361 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbbAEW0F (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Jan 2015 17:26:05 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so16039713qcy.7
        for <util-linux@vger.kernel.org>; Mon, 05 Jan 2015 14:26:04 -0800 (PST)
Message-ID: <54AB0F5C.7020206@ubuntu.com>
Date: Mon, 05 Jan 2015 17:25:32 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: JPT <j-p-t@gmx.net>, util-linux@vger.kernel.org
Subject: Re: [BUG] Mount: codepage mapping does not work for msdos fs
References: <m7riin$iuv$1@ger.gmane.org>
In-Reply-To: <m7riin$iuv$1@ger.gmane.org>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/29/2014 7:48 AM, JPT wrote:
> Hi,
> 
> I want to mount a DOS 5.0 partition without messing it up with
> LFNs.
> 
> According to man page this only works if I use the MSDOS fs instead
> of VFAT.
> 
> But using MSDOS fails on converting non ASCII chars.

This doesn't really have anything to do with util-linux; the kernel
msdos driver simply lacks the ability to use the iocharset option.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUqw9cAAoJENRVrw2cjl5RDukH/00LPDgvnNNL1PownJTGJxwv
948PxDwypSRO1pJO1yoh5ldc8jfJ9vNZCpv/cbbJ5y6P/uro4+aLQcCRNLbhPHRZ
OEKnlatYbHJcG09rDwJj8K7sDch87hWGmCKytyCuBixq5aPZc47dYQ2sqgScqCJG
R3ZQmiFZQLyV+I98SJEhh0w3Ur8a5oMlI3d3qj/y0ZUuMsbHr1bFTo5P+0y2kISW
wXnASUOI6C1x71LYpWnitNZzO8lc+9Gnx3DVUE2PrxioJmeUohFI16I49Wr5NGb/
edUzk7S06QfVWZgvIhm/BK3VMjRUt6qYZ4sH0mm79fgQSKydRNNKqW569lA4u6o=
=aH4e
-----END PGP SIGNATURE-----
