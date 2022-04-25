Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54051C433EF
	for <util-linux@archiver.kernel.org>; Mon, 25 Apr 2022 13:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbiDYNrr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbiDYNrq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Apr 2022 09:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8A6F4A3EA
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650894279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aImn5Dt6V1IKHn938dKKKKjiUdJ6cFB7exSBShxRfhM=;
        b=ZF0qZp0ExnkUI7ixuEJJY3AdZXz3IiWIiUZbC/nps4rp3M4i1Ld38NaEoDMPfmM78IRc7t
        SRDBtzrpmnH5h50BOo82VA1ok/PT+BgN0f5Q2VyV9+EvK4YUSpFfVqdJb/JPYAguUtrmFf
        scDIPNlD9hf84aia6OmCW35EuHfo3WY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-zgxcva3iNhSv3CcZrSvdZA-1; Mon, 25 Apr 2022 09:44:38 -0400
X-MC-Unique: zgxcva3iNhSv3CcZrSvdZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D9C51C05129;
        Mon, 25 Apr 2022 13:44:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87B3F463E04;
        Mon, 25 Apr 2022 13:44:37 +0000 (UTC)
Date:   Mon, 25 Apr 2022 15:44:35 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Enze Li <lienze@kylinos.cn>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] eject: update file provenance of DRIVER_SENSE in the
 comments
Message-ID: <20220425134435.h5ezpkraf3u2vuhx@ws.net.home>
References: <20220420093701.868169-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420093701.868169-1-lienze@kylinos.cn>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 20, 2022 at 05:37:01PM +0800, Enze Li wrote:
>  sys-utils/eject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

