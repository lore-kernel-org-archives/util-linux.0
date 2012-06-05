Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5040 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab2FEMuQ (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 5 Jun 2012 08:50:16 -0400
Date: Tue, 5 Jun 2012 14:50:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: kerolasa@gmail.com, util-linux-ng@vger.kernel.org
Subject: Re: [pull] su.1 manual page
Message-ID: <20120605125008.GG14536@x2.net.home>
References: <CAG27Bk3YrUc4cwpUou5o005S165LOc4C8bPHp-EnkwAz2WsFng@mail.gmail.com>
 <4FC72679.7050307@suse.de>
 <CAG27Bk0E79L9Tb7zi0M6ditsxr46LKJcy6Rn1KqFi5wrxTB4pw@mail.gmail.com>
 <4FC88A00.90004@suse.de>
 <CAG27Bk1s96ztd-k4C9vqJqdj=_Mc7oz-VUhzYkDyWMyL2x-irw@mail.gmail.com>
 <4FCC6386.3080505@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FCC6386.3080505@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 04, 2012 at 09:28:06AM +0200, Ludwig Nussel wrote:
> Sami Kerola wrote:
> > On Fri, Jun 1, 2012 at 11:23 AM, Ludwig Nussel <ludwig.nussel@suse.de> wrote:
> >> Sami Kerola wrote:
> >>> On Thu, May 31, 2012 at 10:06 AM, Ludwig Nussel <ludwig.nussel@suse.de> wrote:
> >>>> Hmm, I was about to write a man page from scratch. Should I continue or
> >>>> do we use the coreutils man page?
> >>>
> >>> 1. Continue writing from scratch, and propose your own man page candidate.
> >>
> >> I've attached my suggestion
> > 
> > Hi Ludwig,
> > 
> > Your manual is better, so I took liberty to add it to my branch and
> > make few groff changes.
> > 
> > https://github.com/kerolasa/lelux-utiliteetit/commit/2ab15cb0c3b6fe81697713ce6dc56b85e44a00fe#login-utils/su.1
> > 
> > Have also a look of how the pager will show the end result.
> > 
> > https://raw.github.com/kerolasa/lelux-utiliteetit/su.1/login-utils/su.1
> > 
> > I would like to hear you are OK with that. Without other comments I
> > reckon the su.1 is ready to be merged.
> 
> Fine with me, thanks!

 Merged, thanks!


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
