Return-Path: <SRS0=DPLT=WP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164F5C3A5A0
	for <util-linux@archiver.kernel.org>; Mon, 19 Aug 2019 13:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC3A205C9
	for <util-linux@archiver.kernel.org>; Mon, 19 Aug 2019 13:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfHSNBA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:01:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15957 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfHSNBA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Aug 2019 09:01:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF91D190C110;
        Mon, 19 Aug 2019 13:00:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A7EE82F7D;
        Mon, 19 Aug 2019 13:00:58 +0000 (UTC)
Date:   Mon, 19 Aug 2019 15:00:56 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] wdctl: remove duplicate include of <unistd.h>
Message-ID: <20190819130056.gt3qqn4jwdwhcted@ws.net.home>
References: <1c54caa4c6e6643c149e968206c743f910902a94.1565870582.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c54caa4c6e6643c149e968206c743f910902a94.1565870582.git.ps@pks.im>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Mon, 19 Aug 2019 13:01:00 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Aug 15, 2019 at 02:03:23PM +0200, Patrick Steinhardt wrote:
>  sys-utils/wdctl.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
