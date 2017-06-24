Return-Path: linux-kernel-owner@vger.kernel.org
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 24 Jun 2017 11:08:01 +0100
Message-ID: <CAG27Bk06F72rk7i-dL=DhDmhX3BhCZFct+AAVBis7NMqTEF98w@mail.gmail.com>
Subject: zram hot_add device busy
To: Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>
Cc: linux-kernel@vger.kernel.org,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

While going through if there are new util-linux bugs reported I came a
cross this https://bugs.launchpad.net/ubuntu/+source/util-linux/+bug/1645846

Simple way to reproduce the issue is:
d=$(cat /sys/class/zram-control/hot_add) && zramctl --size 256M /dev/zram$d

I am not entirely sure, but drivers/block/zram/zram_drv.c function
zram_add() should block until the device is usable. Looking the code
that it might be the device_add_disk() from block/genhd.c that should
do the blocking. But perhaps it's best if I leave such detail to
people who know the code a bit better.

One thing annoys me. I expected 'zramctl --find --size 256M' to suffer
from same issue but it does not. I can only reproduce the issue when
triggering hot_add separately, and as quick as possibly using the
path. Notice that sometimes it takes second try before the hot_add and
use triggers the issue. That is almost certainly down to speed the
system in hand, e.g., quicker the computer less likely to trigger.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
