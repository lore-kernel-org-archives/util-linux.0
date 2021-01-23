Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0538EC433DB
	for <util-linux@archiver.kernel.org>; Sat, 23 Jan 2021 18:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71452226A
	for <util-linux@archiver.kernel.org>; Sat, 23 Jan 2021 18:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbhAWShr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 Jan 2021 13:37:47 -0500
Received: from foss.arm.com ([217.140.110.172]:52996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbhAWShq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 23 Jan 2021 13:37:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC3A1474;
        Sat, 23 Jan 2021 10:37:00 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03FBC3F719;
        Sat, 23 Jan 2021 10:36:59 -0800 (PST)
Date:   Sat, 23 Jan 2021 18:36:57 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH 3/5] uclampset: Add man page
Message-ID: <20210123183657.tqhhmvgkwwtksz5h@e107158-lin>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
 <20210116190940.2320819-4-qais.yousef@arm.com>
 <20210120122251.fyvbuecsgrg5yv4p@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120122251.fyvbuecsgrg5yv4p@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 01/20/21 13:22, Karel Zak wrote:
> On Sat, Jan 16, 2021 at 07:09:38PM +0000, Qais Yousef wrote:
> > +See
> > +.BR sched_setscheduler (2)
> > +for a description of the Linux scheduling scheme.
> 
> and maybe sched_setattr(2) too.

Yep. Done.

Thanks

--
Qais Yousef
