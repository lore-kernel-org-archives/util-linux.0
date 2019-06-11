Return-Path: <SRS0=jsgS=UK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757B6C4321A
	for <util-linux@archiver.kernel.org>; Tue, 11 Jun 2019 09:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EE3208E3
	for <util-linux@archiver.kernel.org>; Tue, 11 Jun 2019 09:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfFKJYN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfFKJYN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 11 Jun 2019 05:24:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82D92307D84D;
        Tue, 11 Jun 2019 09:24:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C13005D704;
        Tue, 11 Jun 2019 09:24:12 +0000 (UTC)
Date:   Tue, 11 Jun 2019 11:24:10 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] fstrim: Fix fstrim_all() comment
Message-ID: <20190611092410.vl5ekwjwcvcpnlra@ws.net.home>
References: <787f49bd-0f57-5616-ca10-2173c3801809@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787f49bd-0f57-5616-ca10-2173c3801809@suse.cz>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 11 Jun 2019 09:24:13 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 10, 2019 at 09:59:21PM +0200, Stanislav Brabec wrote:
>  sys-utils/fstrim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All three patches applied. I did some small additional change to the
code and to the man page.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
