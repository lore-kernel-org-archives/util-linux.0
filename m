Return-Path: linux-kernel-owner@vger.kernel.org
Date: Thu, 13 Aug 2015 09:58:12 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: what's cooking in zram for 4.2
Message-ID: <20150813005812.GA17958@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel,

... planned to write this earlier.


zram will see some user-space visible improvements in 4.2 we'd love
to let you know about -- on-demand device creation/removal.

For that purpose we introduce zram control sysfs class, which has two
sysfs attrs:
 - hot_add      -- add a new zram device
 - hot_remove   -- remove a specific (device_id) zram device


-- hot_add sysfs attr is read-only and has only automatic device id
assignment mode.  Read operation performed on this attr creates a
new zram device and returns back its device_id (or error (ret < 0)).

Usage example:
  # add a new zram device
  cat /sys/class/zram-control/hot_add
  2

an example of returning error code (-ENOMEM in this case)

  cat /sys/class/zram-control/hot_add
  cat: /sys/class/zram-control/hot_add: Cannot allocate memory



-- hot_remove is write only and requires a valid zram device_id as
its input parameter:

  # remove a specific zram device
  echo 4 > /sys/class/zram-control/hot_remove


	-ss
