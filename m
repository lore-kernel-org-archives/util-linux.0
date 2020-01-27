Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BF5C33CB1
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 13:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045AB20716
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 13:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJ93hWSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgA0Ne1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:34:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726029AbgA0Ne1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Jan 2020 08:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580132065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=TKAvTXVzm1MzDrmP8jUD3FXUmiynShS7FgS0aUVDSgw=;
        b=UJ93hWSNB7ubBoothoNoMVO4MAHsHwcIvOGHFasCQT9kTLV4CarI4Ii8OmMjHcpn+a7RXs
        m1JRkOd3MIJA89qnPU7FDyv1LdCgYh7qe7XeIk3qICixTR2CiieM8wJz6r+zdHZoEZEKg1
        4BtbUFEatxDboVHQN64LbeOAYViz36g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-MseUeNKJMkq-ZhsoUYldkA-1; Mon, 27 Jan 2020 08:34:21 -0500
X-MC-Unique: MseUeNKJMkq-ZhsoUYldkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DAFC8010C5;
        Mon, 27 Jan 2020 13:34:19 +0000 (UTC)
Received: from [10.36.118.65] (unknown [10.36.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 214915C219;
        Mon, 27 Jan 2020 13:34:15 +0000 (UTC)
Subject: Re: [PATCH RFC] drivers/base/memory.c: indicate all memory blocks as
 removable
To:     Michal Hocko <mhocko@kernel.org>
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
References: <20200124155336.17126-1-david@redhat.com>
 <20200127132950.GH1183@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <548fbb8f-9c05-fbf7-4413-b48eeb7e1c8e@redhat.com>
Date:   Mon, 27 Jan 2020 14:34:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200127132950.GH1183@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 27.01.20 14:29, Michal Hocko wrote:
> On Fri 24-01-20 16:53:36, David Hildenbrand wrote:
>> We see multiple issues with the implementation/interface to compute
>> whether a memory block can be offlined (exposed via
>> /sys/devices/system/memory/memoryX/removable) and would like to simplify
>> it (remove the implementation).
>>
>> 1. It runs basically lockless. While this might be good for performance,
>>    we see possible races with memory offlining/unplug that will require
>>    at least some sort of locking to fix.
>>
>> 2. Nowadays, more false positives are possible. No arch-specific checks
>>    are performed that validate if memory offlining will not be denied
>>    right away (and such check will require locking). For example, arm64
>>    won't allow to offline any memory block that was added during boot -
>>    which will imply a very high error rate. Other archs have other
>>    constraints.
>>
>> 3. The interface is inherently racy. E.g., if a memory block is
>>    detected to be removable (and was not a false positive at that time),
>>    there is still no guarantee that offlining will actually succeed. So
>>    any caller already has to deal with false positives.
>>
>> 4. It is unclear which performance benefit this interface actually
>>    provides. The introducing commit 5c755e9fd813 ("memory-hotplug: add
>>    sysfs removable attribute for hotplug memory remove") mentioned
>> 	"A user-level agent must be able to identify which sections of
>> 	 memory are likely to be removable before attempting the
>> 	 potentially expensive operation."
>>    However, no actual performance comparison was included.
>>
>> Known users:
>> - lsmem: Will group memory blocks based on the "removable" property. [1]
>> - chmem: Indirect user. It has a RANGE mode where one can specify
>> 	 removable ranges identified via lsmem to be offlined. However, it
>> 	 also has a "SIZE" mode, which allows a sysadmin to skip the manual
>> 	 "identify removable blocks" step. [2]
>> - powerpc-utils: Uses the "removable" attribute to skip some memory
>> 		 blocks right away when trying to find some to
>> 		 offline+remove. However, with ballooning enabled, it
>> 		 already skips this information completely (because it
>> 		 once resulted in many false negatives). Therefore, the
>> 		 implementation can deal with false positives properly
>> 		 already. [3]
>>
>> With CONFIG_MEMORY_HOTREMOVE, always indicating "removable" should not
>> break any user space tool. We implement a very bad heuristic now. (in
>> contrast: always returning "not removable" would at least affect
>> powerpc-utils)
>>
>> Without CONFIG_MEMORY_HOTREMOVE we cannot offline anything, so report
>> "not removable" as before.
>>
>> Original discussion can be found in [4] ("[PATCH RFC v1] mm:
>> is_mem_section_removable() overhaul").
>>
>> Other users of is_mem_section_removable() will be removed next, so that
>> we can remove is_mem_section_removable() completely.
>>
>> [1] http://man7.org/linux/man-pages/man1/lsmem.1.html
>> [2] http://man7.org/linux/man-pages/man8/chmem.8.html
>> [3] https://github.com/ibm-power-utilities/powerpc-utils
>> [4] https://lkml.kernel.org/r/20200117105759.27905-1-david@redhat.com
>>
>> Suggested-by: Michal Hocko <mhocko@kernel.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: powerpc-utils-devel@googlegroups.com
>> Cc: util-linux@vger.kernel.org
>> Cc: Badari Pulavarty <pbadari@us.ibm.com>
>> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>> Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Karel Zak <kzak@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Please add information provided by Nathan.
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Minor nit below.
> 
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +	return sprintf(buf, "1\n");
>> +#else
>> +	return sprintf(buf, "0\n");
>> +#endif
> 	int ret = IS_ENABLED(CONFIG_MEMORY_HOTREMOVE);
> 
> 	return sprintf(buf, "%d\n", ret)
> 
> would be slightly nicer than explicit ifdefs.
> 

Indeed, thanks!

-- 
Thanks,

David / dhildenb

