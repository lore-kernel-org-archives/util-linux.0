Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727238AbeH3MrE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 30 Aug 2018 08:47:04 -0400
Date: Thu, 30 Aug 2018 10:45:56 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: RFD: --enable-bindir-path ?
Message-ID: <20180830084556.ubvu5e5qhzih5fng@ws.net.home>
References: <5B82E969.6090409@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B82E969.6090409@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 26, 2018 at 10:54:49AM -0700, L A Walsh wrote:
> Was wondering about the addition of an "enable-bindir-path" which would only
> use
> paths with /bin instead of /usr/bin for setups where /usr/bin -> /bin (like
> cygwin who mounts /bin and /lib on /usr/bin and /usr/lib -- using mounts
> instead of symlinks).  The've had that since the beginning with nothing
> being
> installed in /usr/bin or /usr/lib.

So for this use-case /usr should be ignored at all, right? What about PATH
setting? Is it also without /usr? What about man pages, docs?

I have nothing against this feature, but question is if it's important
enough to implement and support it ;-)

> Was also wondering why that wasn't chosen as a default for merging, since
> /bin and /lib are almost always on the root file system so they are always
> there, versus /usr/{bin,lib{,64}} which may need to be mounted before it can
> be used...if it can't be mounted, having things in /bin & /lib pointed
> to /usr won't work so well.

I think originally /usr was also on the same FS as /{bin,lib,...}.

Anyway, now this no issue as we use initram images where is all
stuff that is necessary to assemble usable hierarchy of filesystems
(including RAIDs, NFS moutpoints, etc.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
