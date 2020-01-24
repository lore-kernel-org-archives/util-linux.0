Return-Path: <SRS0=7xEu=3N=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F711C2D0DB
	for <util-linux@archiver.kernel.org>; Fri, 24 Jan 2020 19:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13FE20709
	for <util-linux@archiver.kernel.org>; Fri, 24 Jan 2020 19:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHLeV5gR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391842AbgAXTK0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:10:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33129 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbgAXTKZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jan 2020 14:10:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so2690675otp.0;
        Fri, 24 Jan 2020 11:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rZpWws5nLxdJWxF6Q8KGCMAI9TyfuMXc7iT6zDqb+GA=;
        b=DHLeV5gRhvVzvCoRo2FHM2yTUaacNwWkVsx3Anj0cLRscA0gT1+DjtxUcKCefNL0/m
         adUhtug3FU2K8bHDQRRp0Jkes3THuwIVr+ztO+ThiQ0dRRHt1dWwNeRRhedMYFcWDtng
         xHAHYWjQiFZHFUbvuHrsii9aSIY8V7hVjMsuPYBgyOEiu3VNV5WgmPMKBJo7UfHvgOqG
         a0+Rvp5NJFobpUoXf5B4957b206r+DHtOwa5oyw2uMii7KOfK2jlj5WmzTCXv3Q35a2M
         yOLvDOLNOaUx1J32Mg76QV9oYV1BKbPvntKznBKmAAI7wnJlZ+/7MNgpy2u8JHueWF5v
         w1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZpWws5nLxdJWxF6Q8KGCMAI9TyfuMXc7iT6zDqb+GA=;
        b=FkLdDh4bjnWc271cYzeXOw2lFzQWmnEclowIKoIYnllvc5PzUi83UN4/aQYVy1Vlrb
         yE4s9ZtZsMIqPFu56T8z81At+Z613fIbrG5qTSQ8LHmjz4lQVNPYWa6M0NuMlg1jcsY+
         K/2tSDaxuKpeuYFRWAWc4LyR0nIj/Wpc079RcgJcrepTj6C2Apvhy4dDN3rrdzO70XM2
         tIS5C2HtqbBaqseteb9g3FUNQEkmlKIqaELHsLTa0AJ7hvfU3w58g58SbmFfUaT1u72g
         nb9p2mmLUaRUFXKriyxRrbOgO9m+V2RkRVH9HVo9jtl2P/1XfD/WUqmSmZaQMxXf+Odz
         12UA==
X-Gm-Message-State: APjAAAUxMu0RoDfv3llJWIS544RTzlG0FJCZk6k7fBEg1/KJZN7mISss
        LuGQIvWw42F4XTZkZQiMSg==
X-Google-Smtp-Source: APXvYqw83FvAE7X4iU36HKwq4flfcw4gdoNw+A1yGbKq21az3QaMN5lSol55uB7Fqwlq/0Ihi1OpHA==
X-Received: by 2002:a9d:5888:: with SMTP id x8mr3616737otg.361.1579893024855;
        Fri, 24 Jan 2020 11:10:24 -0800 (PST)
Received: from [10.236.30.189] ([165.204.77.1])
        by smtp.gmail.com with ESMTPSA id e17sm2233697otq.58.2020.01.24.11.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 11:10:24 -0800 (PST)
Subject: Re: [PATCH RFC] drivers/base/memory.c: indicate all memory blocks as
 removable
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        powerpc-utils-devel@googlegroups.com, util-linux@vger.kernel.org,
        Badari Pulavarty <pbadari@us.ibm.com>, ndfont@gmail.com,
        Robert Jennings <rcj@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Karel Zak <kzak@redhat.com>
References: <20200124155336.17126-1-david@redhat.com>
From:   "Fontenot, Nathan" <ndfont@gmail.com>
Message-ID: <ddb71703-81fa-53fe-51de-c018612f2704@gmail.com>
Date:   Fri, 24 Jan 2020 13:10:22 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124155336.17126-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

It's been awhile since I've looked at the powerpc-utils drmgr command and
pseries DLPAR code but a quick scan makes and it appears that it hasn't changed
too much. Given that, some thoughts.

The sysfs 'removable' file was a great help when memory DLPAR was driven
from userspace in the powerpc-utils drmgr command. Having this check did improve
performance though I can't point to any numbers.

Currently, memory DLPAR is done completely in the kernel. The request is
initiated from drmgr writing to /sys/kernel/dlpar (for pHyp partitions)
or from a hotplug interrupt (for guests). I don't believe the 'removable'
sysfs file is used in either of these paths by drmgr. The only time it is
used is on older kernels that do not support in-kernel memory DLPAR.

Given this, I don't think removing the 'removable' sysfs file would cause any
issues for the drmgr command. The only scenario I can think of is using an old
version of drmgr that does not support in-kernel memory DLPAR on a new kernel
where the 'removable' sysfs file has been removed. This doesn't seem likely
though and drmgr could be updated to detect this.

-Nathan Fontenot

On 1/24/2020 9:53 AM, David Hildenbrand wrote:
> We see multiple issues with the implementation/interface to compute
> whether a memory block can be offlined (exposed via
> /sys/devices/system/memory/memoryX/removable) and would like to simplify
> it (remove the implementation).
> 
> 1. It runs basically lockless. While this might be good for performance,
>    we see possible races with memory offlining/unplug that will require
>    at least some sort of locking to fix.
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
> 	"A user-level agent must be able to identify which sections of
> 	 memory are likely to be removable before attempting the
> 	 potentially expensive operation."
>    However, no actual performance comparison was included.

> 
> Known users:
> - lsmem: Will group memory blocks based on the "removable" property. [1]
> - chmem: Indirect user. It has a RANGE mode where one can specify
> 	 removable ranges identified via lsmem to be offlined. However, it
> 	 also has a "SIZE" mode, which allows a sysadmin to skip the manual
> 	 "identify removable blocks" step. [2]
> - powerpc-utils: Uses the "removable" attribute to skip some memory
> 		 blocks right away when trying to find some to
> 		 offline+remove. However, with ballooning enabled, it
> 		 already skips this information completely (because it
> 		 once resulted in many false negatives). Therefore, the
> 		 implementation can deal with false positives properly
> 		 already. [3]
> 
> With CONFIG_MEMORY_HOTREMOVE, always indicating "removable" should not
> break any user space tool. We implement a very bad heuristic now. (in
> contrast: always returning "not removable" would at least affect
> powerpc-utils)
> 
> Without CONFIG_MEMORY_HOTREMOVE we cannot offline anything, so report
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
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: powerpc-utils-devel@googlegroups.com
> Cc: util-linux@vger.kernel.org
> Cc: Badari Pulavarty <pbadari@us.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Karel Zak <kzak@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> 1. Are there any use cases that really require this interface to keep
>    producing "more reliable" results?
> 
> 2. Is there any real performance advantage when using this interface to
>    identify memory blocks to offline?
> 
> ---
>  drivers/base/memory.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 6503f5d0b749..d78a92f09984 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -105,30 +105,17 @@ static ssize_t phys_index_show(struct device *dev,
>  }
>  
>  /*
> - * Show whether the memory block is likely to be offlineable (or is already
> - * offline). Once offline, the memory block could be removed. The return
> - * value does, however, not indicate that there is a way to remove the
> - * memory block.
> + * Legacy interface that we cannot remove. Always indicate "removable"
> + * with CONFIG_MEMORY_HOTREMOVE - bad heuristic.
>   */
>  static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
>  {
> -	struct memory_block *mem = to_memory_block(dev);
> -	unsigned long pfn;
> -	int ret = 1, i;
> -
> -	if (mem->state != MEM_ONLINE)
> -		goto out;
> -
> -	for (i = 0; i < sections_per_block; i++) {
> -		if (!present_section_nr(mem->start_section_nr + i))
> -			continue;
> -		pfn = section_nr_to_pfn(mem->start_section_nr + i);
> -		ret &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
> -	}
> -
> -out:
> -	return sprintf(buf, "%d\n", ret);
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +	return sprintf(buf, "1\n");
> +#else
> +	return sprintf(buf, "0\n");
> +#endif
>  }
>  
>  /*
> 
