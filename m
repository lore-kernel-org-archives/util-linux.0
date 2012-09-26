Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33352 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab2IZU2L convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Sep 2012 16:28:11 -0400
Received: by bkcjk13 with SMTP id jk13so594772bkc.19
        for <util-linux@vger.kernel.org>; Wed, 26 Sep 2012 13:28:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.00.1209261612370.31136@dhcp-187-45.bos.redhat.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
 <alpine.LFD.2.00.1209261546390.31136@dhcp-187-45.bos.redhat.com>
 <CAPXgP11oktXSe3yxdOZCMzNOSrfVawtL95nBuM_NYxB9KPvOdA@mail.gmail.com> <alpine.LFD.2.00.1209261612370.31136@dhcp-187-45.bos.redhat.com>
From: Kay Sievers <kay@vrfy.org>
Date: Wed, 26 Sep 2012 22:27:49 +0200
Message-ID: <CAPXgP11dpk8n_oBpNAuS7g_kvTJVax_5hAkomr5WjUdS66cUFA@mail.gmail.com>
Subject: Re: [PATCH] blkdiscard: add new command
To: =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
Cc: util-linux@vger.kernel.org, kzak@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 26, 2012 at 10:14 PM, Lukáš Czerner <lczerner@redhat.com> wrote:
> On Wed, 26 Sep 2012, Kay Sievers wrote:
>
>> Date: Wed, 26 Sep 2012 22:04:37 +0200
>> From: Kay Sievers <kay@vrfy.org>
>> To: Lukáš Czerner <lczerner@redhat.com>
>> Cc: util-linux@vger.kernel.org, kzak@redhat.com
>> Subject: Re: [PATCH] blkdiscard: add new command
>>
>> On Wed, Sep 26, 2012 at 9:47 PM, Lukáš Czerner <lczerner@redhat.com> wrote:
>> > On Wed, 12 Sep 2012, Lukas Czerner wrote:
>> >
>> >> Date: Wed, 12 Sep 2012 17:49:15 -0400
>> >> From: Lukas Czerner <lczerner@redhat.com>
>> >> To: util-linux@vger.kernel.org, kzak@redhat.com
>> >> Cc: Lukas Czerner <lczerner@redhat.com>
>> >> Subject: [PATCH] blkdiscard: add new command
>> >>
>> >> blkdiscard is used to discard device sectors. This is useful for
>> >> solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
>> >> fstrim this command is used directly on the block device.
>> >>
>> >> blkkdiscard uses BLKDISCARD ioctl or BLKSECDISCARD ioctl for the secure
>> >> discard.
>> >>
>> >> All data in the discarded region on the device will be lost!
>> >
>> > Hi Karel,
>> >
>> > any progress here ?
>>
>> Where is the patch for blockdev?
>
> There is not.
>
>> I'm still convinced randomly named tools per new kernel ioctl is not
>> what we want. People should get their act together, and not add the
>> tool of the week to util-linux.
>
> And I am still convinced that multiplexing different functionalities
> together into a single tool is not always the best way to go,
> especially when they does not have nothing in common.

They have in common that they operate directly on the raw kernel block device.

This:
  blockdev <verb> [options] <devices>
sounds certainly better than than one tool per every new command.

And it's not only the needlessly duplicated binary, it's primarily
consistency, but also maintenance, documentation, ... which is all
needlessly exploded here.
It's not so much about multiplexing, it's about avoiding needless
duplication for rather exotic functions applying to one and the same
domain, a block device, which already has a command.

util-linux is mandatory in every installation, and it is already one
of the most chaotic and weird collections of random things. We should
certainly be more careful here when coming up with new stuff than
people have been in the past.

Kay
