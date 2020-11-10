Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E170C5517A
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 08:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BB72080A
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 08:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpAaauaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKJIEZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Nov 2020 03:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbgKJIEY (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Nov 2020 03:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604995463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5S/rM/gwRhiTYd0LlltKqM+5MJmWcsPpNsqW85/lpdU=;
        b=VpAaauaF+pnUnPZSRpL2ubHxjK39RdFOpW1PWAj82itBvDpwuRF1s05t7EvZbQlImMhe8f
        e7V9esJzNAv9bszPbGLHXwV//y5zczoynN1biwIV9AwB2QIkRajSwd20SwkDt6EZzXOQnK
        pADZtQ15ecFiNe44Z2UzLnJ61ycvgeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-e4_w0T7zPxyEMCKqgmBp1w-1; Tue, 10 Nov 2020 03:04:18 -0500
X-MC-Unique: e4_w0T7zPxyEMCKqgmBp1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B06211074653;
        Tue, 10 Nov 2020 08:04:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84AF119D7C;
        Tue, 10 Nov 2020 08:04:16 +0000 (UTC)
Date:   Tue, 10 Nov 2020 09:04:13 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     util-linux@vger.kernel.org, jbastian@redhat.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH v4 2/2] lscpu-arm: Remove hard corded model name of
 Cortex family and X-Gene
Message-ID: <20201110080413.xzd5dzc3nh3z6wqv@ws.net.home>
References: <20201109030403.26821-1-msys.mizuma@gmail.com>
 <20201109030403.26821-2-msys.mizuma@gmail.com>
 <20201109162331.blv7jd3gtui7es4o@ws.net.home>
 <20201109185127.imanchj6texi6lyn@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109185127.imanchj6texi6lyn@gabell>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Nov 09, 2020 at 01:51:27PM -0500, Masayoshi Mizuma wrote:
> On Mon, Nov 09, 2020 at 05:23:31PM +0100, Karel Zak wrote:
> > On Sun, Nov 08, 2020 at 10:04:03PM -0500, Masayoshi Mizuma wrote:
> > > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > > 
> > > Remove hard corded model name of Cortex family and X-Gene so that
> > > lscpu can show the model name using Processor Version of SMBIOS Type4.
> > 
> > Now I see on my system (Fedora) that:
> > 
> >  $ll /sys/firmware/dmi/entries/4-0/raw
> >  -r-------- 1 root root 0 Nov  9 17:19 /sys/firmware/dmi/entries/4-0/raw
> > 
> > it means it's not readable for non-root users. So, I guess the
> > hardcoded table can be still usable as a fallback solution if we want
> > to provide readable information for non-root.
> 
> Thanks, it's a really good point...
> lscpu changes the Vendoer ID and Model name depends on the user privilege.
> I think it may confuse users.
> 
> Why don't we remove Vendor ID and Model name when non-root runs lscpu?
> Or add a message to get Vendor ID and Model name like as follows?
> 
>     $ lscpu
>     ...
>     Vendor ID:                       (Need to run as root to show)
>     Model name:                      (Need to run as root to show)
>     ...

It seems like user unfriendly solution, especially if it works in the
current versions.

And in some cases model name is important to get readable output. Now,
I'm working on new lscpu to get support for system with multiple CPU
models in one system. For example Cortex-A53 and Cortex-A72 together:

Architecture:          x86_64
  Byte Order:          Little Endian
CPU(s):                6
  On-line CPU(s) list: 0-5
Vendor ID:             ARM
Model name:            Cortex-A53
  Model:               4
  Thread(s) per core:  1
  Core(s) per socket:  4
  Socket(s):           1
  Stepping:            r0p4
  CPU max MHz:         1416.0000
  CPU min MHz:         408.0000
  BogoMIPS:            48.00
  Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
Model name:            Cortex-A72
  Model:               2
  Thread(s) per core:  1
  Core(s) per socket:  2
  Socket(s):           1
  Stepping:            r0p2
  CPU max MHz:         1800.0000
  CPU min MHz:         408.0000
  BogoMIPS:            48.00
  Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
NUMA:                  
  NUMA node(s):        1
  NUMA node0 CPU(s):   0-5
Vulnerabilities:       
  Itlb multihit:       Not affected
  L1tf:                Not affected
  Mds:                 Not affected
  Meltdown:            Not affected
  Spec store bypass:   Not affected
  Spectre v1:          Mitigation; __user pointer sanitization
  Spectre v2:          Mitigation; Branch predictor hardening
  Tsx async abort:     Not affected



This output is generated from /sys and /proc dump where we have 0x
values in cpuinfo.

I guess we can use firmware as primary a source if available,
otherwise static tables with names, or print raw values (e.g. 0xd08)
as the last possibility.

lscpu is not marketing tool, we can use technical information there,
it' better than hide anything ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

