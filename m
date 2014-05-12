Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29103 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbaELKxi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 06:53:38 -0400
Date: Mon, 12 May 2014 12:53:32 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux <util-linux@vger.kernel.org>
Subject: Re: question about test suite regarding stderr/stdout
Message-ID: <20140512105332.GC8951@x2.net.home>
References: <201405120038.12221.sweet_f_a@gmx.de>
 <CAG27Bk0dj=SOiGY5Hb6VttoTZG7o4P2X=XPRV6vc82g0yheybw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0dj=SOiGY5Hb6VttoTZG7o4P2X=XPRV6vc82g0yheybw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 12, 2014 at 12:22:46AM +0100, Sami Kerola wrote:
> On 11 May 2014 23:38, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> > if you do this grep in util-linux
> >   git grep '2>&1 >> $TS_OUTPUT' tests/ts
> >
> > then you find 45 lines like this
> > $TS_CMD_MKCRAMFS -n $LABEL $IMAGE_SRC $IMAGE_PATH 2>&1 >> $TS_OUTPUT
> >
> >
> > which means that these warnings go to make's output but not to
> > $TS_OUTPUT.
> >
> > I'm not sure whether this is really always wanted. For me it often looks
> > like a typo which should be ">> $TS_OUTPUT 2>&1" instead. Of course
> > could also be that it's really wanted as is to ignore stderr of too
> > verbose commands.
> >
> > Could somebody please check this too?
> > I'v had some cases where I would have liked to see that stderr in test
> > diff instead of build log. Moreover because of parallel tests it can be
> > difficult to find out which warning belongs to which particular test.
> 
> Hi Rudi,
> 
> Before parallel tests sending messages to stdout was OK, but now
> things has changed and I think directing all messages to $TS_OUTPUT is
> better option.

 That's usually correct and wanted, but note that some utils generate
 non-generic and irrelevant messages on stdout (for example messages 
 with device names). You cannot log such stuff to $TS_OUTPUT, so
 sometimes it's better to rely on stderr only and ignore stdout.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
