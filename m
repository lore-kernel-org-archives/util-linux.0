Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5443 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbaANIzQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jan 2014 03:55:16 -0500
Date: Tue, 14 Jan 2014 09:54:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Scott Moser <smoser@ubuntu.com>
Cc: util-linux@vger.kernel.org, Philip Susi <psusi@ubuntu.com>
Subject: Re: [PATCH] fix partx --update ranges and out of order tables
Message-ID: <20140114085439.GF12700@x2.net.home>
References: <alpine.DEB.2.02.1401131526340.5329@brickies>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1401131526340.5329@brickies>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 13, 2014 at 03:32:49PM -0500, Scott Moser wrote:
> partx --update DEVICE NUMBER
> was broken in 2 cases:
>  * if NUMBER != 1
>  * if the partition table was "out of order".
>    Ie, where sda2 came after sda3.
> 
> fixes http://pad.lv/1244662.
> See bug for example recreates.

 Good catch.

> -	for (i = 0, n = lower; n <= upper; n++) {
> -		par = blkid_partlist_get_partition(ls, i);
> -		an = blkid_partition_get_partno(par);
> -
> -		if (lower && n < lower)
> -			continue;
> -		if (upper && n > upper)


 It was really stupid code :-(

 Applied, thanks! 


 You forgot "Signed-off-by: ", I have fixed this mistake before commit
 as I guess you agree with this change. OK?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
