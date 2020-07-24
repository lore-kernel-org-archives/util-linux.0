Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_C,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F73CC433DF
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24556206D8
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 16:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGXQck (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:32:40 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:41376
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXQck (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 12:32:40 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcuu-util-linux-ng-3@m.gmane-mx.org>)
        id 1jz0ch-000A6l-Af
        for util-linux@vger.kernel.org; Fri, 24 Jul 2020 18:32:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     util-linux@vger.kernel.org
From:   <nunojsilva@ist.utl.pt> (Nuno Silva)
Subject: Re: [PATCH 04/12] Manual pages: sfdisk.8: Minor wording and formatting fixes
Date:   Fri, 24 Jul 2020 17:32:33 +0100
Message-ID: <rff2f1$77s$2@ciao.gmane.io>
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
        <20200724100618.584918-4-mtk.manpages@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2020-07-24, Michael Kerrisk (man-pages) wrote:

> Signed-off-by: Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com>
> ---
>  disk-utils/sfdisk.8 | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
> index 6c3f62edd..6c54a1699 100644
> --- a/disk-utils/sfdisk.8
> +++ b/disk-utils/sfdisk.8
[...]
> @@ -601,7 +615,9 @@ The welcome message.
>  
>  .SH ENVIRONMENT
>  .IP SFDISK_DEBUG=all
> -enables sfdisk debug output.
> +enablescw

And here "enables", not "enablescw"?

-- 
Nuno Silva

