Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCEFC43334
	for <util-linux@archiver.kernel.org>; Fri, 22 Jul 2022 14:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiGVOkT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 22 Jul 2022 10:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiGVOkR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 22 Jul 2022 10:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 429A3A447
        for <util-linux@vger.kernel.org>; Fri, 22 Jul 2022 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658500815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTm7LfgcXAp5HeuKscypOpKP6m2cq6kyX3NaQ7e+FH4=;
        b=cfaNIgXxEa17ZSKIXX0JeKYHXQrmDfIAwAQYIDvD8APz+mrHp7tKEgW/3su1o9KDYEvcpj
        /GbctaYx1w7sHQie1Q/+JtGHmpi34uYyj5GvNG2eNWzqXFsBm/cPzpiRR13xu3/iZbqjEd
        jItQFWwJlvY6Xt6KKcDeppLXSyuQMAc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-s_y5SES1NWGmTs4g8V0xdw-1; Fri, 22 Jul 2022 10:40:14 -0400
X-MC-Unique: s_y5SES1NWGmTs4g8V0xdw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF076185A7A4
        for <util-linux@vger.kernel.org>; Fri, 22 Jul 2022 14:40:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63F05492C3B
        for <util-linux@vger.kernel.org>; Fri, 22 Jul 2022 14:40:13 +0000 (UTC)
Date:   Fri, 22 Jul 2022 16:40:11 +0200
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: Re: v2.38.1 tomorrow
Message-ID: <20220722144011.z2xpl2i4by5tw7zn@ws.net.home>
References: <20220721082323.64swgexwrrbfpcne@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721082323.64swgexwrrbfpcne@ws.net.home>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jul 21, 2022 at 10:23:23AM +0200, Karel Zak wrote:
>  see and try stable/v2.38 branch
>  https://github.com/util-linux/util-linux/tree/stable/v2.38
> 
>  This is what I want to release tomorrow as stable v2.38.1.

I have to put it off for a week as I'm going to be offline for the
next week.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

