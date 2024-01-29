Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1228A152DFC
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561066; cv=none; b=bLajOqJj1sCaTF2lQSt2OlBAX/uoqx+tlOSdvknofkymf/WkmK2mflZtlQS88NZlA9T1Ik2nS2TYAePWRxAV32oVem9OYyDaFkXnSV7yRJB84pgRNVe7I6/YqZlPA8w0HQEY226EBuWfsXhAYn4z8bP1W2BmwPENRDAGttMG27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561066; c=relaxed/simple;
	bh=A1Oq7WxOIQS7LDol4FQXu1FTVb154mesR+IK72Jkzgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ7MYY56+pT6VnlHGs9TeLucZFrKjPKthz6jHd3wynY1NAuskE6g1kK8bBOkSKwrpA3bW46iF0Ddaz/lsl4gkr/AlBtQWcqERqQBmOA0WKyymJlgMfw4ovWkhEn7pyS1zX9px/bWZy3+JfG50+on+X4WPxO1z2MlOB5akaaBTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=hG38+UQK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="hG38+UQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1706561061; bh=A1Oq7WxOIQS7LDol4FQXu1FTVb154mesR+IK72Jkzgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hG38+UQKH2YGsDIT2BgM1Qnn49E/TWZKoVHqmkEL3l2E7Aanr4zWotmKpKOCME2bV
	 cOcddbK0GLzPsWiGjwPn02FFtT4WNDG5pQionzlvc6J1M/042tuO6FHdKCkRO2tx52
	 3LfRynRkpRhSx7GRUoduz+vvPKEePQustbODreFY=
Date: Mon, 29 Jan 2024 21:44:21 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Thorsten Glaser <tg@debian.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Re: fdisk corrupts data on USB stick
Message-ID: <5b8f9459-cc95-4c08-b68c-39abb2ff9f68@t-8ch.de>
References: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org>
 <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de>
 <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org>

On 2024-01-29 20:27:13+0000, Thorsten Glaser wrote:
> Thomas Weißschuh dixit:
> 
> >    The device contains 'iso9660' signature and it will be removed by a
> >    write command. See fdisk(8) man page and --wipe option for more
> >    details.
> 
> >I guess your version does the same, but maybe is not printing the
> >warning.
> 
> Hm, maybe it does, maybe it doesn’t, but even so, why should it?

In the message you may or may not have seen there is a reference to the
`--wipe` option that describes the reasoning and possibilities.

Reproduced here for your convenience:
https://manpages.debian.org/bookworm/fdisk/fdisk.8.en.html

-w, --wipe when
    Wipe filesystem, RAID and partition-table signatures from the
    device, in order to avoid possible collisions. The argument when
    can be auto, never or always. When this option is not given, the
    default is auto, in which case signatures are wiped only when in
    interactive mode. In all cases detected signatures are reported by
    warning messages before a new partition table is created. See also
    wipefs(8) command.


As for why: "in order to avoid possible collisions".

> >So the disk gets converted to a normal MBR layout and the ISO signature
> >get wiped. Which makes sense as the ISO image would need to be
> >remastered.
> 
> Totally not! First of, the ISO already contained an MBR with a
> partition table in the first sector, which I extended, and second,
> it’s fdisk’s task to precisely edit the MBR partition table (and,
> if the 55h AAh magic is missing, create it), nothing else (okay,
> extended partitions if someone uses them, but nothing else).

This is your personal interpretation about what exactly fdisk is
supposed to do.
For convenience it even may have shown a prominent warning in bright red
letters with helpful pointers. Or maybe it didn't.

> >> Is there a way we can make it not corrupt such media?
> >
> >Did you look into grml2usb?
> 
> I know that, but I wanted to keep the original ISO 9660 filesystem
> so things don’t accidentally get changed on it. (And the original
> EFI thingy, in case it’s needed.)

Fair enough.

> So, how do I get fdisk to not corrupt the ISO 9660 part?
> MirBSD fdisk doesn’t do that, it sticks to the MBR.

Try `--wipe never` as explained above.


Thomas
