Return-Path: <SRS0=c2jh=RH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7A6C43381
	for <util-linux@archiver.kernel.org>; Mon,  4 Mar 2019 10:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9718820823
	for <util-linux@archiver.kernel.org>; Mon,  4 Mar 2019 10:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfCDKnk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:43:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfCDKnk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Mar 2019 05:43:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 960E0A779;
        Mon,  4 Mar 2019 10:43:39 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D43B1001DCA;
        Mon,  4 Mar 2019 10:43:38 +0000 (UTC)
Date:   Mon, 4 Mar 2019 11:43:35 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] last: do not use non-standard __UT_NAMESIZE
Message-ID: <20190304104335.gowswpwurkniy6yk@ws.net.home>
References: <808b43f44dd1d87ff4ee771503e97438f1d65660.1551461730.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <808b43f44dd1d87ff4ee771503e97438f1d65660.1551461730.git.ps@pks.im>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 04 Mar 2019 10:43:40 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Mar 01, 2019 at 06:35:49PM +0100, Patrick Steinhardt wrote:
> As there is no standardized define, we should just use `sizeof`.

I think sizeof is a good choice almost always ;-)

>  login-utils/last.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
