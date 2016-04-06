Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32886 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbcDFViN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2016 17:38:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so5358596pfe.0
        for <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 14:38:13 -0700 (PDT)
Date: Wed, 6 Apr 2016 14:38:10 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] tests: test_md5 prints md5sum only
Message-ID: <20160406213809.GA6396@newbook>
References: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de>
 <201604061433.59553.sweet_f_a@gmx.de>
 <20160406164054.GA5851@newbook>
 <201604061940.22739.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201604061940.22739.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 06, 2016 at 06:40:21PM +0100, Ruediger Meier wrote:
> On Wednesday 06 April 2016, Isaac Dunham wrote:
> > On Wed, Apr 06, 2016 at 01:33:58PM +0100, Ruediger Meier wrote:
> > > On Wednesday 06 April 2016, Karel Zak wrote:
> > > > On Wed, Apr 06, 2016 at 12:30:17PM +0200, Ruediger Meier wrote:
> > > > > We want to to use it for other tests without depending on
> > > > > gnu md5sum and without cut or awk.
> > > >
> > > > It does not seem like anything critical, both patches applied to
> > > > the next branch (will be in v2.29). Thanks.
> > >
> > > That's ok. These patches do not fix any existing problem yet. They
> > > are just one minor step to remove coreutils dependency from out
> > > tests. We would still need to fix usage of readlink, seq and
> > > truncate.
> >
> > Is this for the sake of something where you cannot expect *any*
> > coreutils-equivalent to be installed?
> > If you can't expect that, can you expect the build scripts to work?
> 
> Yes, autoconf/automake/libtool generate highly portable shell scripts. 
> For example the configure script even checks whether there is a 
> thread-safe "mkdir -p" available or what kind of sed is installed.

Ah yes, I should have remembered that it checks that. ;)
http://lists.busybox.net/pipermail/busybox/2004-January/044642.html
(The test is for "GNU sed version ..." rather than behavior.)

> The only problems are usually caused by hand-written scripts like shell 
> snippets in Makefile.am or our test scripts ;)
> 
> Our tests depend on GNU extensions for md5sum, readlink, seq, truncate, 
> find,  xargs, tar, sed and the shell has to be bash. That's all not 
> critical but at least nice to be fixed if it doesn't make our scripts 
> too ugly. 
>
> > I ask because md5sum, seq, and readlink are included in every set of
> > base utilities I'm aware of, including coreutils, busybox, toybox,
> > and even sbase (the 'suckless' base utilities).
> > That said, seq and md5sum are only specified in the LSB, and readlink
> > isn't even there.
> 
> md5sum is special. It's not Posix and not available or completely 
> different on non-Linux systems.

Ah yes. Somehow I keep forgetting that util-linux needs to worry about
non-linux systems.
As far as I can tell, the BSDs use 'md5', which approximates the desired
output when run as 'md5 -r'; but your approach is better than trying
to coerce suitable output from diverse programs.
 
> About seq, readlink and truncate: our test-suite is using non-portable 
> GNU extenstions. I guess it would not run with busybox. You can 
> similate that even with coreutils:
> 
> $ POSIXLY_CORRECT=1 make check

grep -rw seq tests/ reports only a series of invocations that resolve to
'seq $START $END'; however, one or two of them will probably break due
to the shell not working the same (parameter subsitution inside shell
aritmetic inside $().).
Similarly, -f is the only readlink option that seems to be used.
(Busybox supports this.)
Trying to run "make check", however, runs into busybox xargs not
supporting -P (needed for parallel tests).
truncate is not POSIX, but it's relatively new.

> If you feel bored you may try to fix some of the mentioned GNUisms ;)

I might.
Most likely, the biggest issue is bash.


Thanks,
Isaac

