Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0330DC433E0
	for <util-linux@archiver.kernel.org>; Tue, 26 Jan 2021 15:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB04322D58
	for <util-linux@archiver.kernel.org>; Tue, 26 Jan 2021 15:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391626AbhAZPKD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 Jan 2021 10:10:03 -0500
Received: from foss.arm.com ([217.140.110.172]:44068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406208AbhAZPJj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 26 Jan 2021 10:09:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9347931B;
        Tue, 26 Jan 2021 07:08:53 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C86133F66E;
        Tue, 26 Jan 2021 07:08:52 -0800 (PST)
Date:   Tue, 26 Jan 2021 15:08:50 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     util-linux@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH 3/5] uclampset: Add man page
Message-ID: <20210126150850.evzcfxfeiiikpbfa@e107158-lin>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
 <20210116190940.2320819-4-qais.yousef@arm.com>
 <CAKfTPtAKBUmvXAnDSyp1-S=uXewQus-HzEaNhpOieRHS1p-tqQ@mail.gmail.com>
 <20210123183133.dniog4z2rxw45sd6@e107158-lin>
 <CAKfTPtDwe98LmnyN8uU28fsekVQF=RBtTqm+gcpr0SJeTwr61g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDwe98LmnyN8uU28fsekVQF=RBtTqm+gcpr0SJeTwr61g@mail.gmail.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 01/25/21 09:26, Vincent Guittot wrote:
> On Sat, 23 Jan 2021 at 19:31, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 01/20/21 15:46, Vincent Guittot wrote:
> > > > +.TP
> > > > +For example:
> > > > +.B uclampset \-s
> > > > +.I -m\ 512
> > > > +.I -M\ 700
> > > > +.PP
> > > > +will prevent any task from being boosted higher than 512. And all tasks in the
> > >
> > > will prevent any task from being boosted higher than 700
> >
> > 700 or 512 you mean here?
> >
> > > or
> > > will ensure  any task to be boosted higher than 512
> >
> > It is certainly not that. That's the confusion I was trying to clear up in this
> > note. The system values are _constraints_. It sets an upper bound on the
> > maximum uclamp_min/max value the system will apply.
> >
> > For example if a task::uclamp_min=1024 but the system::uclamp_min=512 512, then
> > effectively the task will only be boosted to 512. Once this restriction is left
> > by setting system::uclamp_min=1024 again, then the task will get the boost
> > value it requested.
> 
> ok, I got confused because uclamp -p PID  -min 512 - M 700 and uclamp
> -s  -min 512 - M 700 look quite similar but their behaviors are quite
> different.
> 
> I mean
> 
> uclamp -p PID -min 512 - M 700 will ensure that the task's utilization
> will be always reported in the range [512:700]
> The behavior is the same for the cgroup  with cpu.uclamp.min and cpu.uclamp.max

The cgroup behavior actually works like system. It is a constraint of your max
allowed util_min/max value. There's an exception to that where cgroup will
behave like '-p'...

I avoided commenting on cgroup behavior here. I plan to send a patch to
document util clamp in the kernel. For this tool since we don't interact with
cgroup I omitted talking about it.

I intend to send a patch documenting util clamp in the kernel. I think It's
better to discuss this details there?

> 
> whereas
> 
> uclamp -s -min 512 - M 700 will do the opposite; i.e. the min of
> task's utilization range will never be above 512
> 
> TBH I don't know how to make it clear that the behavior of -min is the
> opposite between -p and -s

Hopefully it'll become common knowledge at some point..

Thanks for having a look.

Cheers

--
Qais Yousef
