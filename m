Return-Path: <SRS0=jXkZ=NX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48581C43441
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 10:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163C42087A
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 10:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163C42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeKLUcn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:32:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbeKLUcn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Nov 2018 15:32:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C11A3001E64;
        Mon, 12 Nov 2018 10:40:04 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8DC85D9D6;
        Mon, 12 Nov 2018 10:40:03 +0000 (UTC)
Date:   Mon, 12 Nov 2018 11:40:00 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: fix detection of dm-integrity superblock
Message-ID: <20181112104000.p45hlinurl4hv5l6@ws.net.home>
References: <20181107114837.12075-1-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107114837.12075-1-gmazyland@gmail.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 12 Nov 2018 10:40:04 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 07, 2018 at 12:48:37PM +0100, Milan Broz wrote:
>  libblkid/src/superblocks/lvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
