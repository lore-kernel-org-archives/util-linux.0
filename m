Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37045 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752817AbdEOMix (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 15 May 2017 08:38:53 -0400
Received: by mail-wm0-f52.google.com with SMTP id d127so74830164wmf.0
        for <util-linux@vger.kernel.org>; Mon, 15 May 2017 05:38:52 -0700 (PDT)
Date: Mon, 15 May 2017 14:38:45 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Steve Kenton <skenton@ou.edu>,
        =?utf-8?Q?Vojt=C4=9Bch?= Vladyka <xvlady00@stud.feec.vutbr.cz>,
        Jan Kara <jack@suse.cz>
Subject: Re: libblkid: udf: Incorrect implementation of Unicode strings
Message-ID: <20170515123845.GA10015@pali>
References: <201705121638.59416@pali>
 <20170515100940.lggq2um6xt3dg66p@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170515100940.lggq2um6xt3dg66p@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 15 May 2017 12:09:40 Karel Zak wrote:
> On Fri, May 12, 2017 at 04:38:59PM +0200, Pali Rohár wrote:
> > Hi!
> > 
> > Since beginning libblkid's udf code handles 16bit OSTA compressed 
> > unicode as UTF-16BE and 8bit OSTA compressed unicode as UTF-8.
> > 
> > In UDF 2.01 specification is written:
> > ====
> > For a CompressionID of 8 or 16, the value of the CompressionID shall 
> > specify the number of BitsPerCharacter for the d-characters defined in 
> > the CharacterBitStream field. Each sequence of CompressionID bits in the 
> > CharacterBitStream field shall represent an OSTA Compressed Unicode d-
> > character. The bits of the character being encoded shall be added to the 
> > CharacterBitStream from most- to least-significant-bit. The bits shall 
> > be added to the CharacterBitStream starting from the most significant 
> > bit of the current byte being encoded into. The value of the OSTA 
> > Compressed Unicode d-character interpreted as a Uint16 defines the value 
> > of the corresponding d-character in the Unicode 2.0 standard.
> > ====
> > 
> > So it means that 8bit OSTA compressed unicode buffer contains sequence 
> > of Unicode codepoints, one per 8 bits. What effectively means 
> > equivalence with Latin1 (ISO-8859-1) encoding.
> > 
> > And 16bit OSTA compressed unicode means sequence of Unicode codepoints, 
> > one per 16 bits in big endian. What is probably only UCS-2 and not full 
> > UTF-16.
> > 
> > So problem is with 8bit OSTA compressed unicode if contains bytes which 
> > are not UTF-8 invariants (ASCII). As those those are decoded differently 
> > with Latin1 and UTF-8.
> > 
> > Which means libblkid udf implementation of reading Unicode strings is 
> > wrong and affects all read operations (Label, UUID, ...).
> > 
> > To verify this problem I prepared small udf image (attached) which has 
> > logical volume identifier (known as label): 0x08 0xC3 0xBF 0x00 ... 0x03
> > 
> > According to spec it should be decoded as string "Ã¿"
> > (LATIN CAPITAL LETTER A WITH TILDE, INVERTED QUESTION MARK).
> > 
> > But blkid show me "ÿ" (LATIN SMALL LETTER Y WITH DIAERESIS).
> > 
> > I checked grub2 and Windows implementations and they show "Ã¿".
> > 
> > So... what to do with blkid implementation? Fixing it would mean to 
> > break all existing labels and uuids on Linux. Not fixing it would mean 
> > to have different labels across different systems which implements it 
> > properly.
> 
> The issue has never been reported, so I guess the number of the affected
> LABELs is pretty small :-)

Yes, that is possible. As most labels are just ASCII and if somebody
needs something special, then it is probably non-Latin and so above
U+FF codepoint...

> From my point of view it would be better to follow the standard, fix
> the issue and be compatible with the another utils and systems. It
> would be nice to fix it now for v2.30 where we already have changes in
> udf/iso stuff. Please, send the patch :-)

Ok, I can do that.

But question remain what to do with UUID. First 16 characters of Volume
Set Identifier are unique, non trivial and should represent hexadecimal
representation of timestamp. Currently blkid use it for generating UUID.

But "character" here means Unicode codepoint, not byte. So what to do if
Volume Set Identifier (which we use for UUID) contains non hexadecimal
and also non-alphabetical or non-ASCII characters?

Currently blkid read non-alphabetical chars somehow as bytes and encode
them as two hexadecimal digit. But due to broken implementation of
reading OSTA compressed unicode this would be changed (after fixing
reading OSTA Unicode).

So what can be stored in UUID? If any UTF-8 sequence, then we can just
take 16chars of VolSetId, convert OSTA Unicode to UTF-8 and store into
UUID. But it mean that UUID could contain also non printable characters
and also some exotic or non-Latin characters... Other option if
arbitrary Unicode characters is not allowed in UUID then we need to
decide how to convert/escape them into printable-ASCII, alphanumeric or
hexdigit.

The simplest way for UUID is of course to take first 16 chars of
VolSetId and encode them in UTF-8... but it allowed? And it is usable
for users (to specify disk by arbitrary Unicode/UTF-8 sequence)?

Let me know your opinion.

I suggest to include all UDF changes in one release, so "breakage" would
be just between two versions. So if above Label/UUID changes would not
be ready for next release, I would suggest to postpone currently merged
UDF changes.

-- 
Pali Rohár
pali.rohar@gmail.com
