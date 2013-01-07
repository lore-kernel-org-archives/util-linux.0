Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11640 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785Ab3AGMmJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Jan 2013 07:42:09 -0500
Date: Mon, 7 Jan 2013 13:42:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Maksim Melnikau <maxposedon@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fstab zram swap integration idea
Message-ID: <20130107124206.GF28963@x2.redhat.com>
References: <CAGbmdnVWDifpsPvKUkdP+qX0m4GL7VYky5NyB-XYNGS19aXsvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGbmdnVWDifpsPvKUkdP+qX0m4GL7VYky5NyB-XYNGS19aXsvA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 06, 2013 at 03:17:52AM +0300, Maksim Melnikau wrote:
> Linux kernel now have interesting zram feature, which I would like to

 hmm... why this all is not completely hidden in kernel memory
 management? Why we need re-route by special device?

 Is it designed for anything other than swaparea?

> initialize via fstab. May be you find it interesting, and this feature
> will be implemented:
> 
> It will be nice, add to fstab option "mkswap before swapon", which
> could be used for auto-initialization swap in zram.

 swapon(8) already contains swap area reinitialization code (exec
 mkswap), it's used for --fixpgsz.

 Maybe we can add "mkswap" fstab and command line option for swapon.
 Anyway, mkswap is a nice and quick way how to lost data if you make a
 typo in your configuration.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
