Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28573C433DB
	for <util-linux@archiver.kernel.org>; Mon, 15 Feb 2021 15:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E606564EAF
	for <util-linux@archiver.kernel.org>; Mon, 15 Feb 2021 15:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhBOP3v (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:29:51 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:43875 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhBOP3G (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 15 Feb 2021 10:29:06 -0500
Received: by mail-qt1-f171.google.com with SMTP id d3so5029719qtr.10
        for <util-linux@vger.kernel.org>; Mon, 15 Feb 2021 07:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vExrirzE1FY5HSIhMzxbIwrWLSG3VBCWi7Z+gX7Nguo=;
        b=m1K5KOIyAZI3nHoMDHCkySnn41b2OW9NtnPI9wsdO3Shikh7Fhbq7Rca9gcs1qOfPP
         dSaAIE7hpMYeteAR6Smp/M9k7Yq5ta/n1dJCsMem96+BPDdpK87jQvdC6MRYImL9Ky45
         b16h/kfDtCl+TkHBCJmu66jKDsn/tjnluxHre8DiN/3WAkrw2oh8lOfmTN/hG6dNkNjs
         PqxIhHQeUm7bQzvJVyxdadtfA5Ju1moo87v0quDJ7TEDjawCUTMJgbcrCuu1KugaXMBY
         y4D917hEZvjp+g4dj0ca3nvsATm7ZKauK7YR9zuPVW9pmu08mYWcnyb/9oPVh5M+2TYx
         EKZg==
X-Gm-Message-State: AOAM5302JO+q+sCxnTANVIprAg+Piax4OxmnbRTmiqiHfwKr39p5kt7D
        n76y6gzFp/bQBDz2y4QVGfNxbeEqWLrUmPwAkRec+v4dImchrQ==
X-Google-Smtp-Source: ABdhPJwyH+WRvgXFRXRMi5JVy6vctiOWNn2LGlSCpqP0bxjFjK44NnZ1DKI3Ryw+RkW9S/Or/KHSz3mvQt45F+t9hzc=
X-Received: by 2002:ac8:6ed9:: with SMTP id f25mr2331188qtv.352.1613402904037;
 Mon, 15 Feb 2021 07:28:24 -0800 (PST)
MIME-Version: 1.0
From:   Diego Kreutz <kreutz@acm.org>
Date:   Mon, 15 Feb 2021 12:28:12 -0300
Message-ID: <CADjQn4h=J-K=HdGc-WJHLeK4WfepRbjsTL3EWbwfwDwJxZosXw@mail.gmail.com>
Subject: [bug report] cal command segmentation fault
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

I found a bug in the cal command. It is a segmentation fault for the
following input.

cal -d 20210516
Segmentation fault: 11

The segmentation fault happens with exactly 8 digits. However, there
is something going wrong with more digits as well. With 9 or more
digits, the command's output gets weird.

I checked the bug in three systems (Debian 10, OS X, and Ubuntu Server 16.04).

Linux NAME 4.19.0-5-amd64 #1 SMP Debian 4.19.37-5+deb10u2 (2019-08-08)
x86_64 GNU/Linux

Darwin NAME 19.6.0 Darwin Kernel Version 19.6.0: Tue Jan 12 22:13:05
PST 2021; root:xnu-6153.141.16~1/RELEASE_X86_64 x86_64

Linux NAME 4.4.0-116-generic #140-Ubuntu SMP Mon Feb 12 21:23:04 UTC
2018 x86_64 x86_64 x86_64 GNU/Linux

Unfortunately, I don't have the time to go through the code and
provide a detailed fix for the issue. However, I assume it should be
fairly straightforward for the maintainers to find and fix this bug.

Best regards,

Diego
