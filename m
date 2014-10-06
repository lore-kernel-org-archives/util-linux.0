Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f41.google.com ([209.85.215.41]:61216 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaJFPyE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Oct 2014 11:54:04 -0400
Received: by mail-la0-f41.google.com with SMTP id pn19so4721445lab.28
        for <util-linux@vger.kernel.org>; Mon, 06 Oct 2014 08:54:02 -0700 (PDT)
Message-ID: <5432BBB0.30701@gmail.com>
Date: Mon, 06 Oct 2014 17:56:32 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>
CC: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: losetup on a image file containing (GPT) partition doesn't create
 partition devices
References: <542E7000.3040309@gmail.com> <201410031429.s93ET4wu014728@hobgoblin.ariadne.com> <201410031958.s93JwTuY026155@hobgoblin.ariadne.com> <542F065C.2080505@gmail.com> <54304C03.6020309@gmail.com> <201410061547.s96Fl0sN021617@hobgoblin.ariadne.com>
In-Reply-To: <201410061547.s96Fl0sN021617@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[Adding Karel in CC]

On 10/06/2014 05:47 PM, Dale R. Worley wrote:
>> From: Francis Moreau <francis.moro@gmail.com>
> 
>> Ok, so IMHO I think that losetup(8) should issue its own
>> ioctl(BLKRRPART) and shouldn't rely on the kernel during the loop setup
>> since it can fail silently. This way it can check the return value of
>> ioctl() and moght choose to do it again in case the return value is -EBUSY.
>>

Hm I was probably not clear, let me phase it again:

Ok, so IMHO I think that losetup(8) should issue its own
ioctl(BLKRRPART) and shouldn't rely on the kernel during the loop setup
since the kernel can fail silently. Using ioctl(BLKRRPART) allows
losetup(8) to check the return value of ioctl() and might choose to do
it again in case the return value is -EBUSY.

>> Or indicates in the man page that the -P can fail silently.
> 
> It's not clear to me why the kernel would be expected to check itself
> for partitions in this manner.  If losetup does not get the -P option,
> it seems like the kernel should not check.
> 

Thanks
