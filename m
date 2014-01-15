Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18121 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbaAOKY4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jan 2014 05:24:56 -0500
Date: Wed, 15 Jan 2014 11:24:47 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Felix Miata <mrmazda@earthlink.net>, util-linux@vger.kernel.org
Subject: Re: global fdisk colors disable
Message-ID: <20140115102447.GL12700@x2.net.home>
References: <52D62F0C.9060308@earthlink.net>
 <20140115082708.GH12700@x2.net.home>
 <52D6552B.6040704@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <52D6552B.6040704@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 15, 2014 at 09:30:19AM +0000, Pádraig Brady wrote:
> On 01/15/2014 08:27 AM, Karel Zak wrote:
> > On Wed, Jan 15, 2014 at 01:47:40AM -0500, Felix Miata wrote:
> >> Is there a way to do $SUBJECT? One really shouldn't have to resort to using
> >> -L on every invocation to be able to see fdisk output. 
> > 
> >  Does it mean that fdisk output is broken or you just don't like
> >  colors? You can use:
> > 
> >    alias fdisk=fdisk -L=never
> > 
> >  in your shell profile or rc file.
> > 
> >> I see nothing in the
> >> man page about any kind of config file. I don't think there's ever been a
> >> reason to configure it before.
> > 
> >  Well, I guess that more people prefer colorized output so this
> >  feature is enabled by default.
> > 
> > 
> >  I have already thought about it and it would be probably nice to have
> >  a way how to globally configure colors for all command line utils
> >  (e.g.  util-linux, coreutils, ...).
> >  
> >  It seems we have no standard and package  independent solution now,
> >  so distributions use things like "alias" in shell profile files (for
> >  example for ls(1), grep(1), ...). It would be nice to have at least
> >  global variable (something like COLOR_MODE={auto,never,always}) to
> >  avoid aliases with --color= option. (CC: Padraig ;-)
> 
> I think the current mechanism used is best.
> I.E. default to showing colors when possible but give an option to disable.

As I made note on g+, on many places is the default not to show colors,
so we all have --color=auto aliases in shell profile files :-)

BTW, dmesg supports colors, but it's disabled by default -- what about
to enable it by default? (I don't want to add Fedora specific 
/etc/profile.d/colordmesg.sh ...).

> Global env vars come with their own disadvantages.

Yes.

> However I will say that one has to be careful when using colors,
> and the use in fdisk seems a bit redundant. I.E. colors are useful
> to distinguish things, like the portion of a match in grep or
> the type of a file in ls. I'm not sure the items distinguished

That's exactly how fdisk uses colors :-) The another story are warning
and error messages, my experience is that people don't read it, so now
it's in red.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
