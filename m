Return-Path: <SRS0=SGaj=ND=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF8C46475
	for <util-linux@archiver.kernel.org>; Tue, 23 Oct 2018 09:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1577B2075D
	for <util-linux@archiver.kernel.org>; Tue, 23 Oct 2018 09:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1577B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJWSNF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:13:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWSNF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Oct 2018 14:13:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3660088308;
        Tue, 23 Oct 2018 09:50:26 +0000 (UTC)
Received: from ws.net.home (ovpn-116-198.ams2.redhat.com [10.36.116.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E72E60A98;
        Tue, 23 Oct 2018 09:50:25 +0000 (UTC)
Date:   Tue, 23 Oct 2018 11:50:22 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Masato Suzuki <masato.suzuki@wdc.com>
Cc:     util-linux@vger.kernel.org, Damien.LeMoal@wdc.com
Subject: Re: [PATCH] blkzone: fix report zones sector offset check
Message-ID: <20181023095022.oyje5gnh7osiwzcv@ws.net.home>
References: <20181023093135.13414-1-masato.suzuki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023093135.13414-1-masato.suzuki@wdc.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 23 Oct 2018 09:50:26 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Oct 23, 2018 at 06:31:35PM +0900, Masato Suzuki wrote:
>  sys-utils/blkzone.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
