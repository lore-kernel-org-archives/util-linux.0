Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qe0-f41.google.com ([209.85.128.41]:35981 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaANOl6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Jan 2014 09:41:58 -0500
Received: by mail-qe0-f41.google.com with SMTP id gh4so8702257qeb.0
        for <util-linux@vger.kernel.org>; Tue, 14 Jan 2014 06:41:58 -0800 (PST)
Date: Tue, 14 Jan 2014 09:41:56 -0500 (EST)
From: Scott Moser <smoser@ubuntu.com>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org, Philip Susi <psusi@ubuntu.com>
Subject: Re: [PATCH] fix partx --update ranges and out of order tables
In-Reply-To: <20140114085439.GF12700@x2.net.home>
Message-ID: <alpine.DEB.2.02.1401140941030.5329@brickies>
References: <alpine.DEB.2.02.1401131526340.5329@brickies> <20140114085439.GF12700@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 14 Jan 2014, Karel Zak wrote:

> On Mon, Jan 13, 2014 at 03:32:49PM -0500, Scott Moser wrote:
> > partx --update DEVICE NUMBER
> > was broken in 2 cases:
> >  * if NUMBER != 1
> >  * if the partition table was "out of order".
> >    Ie, where sda2 came after sda3.
> >
> > fixes http://pad.lv/1244662.
> > See bug for example recreates.
>
>  Good catch.
>
> > -	for (i = 0, n = lower; n <= upper; n++) {
> > -		par = blkid_partlist_get_partition(ls, i);
> > -		an = blkid_partition_get_partno(par);
> > -
> > -		if (lower && n < lower)
> > -			continue;
> > -		if (upper && n > upper)
>
>
>  It was really stupid code :-(
>
>  Applied, thanks!
>
>
>  You forgot "Signed-off-by: ", I have fixed this mistake before commit
>  as I guess you agree with this change. OK?

I agree.  Thanks.

Signed-off-by: Scott Moser <smoser@ubuntu.com>

Scott
