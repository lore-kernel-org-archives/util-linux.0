Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:38021 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbbKXPE0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Nov 2015 10:04:26 -0500
Message-ID: <56547C78.3010306@suse.de>
Date: Tue, 24 Nov 2015 16:04:24 +0100
From: Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
To: dgilbert@interlog.com, "Martin K. Petersen" <martin.petersen@ORACLE.COM>,
        "James E.J. Bottomley" <jbottomley@odin.com>,
        SCSI development list <linux-scsi@vger.kernel.org>
CC: sweet_f_a@gmx.de, util-linux@vger.kernel.org
Subject: Re: [PATCH RESEND] scsi_debug: fix prevent_allow+verify regressions
References: <5651F740.3010707@interlog.com>
In-Reply-To: <5651F740.3010707@interlog.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/22/2015 06:11 PM, Douglas Gilbert wrote:
> Ruediger Meier observed a regression with the PREVENT ALLOW
> MEDIUM REMOVAL command in lk 3.19:
>   http://www.spinics.net/lists/util-linux-ng/msg11448.html
> 
> Inspection indicated the same regression with VERIFY(10).
> 
> The patch is against lk 3.19.3 and also works with lk 4.3.0 .
> With this patch both commands are accepted and do nothing.
> 
> ChangeLog:
>   - fix the lk 3.19 regression so that the PREVENT ALLOW
>     MEDIUM REMOVAL command is supported once again
>   - same fix for VERIFY(10)
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
