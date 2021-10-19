Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325DCC4332F
	for <util-linux@archiver.kernel.org>; Tue, 19 Oct 2021 09:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB5F6138F
	for <util-linux@archiver.kernel.org>; Tue, 19 Oct 2021 09:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhJSJlg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Oct 2021 05:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235172AbhJSJle (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Oct 2021 05:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634636361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVAgoR2cL91GH9OTqXotJc+OhMFPtq/9GbmZcYNmUsE=;
        b=PDFMdIAKXfFjuBYbgQs9coUTnhnvMDFrqmdbgbcmkLeQoe5yAWuclf/l7yl6+NxHEoQel2
        ygmvgHVQovFlNxTFxzu5hHB+PH5ABcgWlWlkh5xYjbOozoKSgF9FxBotk3+a3PGv6yxC0W
        hD9tFjmH6GVTBFqxMUl/cygfqf1Vd4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-5U1HzBOdMjuaQ_UHpcKaWA-1; Tue, 19 Oct 2021 05:39:17 -0400
X-MC-Unique: 5U1HzBOdMjuaQ_UHpcKaWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A33F210A8E04;
        Tue, 19 Oct 2021 09:39:16 +0000 (UTC)
Received: from ws.net.home (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC28319C59;
        Tue, 19 Oct 2021 09:39:15 +0000 (UTC)
Date:   Tue, 19 Oct 2021 11:39:13 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org, Mark Hindley <mark@hindley.org.uk>
Subject: Re: [PATCH] Fix test/misc/swaplabel failure due to change in mkswap
 behaviour.
Message-ID: <20211019093913.erewh2sqzm42aze4@ws.net.home>
References: <20211018175301.23636-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018175301.23636-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Oct 18, 2021 at 05:53:01PM +0000, Chris Hofstaedtler wrote:
>  tests/ts/misc/swaplabel | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

