Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33ACC388F7
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AA321D79
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 14:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc9kebEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKMOsA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKMOsA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 13 Nov 2020 09:48:00 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80939C0613D1
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 06:48:00 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id p12so6798425qtp.7
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 06:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T2+5LTtbGC5TQr50rk8FZSPRyDL87HS1qcLE/pBreno=;
        b=fc9kebENVctfl4RHdXytdxgsFFcpAkJPD/V8e2ciHelvV3lxSaBjC6i2q8KOQt8VH4
         B/Ohuzsj99ZtK3aDFlfC8X53YiXWgvzAtDfgbevMc9YsMshWvkUWp4rPXrbI+2+eDVbr
         jc3gZfxL6KRt8hAWuRc+wMRosZZk78tMz2/zA1SEK6DiQBIK4Tin4bZDjheo5Ql/Bym0
         byHZTwt6K/PBbdS6wRWWfoPJkdMMXN1s1yk719Y4cM5V51ynF9toTCS6XcSdL02ClFMs
         XWsLHZyk07ip/vFrvWOAr1OGEJdgVYUVM2QuzVgQ2hqiZCobdTKaz+CDB4VlzUZdt5+H
         7SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T2+5LTtbGC5TQr50rk8FZSPRyDL87HS1qcLE/pBreno=;
        b=K806gF8H/+qgCE+CqtATaiglLkF0MWjezQAsSGEaEgJGddiBb4hE34RXbljMGn+k4f
         vPzt1jzs0ZOiyEh3TxMQ72E2FpS/IpDKIfbrIJjR9DpG9CUvmGv9dNLrCR+dIl/Rbd07
         XolcoBMD+Qc4lwzBIK2b22G90X7Q2wdRTovRm84B+7h0r51cdxEm3rmA/b+xhxA/392Q
         Nm4eXus5FdTD0NOcwsP5BvtGeJnYAKlzcI5sQ+cXcnG9OjaFkoVc6KJUcSVXeiY3HUNK
         Y5UvRaGk6em4Zauq7aPQg5zduMmjHXaXc/jYtxgpPfOw6s8XbWlfKblKKI4EIoA3ZYGL
         G3uA==
X-Gm-Message-State: AOAM532Eg/81IBt+W41MjVluWNtxvqf5dtdw/pElE5OwADLGOuW5ZodP
        4dLJfl26BwMSLsu76YF3hw==
X-Google-Smtp-Source: ABdhPJxwINnIyjeRa1YbuOTJNEOFIXO7hK6E81WUGOB4K0YtbW8O3oEJIINPslAY5DQjIw9/jJ7flA==
X-Received: by 2002:ac8:3417:: with SMTP id u23mr2231677qtb.80.1605278879795;
        Fri, 13 Nov 2020 06:47:59 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id 9sm6292594qty.30.2020.11.13.06.47.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Nov 2020 06:47:59 -0800 (PST)
Date:   Fri, 13 Nov 2020 09:47:57 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Cai Qian <qcai@redhat.com>
Subject: Re: new lscpu
Message-ID: <20201113144757.pkheoz77djpz3usy@gabell>
References: <20201113095352.5abeznymfp3lnvoo@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113095352.5abeznymfp3lnvoo@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Excellent job, thanks a lot!

Could you apply the following patch? That's because the build
on aarch64 machine fails.

  $ make lscpu
    CC       sys-utils/lscpu-lscpu-virt.o
  sys-utils/lscpu-virt.c: In function 'lscpu_read_virtualization':
  sys-utils/lscpu-virt.c:571:16: error: void value not ignored as it ought to be
     virt->vendor = read_hypervisor_cpuid();
                  ^
  make: *** [Makefile:11444: sys-utils/lscpu-lscpu-virt.o] Error 1
  $

---
 sys-utils/lscpu-virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/lscpu-virt.c b/sys-utils/lscpu-virt.c
index 5dabe031c..527f7caa4 100644
--- a/sys-utils/lscpu-virt.c
+++ b/sys-utils/lscpu-virt.c
@@ -377,8 +377,9 @@ none:
 }
 
 #else /* ! (__x86_64__ || __i386__) */
-static void read_hypervisor_cpuid(void)
+static int read_hypervisor_cpuid(void)
 {
+	return VIRT_VENDOR_NONE;
 }
 #endif
 
-- 
2.27.0

Thanks,
Masa

On Fri, Nov 13, 2020 at 10:53:52AM +0100, Karel Zak wrote:
> 
> Hi guys,
> 
> I have merged new lscpu(1) to our master branch. Changes:
>                                       
> * code is more readable and better structured (I hope)
> 
> * data about CPU and CPU-type are maintained in separate structs
> 
> * supports multiple CPU-types (model and topology) on one system
>   (the old version reads topology only from CPU0 only)
> 
>   Example from system with A53 and A72 with different number of cores:
>                                      
>         Vendor ID:              ARM   
>           Model name:           Cortex-A53                                     
>             Model:              4     
>             Thread(s) per core: 1     
>             Core(s) per socket: 4     
>             Socket(s):          1     
>             Stepping:           r0p4  
>             CPU max MHz:        1416.0000                                      
>             CPU min MHz:        408.0000                                       
>             BogoMIPS:           48.00 
>             Flags:              fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
>           Model name:           Cortex-A72                                     
>             Model:              2     
>             Thread(s) per core: 1     
>             Core(s) per socket: 2     
>             Socket(s):          1     
>             Stepping:           r0p2  
>             CPU max MHz:        1800.0000                                      
>             CPU min MHz:        408.0000
>             BogoMIPS:           48.00 
>             Flags:              fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
>                                       
>                                       
> * the default output on the terminal is organized in sections to make
>   it more readable for humans, non-terminal output (>file, |grep, etc) is
>   still "flat".
>                                       
> * the output for --extended and --parse provides more columns now 
>                                       
> * it uses cache IDs as exported by new kernels; it's possible that 
>   --extended and --parse cache identifiers will not start from zero. 
>   It's an expected change.
>                                       
> * all recent ARM related changes has been merged into the new code too
>                                       
> I have /sys and /proc dumps from many systems, but it's still possible
> that the new lscpu will print non-senses in some cases. Please, test
> it on your machines, exotic or unusual systems, etc. You know ... ;-)
> Thanks!
> 
>  Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 
