Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F496C3A5A4
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 12:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F75A22CE3
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 12:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfHWMAl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388685AbfHWMAk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 08:00:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4736693C8;
        Fri, 23 Aug 2019 12:00:39 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EE265F7F6;
        Fri, 23 Aug 2019 12:00:37 +0000 (UTC)
Date:   Fri, 23 Aug 2019 14:00:24 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2] include/closestream: fix assignment to read-only
 standard streams
Message-ID: <20190823120024.owduc5lcing3hacr@10.255.255.10>
References: <cover.1565800625.git.ps@pks.im>
 <3e5f8ff67edc6ae34ff67124c956a71dcf49ea98.1566466780.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5f8ff67edc6ae34ff67124c956a71dcf49ea98.1566466780.git.ps@pks.im>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 23 Aug 2019 12:00:40 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Aug 22, 2019 at 11:40:15AM +0200, Patrick Steinhardt wrote:
> Note that both `close_stdout` and `close_stdout_atexit` are misnamed
> after this change, as we do not actually close the streams now. In order
> to avoid unnecessary code churn, we still retain their current names.

Yes, it would be nice to rename it later to something like
"flush_stdstreams" or "verify_stdstreams" or so...

>  include/closestream.h | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)

Looks good. I'll apply the patch later (let's wait for another reviews).

And it seems we can remove 

    #if !defined(__SANITIZE_ADDRESS__)

from the code now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
