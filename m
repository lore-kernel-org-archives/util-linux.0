Return-Path: <SRS0=BLRm=YK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E00ECE58E
	for <util-linux@archiver.kernel.org>; Thu, 17 Oct 2019 09:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDD52089C
	for <util-linux@archiver.kernel.org>; Thu, 17 Oct 2019 09:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfJQJCH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:02:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfJQJCG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 17 Oct 2019 05:02:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0C7E3084288;
        Thu, 17 Oct 2019 09:02:06 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B475C1B5;
        Thu, 17 Oct 2019 09:02:05 +0000 (UTC)
Date:   Thu, 17 Oct 2019 11:02:03 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Merlin =?utf-8?B?QsO8Z2U=?= <merlin.buege@tuhh.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] mount.8: small typo fixes
Message-ID: <20191017090203.gz6qaorczkisq6gt@10.255.255.10>
References: <20191017044522.130193-1-merlin.buege@tuhh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017044522.130193-1-merlin.buege@tuhh.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 17 Oct 2019 09:02:06 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Oct 17, 2019 at 06:45:22AM +0200, Merlin Büge wrote:
> ---
>  sys-utils/mount.8 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
