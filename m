Return-Path: <SRS0=LCHA=5K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73789C43331
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 11:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DF220772
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 11:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUAvCnre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCYLK7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:10:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54776 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgCYLK7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 25 Mar 2020 07:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585134658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vViCe4cMzW1ybwAeI+f/qTrNXAyqrW3v05tbXWuCbcI=;
        b=KUAvCnreEp2nEj1ucgO0DcPogccRC37z1itr1nUYRkY/Q4uMKkudBStc/rxjkYXkZR89m2
        veeWOk5EoGf/4Q6N81D5G4mnNfIiUsv2LT9Tql36H48F0onbBZdLrzQ5hZLWDb8reBnGIL
        qkzGZkKLUOGxt5eH/KHwGX3n2MrJXug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-VKvaL0RwONOKlTP2ASgq_w-1; Wed, 25 Mar 2020 07:10:53 -0400
X-MC-Unique: VKvaL0RwONOKlTP2ASgq_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8774A107ACC4;
        Wed, 25 Mar 2020 11:10:52 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2B0219C70;
        Wed, 25 Mar 2020 11:10:51 +0000 (UTC)
Date:   Wed, 25 Mar 2020 12:10:49 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Aurelien LAJOIE <orel@melix.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: improve uuid_unparse() performance
Message-ID: <20200325111049.jypz2csy2hqxoegr@ws.net.home>
References: <20200324212625.6934-1-orel@melix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324212625.6934-1-orel@melix.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Mar 24, 2020 at 10:26:25PM +0100, Aurelien LAJOIE wrote:
> There is 2 improvements:
> 
>  * remove useless uuid_unpack,
>  * directly print the hexa format from memory without using printf
>    we can do this as the bytes order is the network byte order

I'm not sure, but are you sure that whole UUID is in big-endian order? 
I think that last part (aka "node", 6 bytes) is not subject to swapping. 
It seems uuid_unpack() does nothing with the last part of the UUID.

But your patch works on LE as well as on BE, so I probably miss
something :-)

> before took 382623 us
> after  took  36740 us
> 
> Big Endian OpenBSD:
> before took 3138172 us
> after  took  180116 us

I guess all this is about sprintf(), another way would be to use
uuid_unpack() but avoid sprintf().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

