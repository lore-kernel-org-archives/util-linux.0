Return-Path: util-linux-owner@vger.kernel.org
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:36547 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932847AbaJURGa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 21 Oct 2014 13:06:30 -0400
Date: Tue, 21 Oct 2014 18:06:07 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Tim Small <tim@seoss.co.uk>, linux-ide@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: blkdiscard vs hdparm for erasing a SSD?
Message-ID: <20141021180607.6f2ee53d@alan.etchedpixels.co.uk>
In-Reply-To: <1471878.ajvL24Q1JG@al>
References: <2523736.cvg5kvG8qa@al>
	<543E82DE.8070405@seoss.co.uk>
	<1471878.ajvL24Q1JG@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> The names suggest that TRIM is for marking sectors for garbage collection while
> SECURITY ERASE tries a bit harder. From the runtime performance point of view, I
> would expect that S.E. is at least as fast as TRIM as no more garbage needs to
> be collected at a later point. From a durability PoV, not so sure, it could be
> that S.E. overwrites all blocks (or not).
> 
> Anyway, I have not read into the details and unless the standards (and
> manufacturers) can guarantee certain behavior, it will likely vary between
> device models.

On a decent SSD security erase is almost immediate and does not need to
overwrite anything.

Alan
