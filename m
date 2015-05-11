Return-Path: linux-kernel-owner@vger.kernel.org
Date: Mon, 11 May 2015 13:38:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: what's cooking in zram for 4.1
Message-ID: <20150511113833.GO27969@ws.net.home>
References: <20150509042148.GA514@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150509042148.GA514@swordfish>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 09, 2015 at 01:21:48PM +0900, Sergey Senozhatsky wrote:
> There will be some user-space visible changes in zram 4.1 we'd love to let you know
> about.

Thanks.

> 2) zram has deprecated some of the existing stat sysfs attributes. we will
> consolidate zramX device's stats in 3 files, rather than having N files (per-stat).

sysfs attributes used by zramctl(8) are:

    disksize
    orig_data_size
    compr_data_size
    comp_algorithm
    max_comp_streams
    mem_used_total
    reset

> -- /sys/block/zram<id>/mm_stat
> 
> The stat file represents device's mm statistics. It consists of a single
> line of text and contains the following stats separated by whitespace:

hmm... frankly, the reason why I love /sys and why hate /proc is
value-per-file. You do not need special parsers to read from /sys
(usually).

>         orig_data_size
>         compr_data_size
>         mem_used_total
>         mem_limit
>         mem_used_max
>         zero_pages
>         num_migrated

Why do you need all in one file? ... to provide consistent statistics?


    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
