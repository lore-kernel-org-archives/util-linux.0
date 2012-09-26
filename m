Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55344 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab2IZUE6 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Sep 2012 16:04:58 -0400
Received: by bkcjk13 with SMTP id jk13so575926bkc.19
        for <util-linux@vger.kernel.org>; Wed, 26 Sep 2012 13:04:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.00.1209261546390.31136@dhcp-187-45.bos.redhat.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com> <alpine.LFD.2.00.1209261546390.31136@dhcp-187-45.bos.redhat.com>
From: Kay Sievers <kay@vrfy.org>
Date: Wed, 26 Sep 2012 22:04:37 +0200
Message-ID: <CAPXgP11oktXSe3yxdOZCMzNOSrfVawtL95nBuM_NYxB9KPvOdA@mail.gmail.com>
Subject: Re: [PATCH] blkdiscard: add new command
To: =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
Cc: util-linux@vger.kernel.org, kzak@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 26, 2012 at 9:47 PM, Lukáš Czerner <lczerner@redhat.com> wrote:
> On Wed, 12 Sep 2012, Lukas Czerner wrote:
>
>> Date: Wed, 12 Sep 2012 17:49:15 -0400
>> From: Lukas Czerner <lczerner@redhat.com>
>> To: util-linux@vger.kernel.org, kzak@redhat.com
>> Cc: Lukas Czerner <lczerner@redhat.com>
>> Subject: [PATCH] blkdiscard: add new command
>>
>> blkdiscard is used to discard device sectors. This is useful for
>> solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
>> fstrim this command is used directly on the block device.
>>
>> blkkdiscard uses BLKDISCARD ioctl or BLKSECDISCARD ioctl for the secure
>> discard.
>>
>> All data in the discarded region on the device will be lost!
>
> Hi Karel,
>
> any progress here ?

Where is the patch for blockdev?

I'm still convinced randomly named tools per new kernel ioctl is not
what we want. People should get their act together, and not add the
tool of the week to util-linux.

Thanks,
Kay
