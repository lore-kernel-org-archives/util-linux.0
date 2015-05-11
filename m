Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33772 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbbEKL4Y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 May 2015 07:56:24 -0400
Date: Mon, 11 May 2015 20:56:02 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: what's cooking in zram for 4.1
Message-ID: <20150511115602.GA483@swordfish>
References: <20150509042148.GA514@swordfish>
 <20150511113833.GO27969@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150511113833.GO27969@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On (05/11/15 13:38), Karel Zak wrote:
> hmm... frankly, the reason why I love /sys and why hate /proc is
> value-per-file. You do not need special parsers to read from /sys
> (usually).
> 
> >         orig_data_size
> >         compr_data_size
> >         mem_used_total
> >         mem_limit
> >         mem_used_max
> >         zero_pages
> >         num_migrated
> 
> Why do you need all in one file? ... to provide consistent statistics?
> 

yes, that's the main reason.

	-ss
