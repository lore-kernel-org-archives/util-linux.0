Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F39C77B75
	for <util-linux@archiver.kernel.org>; Mon, 22 May 2023 14:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjEVOWv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 May 2023 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjEVOWt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 May 2023 10:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ADAA3
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684765319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88LoU8kAalG/1tbUTS94ECkDsoLY3Cn19HWrczwEzFk=;
        b=Oacbvi/jNBVTnW3qnIT0xhP/Nb4awMMQMTxxOL4F59VuABkuCq9TEKcz3MSvBG/XXdUl1Q
        jZ/I15t7tmiunsiaVNe598E0iqQHpHZau0sYq4bu6zPi4qQY5cXSIpYTiNM2vrQv9J85Kt
        aNbi6Ra197N1vq03IdOikD/a4cGCAeo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-CA7TcXNFOXeKzP77mr0UvA-1; Mon, 22 May 2023 10:21:57 -0400
X-MC-Unique: CA7TcXNFOXeKzP77mr0UvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BD2D101A53B;
        Mon, 22 May 2023 14:21:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 051A720296C8;
        Mon, 22 May 2023 14:21:56 +0000 (UTC)
Date:   Mon, 22 May 2023 16:21:54 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Quentin Rameau <quinq@fifth.space>
Cc:     util-linux@vger.kernel.org
Subject: Re: mount: sshfs problem with "defaults" option after 2.39 upgrade
Message-ID: <20230522142154.wv3ttxztq7zjmbyl@ws.net.home>
References: <20230521181814.0b0f2d38.quinq@fifth.space>
 <b71959fa-899b-411e-9937-d29689999111@t-8ch.de>
 <20230521201534.62dadbc8.quinq@fifth.space>
 <9c4d0dc2-de5b-4e34-9489-01e00a71e2da@t-8ch.de>
 <20230521212018.17829eb5.quinq@fifth.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521212018.17829eb5.quinq@fifth.space>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, May 21, 2023 at 09:20:18PM +0200, Quentin Rameau wrote:
> > One could even argue that "defaults" should have been fine to be passed,
> > but now it's a regression so needs to be fixed.
> 
> One difference that I can see is that before, "user" was being passed
> but now, "user=$user" is being passed (and that gives an error too)
> 
> With mount patched with the above patch, and "user" option in the fstab
> 
> $ mount /mnt/ssh/path
> fusermount3: unknown option 'user=quinq
> 
> But maybe that should be a different thread, what do you think?

I'll fix it. You're right.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

