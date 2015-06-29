Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 0/7] pull: various small changes
Date: Mon, 29 Jun 2015 12:14:04 +0200
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <1435520605-4296-1-git-send-email-kerolasa@iki.fi> <20150629094913.GV1992@ws.net.home>
In-Reply-To: <20150629094913.GV1992@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201506291214.04794.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 29 June 2015, Karel Zak wrote:
> On Sun, Jun 28, 2015 at 08:43:18PM +0100, Sami Kerola wrote:
> > But deprecations can be tricky, so it would be great to hear if I
> > assumptions about reset(1) and the last-deprecated are right or
> > wrong.
>
>  The old last(1) implementation deprecation is expected and planned,
>  so it's fine and I think it's also fine to add the reset script
>  between deprecated stuff.
>
>  Applied, thanks.
>
> >   build-sys: add minimal whitespace build directory support
>
>  I don't like this patch. I don't think it's good idea to add warning
>  about libtools limitations to the all build systems. If we really
> need such warning than it has to be in the LT_INIT.

BTW even worse than whitespaces are colons within the path because the 
build may work but then no *PATH, LD_LIBRARY_PATH", etc. will work. IMO 
they should already warn in mkdir(1) about such stupid directory 
names ;)

cu,
Rudi
