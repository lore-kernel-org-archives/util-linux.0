Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55742E3EB
	for <util-linux@vger.kernel.org>; Mon, 18 Nov 2024 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731972788; cv=pass; b=gNE3O6/meeise3HO4qrU+Uts3y6MNjMbTbHzD0XRju5xKs+igT8CQEz+wQqmpTDmImOXl8Q8r0IE0ho8eOdjCMHKwf41iaQeW42dDhpg/NONPXTR3rtel5Ak4gkbmvBK42/y25h+DMa3KHMDULiB1S1VLUGrgNs2uIi3E9AOa/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731972788; c=relaxed/simple;
	bh=IWry7JEe4M+lFOUCC/5tznA+xpXsUTakyD3L0Au96Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5Srv6yE5L+afMqfy0OjrIRbHkcFhWNilAawxVI+XHkW9gZeqy5RJAH0lCNDKFdFRqxgPSnu0yM2R7A011CegZHgvuS6VRqQF2Dxif4oxdJI0mtWSHEibc6LeMcah5r8Nu04iZQvDFAkEJrAXHrV7u+VwrC1P3n/XeCD8u05fy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=TQ+U/9QQ; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="TQ+U/9QQ"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 45169781C87
	for <util-linux@vger.kernel.org>; Mon, 18 Nov 2024 23:13:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (100-112-133-187.trex-nlb.outbound.svc.cluster.local [100.112.133.187])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D192878080C
	for <util-linux@vger.kernel.org>; Mon, 18 Nov 2024 23:13:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731971633; a=rsa-sha256;
	cv=none;
	b=WbsP7++3XprOu74+PhfXFPwXXJDfDTMGf5nxeCbMOyMLhp+UaDMoK0imTdajc7mkRAKgcB
	n1hgrrNAcN+2+iUnVn27Qq9wZp5k5LpukQzmiDXI8uIw6uJUosVWXRaa84RPPJGEHmbSIa
	5xqGW0nksgytZzNH9uGdmPTiD+NpSWch9YSmpo/sDs34OrFQehX4fmYQVXdbQB4mMqBxPv
	IdzKgTeTPDLQR88w4jDFsrxW7QSmS01Q6gamHStQO9OrCa0Afn4tNmYSCk0aZ+2uY+SliK
	ozIUSd2Gvzo67t2qoUJNnOKV/JlgcWB0z+H9eYOZenyj+V8Vew22FrjLa3o03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731971633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wN5oV/Y7l9PvIo3vM6zLPSnhZN0334GktGFHAk2J3eI=;
	b=RJC0H37EwimozHemqe1edaI3CBVUqNQ9r6Ip9MI0JNDAaMRum4DhoSfVzfb5bAN80o7Pr4
	wLin8TzeqpqZfwcZMchlbnm06evt68iI+eo4JOyX71nE761EsgQ7YqTmHh426C9iv7vVqe
	T9Xi59Kw+VA5DVeJ4WHx2fzzRdtcj0CW+ftaP7vgluZaRUqer52VqzybnBmdU37JSzg8h8
	73FHqGGjj886Z407HrzxbYRkfrHaMcG63jLtdTwb/z1Y0tf6KouQRWu9KJAT4jY6nbeiSK
	BPGpzdSoa54cKHjJpzoYNiZV9BbCoropdyUFHqexiF/6qofXcyO8fd3PMraXMA==
ARC-Authentication-Results: i=1;
	rspamd-7456989c76-ljxtl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Celery-Society: 4ca9e7cd6aa87794_1731971634055_260121263
X-MC-Loop-Signature: 1731971634054:1551232035
X-MC-Ingress-Time: 1731971634054
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.133.187 (trex/7.0.2);
	Mon, 18 Nov 2024 23:13:54 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4Xsk2n4ndzzdS
	for <util-linux@vger.kernel.org>; Mon, 18 Nov 2024 15:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1731971633;
	bh=wN5oV/Y7l9PvIo3vM6zLPSnhZN0334GktGFHAk2J3eI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=TQ+U/9QQpFHrwSMMTipAdFPMuEC5hAPX2H+Krp2+f+YfzmE0gb0lE70SbtN0mIdnD
	 9nwzXYLMLT0KUTMelNtaJZJMASb69Xz3PNPGzNlRUpHy+0YDMCw7y/sB7v6IFxdJBX
	 czh6vcXDqf8gFFSF7HFOgc3oq5jAIRuffqLNPPjyuhXYfkiFzl9XSme1CWhjYIYSD2
	 39PUgyzMMBDIS0qip0lnk7W0PCfdGaST0NYsob1R+B3dH9el//V18VbL5Dlp52nHUS
	 OjjoYlPXv+RJAzE7KLNww5+8FKfWjKvrMME65tCFgMN7GcaRSHUg7FVk8iTBEnMkia
	 u0KCGi6syqQDQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00e4
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Mon, 18 Nov 2024 15:13:52 -0800
Date: Mon, 18 Nov 2024 15:13:52 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Lennart Poettering <lennart@poettering.net>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
	systemd-devel@lists.freedesktop.org,
	David Reaver <me@davidreaver.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [systemd-devel] [PATCH] libblkid: fix spurious ext superblock
 checksum mismatches
Message-ID: <20241118231352.GC1885@templeofstupid.com>
References: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
 <ZzvBgOP_skwId4ci@gardel-login>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzvBgOP_skwId4ci@gardel-login>

On Mon, Nov 18, 2024 at 11:36:48PM +0100, Lennart Poettering wrote:
> On Mo, 18.11.24 12:35, Krister Johansen (kjlx@templeofstupid.com) wrote:
> 
> > Reads of ext superblocks can race with updates.  If libblkid observes a
> > checksum mismatch, re-read the superblock with O_DIRECT in order to get
> > a consistent view of its contents.  Only if the O_DIRECT read fails the
> > checksum should it be reported to have failed.
> >
> > This fixes a problem where devices that were named by filesystem label
> > failed to be found when systemd attempted to mount them on boot.  The
> > problem was caused by systemd-udevd using libblkid. If a read of a
> > superblock resulted in a checksum mismatch, udev will remove the
> > by-label links which result in the mount call failing to find the
> > device.  The checksum mismatch that was triggering the problem was
> > spurious, and when we use O_DIRECT, or even perform a subsequent retry,
> > the superblock is correctly read.  This resulted in a failure to mount
> > /boot in one out of every 2,000 or so attempts in our environment.
> >
> > e2fsprogs fixed[1] an identical version of this bug that afflicted
> > resize2fs during online grow operations when run from cloud-init.  The
> > fix there was also to use O_DIRECT in order to read the superblock.
> > This patch uses a similar approach: read the superblock with O_DIRECT in
> > the case where a bad checksum is detected.
> 
> Umpf. udev has a clearly defined protocol to comprehensively avoid
> such issues:
> 
> https://systemd.io/BLOCK_DEVICE_LOCKING
> 
> Partitioning tools should simply follow this logic, and udev and
> programs downstream from it will not even be tempted to operate with
> half-written superblocks, partition tables or such.
> 
> Hence, I personally am not convinced of that O_DIRECT approach. First
> of all, it only works on superblocks that have a useful checksum
> covering enough relevant data, and it can never really catch scenarios
> where a disk is comprehensively repartitioned, i.e. one or more fs and
> partition metadata changed at the same time...

I may have done a poor job of explaining this.  This is ext writing its
own superblock from the kernel, but reads seeing an potentially
inconsistent view of that write.  O_DIRECT causes us to seralize with
the locks ext4 holds when it writes the superblock, which prevents the
read from observing a partial update.

It's not necessarily the partitioning tools causing this, but any
filesystem level udpdate that modifies the contents of the superblock.

-K
