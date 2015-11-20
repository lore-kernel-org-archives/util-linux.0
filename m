Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63721 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759534AbbKTLA5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Nov 2015 06:00:57 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi_debug: fix prevent_allow+verify regressions
Date: Fri, 20 Nov 2015 12:00:37 +0100
Cc: SCSI development list <linux-scsi@vger.kernel.org>, jbottomley@odin.com,
        util-linux@vger.kernel.org
References: <5522A0C5.9030804@interlog.com>
In-Reply-To: <5522A0C5.9030804@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201511201200.38623.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

what happened to this patch? It's still not merged into the kernel. 
That's a pity.

cu,
Rudi

On Monday 06 April 2015, Douglas Gilbert wrote:
> Ruediger Meier observed a regression with the PREVENT ALLOW
> MEDIUM REMOVAL command in lk 3.19:
>    http://www.spinics.net/lists/util-linux-ng/msg11448.html
>
> Inspection indicated the same regression with VERIFY(10).
>
> The patch is against lk 3.19.3 and also works with lk 4.0.0-rc6.
> With this patch both commands are accepted and do nothing.
> VERIFY(10) could be implemented since it shares logic with
> COMPARE AND WRITE which is implemented; however that would
> be an enhancement.
>
> ChangeLog:
>    - fix the lk 3.19 regression so that the PREVENT ALLOW
>      MEDIUM REMOVAL command is supported once again
>    - same fix for VERIFY(10)
>
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>


