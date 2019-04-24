Return-Path: <SRS0=0AAi=S2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CDBC10F11
	for <util-linux@archiver.kernel.org>; Wed, 24 Apr 2019 09:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED5B20878
	for <util-linux@archiver.kernel.org>; Wed, 24 Apr 2019 09:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDXJe6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:34:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfDXJe6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Apr 2019 05:34:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E70730B4A68;
        Wed, 24 Apr 2019 09:34:58 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCFC75C220;
        Wed, 24 Apr 2019 09:34:56 +0000 (UTC)
Date:   Wed, 24 Apr 2019 11:34:54 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     util-linux@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] fstrim: document kernel return minlen explicitly
Message-ID: <20190424093454.poidjbho2wmyyveh@ws.net.home>
References: <1556031508-18850-1-git-send-email-wshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556031508-18850-1-git-send-email-wshilong1991@gmail.com>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 24 Apr 2019 09:34:58 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Apr 23, 2019 at 11:58:28PM +0900, Wang Shilong wrote:
>  sys-utils/fstrim.8 | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
