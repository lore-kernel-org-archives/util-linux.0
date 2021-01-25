Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0669C433DB
	for <util-linux@archiver.kernel.org>; Tue, 26 Jan 2021 06:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFF122A84
	for <util-linux@archiver.kernel.org>; Tue, 26 Jan 2021 06:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbhAZGDt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbhAYJUO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Jan 2021 04:20:14 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E6C061797
        for <util-linux@vger.kernel.org>; Mon, 25 Jan 2021 00:26:26 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id c18so1451193ljd.9
        for <util-linux@vger.kernel.org>; Mon, 25 Jan 2021 00:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5XljUNa/LxRBDCFYo6Hm3WQMaKsPphHYouvh4RI8OU=;
        b=kpnoubhndePLkQZ9E5kSkkwrLpsTeCD3ThNM+GPQjJ3PWH91vjoi7bb9EngblpEaO3
         HAYNKv2rEOBU51a8n3rkqAA5TvtU59+/ifJrqwoqN/lNzag8CFEik2AoVdXV2F6fpf4S
         2ohtrKoP8Eaa+PiXi8nASH9+3vxjXaEcTW0MtpiCS7Yndl7vjWUnp90BHpf1UbfQ6yCT
         TX8Is4OwIEOON0ZIt7QGy2jFPT6aiIMW7yR8s1h36/pLVpHpXiKR5zVMMQ7B+lhTKvXj
         7x9Cyh8U3fVB51Ivemn9xS+O+wqfv9+dR6lPzZ9+eWTGiekXwEVXNQfTVmDMmLf0NNQh
         GjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5XljUNa/LxRBDCFYo6Hm3WQMaKsPphHYouvh4RI8OU=;
        b=BZTrINhfpdSgh5pXTetHPXByLKnfr7591onfkiYObypUPHfq/O6igvJAKORcvBUUzv
         BXobQZMq4N6xvbPHeFEq7HB8wFq58H0bZOWpBHpPfTF8mA8JuBoDaRUqPCtN21iSSjUo
         dMIzbzjpoT3kulNN5NbdqK5/ykoQEXiVODlqRQtB5/iuQUGrJjYlc4MtMOgkcjKnTony
         37o4S8reZRT8g7QYYpfo0wYZfVavPzrZ/2+MnHRremX7MgmER5V6qroLuzNEclseRPLe
         ZvUh3GdupfhWDYL14bCxcVr7v3dB/Q/i76GKbe7dXN8qQAQQkx3Ea9eMOesfSe4vrpfZ
         w3kg==
X-Gm-Message-State: AOAM531rQWlejCjq9SacdW7BmPVtCR8s2ja9GPd5+at2BGCfTXW0s0zw
        1jFOqpIJa0lJ/49lvrtiC1jbQDE1/cSRS/8iXwq9yw==
X-Google-Smtp-Source: ABdhPJyg2pGi8JqsgiTkFYUzPCfHEB5Lwgq0hgzrn9EcdPsitzNNrNI0NoBj99Ny0QP1lJ+HZredHu4xBPGL7EY2DyI=
X-Received: by 2002:a2e:7605:: with SMTP id r5mr306715ljc.299.1611563184471;
 Mon, 25 Jan 2021 00:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20210116190940.2320819-1-qais.yousef@arm.com> <20210116190940.2320819-4-qais.yousef@arm.com>
 <CAKfTPtAKBUmvXAnDSyp1-S=uXewQus-HzEaNhpOieRHS1p-tqQ@mail.gmail.com> <20210123183133.dniog4z2rxw45sd6@e107158-lin>
In-Reply-To: <20210123183133.dniog4z2rxw45sd6@e107158-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Jan 2021 09:26:13 +0100
Message-ID: <CAKfTPtDwe98LmnyN8uU28fsekVQF=RBtTqm+gcpr0SJeTwr61g@mail.gmail.com>
Subject: Re: [PATCH 3/5] uclampset: Add man page
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     util-linux@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, 23 Jan 2021 at 19:31, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 01/20/21 15:46, Vincent Guittot wrote:
> > > +.TP
> > > +For example:
> > > +.B uclampset \-s
> > > +.I -m\ 512
> > > +.I -M\ 700
> > > +.PP
> > > +will prevent any task from being boosted higher than 512. And all tasks in the
> >
> > will prevent any task from being boosted higher than 700
>
> 700 or 512 you mean here?
>
> > or
> > will ensure  any task to be boosted higher than 512
>
> It is certainly not that. That's the confusion I was trying to clear up in this
> note. The system values are _constraints_. It sets an upper bound on the
> maximum uclamp_min/max value the system will apply.
>
> For example if a task::uclamp_min=1024 but the system::uclamp_min=512 512, then
> effectively the task will only be boosted to 512. Once this restriction is left
> by setting system::uclamp_min=1024 again, then the task will get the boost
> value it requested.

ok, I got confused because uclamp -p PID  -min 512 - M 700 and uclamp
-s  -min 512 - M 700 look quite similar but their behaviors are quite
different.

I mean

uclamp -p PID -min 512 - M 700 will ensure that the task's utilization
will be always reported in the range [512:700]
The behavior is the same for the cgroup  with cpu.uclamp.min and cpu.uclamp.max

whereas

uclamp -s -min 512 - M 700 will do the opposite; i.e. the min of
task's utilization range will never be above 512

TBH I don't know how to make it clear that the behavior of -min is the
opposite between -p and -s

>
> I'm open to suggestions on how to better explain this..
>
> Thanks
>
> --
> Qais Yousef
