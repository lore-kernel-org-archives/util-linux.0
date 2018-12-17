Return-Path: <SRS0=1kTP=O2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF6CC43387
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CF120675
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbeLQJrb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:47:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732057AbeLQJra (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Dec 2018 04:47:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DB65753EF;
        Mon, 17 Dec 2018 09:47:30 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.118.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 583F95D70A;
        Mon, 17 Dec 2018 09:47:29 +0000 (UTC)
Date:   Mon, 17 Dec 2018 10:47:26 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Sami Kerola <kerolasa@iki.fi>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] README: add link to mail list archive
Message-ID: <20181217094726.3kciiydz6kezto23@ws.net.home>
References: <20181215160540.27647-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215160540.27647-1-kerolasa@iki.fi>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 17 Dec 2018 09:47:30 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Dec 15, 2018 at 04:05:40PM +0000, Sami Kerola wrote:
> -      E-MAIL: util-linux@vger.kernel.org
> -      URL:    http://vger.kernel.org/vger-lists.html#util-linux
> +      E-MAIL:  util-linux@vger.kernel.org
> +      URL:     http://vger.kernel.org/vger-lists.html#util-linux
> +      ARCHIVE: https://lore.kernel.org/util-linux/

Good idea. Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
