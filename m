Return-Path: linux-kernel-owner@vger.kernel.org
Date: Sat, 9 May 2015 13:21:48 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: what's cooking in zram for 4.1
Message-ID: <20150509042148.GA514@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel,

There will be some user-space visible changes in zram 4.1 we'd love to let you know
about.


1) new sysfs node -- /sys/block/zramX/compact

triggers zram memory compaction.


2) zram has deprecated some of the existing stat sysfs attributes. we will
consolidate zramX device's stats in 3 files, rather than having N files (per-stat).

The idea is:
-- the existing RW sysfs device nodes will be downgraded to WO nodes (in linux 4.11)
-- deprecated RO sysfs nodes will eventually be removed (in linux 4.11)


User-space is advised to use the following files:

-- /sys/block/zram<id>/stat

Represents block layer statistics (read Documentation/block/stat.txt for
details).

-- /sys/block/zram<id>/io_stat

The stat file represents device's I/O statistics not accounted by block
layer and, thus, not available in zram<id>/stat file. It consists of a
single line of text and contains the following stats separated by
whitespace:
        failed_reads
        failed_writes
        invalid_io
        notify_free

-- /sys/block/zram<id>/mm_stat

The stat file represents device's mm statistics. It consists of a single
line of text and contains the following stats separated by whitespace:
        orig_data_size
        compr_data_size
        mem_used_total
        mem_limit
        mem_used_max
        zero_pages
        num_migrated

deprecated nodes will be around up until linux 4.11 (approx 2 years from now). in the
meantime, zram will warn (once) should any user space app access any of the deprecated
attrs:
"zram: 30788 (cat) Attribute num_reads (and others) will be removed. See zram documentation."


	-ss
