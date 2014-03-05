Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:7955 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379AbaCELwe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 5 Mar 2014 06:52:34 -0500
Date: Wed, 5 Mar 2014 12:52:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Chris MacGregor <chrismacgregor@google.com>
Cc: util-linux@vger.kernel.org, Chris MacGregor <chris@cybermato.com>
Subject: Re: [PATCH] hwclock: fix possible hang and other
 set_hardware_clock_exact() issues
Message-ID: <20140305115229.GF13353@x2.net.home>
References: <vcw5ha7kiekk.fsf@chrismacgregor0.sea.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <vcw5ha7kiekk.fsf@chrismacgregor0.sea.corp.google.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 27, 2014 at 10:40:59AM -0800, Chris MacGregor wrote:
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 30660d4..161d5cf 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c

 Looks good, it's really more robust solution (and with nice debug
 output:-)
 
 Applied, thanks!

 I did two cosmetic changes to the code (define variables at the begin
 of the code block rather than later in code).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
