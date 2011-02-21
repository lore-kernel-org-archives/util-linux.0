Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29075 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab1BUJTi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Feb 2011 04:19:38 -0500
Date: Mon, 21 Feb 2011 10:19:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Stefan Tauner <stefan.tauner@student.tuwien.ac.at>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] try to 'remount,ro' once if the kernel ignores the ro
	request for bind mounts
Message-ID: <20110221091925.GA2366@nb.net.home>
References: <201102101802.p1AI2Dp0009456@mail2.student.tuwien.ac.at> <201102200214.p1K2EZ2m006839@mail2.student.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201102200214.p1K2EZ2m006839@mail2.student.tuwien.ac.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 20, 2011 at 03:14:30AM +0100, Stefan Tauner wrote:
> i sent the patch below ~10 days ago and did not receive any feedback
> whatsoever. if it's wrong or deemed unneeded, i'd really like to hear
> your opinion why. thanks!

I'm still not sure if mount(8) is the right place to fix odd kernel
behaviour. Anyway, your patch seems like a usable workaround.

I'll try to apply the patch later (it will necessary to modify
libmount, because the library is not able to add a new entry to mtab
for MS_REMOUNT requests).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
