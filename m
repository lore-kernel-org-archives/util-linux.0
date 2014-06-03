Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753721AbaFCL1i (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Jun 2014 07:27:38 -0400
Date: Tue, 3 Jun 2014 13:27:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: build-sys: minor issues
Message-ID: <20140603112732.GR9000@x2.net.home>
References: <201406020056.17074.sweet_f_a@gmx.de>
 <20140602094243.GM9000@x2.net.home>
 <201406021233.23463.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201406021233.23463.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 02, 2014 at 12:33:23PM +0200, Ruediger Meier wrote:
> On Monday 02 June 2014, Karel Zak wrote:
> > On Mon, Jun 02, 2014 at 12:56:16AM +0200, Ruediger Meier wrote:
> > > 1. ./configure --enable-all-programs
> > > also triggers --enable-deprecated-last. Would be nice to exclude
> > > this deprecated stuff somehow.
> >
> >  fixed, thanks for your report.
> 
> Thanks! All the recent build-sys tweaks were really helpful!
> 
> > > 2. make dist
> > > changes files in source dir, which makes the git clone dirty. Would
> > > be nice if we could avoid this somehow.
> >
> >  What files? I see po/ stuff modification and it's more political
> >  issue than technical. The reason is that I update po/ only once
> >  before release (to avoid many many huge commits with irrelevant
> >  changes).
> 
> I have to admit that I'm not really familar with this translations.
> But IMO generally it's not nice that "make dist" pollutes the git
> clone.

 I see two issues with po/Makefile:

 * "make" generates po/*.gmo files into srcdir by

     cd $(srcdir) && rm -f $${lang}.gmo && $(GMSGFMT) ...

 * "make dist" updates po/*.po files in srcdir by

     test "$(srcdir)" = . && cdcmd="" || cdcmd="cd $(srcdir) && "; \
     echo "$${cdcmd}$(MSGMERGE_UPDATE) $(MSGMERGE_OPTIONS) 


 The problem is that we don't control this Makefile, it's created by 
 autopoint and maintained by gettext upstream. 
 
 Yes, it's mistake to modify $srcdir.

> I see 3 possibilities how to avoid this.
> 
> 1. Don't track these po files in git at all. Always generate in
>    builddir. Put them into dist only.

 No, I'm sure we want to have .po files in the git, it's part of the package.

> 2. Don't update them with "make dist". Add new target "make update-po".

 Well, I use "make distcheck" to generate the final release tarballs
 and it would be nice to keep it usable :-)

> 3. Keep them in srcdir but update to builddir. Add a script
>    "commit-po-updates" to manulally move them from builddir to
>    srcdir from time to time. 
> 
> My use case is a cronjob like this
>   git pull origin
>   ./autogen.sh && ./configure && make dist
>   "push-tarball-to-build-host" 
> 
> Because of the current git pollution I have to do always "git 
> reset --hard" before "autogen.sh" to not have "-dirty" suffixed version 
> numbers.

 What about to improve ./tools/git-version-gen to not use -dirty suffix when
 only po/*.po stuff is modified? 
 
 Note that git-version-gen is our script, and it just for developers,
 no problem to change it.
 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
