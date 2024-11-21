Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167422AD00
	for <util-linux@vger.kernel.org>; Thu, 21 Nov 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204540; cv=none; b=Dnv1PwrG5jugeDHbpPgTcrV6/loS1Vs/78KzdkWa6/xCD5MFYCxaGGPF2SaiXUKG+jsNldbDEqsDDUyXHVam+wkX8wjiqpasu5qxavi+inJRgbZkUBBj1c8HK3rTNggqvlqu58Z8JkwiE+acuOyCv8IRoe3s2iowsqq85O3HAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204540; c=relaxed/simple;
	bh=EiTEO1tQTJQ7sQUSmfqJrXnv4vEhnVjqptc16NPLPjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLftb+LEyO1Rf26bclL/bgwrCtjy2cPN9zKJWKBgIOzroGGx2Hg4//Z9nGpa7a52urLx8ZSHBBtvA06Hp60xZZOsHqYkvjrl/fidyqg6J+lGanrcFrhhOW9lQg389om5U9QciMMHQDe2JEDah7gGuxD1l9OrZQkmdmTG0iCQPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kYQaCSuo; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kYQaCSuo"
Received: from macsyma.thunk.org ([50.202.35.157])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4ALFt9ZJ016072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 10:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1732204514; bh=ty+i2BuN7DIZfiehoTNiHFGgin085HUmUNOB4TpL6eM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=kYQaCSuoj3nP5XeVILInLPmjKN5L2R1IARQ4FgzQ1IDPVpt0h4jsRv1+Y+pMVSto5
	 9Ib8NYv/S6mFCHgYvG7MnunRXeiTb6CI/Ti4JQCGWoE1DHkYc1qEgSAEwsmfBZuQDW
	 HYbqmzte+t3B8+rN+E/72jP2f77QSpws13SsQ/ihXVzN+ntBy4aib9cgB0fjY6e5CC
	 0qfhAjSsqjworNtkE0Yf1C/7qef/aHpYYuKASqOv+eKI1JxJlju2E2X63PWMMfvSbl
	 ExzzeB1suxgs47MC0rz5sAnBYxDYsKmSIMZkSGqvpBvgDYmg9OhIQkIgoxyYM606Tw
	 CN4AErDvRmu+w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 40B31340ED3; Thu, 21 Nov 2024 10:55:09 -0500 (EST)
Date: Thu, 21 Nov 2024 07:55:09 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: Karel Zak <kzak@redhat.com>
Cc: "Windl, Ulrich" <u.windl@ukr.de>,
        Krister Johansen <kjlx@templeofstupid.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>,
        David Reaver <me@davidreaver.com>
Subject: Re: [EXT] [systemd-devel] [PATCH] libblkid: fix spurious ext
 superblock checksum mismatches
Message-ID: <20241121155509.GA3802465@mit.edu>
References: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
 <7bc43689ca4249f18c60fa4b063822ea@ukr.de>
 <20241119174957.GA3484088@mit.edu>
 <cu2l7alrme6y7mm3kjmdnszyc7ka4a6zh5lw3ps3vj7igzjpkv@t7pgmn4aztkj>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cu2l7alrme6y7mm3kjmdnszyc7ka4a6zh5lw3ps3vj7igzjpkv@t7pgmn4aztkj>

On Thu, Nov 21, 2024 at 11:44:14AM +0100, Karel Zak wrote:
> I doubt it will be helpful for us.
> 
> I believe that EXT4_IOC_GET_SUPERBLOCK will be used with a mountpoint
> file descriptor, but libblkid works directly with the block device
> (e.g. open(/dev/sda1)) where it searches for valid filesystems.

Yeah, that's why I haven't prioritized implementing it.  Higher
priority is to implement ioctls so that tune2fs will no longer need to
modify the superblock while the file system is mounted, so we can
allow prohibiting read/write access to the block device while it is
mounted.  (Well, after waiting a decent interval so that distros
everywhere can update to a sufficiently new version of e2fsprogs.)

I had guessed that libblkid wouldn't be excited about trying to
determine the mountpoint and using an ioctl that required an open fd
on the mountpoint, but if I had been wrong, I would have been happy to
priotize EXT4_IOC_GET_SUPERBLOCK higher on my todo list.

> Another issue is that libblkid does not check if the device is
> mounted, so the FS prober can be triggered in all cases. It simply
> calls seek()+read() and tries to be smart.

Well, what I had been proposing was something that could be used in
by the ext[234] specific probe code.

> Ideally, we would have a generic ioctl (for block devices) to ask the
> kernel if a superblock at a specific location is valid.
> 
>   ioctl(fd, BLKVERIFYFS, { .fsname="ext4", .offset=123456 })

I wouldn't have thought this to be that useful since there are plenty
of file systems known by libblkid that the kernel doesn't support ---
and even if the source code exists in the kernel, there is no
guarantee that it is actually compiled into a particular kernel image.
(Exhibit 1: Reiserfs)

So would it really simplify libblkid all that much?

Cheers,

						- Ted
	
