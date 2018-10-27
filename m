Return-Path: <SRS0=EwlK=NH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9B3C46475
	for <util-linux@archiver.kernel.org>; Sat, 27 Oct 2018 15:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752A9204FD
	for <util-linux@archiver.kernel.org>; Sat, 27 Oct 2018 15:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752A9204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeJ0X6g (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 27 Oct 2018 19:58:36 -0400
Received: from shell.v3.sk ([90.176.6.54]:33609 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbeJ0X6g (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 27 Oct 2018 19:58:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 473FFC40E0;
        Sat, 27 Oct 2018 17:17:14 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sIyZ8LY0l1dr; Sat, 27 Oct 2018 17:17:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6AE34C41B4;
        Sat, 27 Oct 2018 17:17:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qX-lRw4mAtm0; Sat, 27 Oct 2018 17:17:10 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 857BCC40E0;
        Sat, 27 Oct 2018 17:17:10 +0200 (CEST)
Message-ID: <9c1f697acf819067a1f78795b0aec5b51caf4138.camel@v3.sk>
Subject: Re: [PATCH] agetty: when logname is erased, re-enable reloads
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Cc:     Karel Zak <kzak@redhat.com>
Date:   Sat, 27 Oct 2018 17:17:09 +0200
In-Reply-To: <30ff9b68-4eab-5c42-22e6-1e84920862f0@suse.cz>
References: <30ff9b68-4eab-5c42-22e6-1e84920862f0@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, 2018-10-26 at 15:02 +0200, Stanislav Brabec wrote:
> When user starts to enter logname, 8b58ffdd blocks issue reloads.
> Reloads remain blocked even if user deletes all typed characters.
> 
> Make things visually consistent: If no characters are entered,
> re-enable reloads.
> 
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Karel Zak <kzak@redhat.com>

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>
Tested-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks,
Lubo

> ---
>  term-utils/agetty.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index cfcdffe93..05a269abb 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -2182,6 +2182,9 @@ static char *get_logname(struct issue *ie,
> struct options *op, struct termios *t
>  				*bp++ = ascval;			/*
> and store it */
>  				break;
>  			}
> +			/* Everything was erased. */
> +			if (bp == logname)
> +				goto no_reload;
>  		}
>  	}
>  
> -- 
> 2.19.1
> 

