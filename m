Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752538AbdF2KiC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Jun 2017 06:38:02 -0400
Date: Thu, 29 Jun 2017 12:37:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: fputs() vs puts() (was: [PATCH] hwclock: remove unused usage()
 FILE argument)
Message-ID: <20170629103757.7vcd5dlpr42doez4@ws.net.home>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <ce8ce9d6-d266-12da-8e7e-c41e6a185714@gmx.com>
 <20170620085610.5eacn7kl5agfemmk@ws.net.home>
 <201706282129.41161.sweet_f_a@gmx.de>
 <20170629085114.66lbbszwxnooszbb@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629085114.66lbbszwxnooszbb@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 29, 2017 at 10:51:14AM +0200, Karel Zak wrote:
> On Wed, Jun 28, 2017 at 09:29:40PM +0200, Ruediger Meier wrote:
> > On Tuesday 20 June 2017, Karel Zak wrote:
> > > On Sun, Jun 18, 2017 at 08:49:49PM -0400, J William Piggott wrote:
> > > >  sys-utils/hwclock.c | 74
> > > > ++++++++++++++++++++++++++--------------------------- 1 file
> > > > changed, 37 insertions(+), 37 deletions(-)
> > >
> > > It would be better to remove this patch from the pull-request; let's
> > > keep fputs() in the code and wait for any solution from Rudi :-)
> > 
> > I have now finished my cleanup regarding stdout only. To make the diffs 
> > small I have left a useless definition "FILE *out = stdout;" in almost 
> > any usage function.
> > 
> > We can remove this "out" variable now everwhere using a sed or awk. But 
> > a few questions about what would be the best end state.
> > 
> > 1. fputs vs puts?:
> > 
> >    Is it a problem for translators if we remove a newline from almost
> >    any string? And, does puts() look more nice at all? I mean many usage
> >    functions have to use printf too, so does it look good if some
> >    strings are '\n' terminated and others not?
> 
> Frankly, I prefer to have \n in the string, because in this case you
> have full control on the output. And it also means all the strings
> modification... for me fputs() is the winner :-)

Note that I don't think we have to be so strict about it. For old already 
translated strings I prefer fputs to avoid \n changes, but for new
tools or after some massive change in usage() it's probbaly fine to
use puts(). Use common sense :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
