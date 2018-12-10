Return-Path: <SRS0=pu0z=OT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56961C04EB8
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 11:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263A620880
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 11:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263A620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeLJLsf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:48:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbeLJLsf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Dec 2018 06:48:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 778DF308A974;
        Mon, 10 Dec 2018 11:48:35 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1800600D6;
        Mon, 10 Dec 2018 11:48:34 +0000 (UTC)
Date:   Mon, 10 Dec 2018 12:48:32 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Seth Girvan <snth@snthhacks.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: fix man page typos
Message-ID: <20181210114832.xzgeo6ywi4p4yapp@ws.net.home>
References: <20181207100200.23361-1-snth@snthhacks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207100200.23361-1-snth@snthhacks.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 10 Dec 2018 11:48:35 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Dec 07, 2018 at 02:02:00AM -0800, Seth Girvan wrote:
>  libuuid/man/uuid.3          |  4 ++--
>  libuuid/man/uuid_generate.3 | 10 +++++-----
>  libuuid/man/uuid_parse.3    |  4 ++--
>  libuuid/man/uuid_unparse.3  |  2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
