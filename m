Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:65347 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbbDBWuc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Apr 2015 18:50:32 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Date: Thu, 2 Apr 2015 23:50:20 +0100
Cc: util-linux@vger.kernel.org, Isaac Dunham <ibid.ag@gmail.com>
References: <201504011342.56546.sweet_f_a@gmx.de> <20150402161952.GB22171@vapier> <20150402191530.GG2097@ws.net.home>
In-Reply-To: <20150402191530.GG2097@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201504030050.21386.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 02 April 2015, Karel Zak wrote:
> On Thu, Apr 02, 2015 at 12:19:52PM -0400, Mike Frysinger wrote:
> > On 02 Apr 2015 10:20, Karel Zak wrote:
> > > If I good remember then the reason is that the helpers does not
> > > have to be installed in standard PATH. Well, you're author of
> > > this thing
> > >
> > > :-)
> >
> > i wrote the code to make it a configure option, but the actual
> > behavior predates me.  i'm interested more in the behavior, not the
> > exact configure option.
>
>  So, the basis question is if we really need to support non-standard
>  paths for the helpers. IMHO it's unnecessary legacy and I don't see
> a problem to drop this feature and require $PATH, and for critical
> things like fsck fallback to /sbin if $PATH is undefined.
>
>  Comments?

I would like to use PATH too but also fallback if PATH is defined. That 
means we just need to append our fallback path to PATH always.

The fallback path(s) may depend on what we are looking for.

In case we search an ul binary we should add the conigured and the 
default path (which is just one path in default case):

"$PATH:$sbindir:/sbin"   for sbin_PROGRAMS like "fsck" or "mkswap"
"$PATH:$bindir:/bin"     for bin_PROGRAMS like "mount/umount"
"$PATH:$usrsbin_execdir:/usr/sbin"  for usrsbin_exec_PROGRAMS
"$PATH:$usrbin_execdir:/usr/bin"    for usrbin_exec_PROGRAMS

For non-ul programs we should not add any fallback path unless there is 
a POSIX or other well-known one. "/bin/sh" might be the only real 
special case.

> > looks like mkfs added it during the 2.2->2.5 transition, but
> > otherwise no details in the bundled NEWS that i saw.  oh well.
>
>  mkfs is deprecated, the right way is to call directly mkfs.<type>.
>
> > mount makes sense as it's set*id and we can't trust users to not be
> > evil :)
>
>  It does not execute anything with root rights, but yes, hardcoded
>  paths make sense there (just to avoid complexity and external
>  dependencies on environment).

Even for mount I would like "$PATH:$bindir:/bin" too. If PATH is really 
a security issue then at least "$bindir:/bin". configure --prefix=xyz 
should install consistent usable util-linux progs.

cu,
Rudi

