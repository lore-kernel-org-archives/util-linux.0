Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbdE3PSS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 May 2017 11:18:18 -0400
Date: Tue, 30 May 2017 17:18:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Assaf Gordon <assafgordon@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.30-rc2
Message-ID: <20170530151814.wm26bajmdihwaryo@ws.net.home>
References: <20170523105038.hm3ryvwvghgife4j@ws.net.home>
 <E6F9AA27-1BC9-4595-9FB2-30F1BA3663CA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <E6F9AA27-1BC9-4595-9FB2-30F1BA3663CA@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 30, 2017 at 01:03:53AM -0400, Assaf Gordon wrote:
> Hello
> 
> > On May 23, 2017, at 06:50, Karel Zak <kzak@redhat.com> wrote:
> > 
> > The util-linux release v2.30-rc2 is available at
> > 
> >  http://www.kernel.org/pub/linux/utils/util-linux/v2.30/
> 
> Few results from various system:
> 
> 1.
> On several systems which do not have ncurses development files
> installed, the "configure" script does not detect it,
> and completion later fails.
> Example with Debian 8.1:
> 
> ===
>   CC       disk-utils/cfdisk-cfdisk.o
> disk-utils/cfdisk.c: In function ‘ui_get_string’:
> disk-utils/cfdisk.c:1757:3: warning: implicit declaration of function ‘get_wch’ [-Wimplicit-function-declaration]
>    if (get_wch(&c) == ERR) {
>    ^
> disk-utils/cfdisk.c:1757:3: warning: nested extern declaration of ‘get_wch’ [-Wnested-externs]
>   CCLD     cfdisk
> /usr/bin/ld: cannot find -lncursesw
> collect2: error: ld returned 1 exit status
> make[2]: *** [cfdisk] Error 1
> ===

OK, I had nice afternoon with Debian (after 10 years;-)

All should be fixed. Please, test it. I'd like to release v2.30 ASAP.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
