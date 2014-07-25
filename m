Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23928 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbaGYHVu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jul 2014 03:21:50 -0400
Date: Fri, 25 Jul 2014 09:21:43 +0200
From: Karel Zak <kzak@redhat.com>
To: "Linda A. Walsh" <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Q: (RFE?)  How do you specify the 'no-canonicalize' option in
 fstab?
Message-ID: <20140725072143.GN26781@x2.net.home>
References: <53D08C77.6010500@tlinx.org>
 <20140724073222.GI26781@x2.net.home>
 <53D1BF03.9000201@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53D1BF03.9000201@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 24, 2014 at 07:20:51PM -0700, Linda A. Walsh wrote:
> Karel Zak wrote:
> >On Wed, Jul 23, 2014 at 09:32:55PM -0700, Linda A. Walsh wrote:
> >>While it works interactively, that leaves out using it when most of the file
> >>systems are loaded -- how can one specify -no-canonicalize in /etc/fstab?
> >
> > Why do you want something like this?
> ----
> Why wouldn't I?

Well, I'm trying to help you, so it would be nice to have more
information about your use-case...

> > The option --no-canonicalize has very special purpose (e.g. when
> > mount.<type> helper calls mount(8)).
> The default canonicalization has a very special purpose to the kernel/dm,
> but it
> is not necessarily what a user wants to see when they type 'mount'.

Do you mean that you want to see kernel device names for DM when you
list all mountpoint by 'mount'?

> Is there a reason NOT to give the option to user to display it as they wish,
> or is there some reason to force the user into using the kernel/lvm internal
> format?

/dev/dm-0 is internal format that is unexpected for users, DM guys
don't want to see these names in the df, mount, .. outputs. 

Anyway, the goal is to keep device names and mounpoints paths for
mount(2) syscall in some well know (canonical) format, to make it fast
to search in mount tables, etc.

You can use "lsblk -o+KNAME" if you want to see the kernel device names. 

Maybe we can add KNAME also to findmnt(8) to make the name accessible from list
of the mounted filesystem, but don't expect any change in mount(8). It's bad 
idea to change the way how we use devices for mounting just for reason that 
you want to see something else in 'mount' output. It's better to improve 
things like findmnt(8).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
