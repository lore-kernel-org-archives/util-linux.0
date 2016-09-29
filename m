Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752029AbcI2J7H (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Sep 2016 05:59:07 -0400
Date: Thu, 29 Sep 2016 11:59:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Tobias Stoeckmann <tobias@stoeckmann.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] text-utils/ul: Fix buffer overflow
Message-ID: <20160929095904.wfsleb4b5d4lxznt@ws.net.home>
References: <20160908191922.GA18991@localhost>
 <CAJVOszCqwtc-V8K2VVbjiO3iVO3xt1i00VLdW5ZEOEQ=ZR6e_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJVOszCqwtc-V8K2VVbjiO3iVO3xt1i00VLdW5ZEOEQ=ZR6e_Q@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 11, 2016 at 02:47:22PM -0500, Shaun Tancheff wrote:
> On Thu, Sep 8, 2016 at 2:19 PM, Tobias Stoeckmann <tobias@stoeckmann.org> wrote:
> > The text-utility ul can run into a buffer overflow on very long lines.
> > See this proof of concept how to reproduce the issue:
> >
> > $ dd if=/dev/zero bs=1M count=10 | tr '\000' '\041' > poc.txt
> > $ echo -ne '\xe\x5f\x8\x5f\x61\x2\xf\x5f\x8\x5f' | dd of=poc.txt conv=notrunc
> > $ ul -i poc.txt > /dev/null # output would take ages
> > Segmentation fault
> > $ _
> >
> > The problem manifests by using alloca with "maxcol", which can be as
> > large as INT_MAX, based on the input line.
> >
> > A very long line (> 8 MB) with modes must be supplied to ul, as seen in
> > my proof of concept byte sequence above.
> >
> > It is rather easy to fix this issue: allocate space on the heap instead.
> > maxcol could overflow here, but in that case no system will have enough
> > space to handle the request, properly ending ul through an err() call.
> >
> >
> > Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
> > ---
> >  text-utils/ul.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)

Applied, thanks.

> 
> Just a nit .. may as well change 'i' from an int to a long here as well.
> That should cover the theoretical overflow for 64 bit machines.

This is generic problem of the 'ul' code, on many many places it uses 'int'
rather than 'size_t'. It would be better to fix it completely rather
than just one 'i' ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
