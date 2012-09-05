Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout-de.gmx.net ([213.165.64.22]:58461 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751999Ab2IEPWW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 5 Sep 2012 11:22:22 -0400
Date: Wed, 5 Sep 2012 17:22:13 +0200
From: Moritz Barsnick <barsnick@gmx.net>
To: util-linux list <util-linux@vger.kernel.org>
Subject: Re: util-linux-2.22: backward compatibility of wdctl
Message-ID: <20120905152213.GA19281@sunshine.barsnick.net>
References: <20120905112717.GA14130@sunshine.barsnick.net>
 <504755AC.9080008@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <504755AC.9080008@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Bernhard,
[thanks for CC'ing me, as I'm not subscribed]

On Wed, Sep 05, 2012 at 15:37:48 +0200, Bernhard Voelker wrote:
> You can use a crude hack to work around building wdctl:
>   $ touch sys-utils/wdctl.o wdctl ; make

Fine for me for the time being. I just wanted to point this out because
it will break people's (and distributions') builds.

> but this won't make you happy. You'll most propably hit other
> problems. This is from my SLES 10.4 system:

I see the same thing as you in partx, of course.

> Temporarily defining __user to nothing seems to work:
>   $ make CFLAGS='-D__user='

Good point. I figured out that this is supposed to be happening in
<linux/compiler.h>, but even including that didn't help. At least partx
build can be disabled (--disable-partx).

> ... although this is another bad workaround. ;-(

Looking forward to 2.22.1. :-)

Thanks,
Moritz
