Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7788DC433B4
	for <util-linux@archiver.kernel.org>; Tue, 13 Apr 2021 08:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475686135C
	for <util-linux@archiver.kernel.org>; Tue, 13 Apr 2021 08:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbhDMIxU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243793AbhDMIxT (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Apr 2021 04:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618303980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3uQECxtK2TCk7bFYuabOFVXcyyIlsDTMAZhVdEaR1P0=;
        b=YRJba+oVunF+bE/yg89vn4JinUNh5a2sxBwkCqplbAgwCozxFp4Iu3SZ0WarLkmcx05FKB
        L4zcgrnEDgTzggmTnEIEbKXEGQsrZJHRFJto7aJelRCFU1VoTi6hEh/Qir6HktnWv7CRpn
        NEwLZnIlENADI9AWYGVnAAO/2p4PpnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-i3oxuzb9MneRQA1v8PXEwQ-1; Tue, 13 Apr 2021 04:52:55 -0400
X-MC-Unique: i3oxuzb9MneRQA1v8PXEwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7F858030A0;
        Tue, 13 Apr 2021 08:52:54 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 415781C952;
        Tue, 13 Apr 2021 08:52:54 +0000 (UTC)
Date:   Tue, 13 Apr 2021 10:52:51 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] hexdump: add "hd" program name to man page
Message-ID: <20210413085251.dseuq6wmgy4ea2ky@ws.net.home>
References: <20210412154926.2039689-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412154926.2039689-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Apr 12, 2021 at 03:49:26PM +0000, Chris Hofstaedtler wrote:
>  text-utils/hexdump.1.adoc | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

