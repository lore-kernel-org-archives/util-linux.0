Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC2C33CB7
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558AA22464
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 13:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580131794;
	bh=ai/dj2YFPgI/Sl1U6CLzSQboFkc0rAe++51s5B+lTWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c5ULpL6QkhklAj0mEkNB+ErwIshp8vi479ABTPH+A+OmhvyQnJmiKoad+iu3sYpMv
	 +2TNmFV+oSeNSHSzqUKDSt8A8hEnv+i+lYcrHyAn4Ohc7a7mhRyphaIkXhNwUPZK/D
	 828+DuKS/6OjKQKxkOhx3WTzROo3M4qMV+jXKhXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgA0N3x (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:29:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40883 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgA0N3x (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Jan 2020 08:29:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so11295686wrn.7;
        Mon, 27 Jan 2020 05:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U0eQycVZcE3O8afEj675IsnFK3PsSZu1C9KgNaCL9Xo=;
        b=dwLGeVGCUHAawz/1VAH7jLVpXGmTu2GY8fPsMyvAykeeL/SVIhm7QjpuVIQIFJjB3w
         OtT4YD0AfZr7iI0CU/dBpcuf/70IX/ZsBF+Wz86naJHGWgNzIOPMegoWdUWxRA6A0nFC
         8hh6RWyiFB2XchQ+YnZhVuCs1sZYFX/3ZpNjpxX6xjBHlEVn7X/ArmaZAiS8zJff7dAw
         gQrB3UeH34y+KGr1WN7fgtAGNunN9C9G4Flj7vlEcnAV3uiUQPEV2QQC1EyIqH9vaPRi
         6L5xkYQ+vjRGuInrlvtuy+QySOvXF8RrSWt0qETOm0Avh6K+ze74cIgwQaG4uCmVt73k
         aQpg==
X-Gm-Message-State: APjAAAUczFYTcstv7ptgqRJBf07Mk2KXIPj8aMAZJyX0HhVSqREudXOL
        IW2YxO6LgSATB/fs7PQ/D3A=
X-Google-Smtp-Source: APXvYqyVFRZyGR6ELFEgDXR5Vlxa3HsmlnZMCI92BdfDk38nRTyMVa5dEynNWcKUUuYcFaxqVD+IkA==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr20770480wrq.232.1580131791360;
        Mon, 27 Jan 2020 05:29:51 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y20sm18183543wmi.25.2020.01.27.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:29:50 -0800 (PST)
Date:   Mon, 27 Jan 2020 14:29:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
Subject: Re: [PATCH RFC] drivers/base/memory.c: indicate all memory blocks as
 removable
Message-ID: <20200127132950.GH1183@dhcp22.suse.cz>
References: <20200124155336.17126-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124155336.17126-1-david@redhat.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri 24-01-20 16:53:36, David Hildenbrand wrote:
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

Please add information provided by Nathan.
Acked-by: Michal Hocko <mhocko@suse.com>

Minor nit below.

> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +	return sprintf(buf, "1\n");
> +#else
> +	return sprintf(buf, "0\n");
> +#endif
	int ret = IS_ENABLED(CONFIG_MEMORY_HOTREMOVE);

	return sprintf(buf, "%d\n", ret)

would be slightly nicer than explicit ifdefs.
-- 
Michal Hocko
SUSE Labs
