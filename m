Return-Path: <SRS0=T2Wt=5M=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D36C43331
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 16:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1460F20658
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 16:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fw4vZ9o6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgC0Q2N (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:28:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45044 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgC0Q2N (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 27 Mar 2020 12:28:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id i16so10966033edy.11
        for <util-linux@vger.kernel.org>; Fri, 27 Mar 2020 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DDvHtu2LPjFPTk6N1lekFV2ShYbYm5F3D1HLZEOy4c=;
        b=fw4vZ9o6IO+HeqP3Xok6kSfraOxkKRu3PTNnrtA1xuBEpKJw4E2lOL0cwe6R5C4/fS
         RhoOsxRVFEQ355RtKB3injRaQbeTDEMKkjGAXvMZTpncOv8V7sOpzZRls2ppexvsVyje
         8x3ynqj+MMtcZV9eDQORFww/0X7TksNVf8vHCgQK6tgnV9ImVXB0dqW03mf9gZdRHEQi
         9hPZQZLkYoG4j9gDWdgvLfOZNYWWH/kP7Ehqhdjt1+Mi5Qn90OXtTq6WURD/sChECIal
         D3e0+PY74OGxeKZUWDQx84QNiXzOKPB2pi2qAoCtUnVq+R4rydI8B2RaJ3TV2PtPsSOd
         TQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DDvHtu2LPjFPTk6N1lekFV2ShYbYm5F3D1HLZEOy4c=;
        b=LhNOkE6J9dTbR+AiimWDTr36MAWkP3gPWdZ2ui9yFQXDHhF1DDhy07+arYJ3rP8QZw
         lgOJqj0ND02eUONGwhHTeqfKF8PBUKKj3w8ixGIjYRfKJLcQ2GpKOHwZu+2mt8mf7Ps0
         PGvy/VfH3lBnI7BUNTY8PjIVDzz+xvuLSivhC+LbOtJqn34P5YDcgX+W4PO8DdToJHSe
         9LAmUmMum/uib5o9u83gZEfEWi0c3s/rAiDnR07+j1xZhGP/G6gSiaW01P+4zqz2aWC9
         RERE76CY5aIZA7jzcM334RXk7tRsNDnAoqMAfd2Q/4rlSIzKu5uJaXJrYx6LlmErBA48
         AOyA==
X-Gm-Message-State: ANhLgQ03bOEA5QasVDv4p64WOtzKr7Z1uZeAOAigodpgxTciAhsmMLWP
        SphRcWnR3SDCYfw91NCX1/0GguoUaA7iwqS5Co1M1Q==
X-Google-Smtp-Source: ADFU+vv9x1cRXR5JTTiwUKkMwnERnkbjfXRnFDDpWIPM5Fjuj1B/ZA0jL9dsfDKbMCnmWg8krWLCIRJeGHd6OtlGNmU=
X-Received: by 2002:aa7:d7c7:: with SMTP id e7mr13903000eds.296.1585326491184;
 Fri, 27 Mar 2020 09:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200128093542.6908-1-david@redhat.com> <CAPcyv4jpdaNvJ67SkjyUJLBnBnXXQv686BiVW042g03FUmWLXw@mail.gmail.com>
 <20200327074718.GT27965@dhcp22.suse.cz> <8c74afdc-98cb-dd48-c516-ff6e8b59d598@redhat.com>
In-Reply-To: <8c74afdc-98cb-dd48-c516-ff6e8b59d598@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 27 Mar 2020 09:28:00 -0700
Message-ID: <CAPcyv4jWG8zpK_fJ=JsnTX0d5zXmQsKap=6=CTtOQpD0iGCoMQ@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/base/memory.c: indicate all memory blocks as removable
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        powerpc-utils-devel@googlegroups.com, util-linux@vger.kernel.org,
        Badari Pulavarty <pbadari@us.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Robert Jennings <rcj@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Karel Zak <kzak@redhat.com>,
        "Scargall, Steve" <steve.scargall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Mar 27, 2020 at 2:00 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 27.03.20 08:47, Michal Hocko wrote:
> > On Thu 26-03-20 23:24:08, Dan Williams wrote:
> > [...]
> >> David, Andrew,
> >>
> >> I'd like to recommend this patch for -stable as it likely (test
> >> underway) solves this crash report from Steve:
> >>
> >> [  148.796036] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> >> [  148.796074] ------------[ cut here ]------------
> >> [  148.796098] kernel BUG at include/linux/mm.h:1087!
> >> [  148.796126] invalid opcode: 0000 [#1] SMP NOPTI
> >> [  148.796146] CPU: 63 PID: 5471 Comm: lsmem Not tainted 5.5.10-200.fc31.x8=
> >> 6_64+debug #1
> >> [  148.796173] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5=
> >> C620.86B.02.01.0010.010620200716 01/06/2020
> >> [  148.796212] RIP: 0010:is_mem_section_removable+0x1a4/0x1b0
> >> [  148.796561] Call Trace:
> >> [  148.796591]  removable_show+0x6e/0xa0
> >> [  148.796608]  dev_attr_show+0x19/0x40
> >> [  148.796625]  sysfs_kf_seq_show+0xa9/0x100
> >> [  148.796640]  seq_read+0xd5/0x450
> >> [  148.796657]  vfs_read+0xc5/0x180
> >> [  148.796672]  ksys_read+0x68/0xe0
> >> [  148.796688]  do_syscall_64+0x5c/0xa0
> >> [  148.796704]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >> [  148.796721] RIP: 0033:0x7f3ab1646412
> >>
> >> ...on a non-debug kernel it just crashes.
> >>
> >> In this case lsmem is failing when reading memory96:
> >>
> >> openat(3, "memory96/removable", O_RDONLY|O_CLOEXEC) = 4
> >> fcntl(4, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
> >> fstat(4, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
> >> read(4,  <unfinished ...>)              = ?
> >> +++ killed by SIGSEGV +++
> >> Segmentation fault (core dumped)
> >>
> >> ...which is phys_index 0x60 => memory address 0x3000000000
> >>
> >> On this platform that lands us here:
> >>
> >> 100000000-303fffffff : System RAM
> >>   291f000000-291fe00f70 : Kernel code
> >>   2920000000-292051efff : Kernel rodata
> >>   2920600000-292093b0bf : Kernel data
> >>   29214f3000-2922dfffff : Kernel bss
> >> 3040000000-305fffffff : Reserved
> >> 3060000000-1aa5fffffff : Persistent Memory
> >
> > OK, 2GB memblocks and that would mean [0x3000000000, 0x3080000000]
> >
> >> ...where the last memory block of System RAM is shared with persistent
> >> memory. I.e. the block is only partially online which means that
> >> page_to_nid() in is_mem_section_removable() will assert or crash for
> >> some of the offline pages in that block.
> >
> > Yes, this patch is a simple workaround. Normal memory hotplug will not
> > blow up because it should be able to find out that test_pages_in_a_zone
> > is false. Who knows how other potential pfn walkers handle that.
>
> All other pfn walkers now correctly use pfn_to_online_page() - which
> will also result in false positives in this scenario and is still to be
> fixed by Dan IIRC. [1]

Sorry, it's been too long and this fell out of my cache. I also turned
away once the major fire in KVM was put out with special consideration
for for devmem pages. What's left these days? ...besides
removable_show()?
