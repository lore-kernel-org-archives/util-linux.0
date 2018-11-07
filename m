Return-Path: <SRS0=MPMV=NS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645E0C0044C
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372A12085B
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 13:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372A12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeKGWtc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:49:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeKGWtc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Nov 2018 17:49:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 749DC30820C8;
        Wed,  7 Nov 2018 13:19:11 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CB9C60190;
        Wed,  7 Nov 2018 13:19:10 +0000 (UTC)
Date:   Wed, 7 Nov 2018 14:19:07 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Christian Hesse <list@eworm.de>
Cc:     util-linux@vger.kernel.org, Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] agetty: fix output of escaped characters
Message-ID: <20181107131907.t5nhg53thr4svkic@ws.net.home>
References: <20181107134217.2fe72a87@leda>
 <20181107125506.8432-1-list@eworm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107125506.8432-1-list@eworm.de>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 07 Nov 2018 13:19:11 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 07, 2018 at 01:55:06PM +0100, Christian Hesse wrote:
> From: Christian Hesse <mail@eworm.de>
> 
> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---
>  term-utils/agetty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 05a269abb..b9f08728e 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -2755,7 +2755,7 @@ static void output_special_char(struct issue *ie,
>  		break;
>  	}
>  	default:
> -		putchar(c);
> +		putc(c, ie->output);
>  		break;

Seems we need 2.33.1 ASAP.

(by the way this bug is also in v2.33-rc2, unfortunately badly tested...)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
