Return-Path: linux-kernel-owner@vger.kernel.org
Date: Mon, 18 May 2015 23:40:27 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Karel Zak <kzak@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: what's cooking in zram for 4.1
Message-ID: <20150518144027.GA10979@swordfish>
References: <20150509042148.GA514@swordfish>
 <20150511113833.GO27969@ws.net.home>
 <20150511115602.GA483@swordfish>
 <20150518135552.GA3270@blaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150518135552.GA3270@blaptop>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On (05/18/15 22:55), Minchan Kim wrote:
> > > Why do you need all in one file? ... to provide consistent statistics?
> > > 
> > 
> > yes, that's the main reason.
> 
> In my side, other main reason was to reduce the number of system call
> to see statistics. It is not only syscall overhead itself but also
> causes slightly high-order allocation for kernel internal data structure
> via slab allocation which is bad on low memory situation where is
> frequent in zram-swap. Slab allocation could be fallback with 0-order
> pages but it could cause excessive page reclaim seriously since compaction
> didn't work.
> Yes, it's a one of problem of current VM but there is no reason to hesitate
> if we can avoid such problems and support consistent statistic as well.
> 

true.

syscalls and corresponding error handling for each one of them were on a
list:
https://www.marc.info/?l=linux-kernel&m=142586445420298&w=2

Karel has a remarkably good codebase, so error handling would not be an
issue :-) that's why consistent stats moved forward.

in general, increasing consistency and reducing the syscall pressure are
good enough to move on.

	-ss
