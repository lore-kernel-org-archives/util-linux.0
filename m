Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54807 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632AbaAORLf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jan 2014 12:11:35 -0500
Date: Wed, 15 Jan 2014 18:11:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Felix Miata <mrmazda@earthlink.net>
Cc: util-linux@vger.kernel.org
Subject: Re: global fdisk colors disable
Message-ID: <20140115171128.GM12700@x2.net.home>
References: <52D62F0C.9060308@earthlink.net>
 <20140115082708.GH12700@x2.net.home>
 <52D696CB.5060606@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52D696CB.5060606@earthlink.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 15, 2014 at 09:10:19AM -0500, Felix Miata wrote:
> On 2014-01-15 09:27 (GMT+0100) Karel Zak composed:
> 
> >On Wed, Jan 15, 2014 at 01:47:40AM -0500, Felix Miata wrote:
> 
> >>Is there a way to do $SUBJECT? One really shouldn't have to resort to using
> >>-L on every invocation to be able to see fdisk output.
> 
> >  Does it mean that fdisk output is broken or you just don't like
> >  colors? You can use:
> 
> How about I defer answering that until you look at this image I should have
> included in my OP:
> 
> http://fm.no-ip.com/SS/colorsTTYbadFdisk.png

 Well, for me is the output pretty readable, but I understand that
 for someone else it could be difficult.

 If I run "xterm -bg blue -fg white" then ls(1) output on Fedora is
 absolutely useless, does it mean that coreutils/Fedora use stupid
 defaults?

> Exactly what in that image is the non-default color supposed to be conveying?

 make the header more readable ;-)

> >    alias fdisk=fdisk -L=never
> 
> >  in your shell profile or rc file.
> 
> That seems to have ignored a keyword in $SUBJECT: global

 I don't think so.

> I have many logins on many installations. In what global config file (e.g.
> Debian, Fedora, Gentoo, Knoppix, Mageia, openSUSE, Slackware, etc.) can I
> make never the default for all users?

 depends on distro... for example /etc/profile.d/*

> Orange on a 16 color display doesn't look much different than red. Both
> contrast poorly unless the background is white, detracting from any value as
> warning intended by those color choices.

 so your suggestion is to disable the colors at all for all Linux boxes by
 default? 
 
 I understand your point of view, but I'd like to use default that is
 usable to majority of the Linux users.

> >  I have already thought about it and it would be probably nice to have
> >  a way how to globally configure colors for all command line utils
> >  (e.g.  util-linux, coreutils, ...).
> 
> I'm pretty sure all other utils I commonly use have a way to turn off color
> globally. Some utils don't, so I don't use them unless no alternative
> exists. There really is no practical alternative to fdisk -l that I'm aware
> of.

 See the problem from opposite side -- for example grep and ls have
 disabled colors by default, so many distributions have things like:

         alias egrep='egrep --color=tty'
         alias fgrep='fgrep --color=tty'
         alias grep='grep --color=tty'
         alias l.='ls -d .* --color=auto'
         alias ll='ls -l --color=auto'
         alias ls='ls --color=auto'

 in /etc/profile.d/ to overwrite the default...
 
> >  It seems we have no standard and package  independent solution now,
> >  so distributions use things like "alias" in shell profile files (for
> >  example for ls(1), grep(1), ...). It would be nice to have at least
> >  global variable (something like COLOR_MODE={auto,never,always}) to
> >  avoid aliases with --color= option. (CC: Padraig ;-)
> 
> One reason I use the ttys is for comfort, a pleasant environment where
> legibility is maximized, in part by big bold text, in part by lack of
> distraction from other windows and widgets, in other part by using only the
> two colors of my choice. In that environment I don't want or need to be
> "warned" by colors I can barely see.

 I understand.. it would be nice to have a one place to disable/enable
 colors for all terminal utils, maybe something like
 
    /etc/terminal-colors.d/[<utilname>.]disable

 I'm going to resolve the problem for the next v2.25. Thanks!

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
