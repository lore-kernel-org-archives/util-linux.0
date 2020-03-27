Return-Path: <SRS0=T2Wt=5M=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76053C2D0E8
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 07:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5037B20737
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 07:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585295244;
	bh=6BfJqeZ5GPTg9LriPtdJ82fgs7cFEsDpX1K2rR/Uuo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Vc7EoWNDFOvybGojxnx5+85LIrR2GRNpscm5+z+lLOtEiAdgLrtN5zbsCNrqa89z
	 cKpgHC58Ae/UWPoD1t1e+sZmjLerTB1rh0Hu2FRpCVxhI8X5+QKWtiHhK1RY876GWb
	 RXE/5x8jszEq1Zpd8sJAl3PxafBGxCgQVMeb5LX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgC0HrX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 27 Mar 2020 03:47:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42560 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0HrX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 27 Mar 2020 03:47:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so10190323wrx.9;
        Fri, 27 Mar 2020 00:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qEZ5Ip7i9had6fEO82hFIkKLGs/LbFrnFrp/b642r5w=;
        b=hwwCKFL5YkFHIBvpIOVmsnmr1DbYJxQnxziwJVd9+AQ5AiHR4EuOYq1L3guSA/H/ZE
         kqOZjpr0X5Ok1+E4BD+HaKubx32fne3om02x7aHE0H9wlOtg6hsBvTjZT0AgcgTS3K1o
         VQKeSECOrm74vev2oO8PLCSkrYQsVv71xuDXeDKAH0DOOlQZP3VEIX6qi1URZBTXLCOq
         sbE6ff3A3WQ/5Xbp5dMk+a2G65aEL+UmJTu79K6m9SCGk02x+jHWpUnzhv9M4fFQdU15
         CPXuVOI5cPtRvDeTjUEvk+VA+qE2ivvhjP84y8O4oOUtY5viTZSNOcmFYlNeEYzIJzR5
         NwCw==
X-Gm-Message-State: ANhLgQ3wwp5BcVaVGQAbCsVJ9uFwK7S2V3TjuUQHq2DD0iuhj9BqxiS2
        dR6w9OJ+nsDNCQ9jDpZ45Fs=
X-Google-Smtp-Source: ADFU+vuuSo7T6YcHgxJxpJMJO9OFoszj9JySSGi9/4AourYAZav0KiQQ3z+vQhBmGWDP73/P6MkV9w==
X-Received: by 2002:adf:a448:: with SMTP id e8mr1057190wra.238.1585295241412;
        Fri, 27 Mar 2020 00:47:21 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id g14sm7306767wme.32.2020.03.27.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 00:47:20 -0700 (PDT)
Date:   Fri, 27 Mar 2020 08:47:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
Subject: Re: [PATCH v1] drivers/base/memory.c: indicate all memory blocks as
 removable
Message-ID: <20200327074718.GT27965@dhcp22.suse.cz>
References: <20200128093542.6908-1-david@redhat.com>
 <CAPcyv4jpdaNvJ67SkjyUJLBnBnXXQv686BiVW042g03FUmWLXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jpdaNvJ67SkjyUJLBnBnXXQv686BiVW042g03FUmWLXw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu 26-03-20 23:24:08, Dan Williams wrote:
[...]
> David, Andrew,
> 
> I'd like to recommend this patch for -stable as it likely (test
> underway) solves this crash report from Steve:
> 
> [  148.796036] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> [  148.796074] ------------[ cut here ]------------
> [  148.796098] kernel BUG at include/linux/mm.h:1087!
> [  148.796126] invalid opcode: 0000 [#1] SMP NOPTI
> [  148.796146] CPU: 63 PID: 5471 Comm: lsmem Not tainted 5.5.10-200.fc31.x8=
> 6_64+debug #1
> [  148.796173] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5=
> C620.86B.02.01.0010.010620200716 01/06/2020
> [  148.796212] RIP: 0010:is_mem_section_removable+0x1a4/0x1b0
> [  148.796561] Call Trace:
> [  148.796591]  removable_show+0x6e/0xa0
> [  148.796608]  dev_attr_show+0x19/0x40
> [  148.796625]  sysfs_kf_seq_show+0xa9/0x100
> [  148.796640]  seq_read+0xd5/0x450
> [  148.796657]  vfs_read+0xc5/0x180
> [  148.796672]  ksys_read+0x68/0xe0
> [  148.796688]  do_syscall_64+0x5c/0xa0
> [  148.796704]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  148.796721] RIP: 0033:0x7f3ab1646412
> 
> ...on a non-debug kernel it just crashes.
> 
> In this case lsmem is failing when reading memory96:
> 
> openat(3, "memory96/removable", O_RDONLY|O_CLOEXEC) = 4
> fcntl(4, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
> fstat(4, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
> read(4,  <unfinished ...>)              = ?
> +++ killed by SIGSEGV +++
> Segmentation fault (core dumped)
> 
> ...which is phys_index 0x60 => memory address 0x3000000000
> 
> On this platform that lands us here:
> 
> 100000000-303fffffff : System RAM
>   291f000000-291fe00f70 : Kernel code
>   2920000000-292051efff : Kernel rodata
>   2920600000-292093b0bf : Kernel data
>   29214f3000-2922dfffff : Kernel bss
> 3040000000-305fffffff : Reserved
> 3060000000-1aa5fffffff : Persistent Memory

OK, 2GB memblocks and that would mean [0x3000000000, 0x3080000000]

> ...where the last memory block of System RAM is shared with persistent
> memory. I.e. the block is only partially online which means that
> page_to_nid() in is_mem_section_removable() will assert or crash for
> some of the offline pages in that block.

Yes, this patch is a simple workaround. Normal memory hotplug will not
blow up because it should be able to find out that test_pages_in_a_zone
is false. Who knows how other potential pfn walkers handle that.

Risking to sound like a broken record I will remind that I have been
pushing for having _all_ existing struct pages initialized and we
wouldn't have problems like this popping out here and there.

That being said, I do not have any objections to backporting to stable
trees.
-- 
Michal Hocko
SUSE Labs
