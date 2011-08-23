Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58884 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216Ab1HWKXA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 23 Aug 2011 06:23:00 -0400
Date: Tue, 23 Aug 2011 12:22:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lomount: correct qsort compare function
Message-ID: <20110823102255.GC21266@nb.net.home>
References: <m2obzhywq0.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m2obzhywq0.fsf@igel.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 22, 2011 at 11:15:03PM +0200, Andreas Schwab wrote:
> ---
>  mount/lomount.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

 Very good catch! Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
