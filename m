Return-Path: <SRS0=lvf1=NN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4321DC32789
	for <util-linux@archiver.kernel.org>; Fri,  2 Nov 2018 08:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4E92082E
	for <util-linux@archiver.kernel.org>; Fri,  2 Nov 2018 08:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4E92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeKBRjG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:39:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18685 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKBRjG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 2 Nov 2018 13:39:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17E2D4E916;
        Fri,  2 Nov 2018 08:32:45 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 128CE60FE6;
        Fri,  2 Nov 2018 08:32:43 +0000 (UTC)
Date:   Fri, 2 Nov 2018 09:32:41 +0100
From:   Karel Zak <kzak@redhat.com>
To:     justinpopo6@gmail.com
Cc:     util-linux@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH] rtcwake: use poweroff if shutdown is not found
Message-ID: <20181102083241.it5zhn3zgokgp7ys@ws.net.home>
References: <1541095838-3816-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541095838-3816-1-git-send-email-justinpopo6@gmail.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 02 Nov 2018 08:32:45 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Nov 01, 2018 at 11:10:38AM -0700, justinpopo6@gmail.com wrote:
>  include/pathnames.h |  1 +
>  sys-utils/rtcwake.c | 39 +++++++++++++++++++++++++++------------
>  2 files changed, 28 insertions(+), 12 deletions(-)

 Seems good. I'll merge it after v2.33 release (Mon/Thu next week).
 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
