Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62752 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756814Ab2IMLZy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 13 Sep 2012 07:25:54 -0400
Date: Thu, 13 Sep 2012 13:25:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Giacomo <giacomo.perale@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: rtcwake doesn't reset wakealarm
Message-ID: <20120913112546.GB13016@x2.net.home>
References: <loom.20120911T131040-30@post.gmane.org>
 <loom.20120912T113440-886@post.gmane.org>
 <20120912100916.GB17256@x2.net.home>
 <20120912103130.GC17256@x2.net.home>
 <loom.20120912T125253-285@post.gmane.org>
 <loom.20120912T191123-580@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20120912T191123-580@post.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 12, 2012 at 05:33:39PM +0000, Giacomo wrote:
> That was needlessly complex. The issue never was "don't call RTC_AIE_OFF if you
> didn't call RTC_AIE_ON before," it was "don't call RTC_AIE_OFF if it is not
> supported."

Good point.

> 
> So to disable an alarm use the same logic used to enable it: first try
> RTC_WKALM_SET with the "enabled" flag set to false, if it fails fall back to
> RTC_AIE_OFF.
> 
> This patch works for me as well and it seems to me it's cleaner than my previous
> one.

 Applied, thanks. (You forgot 'Signed-off-by:' but I guess you agree
 with this line in the commit message... )

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
