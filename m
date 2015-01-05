Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f67.google.com ([209.85.192.67]:64754 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbbAEWSY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Jan 2015 17:18:24 -0500
Received: by mail-qg0-f67.google.com with SMTP id z107so4712943qgd.6
        for <util-linux@vger.kernel.org>; Mon, 05 Jan 2015 14:18:23 -0800 (PST)
Message-ID: <54AB0D8F.2010100@ubuntu.com>
Date: Mon, 05 Jan 2015 17:17:51 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Linda Walsh <lkml@tlinx.org>, util-linux@vger.kernel.org
CC: Matthew Eaton <m.eaton82@gmail.com>, Karel Zak <kzak@redhat.com>
Subject: Re: fdisk units size & disk manufacturers buying the standard
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>	<20141204130044.GH1994@x2.net.home> <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com> <548619AF.5070900@tlinx.org>
In-Reply-To: <548619AF.5070900@tlinx.org>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/8/2014 4:35 PM, Linda Walsh wrote:
> They may a fundamental error that any engineer or mathematician 
> could point out:
> 
> 'B' == a prefix meaning 2^3bits.  I.e 'B' is a base-2 measurement. 
> In science and engineering, you just don't mix units like that 
> unless want to prove you don't know what you are talking about.

While I do despise the HD industry for lieing about drive sizes, I
have to point out your error here.  How the unit the prefix is applied
to relates to some other unit has no bearing whatsoever on the prefix
itself.  Your argument is like saying that a kilowatt-hour should be
only 60 watt-hours instead of 1,000 because a watt-hour is 3600
joules, which is base 60 instead of base 10.

> Also, disk manufacturers are lying.  Disk space is allocated in
> 2^9 (512 Bytes or 2^12 bits) or 2^12 Bytes (2^15 bits).   They 
> ***CANNOT*** accurate quote disk space using base 10.  I.e. 1MB = 
> 2048 sectors.  But 1MBd = 1954.125 sectors -- and you cannot use 
> 1/8th of a sector.  So ANY figure they give will be a lie as 10 
> doesn't divide into a power of 2 which is how computer space is 
> allocated and used.

Rounding is not the same thing as lieing.  If they were claiming that
a disk that has 1,000,000,000 sectors was 477 GB, you couldn't really
fault them for the missing ~166 MB.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUqw2PAAoJENRVrw2cjl5RuaMH/A6eJT6Ww3NJR80A3s2jnieO
2W1ny8pR2J8cBRF5TfDc/LXJ3N/u9rwaVkag4DGA5LACkI6NMO9eESrbQgbCl+vs
oplEm/Ph4rvinXn78k9m0sEFS8NHtB8C023xKeqCc5exQth/lo2AA2Wkl4WylyJT
ZUtM4RlmyjEv3TuWqfyeXxHTW8HSF6Bsy5CiN2hr8Ly1VIe1uSSz+xwWz2+vjtZy
NrTod2wwwpkdXvjatzNDGkA/EDF4md/IPSuH9QNZ1TAESa/0dKa21s172Tl/y/jd
ghrqoXIQPXGXzjurWF64UG6ANX19GeG28sG4fDojbtHNAq1deIgQdwHJ5KtCYbE=
=NF/s
-----END PGP SIGNATURE-----
