Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60289 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbaKJK7N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Nov 2014 05:59:13 -0500
Date: Mon, 10 Nov 2014 11:59:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, util-linux@vger.kernel.org
Subject: Re: libfdisk: fdisk_read_firstsector should seek to offset 0
Message-ID: <20141110105907.GM6880@x2.net.home>
References: <20141109021901.GA2799@type.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141109021901.GA2799@type.youpi.perso.aquilenet.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 09, 2014 at 03:19:01AM +0100, Samuel Thibault wrote:
> The current offset of cxt->dev_fd may not be still 0, notably when
> blkdev_get_size has to resort to using blkdev_find_size

 Oh.. this is stupid bug. Applied, thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
