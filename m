Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE876058
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558501; cv=none; b=V2e78nV1LPgbZh6JQuB/ew8LRduGlVYAakwxdmzo9iWh2MejBIxX0RObHW4gtHDW/ttD2vaQCnlTCS371YrpnO7pjfDKPoIvufV/pu7kd4T8rJB9qMBdj6tSZLFYmBG7+6GUPXSArtcwRtpGvYlRIqM/PIWg5CLiVNUazo9779Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558501; c=relaxed/simple;
	bh=Yzo1W9jUY1MWQ8+Z2wzB8sd0RIL5CoffectNDST0yZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIkSWaGptS70WMxXbLZThGHJPRdDOVpXFdDNJPloINiCm7vnX2tZ/tAy7ohICaE/8KwKxBL8PGXpTiCXxM+/WmLw+iAaBs9yhcQ5BuykVQGpWeDdTgNsV+iiLa0/PYjxUY4qzMJdXM9plc06Zgs279Fsuvt9hVfpTWeCsB1jMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=cxLqNevl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="cxLqNevl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1706558491; bh=Yzo1W9jUY1MWQ8+Z2wzB8sd0RIL5CoffectNDST0yZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxLqNevl32CELIc3t0OfwDkeRwlyC4AuYTJMRO60UcHdVTrCTukhtlFGnhin/FyVB
	 SpcEc7KtsJO9f038AlqshSt3E/9bWMbZe9uNoTqFrwTyr6JJdosVQnotNrMF1exYNu
	 UZU7AE5I9eN1QsFyea9DqBTBS5I6myWJm+a08s3s=
Date: Mon, 29 Jan 2024 21:01:31 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Thorsten Glaser <tg@debian.org>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk corrupts data on USB stick
Message-ID: <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de>
References: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org>

Hi Thorsten,

On 2024-01-29 17:04:12+0000, Thorsten Glaser wrote:
> Background: https://github.com/grml/grml/issues/205
> 
> Using fdisk 2.36.1-8+deb11u1 from util-linux to create an extra
> partition on a USB stick on which I had previously written an
> ISO 9660 image does something to the data on the stick to make
> klibc fstype not recognise it as ISO 9660 any more. Specifically,
> it corrupts some data at some location within the first 4 MiB of
> the stick but outside of the first 512 byte of it, as restoring
> those first 4 MiB then re-restoring the MBR to the state fdisk
> had written makes it work again.
> 
> This is a data corruption bug. I expect fdisk to change precisely
> the MBR and nothing else unless told so.

When trying your reproduction steps with a newer version of fdisk I
instantly get greeted like this:

    # fdisk /dev/loop0 
    
    Welcome to fdisk (util-linux 2.39.3).
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.
    
    The device contains 'iso9660' signature and it will be removed by a write command. See fdisk(8) man page and --wipe option for more details.

    Command (m for help): p

    Disk /dev/loop0: 492.25 MiB, 516161536 bytes, 1008128 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x773b5e3b
    
    Device       Boot Start     End Sectors  Size Id Type
    /dev/loop0p1 *        0 1007615 1007616  492M  0 Empty
    /dev/loop0p2        592    8783    8192    4M ef EFI (FAT-12/16/32)


I guess your version does the same, but maybe is not printing the
warning.

So the disk gets converted to a normal MBR layout and the ISO signature
get wiped. Which makes sense as the ISO image would need to be
remastered.

> Is there a way we can make it not corrupt such media?

Did you look into grml2usb?

This is what [0] recommends to achieve persistence.

[0] https://wiki.grml.org/doku.php?id=persistency

Thomas
