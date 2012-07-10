Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57943 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120Ab2GJKLx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jul 2012 06:11:53 -0400
Date: Tue, 10 Jul 2012 11:56:40 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] /run directory and swapon
Message-ID: <20120710095640.GC5281@x2.net.home>
References: <CAG27Bk3xh7nAhvktOR45drKcKBgaCTtFqduOyvWz5arTGegCBA@mail.gmail.com>
 <4FEBEF93.8000107@bernhard-voelker.de>
 <4FEBF7E4.5080606@bernhard-voelker.de>
 <CAG27Bk3GYLLzpQry3+VrnOAxTZRqHtseTe0WQY3n9M0q6yAY7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3GYLLzpQry3+VrnOAxTZRqHtseTe0WQY3n9M0q6yAY7w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 28, 2012 at 10:06:35AM +0200, Sami Kerola wrote:
> sake@sake /home/src/util-linux ./swapon --show --bytes
> NAME      TYPE            SIZE USED PRIO
> /dev/dm-0 partition 7999582208    0   -1
> 
> sake@sake /home/src/util-linux ./lsblk -I 252 --bytes	# why I did not
> get output?
> sake@sake /home/src/util-linux ./lsblk --bytes | grep 252
> | `-cryptswap1 (dm-0) 252:0    0   7999586304  0 crypt [SWAP]
> 
> Still differs?  But which one is right?

Both is right, because size of swap area != size of the device. The
first page (e.g. 4096 bytes) on the device is swap header. The area
could be also reduced by bad blocks or by mkswap <size> option.

 7999586304 - 7999582208 = 4096

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
