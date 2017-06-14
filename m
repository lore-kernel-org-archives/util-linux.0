Return-Path: jack@suse.cz
Date: Wed, 14 Jun 2017 11:46:14 +0200
From: Jan Kara <jack@suse.cz>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jan Kara <jack@suse.com>, Steve Kenton <skenton@ou.edu>,
	=?utf-8?Q?Vojt=C4=9Bch?= Vladyka <xvlady00@stud.feec.vutbr.cz>,
	Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: UDF & dstring
Message-ID: <20170614094614.GA20247@quack2.suse.cz>
References: <201706111710.03013@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201706111710.03013@pali>
List-ID: <util-linux.vger.kernel.org>

Hi,

On Sun 11-06-17 17:10:02, Pali Rohár wrote:
> 2.1.3 Dstrings
> 
> The ECMA 167 standard, as well as this document, has normally defined 
> byte positions relative to 0. In section 7.2.12 of ECMA 167, dstrings 
> are defined in terms of being relative to 1. Since this offers an 
> opportunity for confusion, the following shows what the definition would 
> be if described relative to 0.
> 
> 7.2.12 Fixed-length character fields
> 
> A dstring of length n is a field of n bytes where d-characters (1/7.2) 
> are recorded. The number of bytes used to record the characters shall be 
> recorded as a Uint8 (1/7.1.1) in byte n-1, where n is the length of the 
> field. The characters shall be recorded starting with the first byte of 
> the field, and any remaining byte positions after the characters up 
> until byte n-2 inclusive shall be set to #00.
> 
> If the number of d-characters to be encoded is zero, the length of the 
> dstring shall be zero.
> 
> NOTE: The length of a dstring includes the compression code byte (2.1.1) 
> except for the case of a zero length string. A zero length string shall 
> be recorded by setting the entire dstring field to all zeros.
> =====
> 
> Next in previous section 2.1.1 Character Sets is Compression Algorithm 
> table where IDs 0-7 are reserved.
> 
> I'm not sure how to correctly interpret those sections.
> 
> Does it mean that every dstring should consist of following buffer?
> 
> L - length of encoded characters
> N - size of dstring buffer
> 
> buffer:
>       1   byte: 0x08 (for Latin1) or 0x10 (for UCS-2BE)
>   2 - L+2 byte: encoded characters (data either in Latin1 or UCS-2BE)
> L+2 - N-2 byte: 0x00
>       N-1 byte: number L+1
> 
> And in special case when L = 0, then first and last byte is also zero?

Yes, apparently that's what the spec says.

> Because currently we have different implementation in kernel udf driver, 
> util-linux blkid library and in mkudffs from udftools.
> None of those implementation accept fully empty buffer as valid dstring.

As far as I'm looking, kernel handles this just fine. Note that 'dstring'
is actually rather rare in UDF. E.g. filenames are recorded as d-characters
which is something different. For converting dstrings (only used for
getting volume and set identifiers) we use udf_dstrCS0toUTF8() which uses
udf_name_from_CS0() and that handles input length of 0 just fine.
 
> mkudffs stores at last byte length of encoded characters + 1 (for 
> compression id) as written above. On the other hand blkid from util-
> linux things that last byte is part of encoded characters and Linux 
> kernel driver does not set last byte to some value.

Linux kernel UDF driver never writes any dstring.

> So... how should be understood that UDF specification? Should last byte 
> be set to length encoded characters + 1 or not? And should be fully 
> empty buffer (also with compression id set to 0x00 which is reserved) 
> treated as valid string (empty one)?
> 
> And... we should unify implementation of blkid, kernel udf driver and 
> mkudffs.

I think you understood the spec correctly. What I think we should do is to
make udf-tools and blkid accept both variants but create the one defined in
the spec (to have higher chances for interoperability).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
