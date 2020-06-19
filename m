Return-Path: <SRS0=jjIi=AA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84853C433DF
	for <util-linux@archiver.kernel.org>; Fri, 19 Jun 2020 08:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D06A207FC
	for <util-linux@archiver.kernel.org>; Fri, 19 Jun 2020 08:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbMJBL+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgFSIIr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:08:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54602 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730924AbgFSIIh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 19 Jun 2020 04:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592554116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQbHpI8ElgAbgbNpQyycKH4sacjtDi3/JxMzQXEJ4gI=;
        b=WbMJBL+NFeqjn/IETXWK3LshM7cyjWojPnJt9BAfUp3t6DeB7wgaToHIF+D9OMJpJyXHty
        wJU/SBYs5TcUz7e1wGytP55s9SMDOCS4/gddQx2u17HNVjV3G4++hahMGa88FE6JuzNl42
        4iaXdN7o4ynXpNwn6buBx4Cw+CVEygM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-BZ3YYIWRO1y279Imu3IC6A-1; Fri, 19 Jun 2020 04:08:31 -0400
X-MC-Unique: BZ3YYIWRO1y279Imu3IC6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9FA7107ACF4
        for <util-linux@vger.kernel.org>; Fri, 19 Jun 2020 08:08:30 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 238285BAC3;
        Fri, 19 Jun 2020 08:08:29 +0000 (UTC)
Date:   Fri, 19 Jun 2020 10:08:27 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Rupesh Girase <rgirase@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Manual pages: losetup.8: Fix "--direct-io" defaults
Message-ID: <20200619080827.ljcu5mwurwvxz2xw@ws.net.home>
References: <1592488061-1868-1-git-send-email-rgirase@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592488061-1868-1-git-send-email-rgirase@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jun 18, 2020 at 07:17:41PM +0530, Rupesh Girase wrote:
>  sys-utils/losetup.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

