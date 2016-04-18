Return-Path: util-linux-owner@vger.kernel.org
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51376 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953AbcDRPuW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 11:50:22 -0400
Message-ID: <1460994619.7385.14.camel@HansenPartnership.com>
Subject: Re: [PATCH] nsenter: fix ability to enter unprivileged containers
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: util-linux@vger.kernel.org
Cc: ebiederm@xmission.com
Date: Mon, 18 Apr 2016 11:50:19 -0400
In-Reply-To: <1460993854.7385.11.camel@HansenPartnership.com>
References: <1460982392.2452.6.camel@HansenPartnership.com>
	 <1460993854.7385.11.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2016-04-18 at 11:37 -0400, James Bottomley wrote:
> > # nsenter --mount=/run/build-container/aarch64 nsenter -
> > -user=/dev/fd/3 3&lt;/run/build-container/user
> 
> It should work, but for some inexplicable reason it's giving EINVAL.
> 
> # nsenter --mount=/run/build-container/aarch64 3</run/build
> -container/user 
> # ls -l /proc/self/fd
> total 0
> lrwx------ 1 root root 64 Apr 18 15:31 0 -> /dev/pts/1
> lrwx------ 1 root root 64 Apr 18 15:31 1 -> /dev/pts/1
> lrwx------ 1 root root 64 Apr 18 15:31 2 -> /dev/pts/1
> lr-x------ 1 root root 64 Apr 18 15:31 3 -> /run/build-container/user
> lr-x------ 1 root root 64 Apr 18 15:31 4 -> /proc/10304/fd
> # nsenter --user=/proc/self/fd/3
> nsenter: reassociate to namespace 'ns/user' failed: Invalid argument
> 
> I think it's because the fd wasn't properly opened by the shell

Actually, just to follow up, this is specifically a problem of the type
of container I'm running: it's actually an architecture emulation
container, so after I've done the mount namespace enter, I'm running
under aarch64 emulation and, apparently, qemu has some problem with the
setns system call.  This does, however, mean I have to enter both
namespaces together ...

James

