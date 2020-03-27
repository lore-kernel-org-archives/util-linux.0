Return-Path: <SRS0=T2Wt=5M=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4AFC2D0EE
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 09:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B6420723
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 09:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXlQsHBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0JAZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:00:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50653 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbgC0JAY (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 27 Mar 2020 05:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585299622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=w7C95T3X2ZVwfovtq/VtFggMuxjj6FAEJCWh9ND0sUQ=;
        b=TXlQsHBSBxDRQ06OsJG+XwD/YzFwjMb13muNAfLlMMqUeL32G4q8vbKnFKMoV7fc/MSaMS
        hy6nu4PvoT2ZKl4Q+0gZNMGVDaqRWMhncPm/2K9ctXJZptJpCec340hAoZO59JN5mrWQz6
        CiUgWxLCkPT6kRwZ0YJzFcWpUNOMFuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-YDuTn_vBMHWJymhbCWqbug-1; Fri, 27 Mar 2020 05:00:15 -0400
X-MC-Unique: YDuTn_vBMHWJymhbCWqbug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 602A9189F777;
        Fri, 27 Mar 2020 09:00:13 +0000 (UTC)
Received: from [10.36.112.108] (ovpn-112-108.ams2.redhat.com [10.36.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3E5396F9B;
        Fri, 27 Mar 2020 09:00:09 +0000 (UTC)
Subject: Re: [PATCH v1] drivers/base/memory.c: indicate all memory blocks as
 removable
To:     Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
References: <20200128093542.6908-1-david@redhat.com>
 <CAPcyv4jpdaNvJ67SkjyUJLBnBnXXQv686BiVW042g03FUmWLXw@mail.gmail.com>
 <20200327074718.GT27965@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <8c74afdc-98cb-dd48-c516-ff6e8b59d598@redhat.com>
Date:   Fri, 27 Mar 2020 10:00:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327074718.GT27965@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 27.03.20 08:47, Michal Hocko wrote:
> On Thu 26-03-20 23:24:08, Dan Williams wrote:
> [...]
>> David, Andrew,
>>
>> I'd like to recommend this patch for -stable as it likely (test
>> underway) solves this crash report from Steve:
>>
>> [  148.796036] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>> [  148.796074] ------------[ cut here ]------------
>> [  148.796098] kernel BUG at include/linux/mm.h:1087!
>> [  148.796126] invalid opcode: 0000 [#1] SMP NOPTI
>> [  148.796146] CPU: 63 PID: 5471 Comm: lsmem Not tainted 5.5.10-200.fc=
31.x8=3D
>> 6_64+debug #1
>> [  148.796173] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIO=
S SE5=3D
>> C620.86B.02.01.0010.010620200716 01/06/2020
>> [  148.796212] RIP: 0010:is_mem_section_removable+0x1a4/0x1b0
>> [  148.796561] Call Trace:
>> [  148.796591]  removable_show+0x6e/0xa0
>> [  148.796608]  dev_attr_show+0x19/0x40
>> [  148.796625]  sysfs_kf_seq_show+0xa9/0x100
>> [  148.796640]  seq_read+0xd5/0x450
>> [  148.796657]  vfs_read+0xc5/0x180
>> [  148.796672]  ksys_read+0x68/0xe0
>> [  148.796688]  do_syscall_64+0x5c/0xa0
>> [  148.796704]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [  148.796721] RIP: 0033:0x7f3ab1646412
>>
>> ...on a non-debug kernel it just crashes.
>>
>> In this case lsmem is failing when reading memory96:
>>
>> openat(3, "memory96/removable", O_RDONLY|O_CLOEXEC) =3D 4
>> fcntl(4, F_GETFL)                       =3D 0x8000 (flags O_RDONLY|O_L=
ARGEFILE)
>> fstat(4, {st_mode=3DS_IFREG|0444, st_size=3D4096, ...}) =3D 0
>> read(4,  <unfinished ...>)              =3D ?
>> +++ killed by SIGSEGV +++
>> Segmentation fault (core dumped)
>>
>> ...which is phys_index 0x60 =3D> memory address 0x3000000000
>>
>> On this platform that lands us here:
>>
>> 100000000-303fffffff : System RAM
>>   291f000000-291fe00f70 : Kernel code
>>   2920000000-292051efff : Kernel rodata
>>   2920600000-292093b0bf : Kernel data
>>   29214f3000-2922dfffff : Kernel bss
>> 3040000000-305fffffff : Reserved
>> 3060000000-1aa5fffffff : Persistent Memory
>=20
> OK, 2GB memblocks and that would mean [0x3000000000, 0x3080000000]
>=20
>> ...where the last memory block of System RAM is shared with persistent
>> memory. I.e. the block is only partially online which means that
>> page_to_nid() in is_mem_section_removable() will assert or crash for
>> some of the offline pages in that block.
>=20
> Yes, this patch is a simple workaround. Normal memory hotplug will not
> blow up because it should be able to find out that test_pages_in_a_zone
> is false. Who knows how other potential pfn walkers handle that.

All other pfn walkers now correctly use pfn_to_online_page() - which
will also result in false positives in this scenario and is still to be
fixed by Dan IIRC. [1]

>=20
> Risking to sound like a broken record I will remind that I have been
> pushing for having _all_ existing struct pages initialized and we
> wouldn't have problems like this popping out here and there.

The real issue is that we have uninitialized memmap within a section
that is marked to contain initialized/online memmap. As I said, even
pfn_to_online_page()/SECTION_IS_ONLINE does not help here.

Also, there is no way to mark devmem to have a initialized memmap
(something like SECTION_IS_ONLINE). I expressed my feeling about that
already.

[1] contains a discussion how it could be addressed.

>=20
> That being said, I do not have any objections to backporting to stable
> trees.
>=20

This one is one of the remaining places where we don't use
pfn_to_online_page(). So yeah, this patch shouldn't hurt.

[1] https://lkml.kernel.org/r/20191024120938.11237-1-david@redhat.com

--=20
Thanks,

David / dhildenb

