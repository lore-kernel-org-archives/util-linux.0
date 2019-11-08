Return-Path: <SRS0=EUsd=ZA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B200C5DF60
	for <util-linux@archiver.kernel.org>; Fri,  8 Nov 2019 10:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99032178F
	for <util-linux@archiver.kernel.org>; Fri,  8 Nov 2019 10:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWp/giki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfKHKSx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:18:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30670 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726149AbfKHKSx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 8 Nov 2019 05:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573208332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtigw+Inyr1RH779KI0w2xyzXHEyfS9czs5FNx4TW6U=;
        b=GWp/gikivA8ZI/CREXsyNxjPEhSSL/DrTrT2KwqtuR2zo9huSsEu3pJgFeKA0fQasTd9zQ
        RJcsCRynF47bpiyt0UDPrRVF3xd0cA6MTKFWYGAyxMo0RS0nUAYzzPrJP80o4MmthPD0PT
        1Q6AU3rpWUe37tlKW6mJVJDz5Fgsxs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-D5yaKqCSM4GFWcDEwocyRw-1; Fri, 08 Nov 2019 05:18:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0242C800C72
        for <util-linux@vger.kernel.org>; Fri,  8 Nov 2019 10:18:50 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 424CD1001B39;
        Fri,  8 Nov 2019 10:18:49 +0000 (UTC)
Date:   Fri, 8 Nov 2019 11:18:46 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Andrew Price <anprice@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] fallocate.1: List gfs2 as supporting punch-hole
Message-ID: <20191108101846.lbhr6gzwescn2yrz@10.255.255.10>
References: <20191031165144.1877-1-anprice@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191031165144.1877-1-anprice@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: D5yaKqCSM4GFWcDEwocyRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Oct 31, 2019 at 04:51:44PM +0000, Andrew Price wrote:
>  sys-utils/fallocate.1 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

