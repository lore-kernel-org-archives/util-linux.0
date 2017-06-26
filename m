Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33442 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdFZCjF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 25 Jun 2017 22:39:05 -0400
Date: Mon, 26 Jun 2017 11:39:12 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: zram hot_add device busy
Message-ID: <20170626023912.GA373@jagdpanzerIV.localdomain>
References: <CAG27Bk06F72rk7i-dL=DhDmhX3BhCZFct+AAVBis7NMqTEF98w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk06F72rk7i-dL=DhDmhX3BhCZFct+AAVBis7NMqTEF98w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

(Cc Andrew, Karel)

On (06/24/17 11:08), Sami Kerola wrote:
> Hello,
> 
> While going through if there are new util-linux bugs reported I came a
> cross this https://bugs.launchpad.net/ubuntu/+source/util-linux/+bug/1645846
> 
> Simple way to reproduce the issue is:
> d=$(cat /sys/class/zram-control/hot_add) && zramctl --size 256M /dev/zram$d
> 
> I am not entirely sure, but drivers/block/zram/zram_drv.c function
> zram_add() should block until the device is usable. Looking the code
> that it might be the device_add_disk() from block/genhd.c that should
> do the blocking. But perhaps it's best if I leave such detail to
> people who know the code a bit better.
> 
> One thing annoys me. I expected 'zramctl --find --size 256M' to suffer
> from same issue but it does not. I can only reproduce the issue when
> triggering hot_add separately, and as quick as possibly using the
> path. Notice that sometimes it takes second try before the hot_add and
> use triggers the issue. That is almost certainly down to speed the
> system in hand, e.g., quicker the computer less likely to trigger.


ok... I don't think I see what we can do in zram about the
issue in question. what I see on my system is that systemd
udevd is racing with zramctl.


so, the "failed" case looks like this


			process		action

[  761.191697] zram: >>[systemd-udevd]>>> zram_open
				^^^^^^^ systemd opens the device. we have ->bd_openers now

[  761.194057] zram: >>[zramctl]>>> reset_store
				^^^^^^^ fails, because device is opened by systemd.
					if (bdev->bd_openers || zram->claim) is true, we can't reset

[  761.195105] zram: >>[systemd-udevd]>>> zram_release
				^^^^^^^ now system releases the device

[  761.198655] zram: >>[zramctl]>>> reset_store
				^^^^^^^ succeeds, because we don't have ->bd_openers anymore

[  761.198669] zram: >>[zramctl]>>> zram_reset_device
[  761.198721] zram: >>[zramctl]>>> disksize_store
[  761.199279] zram0: detected capacity change from 0 to 268435456


normal case,

			process		action


[  761.203989] zram: >>[systemd-udevd]>>> zram_open
[  761.204461] zram: >>[systemd-udevd]>>> zram_release
[  761.204940] zram: >>[zramctl]>>> reset_store
[  761.204948] zram: >>[zramctl]>>> zram_reset_device
[  761.204972] zram: >>[zramctl]>>> disksize_store
[  761.205409] zram1: detected capacity change from 0 to 268435456


as you can see, systemd-udevd releases the device before zramctl
attempts to reset it.

	-ss
