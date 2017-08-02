Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752298AbdHBIVK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 2 Aug 2017 04:21:10 -0400
Date: Wed, 2 Aug 2017 10:21:01 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/8] hwclock: fix RTC read logic
Message-ID: <20170802082101.swemgk2zligiib42@ws.net.home>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
 <5714882c-8ed5-c703-410e-c0dd191051f6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5714882c-8ed5-c703-410e-c0dd191051f6@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 01, 2017 at 09:17:08AM -0400, J William Piggott wrote:
> 
> Over the past decade a few commits for a corner case problem
> have left the RTC read branch in a bad place.
> 
> The problem was: when a corrupted RTC could not be read, then
> it also could not be reset, because hwclock would error out
> due to the RTC read failure.
> 
> 2.15-rc1 commit 3b96a7a Aug  9 2008
> 2.19-rc1 commit 5606df5 Dec 29 2010
> 2.23-rc1 commit ab8f402 Mar 21 2013
> 
> The first fix was to ignore a synchronization timeout only for
> the busywait branch.
> 
> Two and a half years later a commit describing the same problem
> took a little more heavy-handed approach by ignoring all
> synchronization failures and the RTC read after it, for both of
> the RTC set functions.
> 
> Because the previous fix also ignored the select() branch timeout
> it caused a bogus warning. The chosen workaround for that was to
> only print the select() timeout message in debug mode (this is
> reverted by another patch).
> 
> The problem with these fixes is that we cannot just ignore the
> synchronization timeout like that, because then the drift
> correction operations will be invalid. The original logic was
> correct; we must exit when synchronization fails.

... but will be possible to set RTC with invalid data?

> Another problem is that now there are statements between the
> timing-critical synchronize-read-timestamp trio (which were
> also in the wrong order, but that part of the problem goes
> back further in history).
> 
> The solution is to skip the RTC read block completely for the
> RTC set functions when not also using the --update-drift
> option. If we are updating the drift correction factor during
> a set function then we must synchronize and read the RTC.
> Otherwise reading the RTC is not needed. Anyone trying to set
> a corrupt RTC should not be using --update-drift, because the
> resulting drift correction factor would be invalid.

OK, I see. The issue is --update-drift.

Maybe it would be nice to be more explicit in the man page and do 
NOT recommend to use --systohc together with --update-drift.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
