Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EBFC433DB
	for <util-linux@archiver.kernel.org>; Sat, 23 Jan 2021 18:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D3F2226A
	for <util-linux@archiver.kernel.org>; Sat, 23 Jan 2021 18:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbhAWScW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 Jan 2021 13:32:22 -0500
Received: from foss.arm.com ([217.140.110.172]:52802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbhAWScW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 23 Jan 2021 13:32:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D41F1474;
        Sat, 23 Jan 2021 10:31:36 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D30413F719;
        Sat, 23 Jan 2021 10:31:35 -0800 (PST)
Date:   Sat, 23 Jan 2021 18:31:33 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     util-linux@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH 3/5] uclampset: Add man page
Message-ID: <20210123183133.dniog4z2rxw45sd6@e107158-lin>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
 <20210116190940.2320819-4-qais.yousef@arm.com>
 <CAKfTPtAKBUmvXAnDSyp1-S=uXewQus-HzEaNhpOieRHS1p-tqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAKBUmvXAnDSyp1-S=uXewQus-HzEaNhpOieRHS1p-tqQ@mail.gmail.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 01/20/21 15:46, Vincent Guittot wrote:
> > +.TP
> > +For example:
> > +.B uclampset \-s
> > +.I -m\ 512
> > +.I -M\ 700
> > +.PP
> > +will prevent any task from being boosted higher than 512. And all tasks in the
> 
> will prevent any task from being boosted higher than 700

700 or 512 you mean here?

> or
> will ensure  any task to be boosted higher than 512

It is certainly not that. That's the confusion I was trying to clear up in this
note. The system values are _constraints_. It sets an upper bound on the
maximum uclamp_min/max value the system will apply.

For example if a task::uclamp_min=1024 but the system::uclamp_min=512 512, then
effectively the task will only be boosted to 512. Once this restriction is left
by setting system::uclamp_min=1024 again, then the task will get the boost
value it requested.

I'm open to suggestions on how to better explain this..

Thanks

--
Qais Yousef
