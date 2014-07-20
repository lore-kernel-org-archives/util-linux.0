Return-Path: util-linux-owner@vger.kernel.org
Received: from g2t2354.austin.hp.com ([15.217.128.53]:48849 "EHLO
	g2t2354.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbaGTUgw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jul 2014 16:36:52 -0400
Message-ID: <1405888608.11927.11.camel@buesod1.americas.hpqcorp.net>
Subject: Re: [RFC] Zram handle util
From: Davidlohr Bueso <davidlohr@hp.com>
To: Timofey Titovets <nefelim4ag@gmail.com>
Cc: util-linux@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Date: Sun, 20 Jul 2014 13:36:48 -0700
In-Reply-To: <53CAAAB6.6020607@gmail.com>
References: <53CAAAB6.6020607@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 2014-07-19 at 20:28 +0300, Timofey Titovets wrote:
> Good time of day.
> I want hear your opinions.
> Several days ago, i writed zramctl util (on C++) for have useful app for 
> setup zrams..
> Code hosted her: https://github.com/Nefelim4ag/zramctl
> 
> Examples:
> zramctl find # return name of first free device (zram0)
> zramctl find 1024M lz4 4 # (i not implement -? options now)
> 			 # 4 - threads
> 			 # setup and return name of device (zram1)
> zramctl reset zram0 zram1 ...
> 
> 
> I want to port it on C and try include it in util-linux, like losetup.
> It has a sense? What do you think?

Minchan, any thoughts in keeping this sort of utility in the kernel
tree? Perhaps tools/zram/? No idea if the code is suitable to consider
right away, but it kinda makes sense.

Thanks,
Davidlohr

