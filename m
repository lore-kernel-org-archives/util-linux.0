Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58079 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933971AbcCQWl6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 18:41:58 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/2] build-sys: install missing bash completions
Date: Thu, 17 Mar 2016 23:41:46 +0100
Cc: util-linux@vger.kernel.org
References: <1458209046-18526-1-git-send-email-sweet_f_a@gmx.de> <201603171752.27998.sweet_f_a@gmx.de> <20160317182421.3yp2p6gnrgqoraow@ws.net.home>
In-Reply-To: <20160317182421.3yp2p6gnrgqoraow@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603172341.47036.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 17 March 2016, Karel Zak wrote:
> On Thu, Mar 17, 2016 at 05:52:27PM +0100, Ruediger Meier wrote:
> > On Thursday 17 March 2016, Karel Zak wrote:
> > > On Thu, Mar 17, 2016 at 11:04:06AM +0100, Ruediger Meier wrote:
> > > > We haven't installed these files since three years. Hopefully
> > > > they will work.
> > >
> > >  I have added tools/checkcompletion.sh (sorry about my shell
> > >  programming skills, it requires bash:-), so now:
> > >
> > >  $ make checkcompletion
> > >  Missing completion scripts:
> > >     agetty
> > >     findfs
> > >     kill
> > >     line
> > >     login
> > >     runuser
> > >     sulogin
> > >     switch_root
> > >     vipw
> > >
> > > > +if BUILD_MOUNT
> > > > +dist_bashcompletion_DATA += bash-completion/mount
> > > > +dist_bashcompletion_DATA += bash-completion/umount
> > > > +endif
> > >
> > >  ... and checkcompletion does not check for incomplete Makefiles
> > > of course, but better than nothing.
> >
> > Maybe checkcompletion.sh would be more simple and safe if we do
> > "make install DESTDIR=/tmp/dest" and compare installed *bin/
> > binaries.
>
> Good point.
>
> > with installed completions (and BTW manpages!). It would also
> > discover Makefile bugs. I'm sure that such distcheck-hook scripts
> > should already exist. Like rpmlint does such checks for the distro
> > packages and prints warnings plus counts negative scores:
> >
> > RPMLINT report:
> > ===============
> > [...]
> > util-linux.x86_64: W: no-manual-page-for-binary flushb
> > util-linux.x86_64: W: no-manual-page-for-binary chrp-addnote
> > Each executable in standard binary directories should have a man
> > page. [...]
> >
> >
> >
> > But actually the most simple way to find non-distributed
> > files in _general_ is IMO this:
> >
> > $ make distdir
> > $ find util-linux-2.28.rc1-65-5ae7a/ -type f -printf "%P\n" | sort
> > > files-dist $ git ls-files | sort > files-git
> > $ diff files-git files-dist | grep "^<"
>
> Well, "make distcheck" already checks if the final tarball is usable
> without git tree.

Yes, but these commands above showed me clearly that somebody committed 
bash completions but we neither distribute nor install them! distcheck 
can't find such issues.

BTW I had spent almost one hour with creating very exotic 
grep/git/find/whatever command line pipes because I _wanted_ to find 
dead/unused files. Finally above stupid thing worked.

Funny that these 3 files were not installed since 3 years but 
nethertheless maintained and bug fixed a few times. This shows that I'm 
not the only one who _greps_ for bugs if you don't see any in real 
life. :)

cu,
Rudi
