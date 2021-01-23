Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90A7C433DB
	for <util-linux@archiver.kernel.org>; Sat, 23 Jan 2021 16:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D89D22DBF
	for <util-linux@archiver.kernel.org>; Sat, 23 Jan 2021 16:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbhAWQvp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 Jan 2021 11:51:45 -0500
Received: from foss.arm.com ([217.140.110.172]:49330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbhAWQvp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 23 Jan 2021 11:51:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B23211D4;
        Sat, 23 Jan 2021 08:50:59 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B7B93F719;
        Sat, 23 Jan 2021 08:50:58 -0800 (PST)
Date:   Sat, 23 Jan 2021 16:50:55 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH 1/5] Move sched_attr struct and syscall definitions into
 header file
Message-ID: <20210123165055.yphylpc575dqbw5s@e107158-lin>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
 <20210116190940.2320819-2-qais.yousef@arm.com>
 <20210120102555.mu5czlpkb3gujapc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120102555.mu5czlpkb3gujapc@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 01/20/21 11:25, Karel Zak wrote:
> On Sat, Jan 16, 2021 at 07:09:36PM +0000, Qais Yousef wrote:
> > So that we can re-use them in other files.
> 
> Good idea.
> 
> > +++ b/include/sched_attr.h
> > @@ -0,0 +1,97 @@
> > +/*
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License, version 2, as
> > + * published by the Free Software Foundation
> 
> My goal is to keep include/ and lib/ usable for LGPL and BRD code,
> because util-linux is not only GPL code. The ideal solution is to 
> use public domain or LGPL for this shared directories. 
> 
> Maybe we can use Public Domain also for this new header file as it
> contains only ifdef fallbacks. 
> 
> The other solution is to keep GPL sched_attr.h in schedutils/ directory.

Sorry I didn't realize the licensing constraint.

Don't we need Robert's Love permission to change the license? Making it Public
Domain makes sense. There's nothing special in here.

Thanks

--
Qais Yousef
