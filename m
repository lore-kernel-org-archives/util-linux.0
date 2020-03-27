Return-Path: <SRS0=T2Wt=5M=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0E6C2D0E7
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 06:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B312076A
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 06:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lsZqiLXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC0GY2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:24:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46009 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgC0GYW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 27 Mar 2020 02:24:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id u59so9754746edc.12
        for <util-linux@vger.kernel.org>; Thu, 26 Mar 2020 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=En8EPJA/YzzaECS+i9To72vL6rgyNHQEvauTekaW9pw=;
        b=lsZqiLXLimB2w+h8NGKFvGT39Q8QhAUF3usiYDtZRvngQ2xUXZqHSsFTYugfHVF5nC
         dTRLU6RTTT9c227wNGwoPQwzVQLmw8XiT4e4z1NrYsp44MQe6ElxckfLlEAvPh2MrbbD
         GQEPNtFlMBA5v+sFoN6RWhoiObdFqrzLsu7xr6JdG+Ucg1AFEOlZwrBub8LH2r+xEGuN
         8rmPUUBmpuseOHsa1lCb66yohqsAe+ylpDQQYVc1MUzo0HqLJnYPBIX/0bkR3oqmYzg8
         afBrSNiHjlN3HMfMVxCemn7XSI9so+lJrzvoHK+/QTT0ib3JST/ZjCLN71Z2pvinNDE5
         3ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=En8EPJA/YzzaECS+i9To72vL6rgyNHQEvauTekaW9pw=;
        b=ees3f6GlrcJY1cGuhfYaj9rNWMr+P4LJMI46Swq2QKLncELPH+wngEMfm4l4v4ivxh
         ucdr8pu4aNiXCrqtdjnpFtoCsUU2TOzro/HeSTXmCwHd/EDFdgjivmMIZzm1wM80OhkA
         LiSmMcOYa5pFSsDaLTSjhL+4vU2Y83MDAbdpE+PkeeEAC9rEntbgfwrXYS7ZU4BeOZZr
         bsMnApM6Nww6JDNB0Ovs/7q6zbBkI9ueCPm51FTZ6eqkkDBaDF4xZMdOmNw33lN7EkE1
         1jigdtYIT5zW0cuvJiKoZyknw9Pz2j4qTJp+BSig4BIhkKFuOygOHzHeseT0byeBtjzH
         Y1ow==
X-Gm-Message-State: ANhLgQ2KYl88C+yT5wDvi8P+KDd9FOWoOVaiyFebSk/8VnpxlpfYt4DZ
        eVTZaHFV/9hJKqLCjQ5798DumI9NUYl9F4tKTbLLlA==
X-Google-Smtp-Source: ADFU+vut0FpmqM1vukJrRvJvQFHaReNNvfupgSirr1gMyo0DzB+Fv/I4K5Ii33mqnGXJ1w1T4A5KS4Y4qhdJvSt539o=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr10686413ejj.317.1585290259788;
 Thu, 26 Mar 2020 23:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200128093542.6908-1-david@redhat.com>
In-Reply-To: <20200128093542.6908-1-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 26 Mar 2020 23:24:08 -0700
Message-ID: <CAPcyv4jpdaNvJ67SkjyUJLBnBnXXQv686BiVW042g03FUmWLXw@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/base/memory.c: indicate all memory blocks as removable
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
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

On Tue, Jan 28, 2020 at 1:44 AM David Hildenbrand <david@redhat.com> wrote:
>
> We see multiple issues with the implementation/interface to compute
> whether a memory block can be offlined (exposed via
> /sys/devices/system/memory/memoryX/removable) and would like to simplify
> it (remove the implementation).
>
> 1. It runs basically lockless. While this might be good for performance,
>    we see possible races with memory offlining that will require at least
>    some sort of locking to fix.
>
> 2. Nowadays, more false positives are possible. No arch-specific checks
>    are performed that validate if memory offlining will not be denied
>    right away (and such check will require locking). For example, arm64
>    won't allow to offline any memory block that was added during boot -
>    which will imply a very high error rate. Other archs have other
>    constraints.
>
> 3. The interface is inherently racy. E.g., if a memory block is
>    detected to be removable (and was not a false positive at that time),
>    there is still no guarantee that offlining will actually succeed. So
>    any caller already has to deal with false positives.
>
> 4. It is unclear which performance benefit this interface actually
>    provides. The introducing commit 5c755e9fd813 ("memory-hotplug: add
>    sysfs removable attribute for hotplug memory remove") mentioned
>         "A user-level agent must be able to identify which sections of
>          memory are likely to be removable before attempting the
>          potentially expensive operation."
>    However, no actual performance comparison was included.
>
> Known users:
> - lsmem: Will group memory blocks based on the "removable" property. [1]
> - chmem: Indirect user. It has a RANGE mode where one can specify
>          removable ranges identified via lsmem to be offlined. However, it
>          also has a "SIZE" mode, which allows a sysadmin to skip the manual
>          "identify removable blocks" step. [2]
> - powerpc-utils: Uses the "removable" attribute to skip some memory
>                  blocks right away when trying to find some to
>                  offline+remove. However, with ballooning enabled, it
>                  already skips this information completely (because it
>                  once resulted in many false negatives). Therefore, the
>                  implementation can deal with false positives properly
>                  already. [3]
>
> According to Nathan Fontenot, DLPAR on powerpc is nowadays no longer
> driven from userspace via the drmgr command (powerpc-utils). Nowadays
> it's managed in the kernel - including onlining/offlining of memory
> blocks - triggered by drmgr writing to /sys/kernel/dlpar. So the
> affected legacy userspace handling is only active on old kernels. Only very
> old versions of drmgr on a new kernel (unlikely) might execute slower -
> totally acceptable.
>
> With CONFIG_MEMORY_HOTREMOVE, always indicating "removable" should not
> break any user space tool. We implement a very bad heuristic now.  Without
> CONFIG_MEMORY_HOTREMOVE we cannot offline anything, so report
> "not removable" as before.
>
> Original discussion can be found in [4] ("[PATCH RFC v1] mm:
> is_mem_section_removable() overhaul").
>
> Other users of is_mem_section_removable() will be removed next, so that
> we can remove is_mem_section_removable() completely.
>
> [1] http://man7.org/linux/man-pages/man1/lsmem.1.html
> [2] http://man7.org/linux/man-pages/man8/chmem.8.html
> [3] https://github.com/ibm-power-utilities/powerpc-utils
> [4] https://lkml.kernel.org/r/20200117105759.27905-1-david@redhat.com
>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>

David, Andrew,

I'd like to recommend this patch for -stable as it likely (test
underway) solves this crash report from Steve:

[  148.796036] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
[  148.796074] ------------[ cut here ]------------
[  148.796098] kernel BUG at include/linux/mm.h:1087!
[  148.796126] invalid opcode: 0000 [#1] SMP NOPTI
[  148.796146] CPU: 63 PID: 5471 Comm: lsmem Not tainted 5.5.10-200.fc31.x8=
6_64+debug #1
[  148.796173] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5=
C620.86B.02.01.0010.010620200716 01/06/2020
[  148.796212] RIP: 0010:is_mem_section_removable+0x1a4/0x1b0
[  148.796561] Call Trace:
[  148.796591]  removable_show+0x6e/0xa0
[  148.796608]  dev_attr_show+0x19/0x40
[  148.796625]  sysfs_kf_seq_show+0xa9/0x100
[  148.796640]  seq_read+0xd5/0x450
[  148.796657]  vfs_read+0xc5/0x180
[  148.796672]  ksys_read+0x68/0xe0
[  148.796688]  do_syscall_64+0x5c/0xa0
[  148.796704]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  148.796721] RIP: 0033:0x7f3ab1646412

...on a non-debug kernel it just crashes.

In this case lsmem is failing when reading memory96:

openat(3, "memory96/removable", O_RDONLY|O_CLOEXEC) = 4
fcntl(4, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
fstat(4, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
read(4,  <unfinished ...>)              = ?
+++ killed by SIGSEGV +++
Segmentation fault (core dumped)

...which is phys_index 0x60 => memory address 0x3000000000

On this platform that lands us here:

100000000-303fffffff : System RAM
  291f000000-291fe00f70 : Kernel code
  2920000000-292051efff : Kernel rodata
  2920600000-292093b0bf : Kernel data
  29214f3000-2922dfffff : Kernel bss
3040000000-305fffffff : Reserved
3060000000-1aa5fffffff : Persistent Memory

...where the last memory block of System RAM is shared with persistent
memory. I.e. the block is only partially online which means that
page_to_nid() in is_mem_section_removable() will assert or crash for
some of the offline pages in that block.
