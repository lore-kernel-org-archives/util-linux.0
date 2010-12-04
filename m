Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f45.google.com ([209.85.215.45]:64343 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab0LDLWH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 4 Dec 2010 06:22:07 -0500
Received: by ewy10 with SMTP id 10so6192181ewy.4
        for <util-linux@vger.kernel.org>; Sat, 04 Dec 2010 03:22:04 -0800 (PST)
Message-ID: <4CFA245A.3020900@gmail.com>
Date: Sat, 04 Dec 2010 14:22:02 +0300
From: Andrew Nayenko <resver@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: NTFS volume label not found due to endian conversion bug in libblkid
References: <CDF89843-21BA-4549-842C-5C82861514D9@hugheaves.com> <20101203143031.GJ3077@nb.net.home>
In-Reply-To: <20101203143031.GJ3077@nb.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>> I've been having a problem with blkid not finding the volume label
>> on NTFS volumes on my big-endian (PowerPC) system. I tracked the
>> issue down to a bug in the endian conversion code for parsing the
>> MFT $Volume attributes in ntfs.c.
> 
>  Fixed. Thanks!

Another similar typo:

diff --git a/shlibs/blkid/src/superblocks/nilfs.c b/shlibs/blkid/src/superblocks/nilfs.c
index bf16918..1f8f3a6 100644
--- a/shlibs/blkid/src/superblocks/nilfs.c
+++ b/shlibs/blkid/src/superblocks/nilfs.c
@@ -84,7 +84,7 @@ static int probe_nilfs2(blkid_probe pr, const struct blkid_idmag *mag)
    if (!sb)
        return -1;

-   bytes = le32_to_cpu(sb->s_bytes);
+   bytes = le16_to_cpu(sb->s_bytes);
    crc = crc32(le32_to_cpu(sb->s_crc_seed), (unsigned char *)sb, sumoff);
    crc = crc32(crc, sum, 4);
    crc = crc32(crc, (unsigned char *)sb + sumoff + 4, bytes - sumoff - 4);
--

I believe there is a better approach to endianness handling. And compiler is our best
helper here. We just need to make it generate an error when we try to use a field with
wrong (or without any) endianness conversion. To achieve this, fields in structures
should be explicitly declared as little or big endian, e.g.:
	struct sb {
		.....
		xle16_t s_bytes;
		.....
	};
The xle16_t type should be a complex one, not an integral:
	typedef struct { uint16_t __leu16; } xle16_t;
Only appropriate conversion functions should know how to convert those types to
integral ones:
	uint16_t xle16_to_cpu(xle16_t v) { return le16_to_cpu(v.__leu16); }
	xle16_t xcpu_to_le16(uint16_t v) { xle16_t t = {cpu_to_le16(v)}; return t; }
That's it. Now compiler will enforce us to use the right conversion anytime we
access a field, i.e. the following statements will fail to compile:
	uint16_t bytes = sb->s_bytes; /* no conversion */
	uint32_t bytes = xle32_to_cpu(sb->s_bytes); /* wrong conversion */
I use this approach in a real life project (FS driver) and it proved to be a good
"bugkeeper".

I had a look at shlibs/blkid/src/superblocks/*.c and I think that most probers can
adopt this approach. But in some cases it can be problematic:
1) sometimes fields endianness can vary (e.g. befs, linux_raid) and we do not know
   it at compile time;
2) some probers (zfs) prefer to convert fields to native endianness first and then
   just use instead of in-place conversion at any access to the field.

-- 
 Andrew Nayenko <resver@gmail.com>
