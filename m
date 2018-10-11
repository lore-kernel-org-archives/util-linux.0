Return-Path: <SRS0=Y62r=MX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66C6C32788
	for <util-linux@archiver.kernel.org>; Thu, 11 Oct 2018 12:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C332205C9
	for <util-linux@archiver.kernel.org>; Thu, 11 Oct 2018 12:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C332205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeJKT17 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:27:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJKT17 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 11 Oct 2018 15:27:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 988E0A0C4B;
        Thu, 11 Oct 2018 12:01:04 +0000 (UTC)
Received: from ws.net.home (ovpn-117-176.ams2.redhat.com [10.36.117.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A55A66A1B;
        Thu, 11 Oct 2018 12:01:03 +0000 (UTC)
Date:   Thu, 11 Oct 2018 14:01:01 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] agetty: rename variable changed to triggered
Message-ID: <20181011120101.hs7tjlw2smnxlswj@ws.net.home>
References: <b5c097e3-84ad-d681-38c9-50c9a0a33b23@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c097e3-84ad-d681-38c9-50c9a0a33b23@suse.cz>
User-Agent: NeoMutt/20180716-423-e60b71
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 11 Oct 2018 12:01:04 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Oct 10, 2018 at 07:26:21PM +0200, Stanislav Brabec wrote:
>  term-utils/agetty.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
