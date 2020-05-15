Return-Path: <SRS0=YmJi=65=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B010DC433E1
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 12:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CCB02074D
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 12:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUjLf5Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOM61 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 May 2020 08:58:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55318 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726162AbgEOM61 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 May 2020 08:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589547506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2BDNYO5yaD0XYKzStCslC+qfTqVdngkZBwJUGe9UyRo=;
        b=FUjLf5KeiBwEqfm3oLzXVS6iRQdNnkD1SllLJ1+CctnifdZdlmvUPk8DHIeo1akiVhtpXR
        Lr5b8v90M5sqEyBWKmP3vz1iRsCgEDkxtLceP8NLVC53Rbf8fBGCSN5XKZnMITbam5HOp2
        A+jK3J8oSTUDobmByFvwLxhWA/XwruQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-GWHEaeOwPsOHfGEpUCmyKA-1; Fri, 15 May 2020 08:58:22 -0400
X-MC-Unique: GWHEaeOwPsOHfGEpUCmyKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58503107ACCD;
        Fri, 15 May 2020 12:58:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2949F10002CD;
        Fri, 15 May 2020 12:58:19 +0000 (UTC)
Date:   Fri, 15 May 2020 14:58:16 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     util-linux@vger.kernel.org, Coly Li <colyli@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] blkzone: deny destructive ioctls on busy blockdev
Message-ID: <20200515125816.2lyw4f3pg54npv6y@ws.net.home>
References: <20200515084133.21896-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515084133.21896-1-johannes.thumshirn@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, May 15, 2020 at 05:41:33PM +0900, Johannes Thumshirn wrote:
>  sys-utils/blkzone.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

> +	fd = init_device(ctl, O_WRONLY | O_EXCL);
> +	if (fd < 0)
> +		errx(EXIT_FAILURE, _("%s: unable to open"), ctl->devname);

I have removed this error message. It's already within init_device().

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

