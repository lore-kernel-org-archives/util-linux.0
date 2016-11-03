Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:51234 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752047AbcKCG5R (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 3 Nov 2016 02:57:17 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] tests: wait for flock background process
Date: Thu, 3 Nov 2016 08:57:09 +0200
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
References: <1478097115-3203-1-git-send-email-sweet_f_a@gmx.de> <13b5d77f-87e6-3303-bb5d-e311cb303cfd@bernhard-voelker.de> <20161102230828.n2rlorlyf4rwjiqc@ws.net.home>
In-Reply-To: <20161102230828.n2rlorlyf4rwjiqc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201611030757.09823.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 03 November 2016, Karel Zak wrote:
> On Wed, Nov 02, 2016 at 11:11:42PM +0100, Bernhard Voelker wrote:
> > On 11/02/2016 04:51 PM, Karel Zak wrote:
> > >> +timeout 1s bash -c "while [ \$(ps --ppid $pid |wc -l) -lt 2 ];
> > >> do sleep 0.1 ;done" \
> > >
> > > is "0.1" portable? :-)
> >
> > if one has timeout from coreutils, then it's likely that she also
> > has sleep from there.  Thus said, I'd rather worry about
> > portability of using timeout rather than the "0.1" (if sleep fails,
> > then nobody will care anyway). ;-)
>
> Good point... I have added check for "timeout".


BTW we have already a lot more coreutils and other GNU dependencies in 
our tests, inclusive timeout and sleep for floats.

AFAIR for v2.28 I had fixed all GNU deps for configure/make but for the 
test-suite it was too painful. The OSX build on travis needs for the 
tests at least GNU readlink, seq, truncate, find, xargs, tar and sed. 
The Linux-only tests have even more coreutils deps. 

To replace sleep for floats, we could check and use usleep(1) from 
sysvinit. Or we could even add usleep to util-linux as we did with 
other sysvinit commands.


cu,
Rudi
