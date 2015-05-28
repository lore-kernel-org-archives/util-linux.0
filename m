Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38713 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbbE1KcW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 May 2015 06:32:22 -0400
Date: Thu, 28 May 2015 12:32:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Use predictable /dev/mapper partition names for /dev/dm-N
Message-ID: <20150528103220.GA7285@ws.net.home>
References: <55649861.7030501@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55649861.7030501@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 26, 2015 at 05:59:29PM +0200, Stanislav Brabec wrote:
>  libfdisk/src/utils.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

 Applied, thanks.

> +	if (dev_mapped)
> +		free(dev_mapped);

 Don't use if-before-free, it's unnecessary :-)

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
