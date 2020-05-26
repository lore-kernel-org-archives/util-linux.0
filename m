Return-Path: <SRS0=W0VW=7I=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B24C433E0
	for <util-linux@archiver.kernel.org>; Tue, 26 May 2020 23:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C542E2078C
	for <util-linux@archiver.kernel.org>; Tue, 26 May 2020 23:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404537AbgEZXHa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 May 2020 19:07:30 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48687 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404484AbgEZXHa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 26 May 2020 19:07:30 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C30C6564685
        for <util-linux@vger.kernel.org>; Wed, 27 May 2020 01:07:26 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id l73so438477pjb.1
        for <util-linux@vger.kernel.org>; Tue, 26 May 2020 16:07:26 -0700 (PDT)
X-Gm-Message-State: AOAM533fGaq9lanJRxVQSR1ngk/d6g6dFQoZkitNz+h0LdgFl8i47SsD
        xCesMwxxbfhI4EPnf2/HKauGoNpo7ZI+K7GFWio=
X-Google-Smtp-Source: ABdhPJwEuheJWrdjpyx35vHVVkPzpdwG/+vDkjam4M0C5GIC2QslDtReE0PtJYZGABRVGla6GJnSFRt4FdbUz1SsBps=
X-Received: by 2002:a17:90a:17e9:: with SMTP id q96mr1666842pja.56.1590534445214;
 Tue, 26 May 2020 16:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
In-Reply-To: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Wed, 27 May 2020 01:07:14 +0200
X-Gmail-Original-Message-ID: <CAA0A08W0S8ZnZXJ1D0VDnC6qZ4F0sYP_tr9qK7_7Fxi5HGOqAw@mail.gmail.com>
Message-ID: <CAA0A08W0S8ZnZXJ1D0VDnC6qZ4F0sYP_tr9qK7_7Fxi5HGOqAw@mail.gmail.com>
Subject: Re: util-linux-2.35.2 test failures
To:     Util-Linux <util-linux@vger.kernel.org>
Cc:     Bruce Dubbs <bruce.dubbs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed May 27 01:07:27 2020 +0200 (CEST))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 27, 2020 at 12:34 AM Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
>
> I'm getting three test failures and hope I can get someone to help.
>
> The test failures are  ipcs/mk-rm-msg, ipcs/mk-rm-sem, and ipcs/mk-rm-shm.
>
> Concentrating on mk-rm-msg, I found on the system:
>
> ./tests/output/ipcs/mk-rm-msg
> ./tests/ts/ipcs/mk-rm-msg
> ./tests/expected/ipcs/mk-rm-msg
>
> The contents of the output and the expected files are identical:

How have you checked it ?
Can be trailing spaces, final break line or other thing like this.
Can you share the files and the result of ./run.sh ipcs launch from
tests directory?


>
> Message queue id: <was_number>
> 1
> Message queue id: <was_number>
>
> I am running the tests as a non-privileged user.
>
> If I run the commands:
>
> $ ipcmk -Q  (returns 24)
> $ ipcs -q -i 24
> $ ipcrm -q 24
> $ echo $?
> 0
>
> Everything looks OK.  Does anyone have an idea why this test (these
> tests) are failing?
>
>    -- Bruce Dubbs
>       LFS

