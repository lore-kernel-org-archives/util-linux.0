Return-Path: <SRS0=T2Wt=5M=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22256C2D0E5
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 22:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAED820663
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 22:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA8cLSpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgC0WnB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:43:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46928 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727754AbgC0WnA (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585348979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Mzj3ADDwHK3OZxpDobYVftdFd+qF9R9aBxcCpPNr+U=;
        b=YA8cLSpWcI49T8nF58hEQ4L8/SmjvQcCMgWx5XNcOEg5LgDZHvWmDnQL1bwgARh27JON4I
        tePBVwJQz7mNtsYCCjsdkogP8oy/K8ZRQBlyGl2NVopcLQ8f3TOiJ3YTeHxc9O/4FG+cJA
        IrVoZnAf6mAvGBsvk9+vZERVEVjN9iI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-TYMkUUUIO7u-GvmI1jC1cg-1; Fri, 27 Mar 2020 18:42:57 -0400
X-MC-Unique: TYMkUUUIO7u-GvmI1jC1cg-1
Received: by mail-wr1-f72.google.com with SMTP id t25so2898830wrb.16
        for <util-linux@vger.kernel.org>; Fri, 27 Mar 2020 15:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4Mzj3ADDwHK3OZxpDobYVftdFd+qF9R9aBxcCpPNr+U=;
        b=LYxrMNJLinBegJ/f5YWz3ijbGMH6YGn0md0bCaXTLewu2CDodkoxn5gQNkJlie0vtf
         51Sy6hAfca8Gltt3+gTbuzcxKu7S9wPtoSTWztY/C0jj1oRTiA69ztD+KNJfjhYV8D+u
         w/ZBunyIP0lYCKqHro97F2Ita7UaRom2TWWtRIt8GfuHBZFk8MSzNc00bQcyaQpCoCbX
         Pka7hkRWo5yf+lWVat7YNR8EM4TWAdEZ2Z6SCOtYremjFIlVPb92SwKZsJ5ES7yWHzPT
         sbXGwpfzk3RSeuqQqVFhalGaoNiczXip8cnez0orw9bYk5YXY5hrEgYeK004/WgJa8lj
         5rEA==
X-Gm-Message-State: ANhLgQ1L3KIM5dAJAYil+D7htVFHQK7SsYhsVYoyIXh1d/Ps14wOJ1td
        LJBnBFFzsoZFBlU0kYpzDLn43pMLF1nnlgsHowwBlTTaTVzvGGbyIleXTV1S9998+w/uHSGCel1
        B7bxocp8jUiRTTQgNaykgaQ==
X-Received: by 2002:a1c:1d48:: with SMTP id d69mr967959wmd.166.1585348976107;
        Fri, 27 Mar 2020 15:42:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvht9CnqI023WuyvRzJ486mByWv2gyDxVbdP8TdugWtI1ObphZr39PiEAYB16jEmau7Kp4AJA==
X-Received: by 2002:a1c:1d48:: with SMTP id d69mr967943wmd.166.1585348975798;
        Fri, 27 Mar 2020 15:42:55 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C6821.dip0.t-ipconnect.de. [91.12.104.33])
        by smtp.gmail.com with ESMTPSA id 195sm10017222wmb.8.2020.03.27.15.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:42:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] drivers/base/memory.c: indicate all memory blocks as removable
Date:   Fri, 27 Mar 2020 23:42:54 +0100
Message-Id: <700D7668-8E47-4691-8E9F-97A544D660CE@redhat.com>
References: <CAPcyv4jYG8djxq2r=Obosq6VPG2CrR0y24N6vpqhTTvfYNbNKg@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
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
In-Reply-To: <CAPcyv4jYG8djxq2r=Obosq6VPG2CrR0y24N6vpqhTTvfYNbNKg@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17D50)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



> Am 27.03.2020 um 23:13 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFOn Fri, Mar 27, 2020 at 9:50 AM David Hildenbrand <david@redhat.c=
om> wrote:
>>=20
>>> On 27.03.20 17:28, Dan Williams wrote:
>>> On Fri, Mar 27, 2020 at 2:00 AM David Hildenbrand <david@redhat.com> wro=
te:
>>>>=20
>>>> On 27.03.20 08:47, Michal Hocko wrote:
>>>>> On Thu 26-03-20 23:24:08, Dan Williams wrote:
>>>>> [...]
>>>>>> David, Andrew,
>>>>>>=20
>>>>>> I'd like to recommend this patch for -stable as it likely (test
>>>>>> underway) solves this crash report from Steve:
>>>>>>=20
>>>>>> [  148.796036] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>>>>>> [  148.796074] ------------[ cut here ]------------
>>>>>> [  148.796098] kernel BUG at include/linux/mm.h:1087!
>>>>>> [  148.796126] invalid opcode: 0000 [#1] SMP NOPTI
>>>>>> [  148.796146] CPU: 63 PID: 5471 Comm: lsmem Not tainted 5.5.10-200.f=
c31.x8=3D
>>>>>> 6_64+debug #1
>>>>>> [  148.796173] Hardware name: Intel Corporation S2600WFD/S2600WFD, BI=
OS SE5=3D
>>>>>> C620.86B.02.01.0010.010620200716 01/06/2020
>>>>>> [  148.796212] RIP: 0010:is_mem_section_removable+0x1a4/0x1b0
>>>>>> [  148.796561] Call Trace:
>>>>>> [  148.796591]  removable_show+0x6e/0xa0
>>>>>> [  148.796608]  dev_attr_show+0x19/0x40
>>>>>> [  148.796625]  sysfs_kf_seq_show+0xa9/0x100
>>>>>> [  148.796640]  seq_read+0xd5/0x450
>>>>>> [  148.796657]  vfs_read+0xc5/0x180
>>>>>> [  148.796672]  ksys_read+0x68/0xe0
>>>>>> [  148.796688]  do_syscall_64+0x5c/0xa0
>>>>>> [  148.796704]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>>> [  148.796721] RIP: 0033:0x7f3ab1646412
>>>>>>=20
>>>>>> ...on a non-debug kernel it just crashes.
>>>>>>=20
>>>>>> In this case lsmem is failing when reading memory96:
>>>>>>=20
>>>>>> openat(3, "memory96/removable", O_RDONLY|O_CLOEXEC) =3D 4
>>>>>> fcntl(4, F_GETFL)                       =3D 0x8000 (flags O_RDONLY|O_=
LARGEFILE)
>>>>>> fstat(4, {st_mode=3DS_IFREG|0444, st_size=3D4096, ...}) =3D 0
>>>>>> read(4,  <unfinished ...>)              =3D ?
>>>>>> +++ killed by SIGSEGV +++
>>>>>> Segmentation fault (core dumped)
>>>>>>=20
>>>>>> ...which is phys_index 0x60 =3D> memory address 0x3000000000
>>>>>>=20
>>>>>> On this platform that lands us here:
>>>>>>=20
>>>>>> 100000000-303fffffff : System RAM
>>>>>>  291f000000-291fe00f70 : Kernel code
>>>>>>  2920000000-292051efff : Kernel rodata
>>>>>>  2920600000-292093b0bf : Kernel data
>>>>>>  29214f3000-2922dfffff : Kernel bss
>>>>>> 3040000000-305fffffff : Reserved
>>>>>> 3060000000-1aa5fffffff : Persistent Memory
>>>>>=20
>>>>> OK, 2GB memblocks and that would mean [0x3000000000, 0x3080000000]
>>>>>=20
>>>>>> ...where the last memory block of System RAM is shared with persisten=
t
>>>>>> memory. I.e. the block is only partially online which means that
>>>>>> page_to_nid() in is_mem_section_removable() will assert or crash for
>>>>>> some of the offline pages in that block.
>>>>>=20
>>>>> Yes, this patch is a simple workaround. Normal memory hotplug will not=

>>>>> blow up because it should be able to find out that test_pages_in_a_zon=
e
>>>>> is false. Who knows how other potential pfn walkers handle that.
>>>>=20
>>>> All other pfn walkers now correctly use pfn_to_online_page() - which
>>>> will also result in false positives in this scenario and is still to be=

>>>> fixed by Dan IIRC. [1]
>>>=20
>>> Sorry, it's been too long and this fell out of my cache. I also turned
>>> away once the major fire in KVM was put out with special consideration
>>> for for devmem pages. What's left these days? ...besides
>>> removable_show()?
>>=20
>> Essentially any pfn_to_online_page() is a candidate.
>>=20
>> E.g.,
>>=20
>> mm/memory-failure.c:memory_failure()
>>=20
>> is obviously broken (could be worked around)
>=20
> Ooh, the current state looks worse than when I looked previously. I
> wasn't copied on commit 96c804a6ae8c ("mm/memory-failure.c: don't
> access uninitialized memmaps in memory_failure()"). That commit seems
> to ensure the pmem errors in memory sections that overlap with
> System-RAM are not handled. So that change looks broken to me.
> Previously get_devpagemap() was sufficient protection.
>=20

Well, it went in before we learned that pfn_to_online_page() is now broken i=
n corner cases since sub-section hotadd.


>>=20
>> Also
>>=20
>> mm/memory-failure.c:soft_offline_page()
>>=20
>> is obviously broken.
>=20
> How exactly? The soft_offline_page() callers seem to already account
> for System-RAM vs devmem.

Then my quick scan was maybe wrong :)

>=20
>>=20
>>=20
>> Also set_zone_contiguous()->__pageblock_pfn_to_page() is broken, when it
>> checks for "page_zone(start_page) !=3D zone" if the memmap contains garba=
ge.
>>=20
>> And I only checked a handful of examples.
>=20
> Ok, but as the first example shows in the absence of a problem report
> these pre-emptive changes might make things worse so I don't think
> it's as simple as go instrument all the pfn_to_online_page() users.
>=20

Fixing pfn_to_online_page() is the right thing to do, not working around it e=
ventually having false positives IMHO.=

