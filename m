Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51011 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbaG1K3S (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jul 2014 06:29:18 -0400
Date: Mon, 28 Jul 2014 12:29:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] swaplabel: move swapon-common to include directory
Message-ID: <20140728102906.GH8533@x2.net.home>
References: <1406371986-16508-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406371986-16508-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 26, 2014 at 11:53:06AM +0100, Sami Kerola wrote:
> This fixes the following compiler warning.
> 
> disk-utils/swaplabel.c:175:2: warning: implicit declaration of function
> 'get_swap_prober' [-Wimplicit-function-declaration]
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  disk-utils/swaplabel.c    |  1 +
>  include/swapon-common.h   | 28 ++++++++++++++++++++++++++++
>  sys-utils/swapon-common.h | 28 ----------------------------

 and modify include/Makemodule.ac :-)

>  3 files changed, 29 insertions(+), 28 deletions(-)
>  create mode 100644 include/swapon-common.h
>  delete mode 100644 sys-utils/swapon-common.h

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
