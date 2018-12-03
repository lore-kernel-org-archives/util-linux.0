Return-Path: <SRS0=GAnL=OM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C464C04EB9
	for <util-linux@archiver.kernel.org>; Mon,  3 Dec 2018 10:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42D820851
	for <util-linux@archiver.kernel.org>; Mon,  3 Dec 2018 10:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42D820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbeLCKXe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:23:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbeLCKXe (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Dec 2018 05:23:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 331773082E4D;
        Mon,  3 Dec 2018 10:23:09 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 811F1690E3;
        Mon,  3 Dec 2018 10:23:07 +0000 (UTC)
Date:   Mon, 3 Dec 2018 11:23:04 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Ruediger Meier <sweet_f_a@gmx.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] include/c: re-add type checking in container_of()
Message-ID: <20181203102304.xjslwg5e7rndfx7i@ws.net.home>
References: <20181202182345.3508-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202182345.3508-1-sweet_f_a@gmx.de>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 03 Dec 2018 10:23:09 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Dec 02, 2018 at 07:23:45PM +0100, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> This reverts parts of commit eb06d5d4, which seems to be based on
> Linux kernel commit c7acec71. Unlike the original kernel patch we did
> not add that even stronger type checking by using macro BUILD_BUG_ON_MSG.
> So basically we removed a useful warning when compiling such
> broken code:
> 
>       struct st {
>             int a;
>             char b;
>       };
>       struct st t = { .a = 1, .b = 2 };
>       struct st *x = container_of(&t.a, struct st, b);
>       printf("%p %p\n", (void *)&t, (void *)x);
> 
> Moreover we also introduced a new compiler warning for intel/icc:
>    "arithmetic on pointer to void or function type"
> 
> Let's just revert the update of container_of() because adding a
> kernel-like BUILD_BUG_ON_MSG would be too much noise and also
> problematic (see kernel commit c03567a8). Also note that the original
> problem addressed by the kernel commit seems to be only reproducible
> with gcc 4.9, not with any later gcc nor clang,icc. Moreover, currently
> we have no such use-case in the UL sources anyways.

Interesting, I do not see any issue with list_entry(() now ;-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
