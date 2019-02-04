Return-Path: <SRS0=Bpzm=QL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8D8C282C4
	for <util-linux@archiver.kernel.org>; Mon,  4 Feb 2019 14:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F92C2082F
	for <util-linux@archiver.kernel.org>; Mon,  4 Feb 2019 14:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfBDOHl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:07:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfBDOHl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Feb 2019 09:07:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9526A552C7;
        Mon,  4 Feb 2019 14:07:41 +0000 (UTC)
Received: from ws.net.home (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D247C6C77A;
        Mon,  4 Feb 2019 14:07:40 +0000 (UTC)
Date:   Mon, 4 Feb 2019 15:07:38 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: (gpt) add HiFive Unleashed bootloader
 partition UUIDs
Message-ID: <20190204140738.q6o36lfyappraxlj@ws.net.home>
References: <20190124103334.51808-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124103334.51808-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 04 Feb 2019 14:07:41 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jan 24, 2019 at 06:33:34PM +0800, Icenowy Zheng wrote:
>  libfdisk/src/gpt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
