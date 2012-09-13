Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41860 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758057Ab2IMPcc convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 13 Sep 2012 11:32:32 -0400
Received: by bkwj10 with SMTP id j10so637899bkw.19
        for <util-linux@vger.kernel.org>; Thu, 13 Sep 2012 08:32:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.00.1209130934290.2222@new-host-2>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
 <CAPXgP12NSLGBJGejiE2L0bfHTRL3f9RObAse=A6b5_2OqJ+RhA@mail.gmail.com> <alpine.LFD.2.00.1209130934290.2222@new-host-2>
From: Kay Sievers <kay@vrfy.org>
Date: Thu, 13 Sep 2012 17:32:09 +0200
Message-ID: <CAPXgP112ZCnvmwd5=YQdd7X1fK=OMV_h1EXcnrR8ePL8RGPrrw@mail.gmail.com>
Subject: Re: [PATCH] blkdiscard: add new command
To: =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
Cc: util-linux@vger.kernel.org, kzak@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 13, 2012 at 3:37 PM, Lukáš Czerner <lczerner@redhat.com> wrote:
> On Thu, 13 Sep 2012, Kay Sievers wrote:
>
>> Date: Thu, 13 Sep 2012 00:43:01 +0200
>> From: Kay Sievers <kay@vrfy.org>
>> To: Lukas Czerner <lczerner@redhat.com>
>> Cc: util-linux@vger.kernel.org, kzak@redhat.com
>> Subject: Re: [PATCH] blkdiscard: add new command
>>
>> On Wed, Sep 12, 2012 at 11:49 PM, Lukas Czerner <lczerner@redhat.com> wrote:
>> > blkdiscard is used to discard device sectors. This is useful for
>> > solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
>> > fstrim this command is used directly on the block device.
>>
>> Should this maybe live in blockdev(8)?
>>
>> It's kind of unfortunate to create standalone tools for every other
>> rather exotic block device feature.
>
> Discard is hardly exotic feature nowadays :)

Nowadays, stuff is usually done by filesystems during runtime or
filesysystem formatters. Or secure erase of the whole disk, which
usually also has the benefit of resetting the garbage collector tables
in the device.

Therefore, discarding areas with this new command seems pretty exotic to me. :)

And also how does it overlap with hdparm's --trim-sector-ranges ?

Kay
