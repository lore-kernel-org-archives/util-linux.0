Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46667 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932644AbcCQSYY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 14:24:24 -0400
Date: Thu, 17 Mar 2016 19:24:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] build-sys: install missing bash completions
Message-ID: <20160317182421.3yp2p6gnrgqoraow@ws.net.home>
References: <1458209046-18526-1-git-send-email-sweet_f_a@gmx.de>
 <1458209046-18526-2-git-send-email-sweet_f_a@gmx.de>
 <20160317131320.tj343znddbo6vqex@ws.net.home>
 <201603171752.27998.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603171752.27998.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 17, 2016 at 05:52:27PM +0100, Ruediger Meier wrote:
> On Thursday 17 March 2016, Karel Zak wrote:
> > On Thu, Mar 17, 2016 at 11:04:06AM +0100, Ruediger Meier wrote:
> > > We haven't installed these files since three years. Hopefully
> > > they will work.
> >
> >  I have added tools/checkcompletion.sh (sorry about my shell
> >  programming skills, it requires bash:-), so now:
> >
> >  $ make checkcompletion
> >  Missing completion scripts:
> >     agetty
> >     findfs
> >     kill
> >     line
> >     login
> >     runuser
> >     sulogin
> >     switch_root
> >     vipw
> 
> > > +if BUILD_MOUNT
> > > +dist_bashcompletion_DATA += bash-completion/mount
> > > +dist_bashcompletion_DATA += bash-completion/umount
> > > +endif
> >
> >  ... and checkcompletion does not check for incomplete Makefiles of
> >  course, but better than nothing.
> 
> Maybe checkcompletion.sh would be more simple and safe if we do
> "make install DESTDIR=/tmp/dest" and compare installed *bin/ binaries.

Good point.

> with installed completions (and BTW manpages!). It would also discover
> Makefile bugs. I'm sure that such distcheck-hook scripts should
> already exist. Like rpmlint does such checks for the distro packages
> and prints warnings plus counts negative scores:
> 
> RPMLINT report:
> ===============
> [...]
> util-linux.x86_64: W: no-manual-page-for-binary flushb
> util-linux.x86_64: W: no-manual-page-for-binary chrp-addnote
> Each executable in standard binary directories should have a man page.
> [...]
> 
> 
> 
> But actually the most simple way to find non-distributed
> files in _general_ is IMO this:
> 
> $ make distdir
> $ find util-linux-2.28.rc1-65-5ae7a/ -type f -printf "%P\n" | sort > files-dist
> $ git ls-files | sort > files-git
> $ diff files-git files-dist | grep "^<"

Well, "make distcheck" already checks if the final tarball is usable
without git tree.

I think more important is "make install" consistence, because it
absolutely without any verification. (Well, before release I always
use the new tarball for Fedora util-linux RPM, so it's verified. I
also use ./tests/ts/build-sys/config --force to see changes in the
build system.

I agree that for v2.29 it would be nice to add some "make checkxxxx"
targets based on "make install".


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
