Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391A8C1E
	for <util-linux@vger.kernel.org>; Sun, 23 Feb 2025 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337362; cv=none; b=U3nqV2yywOoWdR19zimrvgBQK6C5u/u+uVx72SVJzrFoe2h2w0aDaulrp79KZYtRqo5tJH2zrRwMWNhKvBcQ5pA6JZ1nU5gL6iLoqXZvtbX76BDP7gcnfYp9wMt2Vdm+fzPmUBIJnBBa5gdwM/7VFn9z2F1lw2hmqPzgeZF6ttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337362; c=relaxed/simple;
	bh=gf5a2jWmdnUfl08+JF0cZdZRJQZf/E+NYN8nCc3K86I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeFrgwSURxN3CKvkjEXckwGT0mZ2AhPfLfI/GkBXCk0wCBBwag9yi2lm73pAodX9CdiKG/y8Y3VtVkOVOvn6JIYLUkecFBD6B7Sesyei+wbrDbyURTeAEmRu50Sh13P9B025+8Zcd4TVXjkxmevTQFLG+jT8UD5DlXIn4+Pf3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HKnYIiuO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HKnYIiuO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rVXuIQsQSOqJxV60r5NaCfvv8WQMKItFLmjULHQ0dF4=; b=HKnYIiuO1CCfLRhjPz9eMuGcXq
	5SMR+ny+/YEohSzacaHqs/ec+5uyXdkY7lNCvX+vNF1R6zgklS8tbg5Un5TUEXj11dQ8rYyxFbzmq
	mwXM3kiJWCI8MSTqoLAh2zID66NTZoKLmgMxjuS4GkhYDmIpiiUSoxJ2V0xHv6BOAqKxxWS4SIWhP
	8MwdVl2ZOWRk9MsiErF5j5HMXSHgzTY+ZojhlQXfeqaVaXXtTo53RQE4xAPxAbfRd8orX5Td1PPjm
	Fkwjl0xk4YYHgxNZyfhSz0NBzwoK6JbyCa+3Q1monPm8cOvm5qjdTHNVd7Ogfkvn10a8yso1rILjo
	+qMnSaxA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1tmHFO-00HJba-1C; Sun, 23 Feb 2025 19:02:38 +0000
Date: Sun, 23 Feb 2025 20:02:37 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Florian Bach <Leseratte10@vodafone.de>
Cc: 1098694-quiet@bugs.debian.org, util-linux@vger.kernel.org
Subject: Re: Bug#1098694: Crash in agetty due to invalid strncmp call in
 Trixie
Message-ID: <4ewlrlhq7eskooeb5h7v4p5qv6r3nvm2ubmuo5546lo5yxsrta@pr2horn2sxog>
References: <5534c6e1-b819-4aaa-a8c1-fa22852e327b@vodafone.de>
 <tzuam3pqfrm6g7t4hwwapmpxxux75bf4vxd42qb6iode2hqnnx@ve4h5lyd3yp6>
 <bee22700-d1e4-42a2-9fe6-9ba9d2e64538@vodafone.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bee22700-d1e4-42a2-9fe6-9ba9d2e64538@vodafone.de>
X-Debian-User: zeha

Hi,

thanks for the answers!

* Florian Bach <Leseratte10@vodafone.de> [250223 14:46]:
> > 2) which terminal is this? tty1 or something else?
> 
> What do you mean with "is this"? The error messages show up on tty1, the
> default terminal I get when booting Debian without a GUI installed. The one
> where it says "Debian GNU/Linux trixie/sid <hostname> tty1". But the agetty
> process that crashes seems to be trying to manage a different tty (see
> below).

Glad I asked :-)

From what we can see below, this is agetty on ttyS0. But then your
VM probably does not have a "COM0" hardware.

> > 3) whats your kernel command line?
> 
> # cat /proc/cmdline
> BOOT_IMAGE=/boot/vmlinuz-6.12.12-amd64
> root=PARTUUID=add96c19-7043-4bb1-8899-ca970a7d33c8 ro console=tty0
> console=ttyS0,115200 earlyprintk=ttyS0,115200 consoleblank=0
  ^^^^^^^^^^^^^

> [..] After I sent this bug report yesterday, I also found out that
> someone has reported what I believe is the same bug to
> upstream a while ago ( https://github.com/util-linux/util-linux/issues/3304
> ) but so far nobody has commented on that report.

Yeah, this seems like the same issue.

> Note that in the strace log I attached, it tries to open / access the file
> at /run/credentials/serial-getty@ttyS0.service. My VM does not have a serial
> port (since Proxmox VMs apparently don't have one by default). If I add a
> serial port to the VM and then boot it, the errors are gone. So maybe it
> tries to provide a serial console on ttyS0 due to the "console=ttyS0,115200"
> in the kernel command line (I didn't put it there, maybe it's the default?)
> and that fails because it doesn't exist?

> execve("/sbin/agetty2", ["/sbin/agetty2", "-o", "-- \\u", "--noreset", "--noclear", "--keep-baud", "115200,57600,38400,9600", "-", "vt220"], 0x7fff7671f090 /* 11 vars */) = 0
[..]
> openat(AT_FDCWD, "/run/credentials/serial-getty@ttyS0.service", O_RDONLY|O_CLOEXEC) = 3
[..]
> ioctl(0, TCGETS, 0x7fff9faad2e0)        = -1 EIO (Input/output error)
> ioctl(1, TCGETS, 0x7fff9faad2e0)        = -1 EIO (Input/output error)
> ioctl(2, TCGETS, 0x7fff9faad2e0)        = -1 EIO (Input/output error)
[..]


Chris

