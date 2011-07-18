Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29107 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab1GRVtG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Jul 2011 17:49:06 -0400
Date: Mon, 18 Jul 2011 23:49:01 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] isosize fixes
Message-ID: <20110718214901.GB4354@nb.redhat.com>
References: <CAG27Bk0MvKRCW1d_fQ3-k2s4HXTdy-S1NyVC4UFM2Boxig9usA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0MvKRCW1d_fQ3-k2s4HXTdy-S1NyVC4UFM2Boxig9usA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 11, 2011 at 02:54:04PM +0200, Sami Kerola wrote:
> The following changes since commit 37b94458bd0f4a178233ad0366a727bf5bde879f:
> 
>   sfdisk: fix coding style. (2011-06-29 12:47:38 +0200)
> 
> are available in the git repository at:
>   https://github.com/kerolasa/lelux-utiliteetit isosize
> 
> Sami Kerola (6):
>       isosize: remove global variables
>       isosize: use long options
>       isosize: check user input to be numeric
>       isosize: include-what-you-use header check
>       isosize: fix coding style
>       docs: isosize.8 add long options
> 
>  disk-utils/Makefile.am |    1 +
>  disk-utils/isosize.8   |   16 ++--
>  disk-utils/isosize.c   |  221 +++++++++++++++++++++++++-----------------------
>  3 files changed, 122 insertions(+), 116 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
