Return-Path: <SRS0=uN1w=XV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C7BC4360C
	for <util-linux@archiver.kernel.org>; Thu, 26 Sep 2019 13:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CD021A4A
	for <util-linux@archiver.kernel.org>; Thu, 26 Sep 2019 13:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfIZN6Y (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 26 Sep 2019 09:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfIZN6Y (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 26 Sep 2019 09:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1668610C0929;
        Thu, 26 Sep 2019 13:58:24 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42C685C221;
        Thu, 26 Sep 2019 13:58:22 +0000 (UTC)
Date:   Thu, 26 Sep 2019 15:58:20 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] docs: fix mixtyped constant.
Message-ID: <20190926135820.rbhoiesgg3qqit46@10.255.255.10>
References: <20190923212248.2972-1-andrius@stikonas.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190923212248.2972-1-andrius@stikonas.eu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 26 Sep 2019 13:58:24 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Sep 23, 2019 at 10:22:48PM +0100, Andrius Štikonas wrote:
>  libfdisk/src/iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
