Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:52180 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960AbcDFWg5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 18:36:57 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: [PATCH 1/2] tests: test_md5 prints md5sum only
Date: Thu, 7 Apr 2016 00:36:47 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de> <201604061940.22739.sweet_f_a@gmx.de> <20160406213809.GA6396@newbook>
In-Reply-To: <20160406213809.GA6396@newbook>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201604070036.47481.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 06 April 2016, Isaac Dunham wrote:
> On Wed, Apr 06, 2016 at 06:40:21PM +0100, Ruediger Meier wrote:
> > On Wednesday 06 April 2016, Isaac Dunham wrote:
> > > On Wed, Apr 06, 2016 at 01:33:58PM +0100, Ruediger Meier wrote:
> > > > On Wednesday 06 April 2016, Karel Zak wrote:
> > > > > On Wed, Apr 06, 2016 at 12:30:17PM +0200, Ruediger Meier 
wrote:
> > > > > > We want to to use it for other tests without depending on
> > > > > > gnu md5sum and without cut or awk.
> > > > >
> > > > > It does not seem like anything critical, both patches applied
> > > > > to the next branch (will be in v2.29). Thanks.
> > > >
> > > > That's ok. These patches do not fix any existing problem yet.
> > > > They are just one minor step to remove coreutils dependency
> > > > from out tests. We would still need to fix usage of readlink,
> > > > seq and truncate.
> > >
> > > Is this for the sake of something where you cannot expect *any*
> > > coreutils-equivalent to be installed?
> > > If you can't expect that, can you expect the build scripts to
> > > work?
> >
> > Yes, autoconf/automake/libtool generate highly portable shell
> > scripts. For example the configure script even checks whether there
> > is a thread-safe "mkdir -p" available or what kind of sed is
> > installed.
>
> Ah yes, I should have remembered that it checks that. ;)
> http://lists.busybox.net/pipermail/busybox/2004-January/044642.html
> (The test is for "GNU sed version ..." rather than behavior.)
>
> > The only problems are usually caused by hand-written scripts like
> > shell snippets in Makefile.am or our test scripts ;)
> >
> > Our tests depend on GNU extensions for md5sum, readlink, seq,
> > truncate, find,  xargs, tar, sed and the shell has to be bash.
> > That's all not critical but at least nice to be fixed if it doesn't
> > make our scripts too ugly.
> >
> > > I ask because md5sum, seq, and readlink are included in every set
> > > of base utilities I'm aware of, including coreutils, busybox,
> > > toybox, and even sbase (the 'suckless' base utilities).
> > > That said, seq and md5sum are only specified in the LSB, and
> > > readlink isn't even there.
> >
> > md5sum is special. It's not Posix and not available or completely
> > different on non-Linux systems.
>
> Ah yes. Somehow I keep forgetting that util-linux needs to worry
> about non-linux systems.

I have to admit that IMO it would be ok to skip non-Linux support but 
personally I like portability and sometimes runs on other systems 
discovers theoretical or future bugs even for the major Linux target.

> As far as I can tell, the BSDs use 'md5', which approximates the
> desired output when run as 'md5 -r'; but your approach is better than
> trying to coerce suitable output from diverse programs.
>
> > About seq, readlink and truncate: our test-suite is using
> > non-portable GNU extenstions. I guess it would not run with
> > busybox. You can similate that even with coreutils:
> >
> > $ POSIXLY_CORRECT=1 make check
>
> grep -rw seq tests/ reports only a series of invocations that resolve
> to 'seq $START $END';

Yep, I've grepped that too a few hours ago. But I know for sure that our 
seq usage did not worked on OSX a few weeks ago. Maybe we've used float 
increment a some commits ago .. I don't remember.

> however, one or two of them will probably break 
> due to the shell not working the same (parameter subsitution inside
> shell aritmetic inside $().).
> Similarly, -f is the only readlink option that seems to be used.
> (Busybox supports this.)

Unfortunately readlink -f is the most useful option of readlink. But 
probably we wouldn't need it always where we are using it right now.

> Trying to run "make check", however, runs into busybox xargs not
> supporting -P (needed for parallel tests).

Could be fixed by checking for xargs -P on runtime, disable parallel 
tests otherwhise. But AFAIR missing xargs -r was also an issue.

Generally I remember there are issues with find and xargs don't behave 
like Posix on all non-Unix systems. So for now it was easier to simply 
require well defined GNU findutils.

> truncate is not POSIX, but it's relatively new.

Could be re-replaced by dd but would be nice to check if it keeps the 
files sparse (dd seek=x).

> > If you feel bored you may try to fix some of the mentioned GNUisms
> > ;)
>
> I might.
> Most likely, the biggest issue is bash.

At least we explicitly require bash in the shebang. Maybe we could use
#!/usr/bin/env bash
.. to make it easier on systems where is no bash in /bin

Making test scripts portable to /bin/sh would be really annoying I 
guess. Installing bash-4 is IMO much easier for the users than fixing 
all the other issues (coreutils, findutils, sed, tar). BTW our awk 
usage seems to be ok right now.

cu,
Rudi
