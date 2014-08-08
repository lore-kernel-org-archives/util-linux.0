Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44652 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080AbaHHII5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 8 Aug 2014 04:08:57 -0400
Date: Fri, 8 Aug 2014 10:08:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Linda Walsh <lkml@tlinx.org>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org
Subject: Re: Specifying a generic and per-fs mount line in /etc/fstab as well
 as no-canonicalize.
Message-ID: <20140808080844.GA17719@x2.net.home>
References: <53E2B27C.9020305@tlinx.org>
 <53E2B3FB.8050409@bernhard-voelker.de>
 <53E3D02F.5040300@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53E3D02F.5040300@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 07, 2014 at 12:14:55PM -0700, Linda Walsh wrote:
> Bernhard Voelker wrote:
> >On 08/07/2014 12:55 AM, Linda A. Walsh wrote:
> >>if "/usr/src" is a symlink pointing to /home/src,
> >>and under /home/src, packages points to ../packages, then when I
> >>switch to /usr/src/packages, I see my path listed as /usr/src/packages:
> >>
> >>>> cd /usr/src/packages
> >>/usr/src/packages> pwd
> >>/usr/src/packages
> >>
> >>Only by asking an external util can I find the real name:
> >OT, but: no, "pwd -P" (pwd, the shell built-in) does.
> Yeah... by asking the builtin for the physical path, I could see
> mount -p showing you the physical path.  But wouldn't
> that be "/dev/dm-x"?

/dev/dm-N is *private* DM path and should be nowhere used in
userspace. This is requirement from DM guys. 

> Where is it coming up with /dev/mapper/<mangledname>?

/sys/block/dm-N/dm/name
 
> It's not the link the user gave, and it's not the real device, seems like
> those are "dm" internal names?

it's official device name

> maybe mount -d? for those?

I don't plan to do anything with mount(8) output. If you want more
customized output then use findmnt(8), for long time I think about a
new column KNAME (kernel device name of the mount source). We already
have such column in lsblk(8), maybe it would be nice for findmnt(8) too.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
