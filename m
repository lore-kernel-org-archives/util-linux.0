Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:33552 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab1LFTEj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Dec 2011 14:04:39 -0500
Message-ID: <4EDE6745.6070307@cfl.rr.com>
Date: Tue, 06 Dec 2011 14:04:37 -0500
From: Phillip Susi <psusi@cfl.rr.com>
MIME-Version: 1.0
To: dave@gnu.org
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] partx: add BLKPG_RES_PARTITION support
References: <1323115372-3983-2-git-send-email-psusi@cfl.rr.com> <1323197706.3283.1.camel@offbook>
In-Reply-To: <1323197706.3283.1.camel@offbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/6/2011 1:55 PM, Davidlohr Bueso wrote:
> I like the idea, but we should wait until your BLKPG resize patches are
> accepted in mainline before applying here. Also, assuming they make it
> into the kernel, this patch would break partx compilation on older
> kernels.

Indeed.  I thought that util-linux was closely enough tied to the kernel 
that it didn't care about building on older kernels?  I put #ifdefs 
around the code using it in parted, but didn't think it was needed for 
util-linux.  Easy enough to add them back if you think it's necessary.
