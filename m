Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233Ab1GZOWP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Jul 2011 10:22:15 -0400
Date: Tue, 26 Jul 2011 16:22:12 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] hwclock fixes
Message-ID: <20110726142212.GB14764@nb.net.home>
References: <CAG27Bk0EkOe=dbt88PFtDKwyo9+0mZPaysVh0eM9BjWu4X8+vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0EkOe=dbt88PFtDKwyo9+0mZPaysVh0eM9BjWu4X8+vQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 26, 2011 at 12:42:46AM +0200, Sami Kerola wrote:
> are available in the git repository at:
>   https://github.com/kerolasa/lelux-utiliteetit hwclock
>
>       hwclock: remove clock-ppc.c

OK

>       hwclock: remove misleading information

OK

>       hwclock: coding style clean up

OK

>       hwclock: include-what-you-use header check

 Hmm.. I see something completely different in the patch:

    Showing 5 changed files with 171 additions and 216 deletions. 

 it seems like "use libc error facilities".

>       hwclock: move path definitions to pathnames.h

OK

>       hwclock: remove inb & outb functions

Are you really sure? I think it depends on the header files, for
example it seems GNU Hurd reads information from cmos

http://www.spinics.net/lists/util-linux-ng/msg04179.html

and we already talked about it:

http://www.spinics.net/lists/util-linux-ng/index.html#04673

>       hwclock: fix compiler warnings

This is wrong for __alpha__ code where the variables are used.

Move the comment before the function and the begin of the function to
the #ifndef __alpha_ block, then you can use __unused__ for non-aplha
only.

>       hwclock: remove goto statement

OK

>       hwclock: add variable initialization

Good catch.

>       hwclock: move long options away from global scope

But the enum {} does not have to be in the main().

>       hwclock: validate numeric option arguments

OK

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
