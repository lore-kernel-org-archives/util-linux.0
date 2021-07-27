Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919D8C4338F
	for <util-linux@archiver.kernel.org>; Tue, 27 Jul 2021 22:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9066052B
	for <util-linux@archiver.kernel.org>; Tue, 27 Jul 2021 22:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhG0Wjk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:39:40 -0400
Received: from cmyk.emenem.pl ([217.79.154.63]:33062 "EHLO smtp.emenem.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231730AbhG0Wji (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Jul 2021 18:39:38 -0400
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (50-78-106-33-static.hfc.comcastbusiness.net [50.78.106.33])
        (authenticated bits=0)
        by cmyk.emenem.pl (8.16.1/8.16.1) with ESMTPSA id 16RMdMTi006277
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 28 Jul 2021 00:39:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
        t=1627425564; bh=N8vgsL9Mne1p4q8OZzB1bUa9urFqvrxvh2RAvGQZ6nA=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=KTIZw/J/j6pLm+JqxeGvi/ShLpFe1dbzrxvB8MAoUu6fqdZ0LehbnUBgyqRiZ46i4
         2AyV3LjQWGdyEVDZbgTnONeLyCtC5YJrygY+65RXia6AmBB8DfGyQzoKcrp9vKliVE
         qThIyzJyYrVizl2kJpb8D0SegdXKKN07I7cfPix8=
Subject: Re: Commit d5fd456c88aba4fcf77d35fe38024a8d5c814686 - "loopdev: use
 LOOP_CONFIG ioctl" broke loop on x86-64 w/ 32 bit userspace
From:   =?UTF-8?Q?Krzysztof_Ol=c4=99dzki?= <ole@ans.pl>
To:     Sinan Kaya <sinan.kaya@microsoft.com>, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <a797f527-4599-e986-a326-4bb141487f2c@ans.pl>
Message-ID: <e7f64d43-2a26-e386-b208-5c35d6a56ed4@ans.pl>
Date:   Tue, 27 Jul 2021 15:39:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a797f527-4599-e986-a326-4bb141487f2c@ans.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2021-07-27 at 14:53, Krzysztof Olędzki wrote:
> Hi,
> 
> I have a number of (older) systems that are still based on 32 bit
> userspace but are running a relatively modern 64 bit kernel -
> 5.4-stable, where BTW - LOOP_CONFIGURE is not yet available.
> 
> I noticed that starting with util-linux-2.37 it is no longer possible to
> mount images using loop:
> 
> # mount /usr/install/iso/systemrescue-8.04-amd64.iso /mnt/cdrom
> mount: /mnt/cdrom: failed to setup loop device for
> /usr/install/iso/systemrescue-8.04-amd64.iso.
> 
> Reverting d5fd456c88aba4fcf77d35fe38024a8d5c814686 fixes the problem:
> 
> /tmp/util-linux-2.37# ./mount
> /usr/install/iso/systemrescue-8.04-amd64.iso /mnt/cdrom
> mount: /mnt/cdrom: WARNING: source write-protected, mounted read-only.
> 
> I have not tested if 32 bit kernel + 32 bit userspace is also affected,
> but 64 bit kernel + 64 bit userspace works.

Some debugging data:

30399: loopdev:      CXT: [0xff8d0f98]: using loop-control
30399: loopdev:      CXT: [0xff8d0f98]: loop0 name assigned
30399: loopdev:      CXT: [0xff8d0f98]: find_unused by loop-control [rc=0]
30399: libmount:     LOOP: [0x57cbbcb0]: trying to use /dev/loop0
30399: loopdev:      CXT: [0xff8d0f98]: set backing file=/usr/install/iso/systemrescue-8.04-amd64.iso
30399: loopdev:      CXT: [0xff8d0f98]: set flags=4
30399: loopdev:    SETUP: [0xff8d0f98]: device setup requested
30399: loopdev:    SETUP: [0xff8d0f98]: backing file open: OK
30399: loopdev:      CXT: [0xff8d0f98]: open /dev/loop0 [rw]: Success
30399: loopdev:    SETUP: [0xff8d0f98]: device open: OK
30399: loopdev:    SETUP: [0xff8d0f98]: LOOP_CONFIGURE failed: Inappropriate ioctl for device
30399: loopdev:    SETUP: [0xff8d0f98]: failed [rc=-25]
30399: libmount:     LOOP: [0x57cbbcb0]: failed to setup device
30399: loopdev:      CXT: [0xff8d0f98]: de-initialize
30399: loopdev:      CXT: [0xff8d0f98]: closing old open fd
30399: loopdev:     ITER: [0xff8d1168]: de-initialize
30399: libmount:      CXT: [0x57cbbcb0]: mount: preparing failed
30399: libmount:      CXT: [0x57cbbcb0]: excode: rc=32 message="failed to setup loop device for /usr/install/iso/systemrescue-8.04-amd64.iso"
mount: /mnt/cdrom: failed to setup loop device for /usr/install/iso/systemrescue-8.04-amd64.iso.
30399: libmount:      CXT: [0x57cbbcb0]: <---- reset [status=0] ---->

Seems like the code expects EINVAL (-22) but gets ENOTTY (-25), confirmed with strace:
ioctl(4, LOOP_CONFIGURE, {fd=3, block_size=0, info={lo_offset=0, lo_number=0, lo_flags=LO_FLAGS_AUTOCLEAR, lo_file_name="/usr/install/iso/systemrescue-8.04-amd64.iso", ...}}) = -1 ENOTTY (Inappropriate ioctl for device)

Indeed, changing the code from:
   if (errno != EINVAL)
to:
   if (errno != EINVAL && errno != ENOTTY)
allows it to work.

Not that with 64-bit userspace, kernel returns EINVAL:

ioctl(4, LOOP_CONFIGURE, {fd=3, block_size=0, info={lo_offset=0, lo_number=0, lo_flags=LO_FLAGS_AUTOCLEAR, lo_file_name="/usr/src/PACKAGES/systemrescue-8.04-amd64.iso", ...}}) = -1 EINVAL (Invalid argument)


Thanks,
  Krzysztof
