Return-Path: linux-kernel-owner@vger.kernel.org
Date: Mon, 26 Jun 2017 11:58:18 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sami Kerola <kerolasa@iki.fi>, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: zram hot_add device busy
Message-ID: <20170626025818.GB373@jagdpanzerIV.localdomain>
References: <CAG27Bk06F72rk7i-dL=DhDmhX3BhCZFct+AAVBis7NMqTEF98w@mail.gmail.com>
 <20170626023912.GA373@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170626023912.GA373@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On (06/26/17 11:39), Sergey Senozhatsky wrote:
[..]
> ok... I don't think I see what we can do in zram about the
> issue in question.

... check init_done() in reset_store() and avoid the whole ->bd_openers
branch if the device is already reset?

// not compile tested. just a sketch. //

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index debee952dcc1..79b1a957a6bd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1047,6 +1047,14 @@ static ssize_t reset_store(struct device *dev,
                return -EINVAL;
 
        zram = dev_to_zram(dev);
+
+       down_write(&zram->init_lock);
+       if (!init_done(zram)) {
+               up_write(&zram->init_lock);
+               return len;
+       }
+       up_write(&zram->init_lock);
+
        bdev = bdget_disk(zram->disk, 0);
        if (!bdev)
                return -ENOMEM;

---

	-ss
