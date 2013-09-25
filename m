Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754561Ab3IYJ1N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Sep 2013 05:27:13 -0400
Date: Wed, 25 Sep 2013 11:27:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <davidlohr@hp.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] libfdisk: gpt: loosen check fot pmbr size in lba
Message-ID: <20130925092711.GA30761@x2.net.home>
References: <1379821516-2540-1-git-send-email-davidlohr@hp.com>
 <1379821516-2540-3-git-send-email-davidlohr@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379821516-2540-3-git-send-email-davidlohr@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 21, 2013 at 08:45:16PM -0700, Davidlohr Bueso wrote:
> While most disk partitioning tools out there create a pMBR's size in lba
> to be the lesser of the whole disk or 2Tib, Microsoft apparently does not[1].
> It always sets the entry to the maximum 32-bit limitation - even though a
> drive may be smaller than that.
> 
> Loosen this check and only verify that the size is either the whole disk
> or 0xFFFFFFFF.  No tool in its right mind would set it to any value
> other than these.
> 
> [1] http://thestarman.pcministry.com/asm/mbr/GPT.htm#GPTPT
> 
> Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
> ---
>  libfdisk/src/gpt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
