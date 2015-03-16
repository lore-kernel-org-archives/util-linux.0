Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985AbbCPUXs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 16:23:48 -0400
Date: Mon, 16 Mar 2015 21:23:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Isaac Dunham <ibid.ag@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Trying to avoid incompatability on a mount enhancement
Message-ID: <20150316202343.GO28925@ws.net.home>
References: <20150314220249.GC1808@Sparta>
 <20150316102233.GA28925@ws.net.home>
 <20150316171958.GA13750@newbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150316171958.GA13750@newbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 16, 2015 at 05:19:59PM +0000, Isaac Dunham wrote:
> On Mon, Mar 16, 2015 at 11:22:33AM +0100, Karel Zak wrote:
> >  x-mount.mkdir[=mode]
> > 
> >         Allow  to  make  a target directory (mountpoint).  The
> >         optional argument mode specifies the filesystem access mode
> >         used for mkdir(2) in octal notation.   The default  mode  is
> >         0755.  This functionality is supported only for root users.
> > 
> > 
> >  ... so:
> > 
> >         mount /dev/sda1 /mnt/foo -o x-mount.mkdir
> > 
> 
> Thank you for responding.
> I read about that some time after I sent the email; now comes the question
> of whether Busybox will accept it.
> 
> I've already gotten a comment to the effect that x-mount.mkdir is "ugly"

 Well, x-* prefixes are generic solution for userspace mount options,
 we already use it for more things (for example systemd).

> (no clarifications provided), and that it's lacking the ability to set
> owner/group for the mountpoint.

 Good point, it would be possible to extend it for example to

   x-mount.mkdir[=mode:user:group]

 where :user and :group are optional and may be specified by UID/GID
 or by username/groupname. 

> (The individual who opposes this is arguing in favor of adding a similar
> but more expanded capability to mdev, the Busybox hotplugger.)

 I have no clue about busybox hotplugger, for standard udev we 
 usually don't want to do things like "mount" in udev context.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
