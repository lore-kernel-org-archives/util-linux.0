Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32196 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab2I0XRL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Sep 2012 19:17:11 -0400
Date: Fri, 28 Sep 2012 01:17:05 +0200
From: Karel Zak <kzak@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: add new command
Message-ID: <20120927231705.GA9064@x2.net.home>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
 <alpine.LFD.2.00.1209261546390.31136@dhcp-187-45.bos.redhat.com>
 <20120927094256.GA18644@x2.net.home>
 <alpine.LFD.2.00.1209271113040.31136@dhcp-187-45.bos.redhat.com>
 <yq14nmja2kd.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <yq14nmja2kd.fsf@sermon.lab.mkp.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 27, 2012 at 11:49:22AM -0400, Martin K. Petersen wrote:
> >>>>> "Lukáš" == Lukáš Czerner <lczerner@redhat.com> writes:
> 
> Lukáš> TBH this is fugly :). Also what actually is the advantage of

 Yes, I agree my implementation is not too readable...

> Lukáš> doing this ? So we saved 50 lines of code for this ugliness and
> Lukáš> instead of two separate binaries we have this one hybrid and
> Lukáš> symlink. I am not sure it's worth it. Can't we just have two
> Lukáš> separate binaries ? What is the problem with that ?
> 
> It's not just discard. We should also consider the zeroout and write
> same use cases. They have nothing to do with fstrim.
> 
> Time to incorporate and extend Garzik's blktool, perhaps?

 I have applied Lukas' implementation. It seems better to have it on
 the same place like fstrim.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
