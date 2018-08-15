Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727364AbeHON4b (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Aug 2018 09:56:31 -0400
Date: Wed, 15 Aug 2018 13:04:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
Subject: Re: su(1) --whitelist-environment
Message-ID: <20180815110445.4qefy5zx5gfgbqly@ws.net.home>
References: <20180810092401.inc32ady3eidzyjo@ws.net.home>
 <a745a526-dbc9-ce04-ec4b-8e46d07b8774@gmail.com>
 <745f75b6-d849-a519-7855-9de62d999e06@bernhard-voelker.de>
 <20180814093257.nglcor4c3jagjyxv@ws.net.home>
 <74770378-d739-c0d8-4cfe-3e898bf45f95@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <74770378-d739-c0d8-4cfe-3e898bf45f95@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 14, 2018 at 02:50:12PM +0200, Bernhard Voelker wrote:
> On 08/14/2018 11:32 AM, Karel Zak wrote:
> > On Mon, Aug 13, 2018 at 10:57:01PM +0200, Bernhard Voelker wrote:
> >> Well, this might become slightly trickier with real shell or environment
> >> variables wrt/ correct shell quoting:
> >>
> >>   $ VAR='some value'
> >>   $ su -c 'env VAR="'"$VAR"'" myscript' user
> > 
> > Well, probably usable way for scripts, but ugly for users on command line.
> > 
> > All the idea behind the patch is make things more user-friendly
> > 
> >     su -w GREP_COLOR,COLORFGBG - kzak
> > 
> > seems better than assume -c 'env VAR ..."
> 
> +1 your point. ;-)
> 
> A difference is that  -c 'env VAR ..." works also with shell variables
> while -w filters exported variables only.  I think this not a big deal.
> 
> Regarding your implementation: I suggest to warn when -w is used together
> with -m, -p, --preserve-environment.  WDYT?

Fixed and pushed. Thanks all for review and opinions.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
