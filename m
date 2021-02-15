Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C485FC433DB
	for <util-linux@archiver.kernel.org>; Mon, 15 Feb 2021 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8505F64DB1
	for <util-linux@archiver.kernel.org>; Mon, 15 Feb 2021 16:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhBOQBN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:01:13 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:43712 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhBOP4h (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 15 Feb 2021 10:56:37 -0500
Received: by mail-pl1-f171.google.com with SMTP id r2so3938075plr.10
        for <util-linux@vger.kernel.org>; Mon, 15 Feb 2021 07:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=t2ucl/3CvrJmjxFbM3r8J131uFhKehhk/0W+6qhQ5W4=;
        b=TuRDQCZ02aWaIGBQAnbXRj1nXEbflXlxKABichf7jpu0CKj47Ra2kBqrHDpGOSue/h
         QSqFK5VEcyotC0DwUUiitcZMVcZ25uKjZ8yed818ObNrDztN9hXWXzpFM9tCznR1QUsj
         GjmqJBfnTizlHKwnPgffBUKLE9/v77r/r7FKPD0/jaVnoYyFi9LvW7b+tMNXevKJEnwH
         oPOmxlxOdqnhXsfCGJ/gz3ya3KJB5Wv7un74l/HIKHnafe5A/n1Sc1Ci1M6SBv62uzwC
         EFb1TexRxf+Y8Sv8n4LzZiFJfpS5QhMFwaamNzaos6KyUPROmS7cVAX+ejSQ87CzTthl
         uOXA==
X-Gm-Message-State: AOAM531g1okRpvBXZxPMvhB2IauSeBMRINS+wpd85L+WazJI0GCpPuZJ
        nUFwfSvzc/YOtGZ25akaYsR10ocPiY2t/k11BT/GGOmccgk=
X-Google-Smtp-Source: ABdhPJwbVCrwN3LVYRg+B9g22t6ccqu7RI1kPFSSh7eO92kjHba4AKcXfhkt3vKWlBEA9ZcbE/WjNcC604XbYxLfzEQ=
X-Received: by 2002:a17:90a:ec05:: with SMTP id l5mr9353372pjy.219.1613404554402;
 Mon, 15 Feb 2021 07:55:54 -0800 (PST)
MIME-Version: 1.0
References: <CADjQn4h=J-K=HdGc-WJHLeK4WfepRbjsTL3EWbwfwDwJxZosXw@mail.gmail.com>
In-Reply-To: <CADjQn4h=J-K=HdGc-WJHLeK4WfepRbjsTL3EWbwfwDwJxZosXw@mail.gmail.com>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Mon, 15 Feb 2021 15:55:43 +0000
Message-ID: <CAG27Bk0AV-7VmDj89Cfw5N_aRxtOzC4Ua8BZ7QPtuHB4qtYD_w@mail.gmail.com>
Subject: Re: [bug report] cal command segmentation fault
To:     Diego Kreutz <kreutz@acm.org>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, 15 Feb 2021 at 15:31, Diego Kreutz <kreutz@acm.org> wrote:
> I found a bug in the cal command. It is a segmentation fault for the
> following input.
>
> cal -d 20210516
> Segmentation fault: 11
>
> The segmentation fault happens with exactly 8 digits. However, there
> is something going wrong with more digits as well. With 9 or more
> digits, the command's output gets weird.
>
> I checked the bug in three systems (Debian 10, OS X, and Ubuntu Server 16.04).
>
> Linux NAME 4.19.0-5-amd64 #1 SMP Debian 4.19.37-5+deb10u2 (2019-08-08)
> x86_64 GNU/Linux
>
> Darwin NAME 19.6.0 Darwin Kernel Version 19.6.0: Tue Jan 12 22:13:05
> PST 2021; root:xnu-6153.141.16~1/RELEASE_X86_64 x86_64
>
> Linux NAME 4.4.0-116-generic #140-Ubuntu SMP Mon Feb 12 21:23:04 UTC
> 2018 x86_64 x86_64 x86_64 GNU/Linux
>
> Unfortunately, I don't have the time to go through the code and
> provide a detailed fix for the issue. However, I assume it should be
> fairly straightforward for the maintainers to find and fix this bug.

Hi Diego

I am almost certain you reached wrong mail-list. The util-linux cal(1)
does not have -d option,

$ cal -d 20210516
cal: invalid option -- 'd'
Try 'cal --help' for more information.

$ cal --version
cal from util-linux 2.36.2

I suspect you might be using GNU cal that has -d, --include-today
option[1].  If that is correct
the report is best to forward to related mail-list[2].

[1] https://www.gnu.org/software/gcal/manual/gcal.html#index-_002dd
[2] https://www.gnu.org/software/gcal/

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
