Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE76FC433ED
	for <util-linux@archiver.kernel.org>; Mon, 12 Apr 2021 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9092C61287
	for <util-linux@archiver.kernel.org>; Mon, 12 Apr 2021 14:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbhDLOX1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 12 Apr 2021 10:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237789AbhDLOXY (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Apr 2021 10:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618237386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tod/RbZQjNj9uIO3rFHLvh9NAuAf9FIy9dDi2IG/WQU=;
        b=hW0q1giIgOmVh9tvErMxlSwKIFgLgYVbDKEtdF4LaJgUB8pDJG1aiX+VNmQDf1X035Nt2W
        qoDnkRJ2HTuVo1g2/YqDjiAal+FfM3fFFsdk8YW3hHVUemCx2IK+0BzXq9cBEa7TjQtMNT
        EtLJ6S2cAuF0b4WkapuXun80sj9c/NQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-GRFOQvHjMWqtHS15zib3jg-1; Mon, 12 Apr 2021 10:23:04 -0400
X-MC-Unique: GRFOQvHjMWqtHS15zib3jg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240C5107ACE3;
        Mon, 12 Apr 2021 14:23:03 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 752C35D9DE;
        Mon, 12 Apr 2021 14:23:02 +0000 (UTC)
Date:   Mon, 12 Apr 2021 16:22:59 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.37-rc1
Message-ID: <20210412142259.tockaqoqcsgre7ns@ws.net.home>
References: <20210412103020.aoimejwj5y7aoe4o@ws.net.home>
 <20210412111528.2xormz5rbn7d7k7s@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412111528.2xormz5rbn7d7k7s@begin>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Apr 12, 2021 at 01:15:28PM +0200, Samuel Thibault wrote:
> I have attached a fix.

Applied with some changes, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

