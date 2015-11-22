Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vk0-f41.google.com ([209.85.213.41]:32825 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbKVPRK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Nov 2015 10:17:10 -0500
MIME-Version: 1.0
Date: Sun, 22 Nov 2015 23:17:09 +0800
Message-ID: <CAGnHSEnkQbUfSkuNMniqPx3JZ2QmNZNVbPcmB+Zt0D0C5d8Ysg@mail.gmail.com>
Subject: blkdiscard is not aware of "ro" attributes of block devices
From: Tom Yan <tom.ty89@gmail.com>
To: util-linux@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Block devices can be protected by the ro attribute and this is
sometimes done by default for some devices. For example,

https://www.kernel.org/doc/Documentation/mmc/mmc-dev-parts.txt

in such case the devices can only be written when it's "unlocked"
through the force_ro "knob".

However, I noticed that when I run `blkdiscard [- s]` on such devices,
the protection will simply be ignored. Like I can't write anything to
it with `dd` or so, but `blkdiscard` will wipe them straight away.

Although according to the code in kernel, the BLKDISCARD and
BLKSECDISCARD ioctls seems to do a write mode check when they are
called, it does not prevent `blkdiscard` from wiping emmc boot
partitions, which are "ro" by default, somehow.

Experiencing this with vanilla Linux 4.2.5.
