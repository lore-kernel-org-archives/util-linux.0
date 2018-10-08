Return-Path: <SRS0=4QkE=MU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4667AC00449
	for <util-linux@archiver.kernel.org>; Mon,  8 Oct 2018 07:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAED62087C
	for <util-linux@archiver.kernel.org>; Mon,  8 Oct 2018 07:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAED62087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tlinx.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJHOlL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:41:11 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:43712 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHOlL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2018 10:41:11 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w987Ul3G014855;
        Mon, 8 Oct 2018 00:30:49 -0700
Message-ID: <5BBB07AA.6010403@tlinx.org>
Date:   Mon, 08 Oct 2018 00:30:50 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Karel Zak <kzak@redhat.com>
CC:     util-linux@vger.kernel.org
Subject: static linking working w/gnu?  (was Re: [ANNOUNCE] util-linux v2.33-rc1)
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

On 10/7/2018 8:13 AM, Thorsten Kukuk wrote:

On Sun, Oct 07, Stefan Seyfried wrote:

> > /usr/lib64/gcc/x86_64-suse-linux/8/../../../../x86_64-suse-linux/bin/ld:
> > ./.libs/libmount.a(libmount_la-utils.o): in function `mnt_get_gid':
> > /dev/shm/util-linux-2.33-rc1/libmount/src/utils.c:614: warning: Using
> > 'getgrnam_r' in statically linked applications requires at runtime the
> > shared libraries from the glibc version used for linking
> ....
> > /usr/lib64/gcc/x86_64-suse-linux/8/../../../../x86_64-suse-linux/bin/ld:
> > ./.libs/libmount.a(libmount_la-utils.o): in function `mnt_get_username':
> > /dev/shm/util-linux-2.33-rc1/libmount/src/utils.c:566: warning: Using
> > 'getpwuid_r' in statically linked applications requires at runtime the
> > shared libraries from the glibc version used for linking
> > The bug is thus "RESOLVED WORKSFORME"
>   

No, the bug is, that the code is not designed for static linking,
as all the warnings show. And the upstream author should get the
same warnings as you abvoe.

-----
> On Sun, Oct 07, Stefan Seyfried wrote:
> > Am 07.10.18 um 00:17 schrieb L A Walsh:
> > > Because these utils 'should' be statically linkable and *are* on
> > > redhat> (which I thought opensuse was based on).
> 
> > Where do you get your alternative facts from?
-------------


So Karel, 

	Did you get warnings similar to the above?  The claim
is that you should be getting similar errors, but I got the impression
that you did not.

One person claimed it to be a bug in the Gnu tools & lib, while
others claim its designed that way, so not a bug...*sigh*.

But anyway -- did you get any such warnings?


I love the way Stefan labels my statement about some of the utils
being statically linkable and that it works on redhat an "alternative fact".

(sigh)...
Thanks!


