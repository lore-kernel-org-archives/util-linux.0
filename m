Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36385 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbFMOwF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Jun 2015 10:52:05 -0400
Received: by qkx62 with SMTP id 62so31101757qkx.3
        for <util-linux@vger.kernel.org>; Sat, 13 Jun 2015 07:52:04 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 13 Jun 2015 22:52:04 +0800
Message-ID: <CAGnHSE=gtd2WVcxOBoyfqnp3QtT4RHfK356GHastBbiK5mtmFA@mail.gmail.com>
Subject: optimal io size / custom alignment
From: Tom Yan <tom.ty89@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As I have mentioned in previous mails, I have an sata/usb3 adapter
which could work in uas mode, and when it does, it has a weird optimal
i/o size:

Disk /dev/sdb: 74.5 GiB, 80026361856 bytes, 156301488 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 33553920 bytes

http://www.linuxquestions.org/questions/linux-newbie-8/how-to-foramt-2tb-external-hard-drive-4175529792/

In the above link, there shows another similar case of an external
drive with 4k physical sector.

I am not sure if there's anything wrong with the device(s) or the
kernel, but anyway I doubt if fdisk should determine alignment with
this size. As you can calculate, it may not necessarily be a multiple
of the size of physical sectors, or that of common erase block of SSDs
(which is not reported anywhere AFAIK).

Perhaps this I/O size does matter on alignment for certain cases, but
shouldn't physical sector or erase block be at least of higher
priority when it comes to alignment?

In any case, it would be nice if fdisk can allow customize alignment
(like gdisk does), so that users can at least decide how partitions
should be aligned in weird cases like this. With that, the long-time
deprecated "dos compatibility" might be able to go as well.
