Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33981 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832Ab1HOMer (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Aug 2011 08:34:47 -0400
Date: Mon, 15 Aug 2011 14:34:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Timo Warns <Warns@Pre-Sense.DE>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] befs.c: validate di_br_size !=0 and br_per_di_br != 0
Message-ID: <20110815123442.GA2038@nb.net.home>
References: <20110809074046.GA4237@vermeer.pre-sense.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110809074046.GA4237@vermeer.pre-sense.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 09, 2011 at 09:40:47AM +0200, Timo Warns wrote:
> diff -u util-linux-2.20-rc1-a/libblkid/src/superblocks/befs.c util-linux-2.20-rc1-b/libblkid/src/superblocks/befs.c
> --- util-linux-2.20-rc1-a/libblkid/src/superblocks/befs.c	2011-07-20 21:55:23.000000000 +0200
> +++ util-linux-2.20-rc1-b/libblkid/src/superblocks/befs.c	2011-08-09 09:32:56.000000000 +0200

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
