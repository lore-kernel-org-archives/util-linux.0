Return-Path: <SRS0=Ofmp=5L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E0BC43331
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 02:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60E020737
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 02:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCZCNu convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:13:50 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44996 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgCZCNu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 25 Mar 2020 22:13:50 -0400
Received: by mail-vk1-f194.google.com with SMTP id s194so1282909vkb.11
        for <util-linux@vger.kernel.org>; Wed, 25 Mar 2020 19:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3RVUK3NsKW4dplRgnoB3R2BWTklFBH1U/NnOmUhYgiM=;
        b=D9SgbCLaiLCujax++tDMbAKxy5nE6W/Yrrq0gCY3D4p0HCPn1cJ5LyGJH2cbhRc2M1
         Ze81fNHMu00FaxZrI7Wg5YGbe0/mIIvTNpwVHoehM+bqWNm0ztU9yf5mReZ2lwAmJfaL
         RXZqsrs28Hr0m4J6lmPmRSP8MCRUd2hS2hqwreiMTzNGD3pI2HFR8C77Rm6bq/6WS0uF
         8IKQoVo7hrC+AFLTZm9/jpV3Unlrnukz4he5XvgvrKPcz5X+gNHWSmun7S2SeyTCKxPz
         JETObROhxsVqiB6kcJ9FMX8atCF1W8JLxsbodYqA8y19zTtV8e9lwPseZCvhT09PvEmF
         5O9A==
X-Gm-Message-State: ANhLgQ1r228yBXEAs2uGWicTNxQRi/8wvxlGCWiE206OWilpjfnufx8n
        Ty5LBCwnvrqLM7AXXiNUQjnbYE1HyNvSu6aiTExhwx5d
X-Google-Smtp-Source: ADFU+vsgXBx99g+/rQSwoQ+ojSLAOl7QUJzyU8oPlMe3qhv+kQRk2yVKjbhrFr8+rq3sh/eUKDrnp6THH3gPuaodayk=
X-Received: by 2002:a05:6122:2d0:: with SMTP id k16mr4732169vki.54.1585188829200;
 Wed, 25 Mar 2020 19:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200324212625.6934-1-orel@melix.net> <CA+bjHUQtPfk5vDNbxSbxPzashLNG+MdLzy8HtZLbsOJ0C_fnzQ@mail.gmail.com>
 <CAA0A08WYct_BhybReWMkK_LXBS2L0DmmyNh2W8cp=kys9Q0R7g@mail.gmail.com>
In-Reply-To: <CAA0A08WYct_BhybReWMkK_LXBS2L0DmmyNh2W8cp=kys9Q0R7g@mail.gmail.com>
From:   Peter Cordes <peter@cordes.ca>
Date:   Wed, 25 Mar 2020 23:13:38 -0300
Message-ID: <CA+bjHURiQDMEp2UzxUX4ceop+o3Ebzr1z4zfSZWJDcaYTyN6Dg@mail.gmail.com>
Subject: Re: [PATCH] libuuid: improve uuid_unparse() performance
To:     =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 25, 2020 at 10:07 PM Aurélien Lajoie <orel@melix.net> wrote:
>
> On Wed, Mar 25, 2020 at 3:16 PM Peter Cordes <peter@cordes.ca> wrote:
> > If you really are bottlenecking on UUID throughput, see my SIMD answer
> > on https://stackoverflow.com/questions/53823756/how-to-convert-a-binary-integer-number-to-a-hex-string
> > with x86 SSE2 (baseline for x86-64), SSSE3, AVX2 variable-shift, and
> > AVX512VBMI integer -> hex manual vectorization
>
> I will take a look at it, but in a second time, I get your idea.
> I am not familiar with this, nice way to jumb on SIMD operations.

I can write that code with _mm_cmpgt_epi8 intrinsics from immintrin.h
if libuuid actually wants a patch add an #ifdef __SSE2__ version that
x86-64 can use all the time instead of the scalar version.  I'm very
familiar with x86 SIMD intrinsics so it would be easy for me to write
the code I'm already imagining in my head.  But it might not be worth
the trouble if it won't get merged because nobody wants to maintain
it.

 Also __SSSE3__,  __AVX2__, and __AVX512VBMI__ versions if we want
them, but those would only get enabled for people compiling libuuid
with  -march=native on their machines, or stuff like that.

Or we could even to runtime CPU detection to set a function pointer to
the version that's best for the current CPU.  SSSE3 helps a lot (byte
shuffle as a hexdigit LUT, and to line up data for the '-' gaps).  And
AVX512VBMI is fantastic for this on IceLake client/server.  It's only
called internally so we don't need to use the dynamic-link-time CPU
detection that glibc uses to resolve memset to for example
__memset_avx2_unaligned_erms, using a custom symbol resolver function.
We can see how much speedup we get from using more than SSE2 and
decide if it's worth the trouble.
