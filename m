Return-Path: <SRS0=i9sl=MS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162C0ECDE44
	for <util-linux@archiver.kernel.org>; Sat,  6 Oct 2018 19:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE1421473
	for <util-linux@archiver.kernel.org>; Sat,  6 Oct 2018 19:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE1421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tlinx.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeJGCaK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 6 Oct 2018 22:30:10 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:49126 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeJGCaK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 6 Oct 2018 22:30:10 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w96JPZHx093436;
        Sat, 6 Oct 2018 12:25:37 -0700
Message-ID: <5BB90C30.1080005@tlinx.org>
Date:   Sat, 06 Oct 2018 12:25:36 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Karel Zak <kzak@redhat.com>
CC:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.33-rc1
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home> <5BB15D3A.8040507@tlinx.org> <20181002101454.qm5gzasb5naamnbg@ws.net.home>
In-Reply-To: <20181002101454.qm5gzasb5naamnbg@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 10/2/2018 3:14 AM, Karel Zak wrote:
> On Sun, Sep 30, 2018 at 04:33:14PM -0700, L A Walsh wrote:
>   
>> On 9/25/2018 3:47 AM, Karel Zak wrote:
>>     
>>> The commands mount and umount
>>>       
>> ---
>>   I note that umount has a static option umount.static, but I don't see
>> the same for mount (i.e. mount.static).
>>     
>
>  $ ./configure --enable-static-programs=mount,umount
>  $ make mount.static umount.static
>
> works for me:
>   
so I see...  Except I got:
  CC       sys-utils/mount_static-mount.o
  CCLD     mount.static
libtool: warning: complete static linking is impossible in this 
configuration
/usr/bin/ld: total time in link: 0.038189
  CC       sys-utils/umount_static-umount.o
  CCLD     umount.static
libtool: warning: complete static linking is impossible in this 
configuration
/usr/bin/ld: total time in link: 0.039017

with ldd:
Ishtar:tools/util-linux/util-linux-2.33-rc1> ldd mount.static
  linux-vdso.so.1 (0x00007ffc38d78000)
  librt.so.1 => /lib64/librt.so.1 (0x0000003001c00000)
  libc.so.6 => /lib64/libc.so.6 (0x0000003000800000)
  libpthread.so.0 => /lib64/libpthread.so.0 (0x0000003000c00000)
  /lib64/ld-linux-x86-64.so.2 (0x00007f81b9262000)

It seems something about my config (or Suse's config) is creating a problem
for static linking.  I should probably ask on the Suse list
to see if anyone as run into this or solved it, though if you
have any ideas or known probs, great!




