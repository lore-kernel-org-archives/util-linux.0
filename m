Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34176 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbbERJ43 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 May 2015 05:56:29 -0400
Date: Mon, 18 May 2015 18:56:49 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: what's cooking in zram for 4.1
Message-ID: <20150518095649.GB2330@swordfish>
References: <20150509042148.GA514@swordfish>
 <20150518093645.GL4834@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150518093645.GL4834@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On (05/18/15 11:36), Karel Zak wrote:
> On Sat, May 09, 2015 at 01:21:48PM +0900, Sergey Senozhatsky wrote:
> > There will be some user-space visible changes in zram 4.1 we'd love to let you know
> > about.
> 
> ...
> 
> > -- /sys/block/zram<id>/mm_stat
> > 
> > The stat file represents device's mm statistics. It consists of a single
> > line of text and contains the following stats separated by whitespace:
> >         orig_data_size
> >         compr_data_size
> >         mem_used_total
> >         mem_limit
> >         mem_used_max
> >         zero_pages
> >         num_migrated
> 
> OK, zramctl(8) code in util-linux git tree supports mm_stat file now.
> It's able to fallback to the original /sys/block/zram<id>/<attr> if
> mm_stat does not exist. The change will be available in v2.27 (~Aug 2015).
> 
> I have also added support for MEM-LIMIT, MEM-USED and MIGRATED columns.
> 

great, thanks!

	-ss
