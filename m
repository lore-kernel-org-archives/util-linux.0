Return-Path: minchan.kim@gmail.com
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Mon, 18 May 2015 22:55:52 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Karel Zak <kzak@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: what's cooking in zram for 4.1
Message-ID: <20150518135552.GA3270@blaptop>
References: <20150509042148.GA514@swordfish>
 <20150511113833.GO27969@ws.net.home>
 <20150511115602.GA483@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150511115602.GA483@swordfish>
List-ID: <util-linux.vger.kernel.org>

Hello

On Mon, May 11, 2015 at 08:56:02PM +0900, Sergey Senozhatsky wrote:
> On (05/11/15 13:38), Karel Zak wrote:
> > hmm... frankly, the reason why I love /sys and why hate /proc is
> > value-per-file. You do not need special parsers to read from /sys
> > (usually).
> > 
> > >         orig_data_size
> > >         compr_data_size
> > >         mem_used_total
> > >         mem_limit
> > >         mem_used_max
> > >         zero_pages
> > >         num_migrated
> > 
> > Why do you need all in one file? ... to provide consistent statistics?
> > 
> 
> yes, that's the main reason.

In my side, other main reason was to reduce the number of system call
to see statistics. It is not only syscall overhead itself but also
causes slightly high-order allocation for kernel internal data structure
via slab allocation which is bad on low memory situation where is
frequent in zram-swap. Slab allocation could be fallback with 0-order
pages but it could cause excessive page reclaim seriously since compaction
didn't work.
Yes, it's a one of problem of current VM but there is no reason to hesitate
if we can avoid such problems and support consistent statistic as well.

-- 
Kind regards,
Minchan Kim
