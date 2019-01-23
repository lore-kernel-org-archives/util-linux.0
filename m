Return-Path: <SRS0=H3Yc=P7=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F9C282C2
	for <util-linux@archiver.kernel.org>; Wed, 23 Jan 2019 11:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8219220870
	for <util-linux@archiver.kernel.org>; Wed, 23 Jan 2019 11:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfAWLYb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:24:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbfAWLYb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 23 Jan 2019 06:24:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4A9912039;
        Wed, 23 Jan 2019 11:24:30 +0000 (UTC)
Received: from ws.net.home (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF3266BF64;
        Wed, 23 Jan 2019 11:24:29 +0000 (UTC)
Date:   Wed, 23 Jan 2019 12:24:22 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Johannes Nixdorf <mixi@shadowice.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: fix crypt() detection without -lcrypt
Message-ID: <20190123112422.jklg3lyalqsqpncr@ws.net.home>
References: <20190122181755.2234-1-mixi@shadowice.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122181755.2234-1-mixi@shadowice.org>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 23 Jan 2019 11:24:30 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jan 22, 2019 at 07:17:55PM +0100, Johannes Nixdorf wrote:
>  configure.ac | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
