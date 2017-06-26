Return-Path: linux-kernel-owner@vger.kernel.org
Date: Mon, 26 Jun 2017 11:23:01 +0900
From: Minchan Kim <minchan@kernel.org>
To: kerolasa@gmail.com
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: zram hot_add device busy
Message-ID: <20170626022301.GA18490@bbox>
References: <CAG27Bk06F72rk7i-dL=DhDmhX3BhCZFct+AAVBis7NMqTEF98w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk06F72rk7i-dL=DhDmhX3BhCZFct+AAVBis7NMqTEF98w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

On Sat, Jun 24, 2017 at 11:08:01AM +0100, Sami Kerola wrote:
> Hello,
> 
> While going through if there are new util-linux bugs reported I came a
> cross this https://bugs.launchpad.net/ubuntu/+source/util-linux/+bug/1645846
> 
> Simple way to reproduce the issue is:
> d=$(cat /sys/class/zram-control/hot_add) && zramctl --size 256M /dev/zram$d

To know the problem comes from any side, could you test it without zramctl
command?

IOW,
        d=$(cat /sys/class/zram-control/hot_add) && echo $((256<<20)) /dev/zram$d

If it still has a problem, please show your test code which helps
understanding of fundamental problem a lot. ;-)

> 
> I am not entirely sure, but drivers/block/zram/zram_drv.c function
> zram_add() should block until the device is usable. Looking the code
> that it might be the device_add_disk() from block/genhd.c that should
> do the blocking. But perhaps it's best if I leave such detail to
> people who know the code a bit better.

I might miss something but I believe device is usable state after zram_add done.
Just in case, please test return value after some operation.

if [ $? -ne 0  ];
then
        echo "fail to some op"
        blah blah
fi

Thanks.

> 
> One thing annoys me. I expected 'zramctl --find --size 256M' to suffer
> from same issue but it does not. I can only reproduce the issue when
> triggering hot_add separately, and as quick as possibly using the
> path. Notice that sometimes it takes second try before the hot_add and
> use triggers the issue. That is almost certainly down to speed the
> system in hand, e.g., quicker the computer less likely to trigger.
> 
> -- 
> Sami Kerola
> http://www.iki.fi/kerolasa/
