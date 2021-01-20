Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B473CC433DB
	for <util-linux@archiver.kernel.org>; Wed, 20 Jan 2021 12:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F388206FA
	for <util-linux@archiver.kernel.org>; Wed, 20 Jan 2021 12:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbhATMTd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 20 Jan 2021 07:19:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730929AbhATK1c (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 20 Jan 2021 05:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611138366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R/5vvdfu9idPCjHNNCZZdZm5D8ldrRlSnz9a2WzFA4Q=;
        b=JRgL0SQZMOwWVB2Wla47F1TLRFGpaGwOneraFDv5W9qzdyYyp8xeIglodE6f1Hyva1x71H
        yHW4cQUgyjrGZBWd7Ri1LiiXdfxUghYLEQZ3J4BeeIb0z2MlQMJvkuCv7SphHaUjHF2ZpR
        kPr8ovb4toD0LnG90TSifHrw08C1mcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-K24UMus0N-KeR817v6RWkA-1; Wed, 20 Jan 2021 05:26:01 -0500
X-MC-Unique: K24UMus0N-KeR817v6RWkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 600021800D41;
        Wed, 20 Jan 2021 10:26:00 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D30E627CAC;
        Wed, 20 Jan 2021 10:25:58 +0000 (UTC)
Date:   Wed, 20 Jan 2021 11:25:55 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     util-linux@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH 1/5] Move sched_attr struct and syscall definitions into
 header file
Message-ID: <20210120102555.mu5czlpkb3gujapc@ws.net.home>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
 <20210116190940.2320819-2-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116190940.2320819-2-qais.yousef@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jan 16, 2021 at 07:09:36PM +0000, Qais Yousef wrote:
> So that we can re-use them in other files.

Good idea.

> +++ b/include/sched_attr.h
> @@ -0,0 +1,97 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation

My goal is to keep include/ and lib/ usable for LGPL and BRD code,
because util-linux is not only GPL code. The ideal solution is to 
use public domain or LGPL for this shared directories. 

Maybe we can use Public Domain also for this new header file as it
contains only ifdef fallbacks. 

The other solution is to keep GPL sched_attr.h in schedutils/ directory.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

