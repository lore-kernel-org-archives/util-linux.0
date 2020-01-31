Return-Path: <SRS0=dA+9=3U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C007C2D0DB
	for <util-linux@archiver.kernel.org>; Fri, 31 Jan 2020 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67A920705
	for <util-linux@archiver.kernel.org>; Fri, 31 Jan 2020 13:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neInFgb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgAaNlG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:41:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36206 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgAaNlG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 31 Jan 2020 08:41:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id g15so6598974otp.3;
        Fri, 31 Jan 2020 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aGpeKyJR1iFsXRgAHBYV7vw8xXda1xaF+C/R2cMOyEo=;
        b=neInFgb8zihR76fW+h/5uNTSmgYxnCuq2TsfPdO8JLF2TsJJbgQ58ikwcAz6zLTSTq
         PP+4VKHBDfeKVmlsgdoAMZu5rvNZXbG0n8ZCa04ANwJNSKYVXFD6VPoNpAOZCiMYXlTl
         s0WTGgUVQT9wUtBDMtQiqh4i/z75mjzwTuPasZmEw5DBfhzBlk8QRpHBXeNRcMHkizP5
         QSo5Uw1Lcl7rXasjXPI/YWMxpzWvdEjym95vXwH/ZpI27f2Nb0XmYGvXcc8kkFd0zGM1
         NeUMtb0nluVAx2MXXCBFhgK5Hl+NYatt2WxwEenYDhmU8XKbZzzP5gC4XeU69xyBm5LA
         2e/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aGpeKyJR1iFsXRgAHBYV7vw8xXda1xaF+C/R2cMOyEo=;
        b=CQY3FO1uHIzdoypt273Lf9/wQHgj6kGR8k5htw8GPDLUB3iGwgX7wQyuZOpaUx+Vnq
         xqZzuOMTj+b9+R37pUqEiC3D3t/SgiH67qLt5h6aglvGohZ6H6ximX0+RkTecK5dkmeW
         qI8KkweuLVH2uvXZ3MoG/zRm+F0ph2IMCPTv0aujardlkT8IVj2zKbai/ZHk7qmRS/cr
         5t1+qCtlNgKxfRGM1WlTUrAoPAG4D8psMbL9irZ/uOnk3lwGOY9kuz3sFBJS8aZcnC06
         1Sujsw7VfpA97ZbUszYYZMokQqzaihsAs+FBrcKTxOjysWaFMKQ1BM563U2D6YlIUC15
         2FVA==
X-Gm-Message-State: APjAAAVXlzw1Tcwf5jiJDcphozYK80GdDOtHJME6swHrKpzNZ6Y68Q3a
        trbX6LLfY69NfExxeNgTFw==
X-Google-Smtp-Source: APXvYqzZyyuZqsaiKMM55G0t7rq/4jtVMpxafRSXoVCyVXEI8yLu6hij2q3V1AQyD2ejx8+2ZwSR6A==
X-Received: by 2002:a9d:6e05:: with SMTP id e5mr7657175otr.46.1580478064841;
        Fri, 31 Jan 2020 05:41:04 -0800 (PST)
Received: from [172.31.9.147] (ausvpn.amd.com. [165.204.77.11])
        by smtp.gmail.com with ESMTPSA id x21sm3021644oto.5.2020.01.31.05.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 05:41:04 -0800 (PST)
Subject: Re: [PATCH v1] drivers/base/memory.c: indicate all memory blocks as
 removable
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        powerpc-utils-devel@googlegroups.com, util-linux@vger.kernel.org,
        Badari Pulavarty <pbadari@us.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Robert Jennings <rcj@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Karel Zak <kzak@redhat.com>
References: <20200128093542.6908-1-david@redhat.com>
From:   "Fontenot, Nathan" <ndfont@gmail.com>
Message-ID: <5bc61566-c701-ebc1-5ab8-0d411e9ac705@gmail.com>
Date:   Fri, 31 Jan 2020 07:41:02 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200128093542.6908-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 1/28/2020 3:35 AM, David Hildenbrand wrote:
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

Reviewed-by: Nathan Fontenot <ndfont@gmail.com>

> ---
> 
> RFC -> v1:
> - Use IS_ENABLED() instead of ifdefs
> - Add information from Nathan (thanks!)
> 
> ---
>  drivers/base/memory.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 6503f5d0b749..9664be00a4de 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -105,30 +105,13 @@ static ssize_t phys_index_show(struct device *dev,
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
> +	return sprintf(buf, "%d\n", (int)IS_ENABLED(CONFIG_MEMORY_HOTREMOVE));
>  }
>  
>  /*
> 
