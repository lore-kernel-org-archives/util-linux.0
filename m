Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04660C433F5
	for <util-linux@archiver.kernel.org>; Mon, 21 Feb 2022 11:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356091AbiBULXp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:23:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356096AbiBULX3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 21 Feb 2022 06:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B29102AC1
        for <util-linux@vger.kernel.org>; Mon, 21 Feb 2022 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645442233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dmJNjpF9iiDVMrokKnvH6AjswqGQpx+1S7ebn2ga+mQ=;
        b=QidkNOP5Q2kjUhYlBgVJR0DKcoSXEvDsmEG47MP/o8QYSIeOHJuVqaW+ZRzDxMwfun9wtS
        zhal+AbITkQhL5d9mow3rNpaq9+AqsG4RrqlkWe7/kD1t71cs5MFb5agI0cHD+s72saZ+1
        qyraAw+PHqyLzi8P+wbDwS2Rc+Mq5Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-ErVpYG-UMSydWbWXbCXICA-1; Mon, 21 Feb 2022 06:17:12 -0500
X-MC-Unique: ErVpYG-UMSydWbWXbCXICA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24980100C660;
        Mon, 21 Feb 2022 11:17:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 704891077D24;
        Mon, 21 Feb 2022 11:17:10 +0000 (UTC)
Date:   Mon, 21 Feb 2022 12:17:07 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Eric Estievenart <eric.estievenart@tecwec.eu>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg: handle colorization of emerg/notice/info/debug
 levels
Message-ID: <20220221111707.ol2vnl5ewjmhv75h@ws.net.home>
References: <465e6a29-ddae-2df5-647b-42abcb672034@tecwec.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465e6a29-ddae-2df5-647b-42abcb672034@tecwec.eu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Feb 18, 2022 at 10:43:54PM +0100, Eric Estievenart wrote:
> Hello,
> please find attached a very simple patch which allows consistent customization
> of the coloring schemes  of the emerg, notice, info and debug levels in dmesg.
> (currently only alert, crit, err and warn coloring schemes could be customized).

Already merged from Github PR. Thanks!

> Regards, Thanks & Happy new year, if not too late.

Never is too late ;-)

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

