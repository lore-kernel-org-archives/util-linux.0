Return-Path: <SRS0=z4qa=QZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32589C43381
	for <util-linux@archiver.kernel.org>; Mon, 18 Feb 2019 12:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098D2218FC
	for <util-linux@archiver.kernel.org>; Mon, 18 Feb 2019 12:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfBRMGV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:06:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbfBRMGV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Feb 2019 07:06:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5BABF78EAB;
        Mon, 18 Feb 2019 12:06:21 +0000 (UTC)
Received: from ws.net.home (ovpn-204-99.brq.redhat.com [10.40.204.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 972415D70A;
        Mon, 18 Feb 2019 12:06:20 +0000 (UTC)
Date:   Mon, 18 Feb 2019 13:06:18 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Tobias Stoeckmann <tobias@stoeckmann.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] sfdisk: Avoid out of boundary read with readline
Message-ID: <20190218120618.hyegbhkdbdxhjs4a@ws.net.home>
References: <20190217215529.zh3rn57hqu7rruze@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217215529.zh3rn57hqu7rruze@localhost>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 18 Feb 2019 12:06:21 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Feb 17, 2019 at 10:55:29PM +0100, Tobias Stoeckmann wrote:
>  disk-utils/sfdisk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
