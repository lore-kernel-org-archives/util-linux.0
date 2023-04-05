Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E316AC7619A
	for <util-linux@archiver.kernel.org>; Wed,  5 Apr 2023 10:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbjDEKoB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Apr 2023 06:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbjDEKoA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Apr 2023 06:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C290E19B2
        for <util-linux@vger.kernel.org>; Wed,  5 Apr 2023 03:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680691397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cF9WzmOT7u+BD/B9xotIbjKcKrqwT5fc0lJ95Lm2sFY=;
        b=eUdBQ2Wydh23IagMKrk57rNHQuU2zWrtgiEloos6ImLKZl2cZDcKIwgWy1ibGIcu6wgQX6
        mNsuOu7q9jUCYnKPWY/ESFKj5fveiX6cS8x2ErppHBqqBBtBzXPgi2PFuoC3AxzV7c1i0A
        ZzFC5IusYV0RAm5R8/oQF+wa7U3Ll20=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-KlF7fmzmM8CVHfihiNqG0Q-1; Wed, 05 Apr 2023 06:43:15 -0400
X-MC-Unique: KlF7fmzmM8CVHfihiNqG0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78BD01C27D86;
        Wed,  5 Apr 2023 10:43:15 +0000 (UTC)
Received: from ws.net.home (ovpn-192-2.brq.redhat.com [10.40.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0B6918EC7;
        Wed,  5 Apr 2023 10:43:14 +0000 (UTC)
Date:   Wed, 5 Apr 2023 12:43:12 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: Decouple cputype and topology
Message-ID: <20230405104312.lz23yp3zafcygkpr@ws.net.home>
References: <20230405061238.11888-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405061238.11888-1-akihiko.odaki@daynix.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 05, 2023 at 03:12:38PM +0900, Akihiko Odaki wrote:
w we can merge
> Before this change, lscpu_cputype held topology information.

I do not understand why this is a problem. The topology (number of
threads, cores, etc.) is specific to the type of CPU, right?

I guess the sibling maps in kernel describes this.

> This
> design is incompatible with heterogenous configurations where there are
> several CPU types.

This design has been motivated by heterogenous systems :-)

  Model name:           Cortex-A53
    Model:              4
    Thread(s) per core: 1
    Core(s) per socket: 4
    Socket(s):          1
  Model name:           Cortex-A72
    Model:              2
    Thread(s) per core: 1
    Core(s) per socket: 2
    Socket(s):          1

How we can display "Core(s) per socket" if we will not differentiate
between the types?

> One problem is that logical IDs of e.g. clusters overlap across
> different CPU types. For example, consider a
> 1-socket/2-cluster/1-core/1-thread system. One of the clusters has
> "P-cores", and the other has "E-cores". P-cores and E-cores have
> different CPU types. Before this change,
> "lscpu -p=CPU,Core,Cluster,Socket" output something like the following
> for the system:
> 0,0,0,0
> 1,0,0,0
> 
> Note that lscpu assigns the same core/cluster ID for the two CPUs
> although they are actually in different cores and clusters.
> 
> To fix the inconsistency and ambiguity of such IDs, move the topology
> information from lscpu_cputype to lscpu_cxt. For the earlier example,
> the output will change as follows:
> 0,0,0,0
> 1,1,1,0

Then we need to fix _this output_, but not ignore cputypes for whole
lscpu.

> This also changes how the topology is described in the summary which
> lscpu prints when it is executed with no arguments. Before this change,
> the topology information was associated with CPU types, but the
> topology information is shown in a separate section now.

I don't like it. We had this output before lscpu rewrite and was pretty
confusing for users.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

