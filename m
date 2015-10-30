Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43577 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756952AbbJ3KWu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Oct 2015 06:22:50 -0400
Date: Fri, 30 Oct 2015 11:22:47 +0100
From: Karel Zak <kzak@redhat.com>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare -m for non-root user
Message-ID: <20151030102247.GF19508@ws.net.home>
References: <n0ujgc$tll$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <n0ujgc$tll$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 30, 2015 at 03:09:15AM +0100, U.Mutlu wrote:
> Hi,
> I wonder why "unshare -m" doesn't work for an unpriviledged user:
> 
> $ unshare -m /bin/bash
> unshare: unshare failed: Operation not permitted
> $ echo $?
> 1
> $ ls -l `which unshare`
> -rwxr-xr-x 1 root root 14640 Mar 30  2015 /usr/bin/unshare
> 
> Funny thing: when making the binary setuid then it works.
> But I would prefer a working original version in the OS repository.
> 
> OS: Debian 8
> 
> # dpkg -l | grep -i util-linux
> ii  util-linux                                 2.25.2-6            amd64
> Miscellaneous system utilities
> 
> Is this a bug, or is it not supposed to work for non-root users?

man 2 unshare:

CLONE_NEWNS

This  flag has the same effect as the clone(2) CLONE_NEWNS flag.
Unshare the mount namespace, so that the calling process has a private
copy of its namespace which is not shared with any other process.
Specifying this flag automatically implies CLONE_FS as well.  Use of
CLONE_NEWNS requires the CAP_SYS_ADMIN capability.
                         ^^^^^^^^^^^^

.. so yes, it's expected behavior.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
