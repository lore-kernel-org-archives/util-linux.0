Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35995 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab2IYUvG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 25 Sep 2012 16:51:06 -0400
Received: by bkcjk13 with SMTP id jk13so1509206bkc.19
        for <util-linux@vger.kernel.org>; Tue, 25 Sep 2012 13:51:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1348605188.19630.140661132636721.0CD0D5D4@webmail.messagingengine.com>
References: <1348605188.19630.140661132636721.0CD0D5D4@webmail.messagingengine.com>
From: Kay Sievers <kay@vrfy.org>
Date: Tue, 25 Sep 2012 22:50:44 +0200
Message-ID: <CAPXgP11cuTV5+juJR54=xheDsGD9-ZqnUFuiXv43TRDvdThx1g@mail.gmail.com>
Subject: Re: Why fdisk wants the first partition to start at 1 MiB?
To: Francesco Turco <fturco@fastmail.fm>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 25, 2012 at 10:33 PM, Francesco Turco <fturco@fastmail.fm> wrote:
> I'm trying to use fdisk (from util-linux 2.19.1) for creating a
> partition on a drive. I noticed that the start sector of the first
> partition must be at least 2048, that is 1 MiB from the beginning of the
> drive. This can be changed by entering the "expert mode" and using the
> "move beginning of data in a partition" option. But I'm still wondering
> why fdisk reserves so much space by default.
>
> As far as I know the only sector that should not be used for partitions
> is the first one, that is, sector 0. It is reserved for the MBR. So the
> first partition can start at sector 1. I read that the 1 MiB thing is
> Windows related: http://en.wikipedia.org/wiki/Logical_Disk_Manager. Or
> it's something that Linux users should also care about? I can't find a
> convincing explanation anywhere.
>
> This 1 MiB thing seems to affect parted, too, as it wants partition
> boundaries to be multiples of 1 MiB. I don't know if it's related to the
> problem I have with fdisk, though.

It's a de-facto standard, which Windows does too. The first megabyte
is reserved here for a boot loader or any other management data that
could be needed for a disk or box to boot from.

Boot loader issues are probably not that interesting on EFI boxes and
other non-BIOS hardware, but on usually big sized disks it's still a
safe default.

Kay
