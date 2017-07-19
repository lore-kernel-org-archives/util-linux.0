Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752760AbdGSNm6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 19 Jul 2017 09:42:58 -0400
Date: Wed, 19 Jul 2017 15:42:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: stable/v2.30.1
Message-ID: <20170719134254.5ndo3clpioesbxhu@ws.net.home>
References: <20170717101210.qrcfmdp3mi55mcr5@ws.net.home>
 <201707182203.51629.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201707182203.51629.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 18, 2017 at 10:03:51PM +0200, Ruediger Meier wrote:
> On Monday 17 July 2017, Karel Zak wrote:
> >  The branch stable/v2.30.1 contains what I want to release as v2.30.1
> >  on Wednesday. Do you want to fix anything else?
> 
> During the last "usage" and "gcc-7" cleanups we've found a lot of small 
> bugs (exit codes, error handling, portability etc.). Probably we should 
> better not cherry-pick all these fixes to v2.30.1 because the changes 
> were too invasive and may also change currently known (but broken) 
> behavior.
> 
> So I have almost nothing in my mind to add to the current stable/v2.30.
> BTW I appreciated that you have pushed to the stable branch very early 
> this time. Good to follow while the actual commits are still fresh in 
> our memory.

Yes, some stupid bugs in libfdisk forces me to work on stable branch
early ;-)

> Anyways, IMO the current master is in a very good, reviewed, bug-fixed, 
> tested and cleanup'ed state. So maybe we could also tag a very nice 

What about the coreutils-like-usage changes? I mean "--output
COLUMNS". It would be probably good do all the changes in the same
release.

> 2.31 (this time a bit earlier than usually) instead of waiting for more 
> other major changes and wasting too much time with v2.30.1 and v2.30.2.

Well, as downstream maintainer I really look forward to see .1 ASAP ;-)

> Thus I think v2.30.1 could be released as is without much more 
> debating/waiting. Then lets release v2.31 soon and skip v2.30.2 this 
> time.

We will see.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
