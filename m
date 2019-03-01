Return-Path: <SRS0=2Kk3=RE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F40AC43381
	for <util-linux@archiver.kernel.org>; Fri,  1 Mar 2019 08:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59AE2087E
	for <util-linux@archiver.kernel.org>; Fri,  1 Mar 2019 08:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCAIEZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:04:25 -0500
Received: from shell.v3.sk ([90.176.6.54]:41601 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbfCAIEZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 1 Mar 2019 03:04:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C2545102784;
        Fri,  1 Mar 2019 09:04:21 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rEXMf2n_6J0R; Fri,  1 Mar 2019 09:04:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 297B4102785;
        Fri,  1 Mar 2019 09:04:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EE0-FqsOkH2q; Fri,  1 Mar 2019 09:04:17 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 00BEA102784;
        Fri,  1 Mar 2019 09:04:16 +0100 (CET)
Message-ID: <1c61f1ecc2c5c8738de298063c5278e9573e2709.camel@v3.sk>
Subject: Re: [PATCH 1/2] agetty: Fix input of non-ASCII characters in
 get_logname()
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Date:   Fri, 01 Mar 2019 09:04:15 +0100
In-Reply-To: <76fefdb8-0c24-338e-c0ef-9a5b707d1e0a@suse.cz>
References: <76fefdb8-0c24-338e-c0ef-9a5b707d1e0a@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, 2019-02-27 at 23:22 +0100, Stanislav Brabec wrote:
> As login supports non-ASCII characters in the logname, agetty should be
> consistent.
> 
> 8b58ffdd re-activated old and ASCII-only get_logname(), which restricted

A nit: please use this form to refer to other commits in commit
messages:

commit 8b58ffdd ('agetty: don't put the VC into canonical mode')

It improves readability.

> the input to ASCII only. As the code does not read whole characters,
> isascii(ascval) and isprint(ascval) returns nonsenses after entering a
> non-ASCII character.
> 
> As keyboard maps don't contain unprintable non-control characters, it
> seems to be relatively safe to remove both checks.
> 
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  term-utils/agetty.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 1a3ebc308..0ef8ba36d 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -2175,8 +2175,6 @@ static char *get_logname(struct issue *ie, struct options *op, struct termios *t
>  			case CTL('D'):
>  				exit(EXIT_SUCCESS);
>  			default:
> -				if (!isascii(ascval) || !isprint(ascval))
> -					break;
>  				if ((size_t)(bp - logname) >= sizeof(logname) - 1)
>  					log_err(_("%s: input overrun"), op->tty);
>  				if ((tp->c_lflag & ECHO) == 0)
> -- 
> 2.20.1
> 

