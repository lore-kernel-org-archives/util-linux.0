Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:57899 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbcDFRkd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 13:40:33 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: [PATCH 1/2] tests: test_md5 prints md5sum only
Date: Wed, 6 Apr 2016 18:40:21 +0100
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de> <201604061433.59553.sweet_f_a@gmx.de> <20160406164054.GA5851@newbook>
In-Reply-To: <20160406164054.GA5851@newbook>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201604061940.22739.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 06 April 2016, Isaac Dunham wrote:
> On Wed, Apr 06, 2016 at 01:33:58PM +0100, Ruediger Meier wrote:
> > On Wednesday 06 April 2016, Karel Zak wrote:
> > > On Wed, Apr 06, 2016 at 12:30:17PM +0200, Ruediger Meier wrote:
> > > > We want to to use it for other tests without depending on
> > > > gnu md5sum and without cut or awk.
> > >
> > > It does not seem like anything critical, both patches applied to
> > > the next branch (will be in v2.29). Thanks.
> >
> > That's ok. These patches do not fix any existing problem yet. They
> > are just one minor step to remove coreutils dependency from out
> > tests. We would still need to fix usage of readlink, seq and
> > truncate.
>
> Is this for the sake of something where you cannot expect *any*
> coreutils-equivalent to be installed?
> If you can't expect that, can you expect the build scripts to work?

Yes, autoconf/automake/libtool generate highly portable shell scripts. 
For example the configure script even checks whether there is a 
thread-safe "mkdir -p" available or what kind of sed is installed.

The only problems are usually caused by hand-written scripts like shell 
snippets in Makefile.am or our test scripts ;)

Our tests depend on GNU extensions for md5sum, readlink, seq, truncate, 
find,  xargs, tar, sed and the shell has to be bash. That's all not 
critical but at least nice to be fixed if it doesn't make our scripts 
too ugly. 

> I ask because md5sum, seq, and readlink are included in every set of
> base utilities I'm aware of, including coreutils, busybox, toybox,
> and even sbase (the 'suckless' base utilities).
> That said, seq and md5sum are only specified in the LSB, and readlink
> isn't even there.

md5sum is special. It's not Posix and not available or completely 
different on non-Linux systems.

About seq, readlink and truncate: our test-suite is using non-portable 
GNU extenstions. I guess it would not run with busybox. You can 
similate that even with coreutils:

$ POSIXLY_CORRECT=1 make check

I you feel boring you may try to fix some of the mentioned GNUisms ;)

cu,
Rudi
