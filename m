Return-Path: <SRS0=1Am0=PQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5990BC43387
	for <util-linux@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8692087E
	for <util-linux@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfAHNvl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:51:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbfAHNvl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 8 Jan 2019 08:51:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A8D488314;
        Tue,  8 Jan 2019 13:51:41 +0000 (UTC)
Received: from ws.net.home (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C5745D756;
        Tue,  8 Jan 2019 13:51:39 +0000 (UTC)
Date:   Tue, 8 Jan 2019 14:51:37 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Carlos Santos <casantos@datacom.com.br>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] utmpdump: fix word swapping in manual page
Message-ID: <20190108135137.yiuiziylpxqpahzk@ws.net.home>
References: <20190107193234.9442-1-casantos@datacom.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107193234.9442-1-casantos@datacom.com.br>
User-Agent: NeoMutt/20180716-1022-6b9065-dirty
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 08 Jan 2019 13:51:41 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 07, 2019 at 05:32:34PM -0200, Carlos Santos wrote:
>  login-utils/utmpdump.1 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
