Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34307 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbcDLBH5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2016 21:07:57 -0400
Received: by mail-pf0-f173.google.com with SMTP id c20so2682315pfc.1
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2016 18:07:56 -0700 (PDT)
Date: Mon, 11 Apr 2016 18:07:53 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: Robby Workman <rworkman@slackware.com>
Cc: util-linux@vger.kernel.org, kzak@redhat.com
Subject: Re: v2.29 plan: kill mtab
Message-ID: <20160412010752.GA20359@newbook>
References: <alpine.LNX.2.02.1604071350320.22605@connie.slackware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.02.1604071350320.22605@connie.slackware.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 10, 2016 at 09:35:41PM -0700, Robby Workman wrote:
> Karel Zak wrote:
> 
> > libmount supports three scenarios:
> > 
> > 1) regular classic /etc/mtab
> > 
> > 2) /etc/mtab symlink to /proc/self/mount -- in this case libmount uses
> >    /proc/self/mountinfo and /run/mount/utab
> > 
> > The current default is to detect symlink and on-the-fly switch
> > between 1) and 2).
> > 
> > 3) --enable-libmount-force-mountinfo -- don't care about the symlink
> >    and always use /proc/self/mountinfo. This is robust solution required
> >    for example by systemd, because unfortunately sometimes people use
> >    broken stuff (init scripts, tools, etc.) which removes the symlink.
> > 
> > 
> > I'd like to make 3) default, the question is what with mtab code:
> > 
> >    a) #ifdef all mtab code (and add --enable-libmount-support-mtab)
> > 
> >    b) remove mtab support at all (because it's evil and horrible code)
> > 
> > Comments?
> 
> 
> We still use SysV init because it suits our needs just fine, and we
> have no plans to migrate to systemd in the foreseeable future, so
> we don't have any other compelling reason to use anything other than
> classic /etc/mtab. As such, we'd certainly appreciate, at the very
> least, leaving the mtab support in util-linux.

Contrary to the implication of the mail you quote, whether to use mtab
is not primarily about systemd. Alpine Linux, the distro I use, uses
the /proc/mounts symlink; the userspace is Busybox/OpenRC with musl libc.

The main reason to use /proc/self/mountinfo is that it can be relied on
to tell you what filesystems are mounted where, even if you use chroots,
mount namespaces, private mounts, and similar things. This is because
the kernel necessarily needs to keep track of mounts on a per-process
basis. 
mtab can get confused by chroots and bind mounts, because /etc/mtab
is the userspace keeping track, manually, of the same information,
based on the assumptions that it's the only toolset doing mounts and
unmounts, that everything has the same mounts, and so on; essentially,
it's like keeping track of the number of people in a room by watching
who goes in or out.
Why would you bother counting people going through the door if you have
a window?
Why use code that poorly duplicates information the kernel *needs* to
have an accurate record of?



Thanks,
Isaac Dunham
