Return-Path: <SRS0=Ofmp=5L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F55C43331
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 23:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2E220663
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 23:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZXWY convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:22:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42908 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZXWX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 26 Mar 2020 19:22:23 -0400
Received: by mail-vs1-f65.google.com with SMTP id s10so5074048vsi.9
        for <util-linux@vger.kernel.org>; Thu, 26 Mar 2020 16:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7j/hE/86GlNETcnGjewd3xzekDJ0flWs08eMnj9pfis=;
        b=hz/+M18p6mnpZWWLQoOcxZcKNalOZ59D7s88TjyDmjeAx29FcQ8OvToNFlqzO3xsKZ
         I9DCcXLZ9IFLEo5S55TXbdotzqMJLYKvK2u+Q/XI6aVvRhkApJaaaA+NbE5rgS21MWRh
         WvaqOe20zp4125vhLsq/A6q/lE9nbPqKOeTvkBNEa4Y2Qtpj7MiuRDnUC2Hm36YlARo+
         UACjoVgE8vk5BTJIYDnsKb3RamQxn+1AHuWmNWSPZ/EzJT05FAM51Y/KUcieLkj/Uquh
         PzQXYtnOj5EDYVlNcd/JkkTiwyJN3QMktjR6d4np8T/G70MATUG+WQAYEBhqDG85PrDg
         SHtA==
X-Gm-Message-State: ANhLgQ3D6NcaefNswxdVuj/kn+KMqwU/1/MhCTy87X1Nz5oOvmY8eGDJ
        jX5ORdvsIJUofvPY7DYfD9JhMK1Ff86fVDfHDQU=
X-Google-Smtp-Source: ADFU+vumIqBgTU2lBXwP5MoeYxSQOwaFaU28mYyb5rXLbU4ZcbY/1ffRl/hWTrabxu20AWeZxOqBlXnjSbA5CD4cGhg=
X-Received: by 2002:a05:6102:2042:: with SMTP id q2mr9858308vsr.10.1585264942352;
 Thu, 26 Mar 2020 16:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200324212625.6934-1-orel@melix.net> <CA+bjHUQtPfk5vDNbxSbxPzashLNG+MdLzy8HtZLbsOJ0C_fnzQ@mail.gmail.com>
 <CAA0A08WYct_BhybReWMkK_LXBS2L0DmmyNh2W8cp=kys9Q0R7g@mail.gmail.com> <CA+bjHURiQDMEp2UzxUX4ceop+o3Ebzr1z4zfSZWJDcaYTyN6Dg@mail.gmail.com>
In-Reply-To: <CA+bjHURiQDMEp2UzxUX4ceop+o3Ebzr1z4zfSZWJDcaYTyN6Dg@mail.gmail.com>
From:   Peter Cordes <peter@cordes.ca>
Date:   Thu, 26 Mar 2020 20:22:11 -0300
Message-ID: <CA+bjHUSLC3BdGvpLUe7NWduL7a7Or2=Qe3DAbHtcDTgrBvbBHg@mail.gmail.com>
Subject: Re: [PATCH] libuuid: improve uuid_unparse() performance
To:     =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 25, 2020 at 11:13 PM Peter Cordes <peter@cordes.ca> wrote:
> I can write that code with _mm_cmpgt_epi8 intrinsics from immintrin.h
> if libuuid actually wants a patch add an #ifdef __SSE2__ version that
> x86-64 can use all the time instead of the scalar version.

I wrote SSE2 and SSSE3 versions, and timed them vs. scalar unrolled by
2 or fully rolled, on Skylake and Core 2.
https://godbolt.org/z/WB-C_y  self-contained with a main() you can
test.  Still a mess of comments and wrestling the compiler into
submission, not ready to make a patch yet.  But it looks like it works
as far as correctness goes.  Also an untested AVX512VBMI version that
might be 1.5 to 2x as fast as the SSSE3 version on CPUs that support
it (Ice Lake).  Inserting the dashes with a vpermb that does
merge-masking into a vector of dashes while putting the hex digits in
the right place into the first 32 bytes of the UUID is fun. :)

With everything hot in cache I get a nice 5.5x speedup from just SSE2
vs. partially-unrolled scalar loop, for gcc -O2 on Skylake.  That's
something distros can use for real.  It does need more static data,
but the total amount of static data still fits in one 64-byte cache
line, I think.  I-cache footprint is similar to the partially-unrolled
scalar loop, like 2 or 3 cache lines.

TIMES in seconds for 100 000 000 (100M) iterations, recorded with perf
stat on the whole executable because that's easy.

LUT is the table-lookup like Aurélien's code; CMOV is using c < 10 ?
c+'0' : c + (alpha_base-10); which compiles to a CMOV + ADD for x86,
or a CSEL + ADD for AArch64.  CMOV is 2 uops on Intel before
Broadwell, but Intel since Sandybridge can do 2 loads per clock cycle
so despite only loading single bytes (rather than a whole register and
shifting) the LUT version is faster and may not bottleneck on cache
load throughput.  non-x86 microarchitectures with fewer cache read
ports and more efficient conditionals might see a different tradeoff.

* Skylake @4.1GHz gcc9.3 -march=core2 -O2
(energy_performance_preference=performance so turbo ramps up near
instantly to ~4.1GHz)
* SSSE3 version: 0.175
* SSE2 version: 0.30
* scalar version: unrolled x2, LUT: 1.69
* scalar version: unrolled x2, CMOV: 2.19 (half each cmova 2 uops / cmovb 1 uop)
* scalar version: rolled up, LUT: 2.43
* scalar version: rolled up, CMOV: 2.64

The dash positions are at even i values so unrolling helps
significantly, doing that if() check less often.  i.e. the loop
overhead is much larger than most loops.  But this is might be fast
*enough* that spending more code size here could be unwise for overall
I-cache pressure when a large program uses this function.

So we have speedups from Aurélien's plain rolled up LUT version on
modern Intel, should be representative of Sandybridge-family at least
since Haswell, and probably similar on Zen:
* LUT rolled: 1x baseline
* LUT unrolled by 2:  1.4x on Skylake, possibly similar on some other
ISAs where I haven't written SIMD versions
* SSE2: 8x
* SSSE3: 13.8 x

So it might well be worth doing dynamic dispatch for the SSSE3 version
that can use x86's SIMD byte shuffle.  It has smaller code + data
footprints than the SSE2 version.  And I think the SSE2 version is
worth using; on x86-64 we never need a fallback to scalar.


Conroe (first-gen Core 2) @2.4GHz, same gcc9.3 -march=core2 -O2  (ran
the same binary over NFS)
* SSSE3: 1.21 (clang 1.08)
* SSE2 version: 1.00 (clang 0.880) clang9.0.1
* scalar version: unrolled x2, LUT: 2.88
* scalar version: unrolled x2, CMOV: 6.50
* scalar version: rolled up, LUT: 6.40
* scalar version: rolled up, CMOV: 7.64

Core 2 is sensitive to code alignment quirks that lead to decoding
bottlenecks; this is why Intel introduced a uop cache with
Sandybridge.  And various other stalls.  I expect the unroll vs.
rolled and LUT vs. CMOV numbers have a large error margin as far as
predicting performance on similar CPUs for other compiler versions or
for different quirks of code alignment.  But we still see a 3x
advantage for SIMD over the best scalar version.

Slow shuffle CPUs like Conroe/Merom do better with the SSE2 version.
Pre-Nehalem also have slow unaligned 16-byte loads/stores.
 We should prob. require SSE4 if dynamic dispatching; that would
exclude K8 and first-gen Core 2, although would exclude AMD K10 which
has fast shuffles.

-O3 typically fully unrolls the scalar loops. (clang does that even at
-O2 if you manually unroll the source by 2, probably undesirable).
SIMD doesn't change (much), scalar improves significantly in this
microbenchmark, but at the cost of larger I-cache footprint which
would hurt in real life in programs that care about doing other things
between calls to uuid_unparse() :P

Skylake @4.1GHz gcc9.3 -march=core2 -O3
 * SSSE3 version: 0.173
 * SSE2 version: 0.273
 * scalar version: unrolled x2, LUT: 0.95  // all are fully unrolled I assume
 * scalar version: unrolled x2, CMOV: 2.10 (half each cmova 2 uops /
cmovb 1 uop)
 * scalar version: unrolled x2, mixed: 1.34
 * scalar version: LUT: 0.95
 * scalar version: rolled up, CMOV: 2.54

Conroe @2.4GHz running gcc9.3 -march=core2 -O3
* SSSE3: 1.21
* SSE2 version: 0.965
* scalar version: unrolled x2, LUT: 2.37    // actually fully unrolled
* scalar version: unrolled x2, CMOV: 4.90
* scalar version: unrolled x2, mixed: 2.72

I'll hopefully get back to this and submit a patch, but if I don't,
anyone else is more than welcome to clean up my code and use it.  I
have ADHD and have a bad habit of leaving things unfinished. >.<
