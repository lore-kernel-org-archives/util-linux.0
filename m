Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbaFJMQH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jun 2014 08:16:07 -0400
Date: Tue, 10 Jun 2014 14:16:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: use gettext 0.18.3 if possible
Message-ID: <20140610121600.GH30975@x2.net.home>
References: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de>
 <1402394931-20416-2-git-send-email-sweet_f_a@gmx.de>
 <20140610115208.GG30975@x2.net.home>
 <201406101404.42618.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201406101404.42618.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 10, 2014 at 02:04:42PM +0200, Ruediger Meier wrote:
> On Tuesday 10 June 2014, Karel Zak wrote:
> > On Tue, Jun 10, 2014 at 12:08:51PM +0200, Ruediger Meier wrote:
> > > We add a little hack for backward compatibility on systems with
> > > older gettext installed
> > >
> > > See 0576dbd3 and 81ed13ed.
> > >
> > > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > > ---
> > >  autogen.sh   | 31 ++++++++++++++++++++++++++++++-
> > >  configure.ac |  3 ++-
> > >  2 files changed, 32 insertions(+), 2 deletions(-)
> >
> >  Ah, I see, it seems like another pin for our gettext voodoo doll.
> 
> Hehe.
> 
> >  Applied.
> 
> Ooops, in the cover letter I've mentioned that the new function would 
> probably need some more small portability/safety fixes before final 
> patch. Anyway I'll send them later.

Sorry, fingers were faster than brain...

> One more thing. Since we have "0.18.3" now in configure.ac you should 
> take care to release it next time on a system where at least this 
> version is available. It wouldn't look nice if we ship files from 
> different version.

Sure, I always follow his rule.

 $ gettext --version | head -1
 gettext (GNU gettext-runtime) 0.18.3


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
