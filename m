Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DA389
	for <util-linux@vger.kernel.org>; Sun, 28 Apr 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714338487; cv=none; b=oKYzTuYR4MZXml561Jh2q/9k9TGGjJ/D4OSBAffnedilaktPaGlDVY37WcF1JanFhRwJ8EvgLZThJPLbnbn5dNul4VsS242vENZCiyBCR3iYnkjZ4JkSxJNdSEtuQY+LfZDjGabyg9I/Y6kMhJ6jCGF3bPhixUFESW+M/QibCw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714338487; c=relaxed/simple;
	bh=KsHbQ1P/mxvYBPtWTUq0JoX2vIJAjdb8zXrEby9flgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NokmxV74vx5E8xZdiSRenNo9tuynvDm+y8DCquVnaioY4c6Ea9WevLJDAqUwPuMbOMzqCLfYJL+lVmx8HVY0A+CGZKjUXpNSa20rwqAk0bF11xDCZ2ejDyWoYOQhfhHJzVpvSkyNEIbQPWp0s7D8rYehZekxpAVc8mUAy6G18jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=qnelPthU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="qnelPthU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1714338476; bh=KsHbQ1P/mxvYBPtWTUq0JoX2vIJAjdb8zXrEby9flgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnelPthU7CKxB/WLQlCfNWtVt8rPxtQe7lyeyNPqgikYysTIj8bVdqajmWI6iIFGQ
	 btUHn/sfyZX0PxdxGbq3JMtgYN0MGIF/nMyBFereZyCJqt/fxF+Q1q02AAmSQ8QTX8
	 p6jkEPEdVpvFFXCiEcdzFuiQLxWpIHJADnjnFYFU=
Date: Sun, 28 Apr 2024 23:07:56 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: util-linux@vger.kernel.org, Masatake YAMATO <yamato@redhat.com>, 
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v3] flock: add support for using fcntl() with open file
 description locks
Message-ID: <a0de91f6-2eb0-4526-a50a-b89db9fe140f@t-8ch.de>
References: <20240425094417.1174162-1-rasmus.villemoes@prevas.dk>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425094417.1174162-1-rasmus.villemoes@prevas.dk>

On 2024-04-25 11:44:17+0000, Rasmus Villemoes wrote:
> Currently, there is no way for shell scripts to safely access
> resources protected by POSIX locking (fcntl with the F_SETLK/F_SETLKW
> commands). For example, the glibc function lckpwdf(), used to
> protect access to the /etc/shadow database, works by taking a
> F_SETLKW on /etc/.pwd.lock .
> 
> Due to the odd semantics of POSIX locking (e.g. released when any file
> descriptor associated to the inode is closed), we cannot usefully
> directly expose the POSIX F_SETLK/F_SETLKW commands. However, linux
> 3.15 introduced F_OFD_SETLK[W], with semantics wrt. ownership and
> release better matching those of flock(2), and crucially they do
> conflict with locks obtained via F_SETLK[W]. With this, a shell script
> can do
> 
>   exec 4> /etc/.pwd.lock
>   flock --fcntl 4
>   <access/modify /etc/shadow ...>
>   flock --fcntl --unlock 4 # or just exit
> 
> without conflicting with passwd(1) or other utilities that
> access/modify /etc/shadow.
> 
> No single-letter shorthand is defined for the option, because this is
> somewhat low-level and the user really needs to know what he is doing.
> 
> Also, this leaves the door open for teaching --fcntl to accept an
> optional argument: "ofd", the default, and "posix", should anyone find
> a use for flock(1) taking a F_SETLK[W] lock.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> v3:
> 
> - Replace configure-time checking for F_OFD_ by just hard-coding the
>   proper values in flock.c if the system headers don't provide them.
> 
> - Consequently, drop all HAVE_FCNTL_OFD_LOCKS guards.
> 
> v2:
> 
> - Shorten option name to --fcntl instead of --fcntl-ofd.
> 
> - Use a do_lock() helper function switching on the API to use, making
>   the while () condition easier to read and making it simpler to add
>   the mentioned --fcntl=posix should the need arise.
> 
> - Fix up places that need HAVE_FCNTL_OFD_LOCKS guarding.
> 
>  sys-utils/flock.c | 78 +++++++++++++++++++++++++++++++++++++++++++++--

Some testcases in tests/ts/misc/flock would be nice.

>  1 file changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/sys-utils/flock.c b/sys-utils/flock.c

[..]
