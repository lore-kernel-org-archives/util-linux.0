Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE2EC433FE
	for <util-linux@archiver.kernel.org>; Wed,  6 Apr 2022 12:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiDFMyy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiDFMyW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2022 08:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FAB51E4620
        for <util-linux@vger.kernel.org>; Wed,  6 Apr 2022 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649235329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UPVL7Ei0sC3ImMx1p4dLxSr8ouSWKasUMXXKS/0xWvo=;
        b=jJO2qoeyYoWdjyB4HdSN/tRDnIobz/EAc4sm2llwWl7XhpQlK3SM+nVh8QM8+Onigy5BBA
        /KMF5kupoeuY66S4D8ZPrjLRfDpuGLmPfx8pxjjRPRZrDK5RBgGfraujlEl+W8tnBGrs0z
        cv6I0rCJ8ApRZzJaY+ZKnN0n3Pw03vc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-DWvaiQ0SOGSxsC2OD3fPqA-1; Wed, 06 Apr 2022 04:55:24 -0400
X-MC-Unique: DWvaiQ0SOGSxsC2OD3fPqA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3452E80005D;
        Wed,  6 Apr 2022 08:55:24 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90C4A401DF2;
        Wed,  6 Apr 2022 08:55:23 +0000 (UTC)
Date:   Wed, 6 Apr 2022 10:55:21 +0200
From:   Karel Zak <kzak@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] blkpr: add block persistent reservations command
Message-ID: <20220406085521.nbytfauspc6kgofd@ws.net.home>
References: <20210916032901.2189336-1-pizhenwei@bytedance.com>
 <YkvsUl9ZZOC7j70X@infradead.org>
 <f9e3fb29-a4ee-06a8-238f-ef1caade0234@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e3fb29-a4ee-06a8-238f-ef1caade0234@bytedance.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 06, 2022 at 10:13:00AM +0800, zhenwei pi wrote:
> On 4/5/22 15:14, Christoph Hellwig wrote:
> > Any reason this never got picked up or commented on?
> > This seems to have been ignored.
> 
> Hi Karel,
> Could you please give me any hint?

Frankly, I see this first time and I cannot found 'blkpr' in my
emails ...  but I see it in mailing list archive(s) now, for example
https://lore.kernel.org/all/20210916032901.2189336-1-pizhenwei@bytedance.com/,
so it's probably my mistake. Sorry for this ;-(

At first glance it seems like something I can merge.

   Karel

> > On Thu, Sep 16, 2021 at 11:29:01AM +0800, zhenwei pi wrote:
> > > Linux kernel block layer supports PR (persistent reservations) ioctl
> > > on a block device. Typically SCSI and NVMe disk support PR feature,
> > > and blkpr could operation on them.
> > > 
> > > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > > ---
> > >   configure.ac            |  11 ++
> > >   sys-utils/Makemodule.am |   8 ++
> > >   sys-utils/blkpr.8.adoc  |  64 ++++++++++
> > >   sys-utils/blkpr.c       | 277 ++++++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 360 insertions(+)
> > >   create mode 100644 sys-utils/blkpr.8.adoc
> > >   create mode 100644 sys-utils/blkpr.c
> -- 
> zhenwei pi
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

