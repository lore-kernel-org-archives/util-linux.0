Return-Path: <SRS0=z4qa=QZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A3EC43381
	for <util-linux@archiver.kernel.org>; Mon, 18 Feb 2019 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD8E2184E
	for <util-linux@archiver.kernel.org>; Mon, 18 Feb 2019 12:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfBRMFx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:05:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbfBRMFx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Feb 2019 07:05:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD4E381F13;
        Mon, 18 Feb 2019 12:05:52 +0000 (UTC)
Received: from ws.net.home (ovpn-204-99.brq.redhat.com [10.40.204.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEB3A600C8;
        Mon, 18 Feb 2019 12:05:51 +0000 (UTC)
Date:   Mon, 18 Feb 2019 13:05:48 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Fabian.Kirsch@dlr.de
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] sanity check, to prevent overlapping partitions from
 being partly reported as free
Message-ID: <20190218120548.krvrzrrswundtu2q@ws.net.home>
References: <1550069424.28515.10.camel@dlr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550069424.28515.10.camel@dlr.de>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 18 Feb 2019 12:05:53 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Feb 13, 2019 at 02:49:10PM +0000, Fabian.Kirsch@dlr.de wrote:
>  libfdisk/src/table.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
