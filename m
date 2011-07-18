Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25381 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850Ab1GRVti (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Jul 2011 17:49:38 -0400
Date: Mon, 18 Jul 2011 23:49:34 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] fdformat fixes
Message-ID: <20110718214934.GC4354@nb.redhat.com>
References: <CAG27Bk2uumAs8nhh1EdHHR+v92vOKqK19WSEaNSjnjwHSCjstw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2uumAs8nhh1EdHHR+v92vOKqK19WSEaNSjnjwHSCjstw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 11, 2011 at 07:05:36PM +0200, Sami Kerola wrote:
> The following changes since commit 365acc97654d33a01698ada9bf18fbbdce7d88cc:
> 
>   fdisk: use a single variable for the current disklabel (2011-07-11
> 12:01:42 +0200)
> 
> are available in the git repository at:
>   https://github.com/kerolasa/lelux-utiliteetit fdformat
> 
> Sami Kerola (7):
>       fdformat: use libc error printing facilities
>       fdformat: use long options
>       fdformat: integer comparisons & unused parameter
>       fdformat: use xalloc.h
>       fdformat: include-what-you-use header check
>       fdformat: coding style
>       docs: add long options to fdformat.8
> 
>  disk-utils/fdformat.8 |   18 ++--
>  disk-utils/fdformat.c |  253 ++++++++++++++++++++++++++-----------------------
>  2 files changed, 147 insertions(+), 124 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
