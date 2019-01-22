Return-Path: <SRS0=jsub=P6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C71C282C3
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 11:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EE820879
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 11:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfAVLCw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:02:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfAVLCw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 22 Jan 2019 06:02:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53A6090919;
        Tue, 22 Jan 2019 11:02:52 +0000 (UTC)
Received: from ws.net.home (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84A766013B;
        Tue, 22 Jan 2019 11:02:51 +0000 (UTC)
Date:   Tue, 22 Jan 2019 12:02:48 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] setarch: don't return address of automatic variable
Message-ID: <20190122110248.ekqqg3xjn5g2rhh6@ws.net.home>
References: <87imyk9tqv.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imyk9tqv.fsf@igel.home>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 22 Jan 2019 11:02:52 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jan 19, 2019 at 11:18:16PM +0100, Andreas Schwab wrote:
>  sys-utils/setarch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
