Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191401E7647
	for <util-linux@vger.kernel.org>; Mon, 18 Nov 2024 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970008; cv=none; b=fXchx3l/GFHcg/B3/DKvgw81NTRfjWB4M9ju+Zb5z2Hf8MNiGKc5iP9DPpHBFM7RdjGK+9nh0VMjwzjpwOm0aWcKuRIuwJlCGOYO/89eeBwczFTTsTfT+r8vZ+yVV1IpN2YjLDLepE9EGnGLlXQJRmfmMZwXZPUV7noSw/53VDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970008; c=relaxed/simple;
	bh=sz85CBmjDm+G7avaJ7xCT3tWbHE9glAbbJKPMyxF6vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWeWvvwcdHstMM4g+eUtPXXCSMbAqxsBdAoWNU5iFJYNO8uaaUcRqRLhY2bP433jD6e9AJJK8buKgEanalrelume8/9G44/9sTlIxL/DtBokULmCtskUJ6HierlOGMa/USTXxCEHnW7zDBAI5wIyi3LnRsuBeANNHqj0xv6uYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net; spf=pass smtp.mailfrom=poettering.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id EF12CE80E1E;
	Mon, 18 Nov 2024 23:36:53 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id CF9F7160101; Mon, 18 Nov 2024 23:36:49 +0100 (CET)
Date: Mon, 18 Nov 2024 23:36:48 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
	systemd-devel@lists.freedesktop.org,
	David Reaver <me@davidreaver.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [systemd-devel] [PATCH] libblkid: fix spurious ext superblock
 checksum mismatches
Message-ID: <ZzvBgOP_skwId4ci@gardel-login>
References: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>

On Mo, 18.11.24 12:35, Krister Johansen (kjlx@templeofstupid.com) wrote:

> Reads of ext superblocks can race with updates.  If libblkid observes a
> checksum mismatch, re-read the superblock with O_DIRECT in order to get
> a consistent view of its contents.  Only if the O_DIRECT read fails the
> checksum should it be reported to have failed.
>
> This fixes a problem where devices that were named by filesystem label
> failed to be found when systemd attempted to mount them on boot.  The
> problem was caused by systemd-udevd using libblkid. If a read of a
> superblock resulted in a checksum mismatch, udev will remove the
> by-label links which result in the mount call failing to find the
> device.  The checksum mismatch that was triggering the problem was
> spurious, and when we use O_DIRECT, or even perform a subsequent retry,
> the superblock is correctly read.  This resulted in a failure to mount
> /boot in one out of every 2,000 or so attempts in our environment.
>
> e2fsprogs fixed[1] an identical version of this bug that afflicted
> resize2fs during online grow operations when run from cloud-init.  The
> fix there was also to use O_DIRECT in order to read the superblock.
> This patch uses a similar approach: read the superblock with O_DIRECT in
> the case where a bad checksum is detected.

Umpf. udev has a clearly defined protocol to comprehensively avoid
such issues:

https://systemd.io/BLOCK_DEVICE_LOCKING

Partitioning tools should simply follow this logic, and udev and
programs downstream from it will not even be tempted to operate with
half-written superblocks, partition tables or such.

Hence, I personally am not convinced of that O_DIRECT approach. First
of all, it only works on superblocks that have a useful checksum
covering enough relevant data, and it can never really catch scenarios
where a disk is comprehensively repartitioned, i.e. one or more fs and
partition metadata changed at the same time...

Lennart

--
Lennart Poettering, Berlin
