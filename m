Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5506 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757540AbaGOICi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 04:02:38 -0400
Date: Tue, 15 Jul 2014 10:02:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: mount: what is the point of 'nouser' on the command line?
Message-ID: <20140715080234.GP30288@x2.net.home>
References: <1405331864.10850.141333833.2F92BBFD@webmail.messagingengine.com>
 <20140714145759.GM30288@x2.net.home>
 <1405351467.26224.141460601.7C1F0818@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405351467.26224.141460601.7C1F0818@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 14, 2014 at 05:24:27PM +0200, Benno Schulenberg wrote:
> 
> On Mon, Jul 14, 2014, at 16:57, Karel Zak wrote:
> >  The "user" option is alias to "noexec,nosuid,nodev" mount flags. 
> 
> Ehm...  Not quite.  It *implies* those options, to lightly protect
> the user from some dangers, but its main purpose is to allow
> ordinary users to mount the filesystem so marked in fstab.  No?

 Sure, I have talked about the options and how the options are
 evaluated.

> > > So, is it ever useful to specify '-o nouser' on the command line?
> > 
> >  No, it would be better to remove it from the example
> 
> Will submit a patch later.

 Thanks.

> > > Something else.  On the man page of umount, shouldn't it say that
> > > the -O and -t options are only effective in combination with -a?
> > 
> >  The -t is generic and it's usable in more case (for example to
> >  specify filesystem that should be tried for the device).
> 
> Ehm...  I was talking about umount here, not mount.  :)

 Oh... sorry :-) Anyway, it's the same, the "-t" is usable without -a
 too. 

    umount -a -t <type, ...>

 the <type> is interpreted as pattern.

   umount -t <type>

 the <type> is filesystem type (so you can force umount to use for
 example /sbin/umount.<type>).

 The -O is usable with -a  only.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
