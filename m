Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:58317 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbdGRUEG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Jul 2017 16:04:06 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: stable/v2.30.1
Date: Tue, 18 Jul 2017 22:03:51 +0200
Cc: util-linux@vger.kernel.org
References: <20170717101210.qrcfmdp3mi55mcr5@ws.net.home>
In-Reply-To: <20170717101210.qrcfmdp3mi55mcr5@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201707182203.51629.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 17 July 2017, Karel Zak wrote:
>  The branch stable/v2.30.1 contains what I want to release as v2.30.1
>  on Wednesday. Do you want to fix anything else?

During the last "usage" and "gcc-7" cleanups we've found a lot of small 
bugs (exit codes, error handling, portability etc.). Probably we should 
better not cherry-pick all these fixes to v2.30.1 because the changes 
were too invasive and may also change currently known (but broken) 
behavior.

So I have almost nothing in my mind to add to the current stable/v2.30.
BTW I appreciated that you have pushed to the stable branch very early 
this time. Good to follow while the actual commits are still fresh in 
our memory.

Anyways, IMO the current master is in a very good, reviewed, bug-fixed, 
tested and cleanup'ed state. So maybe we could also tag a very nice 
2.31 (this time a bit earlier than usually) instead of waiting for more 
other major changes and wasting too much time with v2.30.1 and v2.30.2.

Thus I think v2.30.1 could be released as is without much more 
debating/waiting. Then lets release v2.31 soon and skip v2.30.2 this 
time.


cu,
Rudi
