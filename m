Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719CE78F4A
	for <util-linux@vger.kernel.org>; Thu, 19 Dec 2024 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734583699; cv=none; b=DXWDawbGJywGR1H9fiZCfQdGqvdCjRcCOFys813krp/Ls61weVORs+yvtrtQXqkVLY2TkB2/3JvZntIKehdCdwAKFyhX2EiigKgkf5sPYaPGx+0KTQkF1lHTjxnnXzpFL56bccDgHM5mEY/Fq92BsVlqVLiT7l0VAQ1aFhs10RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734583699; c=relaxed/simple;
	bh=MXsi2lAZ1VWXqxexLdyVZY+lvDGiStwX/5Hr3gN/GSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC/pKNV/T+IHWE3/e2qfhj83L4uR/U7SmgUzly8gJKC7bNROnY8PmmLN59ryMu4gzU4sYYH3kxSR+t+0XRI5qN2XYwPvAeA7OLerqPFEq9A1WH74rwe3MPJIAxBVzw5+ILu7sSOIvzXdAyhpTg8QEPlA/mUmm+vzcylNyoaWxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KPImvj8c; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KPImvj8c"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-385e0e224cbso183455f8f.2
        for <util-linux@vger.kernel.org>; Wed, 18 Dec 2024 20:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734583696; x=1735188496; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkBHUlgEoBmBT3Aes5PnqsSG6lH6IGlVyUCdvGYRet8=;
        b=KPImvj8coKEr14Is5di0cwDG5qiMcXRqgadqJiSWy+KipcvgeS6f8Sh5CkmRolwfdg
         zsfp08wZgUMeDTe9cP5Bn6NN5LqI8tZTij2Z02hiogGPDcKzylHTMMgswYVYHdla7kNZ
         BGVbNEfxFxKis9SRXjEWZ8gdW1WoBQ2ImQ31AMhxgOAKkKMnc0KlZy0sPzcUbBPDVvL6
         xf2d6P7TCDW8yNn/hmrKpLHwsaMShRscNZclHwBh0obqlobN61syOqNJQdjTvU5nCX9q
         PGlWyP2BvFQoiMuxykVxD+ej/Gnd45h0J6rbya5RFuE9vPfQgEmYLBdwXau4eHBDPbUa
         oPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734583696; x=1735188496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkBHUlgEoBmBT3Aes5PnqsSG6lH6IGlVyUCdvGYRet8=;
        b=UL3+imoraLNpAWzVEl7XGjt+81wf8TJH11aNf8+yg7NvL+L9hAjODvPEGpVcqiJC5g
         fXKs2D9kLDUQ5jaDJTDskEYUX1WFxGlW67gS+LyNKfyYf94JebMHrasPbK2CYerwqqR5
         XLJSaLW1c9Bb4CsxFETHuKy84R5F0B44CNQu1iUOKC7LRd0DZCCUNn0jZ6V0AsuCPLZq
         CYIRwbJjnbeN0kPg0DswLIAgExp+7SJrvfKLXNmYgEnG25iEoo2Mofw85TRU7iyFEkzj
         H0SnrtQZCMwwA1G81TfmoNcK95205rbsj1OwTdx/y4ynRjKjHhnUKDBnqpPgSb0oWytY
         nr1w==
X-Forwarded-Encrypted: i=1; AJvYcCWjqBspuSYIdyjA/Zxoge/6OxwHpBCyh8DZn30vzH5lD/lwAjQVXXISRHbNo9VcErr5KOrtv4+MxWO0@vger.kernel.org
X-Gm-Message-State: AOJu0YyhVrwpfafaodsU7XCgkG2I1uQh22SKLymVBaWSPSsh0NT2LZNb
	JPvsh3u9I5+PGf+qJ+cCNuiXxj6rF+Mg9hjoxEaYExNVu5pvNjcrnr1QDf3NgG0=
X-Gm-Gg: ASbGnctuekvaYoUrHE7p2rJrORJ+NWi6B0bw3/wtDGzZPq+z/ZjCTKyQRa9Coaf8fDG
	CqslrzE8X6SABuPqUtmE+opsR82ttaMDAXX7N0/ozCxboJ+eJsldlcm2sVF+SlksEX7dnUSdHVs
	3ul28AleNIxeYBhjG/Nn75BLLAgpPAXDIyCLqkI9XLzMX/g9izpNtH/ZQxnb/rJGpaNAjrGrh4K
	nmTI2uZ3fk5BREWkzMJ19AYN5TH2meQ7GBZ1pD+H+oRIHZjcnQyrOFMmKurNDzBRR0RIfz+27n2
	w98bKvMr24ymBWd7X0RoiRCpvSzNFGXythYlhNZ0TJTjHU1x
X-Google-Smtp-Source: AGHT+IEkq3dCsTGzTEPa5xhQohIlF2o2eBzIg/MpMX8j9T6cDBvLEAE25oTkm/HkMLp4tNj5rTwfng==
X-Received: by 2002:a5d:47a9:0:b0:386:32ca:9e22 with SMTP id ffacd0b85a97d-38a19b37052mr1418406f8f.41.1734583695708;
        Wed, 18 Dec 2024 20:48:15 -0800 (PST)
Received: from localhost (2001-b011-300c-1872-7e57-58ff-fec7-948b.dynamic-ip6.hinet.net. [2001:b011:300c:1872:7e57:58ff:fec7:948b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962cf4sm3714615ad.25.2024.12.18.20.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 20:48:15 -0800 (PST)
Date: Thu, 19 Dec 2024 12:48:12 +0800
From: Michael Chang <mchang@suse.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: Karel Zak <kzak@redhat.com>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, 
	Glass Su <glass.su@suse.com>, Heming Zhao <heming.zhao@suse.com>, 
	"linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>, grub-devel@gnu.org, util-linux@vger.kernel.org
Subject: Re: is it possible to add a new filter to detect unusable partition
 types
Message-ID: <jcqrtifxjk2adtngyykvyoffh6ab3twulqra4ugq7satddqob7@rngyhl7nuyhk>
Mail-Followup-To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Karel Zak <kzak@redhat.com>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, 
	Glass Su <glass.su@suse.com>, Heming Zhao <heming.zhao@suse.com>, 
	"linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>, grub-devel@gnu.org, util-linux@vger.kernel.org
References: <826b5136-7ee1-4664-98d6-a3441883f53e@suse.com>
 <43D73CB9-32E4-405E-93A9-E985C94F4A9E__33327.0934455626$1734427189$gmane$org@suse.com>
 <ec0d03c0-40b0-4719-a020-9bae7a3241ec@gmail.com>
 <yjiu3c3e4aknayawhw7lw52kev6fvp4wm6n6wte4t27hx3fr4u__21682.4523567752$1734439545$gmane$org@cc5bu2ij2ia3>
 <dbc7728b-352b-4982-a171-d8f177388a19@gmail.com>
 <hdqz3hun3f5ftfwvimlopkmuujimtz5ilovkuajqesy6p4a7jd@7w6nkryhr2y7>
 <860960db-bb66-453c-a392-1495690bb2ff@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <860960db-bb66-453c-a392-1495690bb2ff@t-8ch.de>

On Wed, Dec 18, 2024 at 06:05:54PM +0100, Thomas Weißschuh wrote:
> On 2024-12-18 15:44:45+0100, Karel Zak wrote:
> > On Wed, Dec 18, 2024 at 11:12:59AM GMT, Zdenek Kabelac wrote:
> 
> [..]
> 
> > > And in the same way blkid should expose installed grub loader - currently
> > > the partition with installed grub looks 'empty' with blkid....
> > 
> > The issue I see is that boot loaders can coexist with filesystems on
> > the same device. This can lead to unexpected warnings when attempting
> > to view the contents of the device using mkfs tools.
> 
> Isn't this specifically about the grub second stage on GPT systems
> inside a dedicated partition?

Yes, GPT has no unallocated space similar to the MBR gap in the MSDOS
partition table that can be repurposed for grub second stage, therefore
a dedicated partition has to be defined and allocated. A similar scheme
is also used in PowerPC, where a dedicated firmware PReP boot partition
must be allocated for the boot code.

See Also:

https://www.gnu.org/software/grub/manual/grub/grub.html#BIOS-installation

> There should be no valid coexistence with a filesystem.
> 
> So having a probe in blkid looks reasonable to me.
> 
> Not that it helps in the specific case mentioned above, where everybody
> is using --force anyways.

That's the reason I think adding such a check in grub-install doesn't
help at all. After adding the check, I believe the tools managing the
bootloader installation will start to use wipefs or enforce --force to
grub-install to make sure no leftover can get in the way. In that sense,
it seems like unnecessary breaking change to the toolings.

Thanks,
Michael

> 
> 
> Thomas
