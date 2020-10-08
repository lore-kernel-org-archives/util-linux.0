Return-Path: <SRS0=zmxI=DP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03232C433E7
	for <util-linux@archiver.kernel.org>; Thu,  8 Oct 2020 21:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A561822241
	for <util-linux@archiver.kernel.org>; Thu,  8 Oct 2020 21:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgJHVuh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 8 Oct 2020 17:50:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45514 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJHVuh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Oct 2020 17:50:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id y14so5429645pgf.12
        for <util-linux@vger.kernel.org>; Thu, 08 Oct 2020 14:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=C01yRMr/hxxUpHgoMk5BC6qRawmuK72sMSXs7qWr7Hs=;
        b=FivRq90aTi8cCV2OHPD/VhCemCaZYdWHXQn818fMEr2rc6MO9nSNV3zjoA63rYks6O
         nX/iOr0Q+wK+/AVMMkLBsibO7Y4dyq1/eq936sAsSvT1Jmi0mq1uAu4c3b4ntkwuSDwL
         e+g399cIsHJNI+lZw+607roLJKeWH9U31/nNrvyI+Gg62FVWjjH1Txa9MjanbZtJtlPU
         9n9QPExsJ+WILndiKW73GvvRISsEY2p0pJmNi32BaNHmg/9UHVquXk6mZJYVWu4kuCjC
         G9vbZYZM3adlJzXNzCP02uNah+vbAgv1GhI06kILYrcm8IR+8IKL6f4lLV/7MiHPF/xm
         +EVA==
X-Gm-Message-State: AOAM532w62nSDHNSn4clIjOr5pGatMWzVvFi1EeZP0ID2WoBLZbmGtcq
        8FImj8NQVDGeV8J3Y3YsXzsI5gz0UIlC7I1V1eZHU48zpUA=
X-Google-Smtp-Source: ABdhPJwUPTh7gwbEPYeAYg9ZMzxHhajBoPKi/qn3I1ZIIUku8SQsB4+qoHBbnchzCJq2QRu7To6yUOV+T/dYk0ZuHi0=
X-Received: by 2002:a17:90b:3884:: with SMTP id mu4mr965491pjb.29.1602193836597;
 Thu, 08 Oct 2020 14:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <423799ab-a6d8-987c-711e-cdda6ee72c3e@suse.cz> <20201008075351.ucusodaf3dqh5k4v@ws.net.home>
In-Reply-To: <20201008075351.ucusodaf3dqh5k4v@ws.net.home>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Thu, 8 Oct 2020 22:50:25 +0100
Message-ID: <CAG27Bk3Uq+Ni5iYwDoVqp3FOHpe8N4-diwVdem9+Wu6Abzp6OA@mail.gmail.com>
Subject: Re: [PATCH] bash-completion: Fix su
To:     Karel Zak <kzak@redhat.com>
Cc:     Stanislav Brabec <sbrabec@suse.cz>,
        Util-Linux <util-linux@vger.kernel.org>,
        jun wang <junguo.wang@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, 8 Oct 2020 at 08:55, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Oct 08, 2020 at 08:50:39AM +0200, Stanislav Brabec wrote:
> > Fix su -s <tab> that reports invalid chsh -l.
>
> "cat /etc/shells" and "chsh -l" get the same output on my system, why
> "chsh -l" is invalid?
>
> chsh -l uses getusershell() glibc function.

I guess "$(</etc/shells)" was done to avoid exec, but it is not the
same as "$(chsh -l)"
because the chsh will not list comment lines. What I get is:

$ x=$(</etc/shells);  echo $x
# Pathnames of valid login shells. # See shells(5) for details.
/bin/sh /bin/bash /usr/bin/git-shell /bin/dash /bin/zsh /usr/bin/zsh

Compared to:

$ chsh --list-shells
/bin/sh
/bin/bash
/usr/bin/git-shell
/bin/dash
/bin/zsh
/usr/bin/zsh

I hope it is obvious why cat(1) or bash memory mapping that $(<file)
is isn't the best way to read /etc/shells when using output as
completion options.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
