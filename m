Return-Path: <SRS0=n+tz=V2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14954C7618B
	for <util-linux@archiver.kernel.org>; Mon, 29 Jul 2019 08:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8BB206E0
	for <util-linux@archiver.kernel.org>; Mon, 29 Jul 2019 08:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfG2If5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:35:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfG2If5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 29 Jul 2019 04:35:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6617630862BE;
        Mon, 29 Jul 2019 08:35:57 +0000 (UTC)
Received: from ws.net.home (ovpn-204-180.brq.redhat.com [10.40.204.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DF5F601A3;
        Mon, 29 Jul 2019 08:35:55 +0000 (UTC)
Date:   Mon, 29 Jul 2019 10:35:53 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Yousong Zhou <yszhou4tech@gmail.com>
Cc:     util-linux@vger.kernel.org,
        Yousong Zhou <zhouyousong@yunionyun.com>,
        Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH v2] column: fix outputing empty column at the end of line
Message-ID: <20190729083553.cxwrlbqnmqvjngky@ws.net.home>
References: <20190729012429.55953-1-zhouyousong@yunionyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729012429.55953-1-zhouyousong@yunionyun.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 29 Jul 2019 08:35:57 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jul 29, 2019 at 01:24:29AM +0000, Yousong Zhou wrote:
>  tests/expected/column/table-empty-column-at-eol  | 1 +
>  tests/expected/column/table-empty-column-at-eol2 | 1 +
>  tests/ts/column/table                            | 8 ++++++++
>  text-utils/column.c                              | 2 +-
>  4 files changed, 11 insertions(+), 1 deletion(-)
>  create mode 100644 tests/expected/column/table-empty-column-at-eol
>  create mode 100644 tests/expected/column/table-empty-column-at-eol2

Applied, thanks! (and sorry for delay)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
