Return-Path: <SRS0=4QkE=MU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90884C65C20
	for <util-linux@archiver.kernel.org>; Mon,  8 Oct 2018 12:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2543520841
	for <util-linux@archiver.kernel.org>; Mon,  8 Oct 2018 12:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2543520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tlinx.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeJHTza (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:55:30 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:53334 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeJHTza (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2018 15:55:30 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w98ChrD8007168;
        Mon, 8 Oct 2018 05:43:55 -0700
Message-ID: <5BBB5108.7060801@tlinx.org>
Date:   Mon, 08 Oct 2018 05:43:52 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: static linking working w/gnu?  (was Re: [ANNOUNCE] util-linux
 v2.33-rc1)
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home> <5BB15D3A.8040507@tlinx.org> <20181002101454.qm5gzasb5naamnbg@ws.net.home> <5BBB07AA.6010403@tlinx.org> <20181008090956.k6cjvg7ztwt3bnnp@ws.net.home>
In-Reply-To: <20181008090956.k6cjvg7ztwt3bnnp@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 10/8/2018 2:09 AM, Karel Zak wrote:
> On Mon, Oct 08, 2018 at 12:30:50AM -0700, L A Walsh wrote:
>   
>> 	Did you get warnings similar to the above?  The claim
>> is that you should be getting similar errors, but I got the impression
>> that you did not.
>>     
>
> I get the warning, but result is still static binary. Don't ask me why
> ;-)
>
> $ file ./mount.static 
> ./mount.static: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, for GNU/Linux 3.2.0, BuildID[sha1]=b66bae970bf72346cbf6d844e0e48d5dbfd07cc2, with debug_info, not stripped
>
> The problem is the way how glibc uses stuff around NSS. In this case
> glibc needs runtime modules, for more details see:\
>   
---
    Well, it could easily use a run-time dynamic load and if the libs were
not present indicate that some feature is not available.
>   https://sourceware.org/glibc/wiki/FAQ#Even_statically_linked_programs_need_some_shared_libraries_which_is_not_acceptable_for_me.__What_can_I_do.3F
>
> on Fedora, the mount.static is static, but I guess glibc internally
> uses some ldopen() when need NSS or iconv stuff.
>   
----
    Maybe, I got the impression that they only knew how to do
load-time linkage.  One might alter resolve.conf and see if its
possible for force mount to look for something and see its behavior,
however, what I've run into are the newlibs in util-linux (libblk...,
libsmartcols...etc) being put on /usr/lib64 which is on a separate 
partition.
So with 'mount' dead, you can't mount the new partition.

    Answer is to either statically link (best, if possible), or
put the libs on the same partition as the binaries.

> I think you do not want to try resolve this issues in the utils.
---
    It really depends on resolving issues used in early HW bring-up.
> It's all about libc design. If glibc does not well for you, then 
> you need something else. For example uclibc, or glibc without NSS,
> etc.
>   
----
    musl seemed to work well when I tried it, but would rather not do
that if there is an easier way.

> Now you know why we have projects like dracut for initramfs.
----
    Because people have moved the system dependent stuff off the root --
which goes against the usrmerge docs which say to only put OS/system
_independent_ stuff on /usr. 
If that had been done, then everything I needed to
run mount and bring up the generic system would have already been on root.


>  It's
> better to use standard libs and utils than try to build parallel
> universe to boot or for rescue disks.
>   
---
    Not trying to build parallel universe -- that universe already
exists.  Just trying to make it more robust in face of randomness.

    Relying on systemd's idea of an emergency  or rescue disk doesn't
work because it reboots after you have made temporary corrections.  It
needs to come up so a longer term solution can be applied, systemd
wouldn't come up because a kernel mod wasn't loaded.  Normally, I'd
just load the module by hand, but systemd's emergency disk won't
continue after you make a correction -- instead, it reboots. 

    One can find faults with any system.  Someday, systemd may be
as reliable as a shell -- but it isn't there yet.


>   

