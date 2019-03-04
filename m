Return-Path: <SRS0=c2jh=RH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B22C43381
	for <util-linux@archiver.kernel.org>; Mon,  4 Mar 2019 10:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BECC206B8
	for <util-linux@archiver.kernel.org>; Mon,  4 Mar 2019 10:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfCDKka (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:40:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfCDKka (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Mar 2019 05:40:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94862C049D7F;
        Mon,  4 Mar 2019 10:40:30 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EBB56013A;
        Mon,  4 Mar 2019 10:40:29 +0000 (UTC)
Date:   Mon, 4 Mar 2019 11:40:27 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] agetty: Switch to 8-bit processing in get_logname()
 for UTF-8 terminals
Message-ID: <20190304104027.qsi22hustreiut4d@ws.net.home>
References: <938cb4db-f24a-4498-27f7-8b6f7180c2a2@suse.cz>
 <fc355e625d959e42309f689d1f1716122deb55b1.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc355e625d959e42309f689d1f1716122deb55b1.camel@v3.sk>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 04 Mar 2019 10:40:30 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Mar 01, 2019 at 09:04:54AM +0100, Lubomir Rintel wrote:
> Tested-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks!

> >  term-utils/agetty.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
