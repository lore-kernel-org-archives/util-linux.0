Return-Path: <SRS0=M2R7=OA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134B4C43441
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 09:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91CE2146F
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 09:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91CE2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeKUUYd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:24:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21429 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeKUUYd (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Nov 2018 15:24:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 473DE30821E3;
        Wed, 21 Nov 2018 09:50:47 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8883182792;
        Wed, 21 Nov 2018 09:50:46 +0000 (UTC)
Date:   Wed, 21 Nov 2018 10:50:44 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Andreas Henriksson <andreas@fatal.se>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix hidding typo
Message-ID: <20181121095044.pq5dkde4xtokpgkn@ws.net.home>
References: <20181112195023.20746-1-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112195023.20746-1-andreas@fatal.se>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 21 Nov 2018 09:50:47 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Nov 12, 2018 at 08:50:23PM +0100, Andreas Henriksson wrote:
>  libblkid/src/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
