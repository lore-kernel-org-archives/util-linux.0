Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38892 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbaGUHxh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 21 Jul 2014 03:53:37 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so9375299pac.31
        for <util-linux@vger.kernel.org>; Mon, 21 Jul 2014 00:53:36 -0700 (PDT)
Date: Mon, 21 Jul 2014 07:57:21 +0000
From: Minchan Kim <minchan@kernel.org>
To: Davidlohr Bueso <davidlohr@hp.com>
Cc: Timofey Titovets <nefelim4ag@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [RFC] Zram handle util
Message-ID: <20140721075721.GC8180@gmail.com>
References: <53CAAAB6.6020607@gmail.com>
 <1405888608.11927.11.camel@buesod1.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405888608.11927.11.camel@buesod1.americas.hpqcorp.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 20, 2014 at 01:36:48PM -0700, Davidlohr Bueso wrote:
> On Sat, 2014-07-19 at 20:28 +0300, Timofey Titovets wrote:
> > Good time of day.
> > I want hear your opinions.
> > Several days ago, i writed zramctl util (on C++) for have useful app for 
> > setup zrams..
> > Code hosted her: https://github.com/Nefelim4ag/zramctl
> > 
> > Examples:
> > zramctl find # return name of first free device (zram0)
> > zramctl find 1024M lz4 4 # (i not implement -? options now)
> > 			 # 4 - threads
> > 			 # setup and return name of device (zram1)
> > zramctl reset zram0 zram1 ...
> > 
> > 
> > I want to port it on C and try include it in util-linux, like losetup.
> > It has a sense? What do you think?
> 
> Minchan, any thoughts in keeping this sort of utility in the kernel
> tree? Perhaps tools/zram/? No idea if the code is suitable to consider
> right away, but it kinda makes sense.

First of all, Thanks for your effor, Timofey!

Adding such userspace tool in kernel src directory doesn't make sense.
If we wanted it, there are tons of user tools in kernel src directory
so IMHO, util-linux is better place.

Thanks.

> 
> Thanks,
> Davidlohr
> 
