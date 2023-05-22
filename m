Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8219EC77B75
	for <util-linux@archiver.kernel.org>; Mon, 22 May 2023 15:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjEVPen (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 May 2023 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjEVPel (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 May 2023 11:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B621E0
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684769635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5a3yRd3ZTpfsd48uNfkM0idBoGVzUNJ3Wt0xIqXrB2o=;
        b=UJKue/kv6oKl0ERC7G+tlHi0xFTVCPvSBmjUL63Evx1riYNXb7h49c+hpoqptlRWyNnRsD
        FWTvkOzzJXJT3HOaNQGW88Wtwg9ppJHQBgL/mWG5FfGiN2mo45mf/3pcHA2MynfCM/+kYR
        /xV+iCWEiszqo3QTpmb4aoJNJd1P5V4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-lSfzqI7JPRaTZhBA7oxzUQ-1; Mon, 22 May 2023 11:33:43 -0400
X-MC-Unique: lSfzqI7JPRaTZhBA7oxzUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F6C1385054F;
        Mon, 22 May 2023 15:33:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADAD9C1ED9A;
        Mon, 22 May 2023 15:33:42 +0000 (UTC)
Date:   Mon, 22 May 2023 17:33:40 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Quentin Rameau <quinq@fifth.space>
Cc:     util-linux@vger.kernel.org
Subject: Re: mount: sshfs problem with "defaults" option after 2.39 upgrade
Message-ID: <20230522153340.7ljlnnzik3ulpmcr@ws.net.home>
References: <20230521181814.0b0f2d38.quinq@fifth.space>
 <b71959fa-899b-411e-9937-d29689999111@t-8ch.de>
 <20230521201534.62dadbc8.quinq@fifth.space>
 <9c4d0dc2-de5b-4e34-9489-01e00a71e2da@t-8ch.de>
 <20230521212018.17829eb5.quinq@fifth.space>
 <20230522142154.wv3ttxztq7zjmbyl@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522142154.wv3ttxztq7zjmbyl@ws.net.home>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 22, 2023 at 04:21:54PM +0200, Karel Zak wrote:
> On Sun, May 21, 2023 at 09:20:18PM +0200, Quentin Rameau wrote:
> > > One could even argue that "defaults" should have been fine to be passed,
> > > but now it's a regression so needs to be fixed.
> > 
> > One difference that I can see is that before, "user" was being passed
> > but now, "user=$user" is being passed (and that gives an error too)
> > 
> > With mount patched with the above patch, and "user" option in the fstab
> > 
> > $ mount /mnt/ssh/path
> > fusermount3: unknown option 'user=quinq
> > 
> > But maybe that should be a different thread, what do you think?
> 
> I'll fix it. You're right.

You need https://github.com/util-linux/util-linux/commit/fe0b1e793c9017edba72768e2e0b4c769c204604

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

