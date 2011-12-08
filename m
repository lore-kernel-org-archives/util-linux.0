Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44554 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760Ab1LHMPe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Dec 2011 07:15:34 -0500
Date: Thu, 8 Dec 2011 13:15:27 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: dave@gnu.org, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] partx: add BLKPG_RES_PARTITION support
Message-ID: <20111208121527.GC8278@nb.redhat.com>
References: <1323115372-3983-2-git-send-email-psusi@cfl.rr.com> <1323197706.3283.1.camel@offbook> <4EDE6745.6070307@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EDE6745.6070307@cfl.rr.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 06, 2011 at 02:04:37PM -0500, Phillip Susi wrote:
> On 12/6/2011 1:55 PM, Davidlohr Bueso wrote:
>> I like the idea, but we should wait until your BLKPG resize patches are
>> accepted in mainline before applying here. Also, assuming they make it
>> into the kernel, this patch would break partx compilation on older
>> kernels.
>
> Indeed.  I thought that util-linux was closely enough tied to the kernel  
> that it didn't care about building on older kernels?  I put #ifdefs  
> around the code using it in parted, but didn't think it was needed for  
> util-linux.

 The command line (our API) should not depend on kernel features, so
 we usually use fallback definitions (see for example include/blkdev.h) 
 in case that libc/kernel header files are too old.

> Easy enough to add them back if you think it's necessary.

 This is detail ;-) I'll fix it before commit.

 The more important is to have kernel part in Linus' tree...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
