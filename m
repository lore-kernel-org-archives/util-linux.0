Return-Path: <SRS0=+2nm=VA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D273C0650E
	for <util-linux@archiver.kernel.org>; Wed,  3 Jul 2019 16:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BA62189E
	for <util-linux@archiver.kernel.org>; Wed,  3 Jul 2019 16:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgFhBF2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfGCQhp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:37:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39830 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCQho (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 3 Jul 2019 12:37:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so3116059wma.4
        for <util-linux@vger.kernel.org>; Wed, 03 Jul 2019 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIMYuvENyeldpOgz8Cp5BoGLeTU64XW/rucWp6u0sWk=;
        b=QgFhBF2MKF3mYxj+GKqyDXoSfQG586JNVpHudvePGGZzuP15CHDwiWkSia2KIAYHho
         68RXwONbYsg45L2XnsBsfCP9UOTfc3o19SMstIunn3aEftEtuBYWuaZJmRjXwgEQztum
         kSc2BVW77YVLIoAamyew52a80hiobG/KpB6ycOwagmts3Rza+EQpuSqTjurXFA20uqlE
         KKZIl54B28R6BCa94cgG26T2RFEqPRxM1qWY9pa1V+SSc1tQjwkWm03iVePtxXQ2WtvU
         t4HEfx5VwbYyaD4oHEUyG9r15hmsEkvwc0O5vygRhkQL8kBWcNRthlsIWKJ97NNYtkX/
         O5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIMYuvENyeldpOgz8Cp5BoGLeTU64XW/rucWp6u0sWk=;
        b=BfNsqlzrDbTpnWRVgZ4ZomfB3ofIsRjSsWj3inJmvFnEltNrNbYNaepZDNlbVf8tX1
         DxZwyI5QmJS7rDIkVl202tWqWL6KaQ1uY6J/IIw6+365gewiDyEcVmkP+tyyWSdmCUYz
         Ysa24wKBUAWJc1OrcCMlULL0GRx6f8XM/5UIImowTrM9hFmpEh9YB3Az06TRHYHyKplR
         9PLpuzTqqoCg9n20++oANx4BzPhXindp/k2kCWLTFPn/upZrhObYHcsIei//Qdwzvsmj
         P6q+1aW7fkFTkZfT+t730G0SFoEC/DRRJBvGALCzKYYk8E/yPdak/6+PQ0vu4qaFrVTy
         hzRA==
X-Gm-Message-State: APjAAAWuoIGwdzjK3QKjMFfjm6UVuatilGyBDmSmYGCKr09W5Mrqv5SE
        5MVVb2q/eA4Q/eriU+uXX7tbkhD5Sg8VtVrjffckzywA
X-Google-Smtp-Source: APXvYqyx21Q/kO2bSiAL/G7uo1BYdL1SPhS36SV80PjbsghzxuzPFj871wk3qZOzkn6PLKkUE3hZIm14hQQRMgCKmBo=
X-Received: by 2002:a05:600c:2385:: with SMTP id m5mr232212wma.4.1562171862932;
 Wed, 03 Jul 2019 09:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190623223052.3345-1-unixmania@gmail.com> <20190624074114.oqz6s64pxgep562a@ws.net.home>
In-Reply-To: <20190624074114.oqz6s64pxgep562a@ws.net.home>
From:   Carlos Santos <unixmania@gmail.com>
Date:   Wed, 3 Jul 2019 13:37:31 -0300
Message-ID: <CAJ4jsafyxwqqScQ-Hi9vGhEbM2WExonm77ysohZDrVtNQoB+NA@mail.gmail.com>
Subject: Re: [PATCH v2] hwclock: define cmos_interface only if necessary
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 24, 2019 at 4:41 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Sun, Jun 23, 2019 at 07:30:52PM -0300, unixmania@gmail.com wrote:
> > Make the static declaration of the cmos_interface struct and related
> > functions conditional to i386/x86_64, preventing several "defined but
> > not used" compiler warnings.
>
> I think we have to be more aggressive :-) It would be better to:
>
> ./configure.ac:
>  * add --disable-hwclock-cmos
>  * add USE_HWCLOCK_CMOS (enabled by default for i386/x86_64)

I don't know much about autoconf. How can I test the target
architecture in config.ac.

>  * add define(USE_HWCLOCK_CMOS)
>
> sys-utils/Makemodule.am:
>  * compile hwclock-cmos.c only "if USE_HWCLOCK_CMOS"
>
> hwclock:
>  * remove all unnecessary #ifdefs from hwclock-cmos.c
>  * add #ifdef USE_HWCLOCK_CMOS to hwclock.c:determine_clock_access_method()
>
>
> Note that we already use the same for RTC (which is linux only).
>
> The result will be more readable hwclock-cmos.c and only optional cmos
> code compilation.

I just sent a third version of the patch comprising all these changes
except for the i386/x86_64 test.

-- 
Carlos Santos <unixmania@gmail.com>
