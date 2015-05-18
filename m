Return-Path: minchan.kim@gmail.com
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Mon, 18 May 2015 22:56:19 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Karel Zak <kzak@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: what's cooking in zram for 4.1
Message-ID: <20150518135619.GB3270@blaptop>
References: <20150509042148.GA514@swordfish>
 <20150518093645.GL4834@ws.net.home>
 <20150518095649.GB2330@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150518095649.GB2330@swordfish>
List-ID: <util-linux.vger.kernel.org>

On Mon, May 18, 2015 at 06:56:49PM +0900, Sergey Senozhatsky wrote:
> On (05/18/15 11:36), Karel Zak wrote:
> > On Sat, May 09, 2015 at 01:21:48PM +0900, Sergey Senozhatsky wrote:
> > > There will be some user-space visible changes in zram 4.1 we'd love to let you know
> > > about.
> > 
> > ...
> > 
> > > -- /sys/block/zram<id>/mm_stat
> > > 
> > > The stat file represents device's mm statistics. It consists of a single
> > > line of text and contains the following stats separated by whitespace:
> > >         orig_data_size
> > >         compr_data_size
> > >         mem_used_total
> > >         mem_limit
> > >         mem_used_max
> > >         zero_pages
> > >         num_migrated
> > 
> > OK, zramctl(8) code in util-linux git tree supports mm_stat file now.
> > It's able to fallback to the original /sys/block/zram<id>/<attr> if
> > mm_stat does not exist. The change will be available in v2.27 (~Aug 2015).
> > 
> > I have also added support for MEM-LIMIT, MEM-USED and MIGRATED columns.
> > 
> 
> great, thanks!

Thanks, guys!

-- 
Kind regards,
Minchan Kim
