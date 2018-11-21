Return-Path: <SRS0=M2R7=OA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25225C43441
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 09:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92B92145D
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 09:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92B92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeKUUaV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:30:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbeKUUaV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Nov 2018 15:30:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C3F03084030;
        Wed, 21 Nov 2018 09:56:34 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78CB982728;
        Wed, 21 Nov 2018 09:56:33 +0000 (UTC)
Date:   Wed, 21 Nov 2018 10:56:30 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Roland Kammerer <roland.kammerer@linbit.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] libblkid: add check for DRBD9
Message-ID: <20181121095630.2n4libom7nz3qh32@ws.net.home>
References: <20181120161049.5687-1-roland.kammerer@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120161049.5687-1-roland.kammerer@linbit.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 21 Nov 2018 09:56:34 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 20, 2018 at 05:10:49PM +0100, Roland Kammerer wrote:
>  libblkid/src/superblocks/drbd.c | 111 ++++++++++++++++++++++++++++++--
>  1 file changed, 107 insertions(+), 4 deletions(-)

Applied, thanks!

It would be nice to have DRBD test images in tests/ts/blkid/images-fs/, 
so on 

    ./tests/run.sh blkid

we will see if DRBD probing code works as expected :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
