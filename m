Received: from mta.selfhost.au (mta.selfhost.au [203.57.115.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB5385D70
	for <util-linux@vger.kernel.org>; Thu,  4 Jun 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.57.115.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568736; cv=none; b=kRBitNQTg6ih3buq2q9vxBdXRjBz/NkdcW4Qd2ePDexGLgKi2WU55JYrQPwc7BLfiVQZj3TNf1RUV0RegWkHoSLU+5Ip0C1kotWw6FeasbFwONBbWDZXRNPJGNaCgK9VeaUWIppnx/zLO0fMsYj+/OLa0wwF4bh3AFM/0a8zd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568736; c=relaxed/simple;
	bh=RlVQq1FVib6+wTkTNyMxR/hxE4erb6PuEUnjZwjuH44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijxl/hOIhr87VNr4yI7SuYFS4d8FTrA+pJWqscWP8hpRwKvfvWMZjuHcuvuilM2ZXuRLo4fCJ0qBWrPnfuNMMneaWf4wGqTeCUExNDDF6Qm3L511O4mf6Sv2OwywklWnjPldQgNhBwjyC2JcR6pbM2YSkzdn/moazdtstzIgw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=selfhost.au; spf=pass smtp.mailfrom=selfhost.au; dkim=pass (2048-bit key) header.d=selfhost.au header.i=@selfhost.au header.b=mrj4fSSM; arc=none smtp.client-ip=203.57.115.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=selfhost.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selfhost.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selfhost.au header.i=@selfhost.au header.b="mrj4fSSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=selfhost.au; s=2026;
	t=1780568136; bh=RlVQq1FVib6+wTkTNyMxR/hxE4erb6PuEUnjZwjuH44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrj4fSSMw0gLMCuBtAbgploFp8lkMgsO3Vipp8Kdcvry3BsxVPuhadvFSPvjwEuMX
	 CphSlcbunWPaeUtdnRv+xaJ6oxkPav8LRgdLo/MVx8z1RtB8nCuzHTqJv2jkk4dVsx
	 maE8ez3TcQjltf7YQyyXNe603qLq1+yF9yhmIXezkI39KBXfijFURTMh0UP6S6gqMQ
	 xN8h5XIq9y+HjdThdtrRYPPG8x/3rZr0q3hA8Aq53A8g2Jq29IW82Ng76CDaBBPQX9
	 sSU6UHU4wNtJjQm4uwGBb6t67TO670Ldndnw7Ehs4ZqUDqC7CnERHoQNKgSRg0eaDc
	 kywTJmqC3kvsg==
Received: from smulan (unknown [192.168.10.10])
	by mta.selfhost.au (Postfix) with ESMTPSA id CA24E2F7;
	Thu, 04 Jun 2026 20:15:36 +1000 (AEST)
Date: Thu, 4 Jun 2026 20:15:35 +1000
From: Ralph Ronnquist <ralph@selfhost.au>
To: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>
Cc: Chris Hofstaedtler <zeha@debian.org>,
	"util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
	"1134639@bugs.debian.org" <1134639@bugs.debian.org>
Subject: Re: Bug#1134639: nsenter -t 1 -m escapes mount and pid namespaces
Message-ID: <aiFQRzblklN7Iv2I@smulan>
References: <aejkWHDXmpCX7Gh7@smyga.hemma>
 <aiBvnWAjX7uu8ydx@per.namespace.at>
 <SJ0P220MB0541F8F40FD5C0E972BBD715E9102@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0P220MB0541F8F40FD5C0E972BBD715E9102@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>

On Thu, Jun 04, 2026 at 04:03:44AM +0000, Christian Albrecht Goeschel Ndjomouo wrote:
> > First: {unshare -m -p -f chroot FS} will change root into that
> > filesystem with unshared mount and pid namespaces.
> >
> 
> This will successfully changes the root directory path of the child process,
> however, the newly created mount namespace's root mount will still
> point to the host's root filesystem, which is the actual root cause of the
> escape (it'll become clearer below).
> 
> > Next: {mount -t proc proc /proc} will mount the procfs for that pid
> > namespace. We see with {ls -l /proc/1/ns/mnt} the identity of the
> > unshared mount namespace, which is different from the identity before
> > chroot.
> >
> 
> As the mount(8) command has copied the execution context of the container
> process, it will see it's root filesystem as `FS`, so the 'procfs' will be mounted
> on FS/proc, rightfully so. The ls command is also running with that context,
> and will show the container's mount namespace ID.
> 
> > But: {nsenter -t 1 -m -- ls -l /proc/1/ns/mnt} shows the identity of
> > the host mount namespace -- the outer namespace.
> >
> > Thus {nsenter -t 1 -m} "escapes" from the unshared namespace to the
> > containing namespace. And for example: {nsenter -t 1 -m /bin/sh}
> > starts a shell in the outer mount and pid namespace(s)!
> >
> 
> The reason why you escaped is that when nsenter(1) calls setns(fd, CLONE_NEWNS)
> , the kernel will set the root filesystem for the calling process to the absolute root of
> the target mount namespace. And, whatever binary it forks will now be decoupled
> from the container's chroot and point back to the host's root filesystem. This is why
> you are also able to view the host's mount table or resolve paths relative to the host
> fs while inside the container, for example, when you executed a shell with nsenter(8).
> 
> If you wish to completely cut ties with the VFS structure of the host, you can make use
> of pivot_root(8). It let's you set the global root mount of the mount namespace and truly
> isolates the mount namespace.
> 
> You can do something like this:
> 
> $ unshare --mount --pid --fork
> $ mount --bind FS FS/
> $ cd FS/
> $ mkdir -p old_root/
> $ /sbin/pivot_root . old_root/
> $ cd /
> $ mount -t proc proc /proc
> $ umount -l old_root/
> $ rmdir old_root
> 
> You should then be able to see the exact same mnt namespace ID.
> 
> $ ls -l /proc/1/ns/mnt
> [...] /proc/1/ns/mnt -> 'mnt:[4026533461]'
> $ nsenter --mount --target 1 -- ls -l /proc/1/ns/mnt
> [...] /proc/1/ns/mnt -> 'mnt:[4026533461]'
> 
> 
> Maybe Karel has more to say about this.
> 
> Anyways I hope this cleared up at least some of the confusion.

Quite subtile, but I can confirm also in my actual setting (which is a
simple and plain "overlay-boot" example).

I will need a couple of sleeps before I fully grasp that "absolute
root" notion. However the recepie you outline does bring the desired
effect of eliminating that namespace eascape for me.

Thanks.

Ralph


> 
> 
> Christian Goeschel Ndjomouo
> 
> 
> 
