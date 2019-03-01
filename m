Return-Path: <SRS0=2Kk3=RE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABA5C43381
	for <util-linux@archiver.kernel.org>; Fri,  1 Mar 2019 08:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6572087E
	for <util-linux@archiver.kernel.org>; Fri,  1 Mar 2019 08:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfCAIFA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:05:00 -0500
Received: from shell.v3.sk ([90.176.6.54]:41609 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCAIFA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 1 Mar 2019 03:05:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9C4CC102784;
        Fri,  1 Mar 2019 09:04:58 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tog7Q9HZt1qe; Fri,  1 Mar 2019 09:04:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4EEDA102785;
        Fri,  1 Mar 2019 09:04:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mQj2I3GJoV4g; Fri,  1 Mar 2019 09:04:55 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A8D8B102784;
        Fri,  1 Mar 2019 09:04:55 +0100 (CET)
Message-ID: <fc355e625d959e42309f689d1f1716122deb55b1.camel@v3.sk>
Subject: Re: [PATCH 2/2] agetty: Switch to 8-bit processing in get_logname()
 for UTF-8 terminals
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Date:   Fri, 01 Mar 2019 09:04:54 +0100
In-Reply-To: <938cb4db-f24a-4498-27f7-8b6f7180c2a2@suse.cz>
References: <938cb4db-f24a-4498-27f7-8b6f7180c2a2@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, 2019-02-27 at 23:22 +0100, Stanislav Brabec wrote:
> If the terminal is in the UTF-8 mode, get_logname() should use 8-bit
> processing.
> 
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> Cc: Lubomir Rintel <lkundrak@v3.sk>

Tested-by: Lubomir Rintel <lkundrak@v3.sk>

(both patches)

Thanks
Lubo

> ---
>  term-utils/agetty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 0ef8ba36d..43dbd6dea 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -2059,7 +2059,7 @@ static char *get_logname(struct issue *ie, struct options *op, struct termios *t
>  		sleep(1);
>  	tcflush(STDIN_FILENO, TCIFLUSH);
>  
> -	eightbit = (op->flags & F_EIGHTBITS);
> +	eightbit = (op->flags & (F_EIGHTBITS|F_UTF8));
>  	bp = logname;
>  	*bp = '\0';
>  
> -- 
> 2.20.1
> 

