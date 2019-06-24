Return-Path: <SRS0=Vkmh=UX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE54C43613
	for <util-linux@archiver.kernel.org>; Mon, 24 Jun 2019 07:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9B620674
	for <util-linux@archiver.kernel.org>; Mon, 24 Jun 2019 07:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFXHXH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:23:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFXHXH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Jun 2019 03:23:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0245459467;
        Mon, 24 Jun 2019 07:23:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4547A5D739;
        Mon, 24 Jun 2019 07:23:06 +0000 (UTC)
Date:   Mon, 24 Jun 2019 09:23:03 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] losetup: Typo fix
Message-ID: <20190624072303.55m2afn4ymniata3@ws.net.home>
References: <20b2d7d0-4b09-b1d6-49b9-f114b8bd944c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20b2d7d0-4b09-b1d6-49b9-f114b8bd944c@suse.cz>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 24 Jun 2019 07:23:07 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jun 20, 2019 at 11:41:30PM +0200, Stanislav Brabec wrote:
>  sys-utils/losetup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
