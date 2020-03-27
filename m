Return-Path: <SRS0=T2Wt=5M=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC653C2D0EE
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 22:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FB52071B
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 22:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ETCX5PhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgC0WN4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:13:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41717 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC0WNz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 27 Mar 2020 18:13:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id v1so13164547edq.8
        for <util-linux@vger.kernel.org>; Fri, 27 Mar 2020 15:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCVUBLgBHDZcIZRf6NoWp0C6Kr3KipLNzlhyXozmmlw=;
        b=ETCX5PhCo24cVzcgcD3xkya0lwtT/cA4TwO0qLWJnEbKqip92vs6gdTLNztvbrSM1f
         o6edaJDVt6l374Pf8huMGp03L1vMwFsDaamOJJpGgZK5iHN/M0tAz8N9i0rJMvPwGBRA
         MsrLmkzyX+aI5EGh6Kk6Qo7G+9EwvDzoH0E4/A/pajr013wBFXR9Wgs+OYcRbNf55NSW
         fgy3FMcz8IVTVDIE+o/XKJHRzr8gOabjALMWxKpa+NHTxXYeEtIm8QZSEBJdfy8M4zJ8
         SWxKFbK4z3NPwnCPiyhr/EoSQ2CCbiRaxnjWQjufg9Hl6X38TuRmYk9QRjC9RZmMXq1e
         IrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCVUBLgBHDZcIZRf6NoWp0C6Kr3KipLNzlhyXozmmlw=;
        b=POsZ94ErEZZY73Grh6ShP6tBia7nkrTrJTDOI/46W2q0+wIF4bYWnHjAyA7KMC7B1p
         NlnBmHaCYVM47rkPPc22Li+plPfm8dlg2hrGbD3FP07M3/vdp7S/dfSeXuukd8Jhe8dG
         uM+e4mj2A877TpmuPf9FGgwWbv4sLqole5SrKwX7fbNpU5QNqnJejQek8b5YnTkV+2Od
         wawXWEGZE7p+21EfVoHrQhWRE5jJE6YPv8WWm44BBnlPcZYXOpMXGe2AYpu7OKA2GDgg
         CVd+Jgx/SrDe4h1D6ZoxAjmY37g15Ko/LlOdVygGBh2I11WLq/Yr4MaSpkcOQ87t+sTG
         1m4A==
X-Gm-Message-State: ANhLgQ0zNvAd+tJtRuaRRlSS8VrPgw6rBwXFaN3xj9zLi31PT2UOGbhj
        CSzEbv5qJz0Ig+UTtbGOuEA02DrUl+Y+H1K66y2XnQ==
X-Google-Smtp-Source: ADFU+vtAbnzVkX6Vs+Nr4fHInTxsPNa4v4+l2BKtGqUDt4f1VHnniOTQ4zXs9yW7NzlsnsfqbKmrXXxr3Eulo7+DciQ=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr1140036ejj.317.1585347233005;
 Fri, 27 Mar 2020 15:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200128093542.6908-1-david@redhat.com> <CAPcyv4jpdaNvJ67SkjyUJLBnBnXXQv686BiVW042g03FUmWLXw@mail.gmail.com>
 <20200327074718.GT27965@dhcp22.suse.cz> <8c74afdc-98cb-dd48-c516-ff6e8b59d598@redhat.com>
 <CAPcyv4jWG8zpK_fJ=JsnTX0d5zXmQsKap=6=CTtOQpD0iGCoMQ@mail.gmail.com> <1bf9777b-90a1-35be-b909-facf1812f91e@redhat.com>
In-Reply-To: <1bf9777b-90a1-35be-b909-facf1812f91e@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 27 Mar 2020 15:13:41 -0700
Message-ID: <CAPcyv4jYG8djxq2r=Obosq6VPG2CrR0y24N6vpqhTTvfYNbNKg@mail.gmail.com>
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

On Fri, Mar 27, 2020 at 9:50 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 27.03.20 17:28, Dan Williams wrote:
> > On Fri, Mar 27, 2020 at 2:00 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 27.03.20 08:47, Michal Hocko wrote:
> >>> On Thu 26-03-20 23:24:08, Dan Williams wrote:
> >>> [...]
> >>>> David, Andrew,
> >>>>
> >>>> I'd like to recommend this patch for -stable as it likely (test
> >>>> underway) solves this crash report from Steve:
> >>>>
> >>>> [  148.796036] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> >>>> [  148.796074] ------------[ cut here ]------------
> >>>> [  148.796098] kernel BUG at include/linux/mm.h:1087!
> >>>> [  148.796126] invalid opcode: 0000 [#1] SMP NOPTI
> >>>> [  148.796146] CPU: 63 PID: 5471 Comm: lsmem Not tainted 5.5.10-200.fc31.x8=
> >>>> 6_64+debug #1
> >>>> [  148.796173] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5=
> >>>> C620.86B.02.01.0010.010620200716 01/06/2020
> >>>> [  148.796212] RIP: 0010:is_mem_section_removable+0x1a4/0x1b0
> >>>> [  148.796561] Call Trace:
> >>>> [  148.796591]  removable_show+0x6e/0xa0
> >>>> [  148.796608]  dev_attr_show+0x19/0x40
> >>>> [  148.796625]  sysfs_kf_seq_show+0xa9/0x100
> >>>> [  148.796640]  seq_read+0xd5/0x450
> >>>> [  148.796657]  vfs_read+0xc5/0x180
> >>>> [  148.796672]  ksys_read+0x68/0xe0
> >>>> [  148.796688]  do_syscall_64+0x5c/0xa0
> >>>> [  148.796704]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>>> [  148.796721] RIP: 0033:0x7f3ab1646412
> >>>>
> >>>> ...on a non-debug kernel it just crashes.
> >>>>
> >>>> In this case lsmem is failing when reading memory96:
> >>>>
> >>>> openat(3, "memory96/removable", O_RDONLY|O_CLOEXEC) = 4
> >>>> fcntl(4, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
> >>>> fstat(4, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
> >>>> read(4,  <unfinished ...>)              = ?
> >>>> +++ killed by SIGSEGV +++
> >>>> Segmentation fault (core dumped)
> >>>>
> >>>> ...which is phys_index 0x60 => memory address 0x3000000000
> >>>>
> >>>> On this platform that lands us here:
> >>>>
> >>>> 100000000-303fffffff : System RAM
> >>>>   291f000000-291fe00f70 : Kernel code
> >>>>   2920000000-292051efff : Kernel rodata
> >>>>   2920600000-292093b0bf : Kernel data
> >>>>   29214f3000-2922dfffff : Kernel bss
> >>>> 3040000000-305fffffff : Reserved
> >>>> 3060000000-1aa5fffffff : Persistent Memory
> >>>
> >>> OK, 2GB memblocks and that would mean [0x3000000000, 0x3080000000]
> >>>
> >>>> ...where the last memory block of System RAM is shared with persistent
> >>>> memory. I.e. the block is only partially online which means that
> >>>> page_to_nid() in is_mem_section_removable() will assert or crash for
> >>>> some of the offline pages in that block.
> >>>
> >>> Yes, this patch is a simple workaround. Normal memory hotplug will not
> >>> blow up because it should be able to find out that test_pages_in_a_zone
> >>> is false. Who knows how other potential pfn walkers handle that.
> >>
> >> All other pfn walkers now correctly use pfn_to_online_page() - which
> >> will also result in false positives in this scenario and is still to be
> >> fixed by Dan IIRC. [1]
> >
> > Sorry, it's been too long and this fell out of my cache. I also turned
> > away once the major fire in KVM was put out with special consideration
> > for for devmem pages. What's left these days? ...besides
> > removable_show()?
>
> Essentially any pfn_to_online_page() is a candidate.
>
> E.g.,
>
> mm/memory-failure.c:memory_failure()
>
> is obviously broken (could be worked around)

Ooh, the current state looks worse than when I looked previously. I
wasn't copied on commit 96c804a6ae8c ("mm/memory-failure.c: don't
access uninitialized memmaps in memory_failure()"). That commit seems
to ensure the pmem errors in memory sections that overlap with
System-RAM are not handled. So that change looks broken to me.
Previously get_devpagemap() was sufficient protection.

>
> Also
>
> mm/memory-failure.c:soft_offline_page()
>
> is obviously broken.

How exactly? The soft_offline_page() callers seem to already account
for System-RAM vs devmem.

>
>
> Also set_zone_contiguous()->__pageblock_pfn_to_page() is broken, when it
> checks for "page_zone(start_page) != zone" if the memmap contains garbage.
>
> And I only checked a handful of examples.

Ok, but as the first example shows in the absence of a problem report
these pre-emptive changes might make things worse so I don't think
it's as simple as go instrument all the pfn_to_online_page() users.
