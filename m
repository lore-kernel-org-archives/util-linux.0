Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbbCRWFY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Mar 2015 18:05:24 -0400
Date: Wed, 18 Mar 2015 23:05:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: question about findmnt --target
Message-ID: <20150318220522.GF28925@ws.net.home>
References: <201503171608.58423.sweet_f_a@gmx.de>
 <201503171814.00580.sweet_f_a@gmx.de>
 <20150317192552.GY28925@ws.net.home>
 <201503181450.41872.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201503181450.41872.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 18, 2015 at 02:50:41PM +0100, Ruediger Meier wrote:
> On Tuesday 17 March 2015, Karel Zak wrote:
> > On Tue, Mar 17, 2015 at 06:14:00PM +0100, Ruediger Meier wrote:
> > > On Tuesday 17 March 2015, Karel Zak wrote:
> > > > On Tue, Mar 17, 2015 at 04:08:58PM +0100, Ruediger Meier wrote:
> > > > > Hi,
> > > > >
> > > > > I wonder what is the correct way to find a mount which is
> > > > > mounted to a certain target directory. findmnt --target will
> > > > > also find a mount if you specify a subdirectory of a
> > > > > mountpoint:
> > > > >
> > > > > $ mkdir /tmp/bla
> > > > > $ findmnt --target /tmp/bla
> > > > > TARGET SOURCE                        FSTYPE OPTIONS
> > > > > /tmp   /dev/mapper/vg0-tmpdirs[/tmp] ext4 ....
> > > > >
> > > > > The man page let me think that --target should not find the
> > > > > parent directory.
> > > >
> > > > No, it's expected behavior since:
> > > >
> > > >     commit b215d8e9a71ca8d22df6111ddc9d28bd896febb1
> > > >     Author: Dave Reisner <dreisner@archlinux.org>
> > > >     Date:   Wed Apr 25 20:30:52 2012 -0400
> > >
> > > Ok, but this was a regression for a common use case. I guess to
> > > late to revert. Even you liked this old behavior:
> >
> > Well, the common use-case is to not use --target :-)
> 
> Yes, but somehow I find the default mix of source and target
> odd. 

 The idea has be to follow mount(8) behavior:

      mount /dev/sda1
      mount /mnt

 that's all the story. Yes, for serious usage (e.g. in scripts) it's
 better to use --source and --target. Now we have the options also
 for mount(8) to avoid the "smart" behavior.

>  findmnt [options] <source> | <mountpoint>
>  findmnt [options] [--source <source>] [--target <file>] [--mountpoint <mountpoint>]

 Yes, exactly. I have thought about it too. It seems like a more
 transparent solution.

> Please go ahead, I guess I would need much more time for this.

 OK.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
