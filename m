Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62481 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab3LKQtd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 Dec 2013 11:49:33 -0500
Date: Wed, 11 Dec 2013 17:49:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: read only bind mount ignores ready only
Message-ID: <20131211164930.GC16572@x2.net.home>
References: <52A878C5.6050505@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52A878C5.6050505@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 11, 2013 at 09:37:57AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Forwarding report from
> https://bugs.launchpad.net/ubuntu/+source/util-linux/+bug/712892
> 
> It seems that the kernel has a bug where it silently ignores the
> MS_RDONLY flag when creating a bind mount.  mount issues a warning

Yes, this is known issue.

> that the mount point appears to be read-write even though you

I think that libmount based mount does not warn about it (mistake?).

> requested read only.  The reporter suggests a patch to automatically
> attempt to remount with MS_RDONLY before issuing this warning to work
> around the kernel bug.  What do you think?

Well, it means that the kernel disadvantage will never be fixed ;-)

It would be relatively simple to fix it, because libmount already
support "additional mounts" to implement things like

   mount --make-private /dev/sda1 /mnt

(kernel does not allow to use propagation flags for regular mount
 operation). I'll try it tomorrow.

The problem is that all these userspace hacks does not atomic...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
