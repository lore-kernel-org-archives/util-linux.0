Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5129C433F5
	for <util-linux@archiver.kernel.org>; Wed,  6 Apr 2022 14:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiDFOVZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiDFOVT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2022 10:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 227D6199E3F
        for <util-linux@vger.kernel.org>; Wed,  6 Apr 2022 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649240834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BvBLRNb4jtmwtHi08yu7iPOUWhcbxLP0ug3BPvDqzgg=;
        b=IQpto8IK+lSmCQN4T/PVHRWueCygdrCioV/dkg2ArHoZ3DnVDpVHA8eN6O3B6dj2mTYkrY
        +IcY4hOxN8zdXOE79knAZozS9v5KRPTYQelbtZMhpzVSVWzoHsPLVroiSGjNXwx4wpczKK
        v7zjNs2xNwIFrh8LiJOpayjULnwb5LQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-N6M-bz_SNJyqx7xd2SewgQ-1; Wed, 06 Apr 2022 06:27:11 -0400
X-MC-Unique: N6M-bz_SNJyqx7xd2SewgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EB4C899EC1;
        Wed,  6 Apr 2022 10:27:10 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB143C27E83;
        Wed,  6 Apr 2022 10:27:09 +0000 (UTC)
Date:   Wed, 6 Apr 2022 12:27:07 +0200
From:   Karel Zak <kzak@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] blkpr: add block persistent reservations command
Message-ID: <20220406102707.vzwcndfueoo64aza@ws.net.home>
References: <20210916032901.2189336-1-pizhenwei@bytedance.com>
 <YkvsUl9ZZOC7j70X@infradead.org>
 <f9e3fb29-a4ee-06a8-238f-ef1caade0234@bytedance.com>
 <20220406085521.nbytfauspc6kgofd@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406085521.nbytfauspc6kgofd@ws.net.home>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 06, 2022 at 10:55:24AM +0200, Karel Zak wrote:
> At first glance it seems like something I can merge.

Merged. I did some minor changes to the code and man-page.

It would be nice to have some short description for the operations and
the types. Something what we can use in --help output.

  register, reserve, release, preempt, preempt-abort, and clear

  write-exclusive, exclusive-access, write-exclusive-reg-only, exclusive-access-reg-only, write-exclusive-all-regs, and exclusive-access-all-regs

I'm not sure if for example "preempt" or "write-exclusive-reg-only" is
obvious enough for end-users.

The next question, what about to rename --operation to --command?  The
man-page describes blkpr as "run persistent reservations command on a
device".

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

