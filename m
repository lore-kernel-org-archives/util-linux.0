Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdFZOHu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 10:07:50 -0400
Date: Mon, 26 Jun 2017 16:07:46 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/13] usage cleanup part 1
Message-ID: <20170626140746.zv5vfomubhy7437u@ws.net.home>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
 <86e4396d-ee18-c049-a660-b03f6db951a5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <86e4396d-ee18-c049-a660-b03f6db951a5@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 26, 2017 at 03:04:30PM +0200, Rüdiger Meier wrote:
> On 06/22/2017 04:37 AM, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > 
> > This is pull request #467 on github
> > https://github.com/karelzak/util-linux/pull/467
> 
> > The major goal is to avoid printing usage/help messages on stderr.
> > 
> > This is the preparing first part of a bigger patch-set. There are
> > some minor bug fixes and finally we add --help options to all our
> > commands (just 5 commands were missing it).
> > 
> > The next completing patch-set (part 2) will be more invasive but
> > even more trivial.
> 
> Thanks for merging.
> 
> FYI I've PR'ed the second part on github only because it's almost
> trivial but invasive.
>    https://github.com/karelzak/util-linux/pull/471

Merged, thanks!

It seems we have many places with "not enough arguments" or "device no
specified" or "bad usage". What about to create some inline function
for these things?

static inline err_usage(int eval, char *msg)
{
    warnx(msg);
    errtryhelp(eval);
}

#define errnoargs(x)    err_usage(x, _("not enough arguments"))
#define errnodevice(x)  err_usage(x, _("no device specified"))
#define errbadusage(x)  err_usage(x, _("bad usage"))


Maybe it seems like over-engineering, but it's pretty common in the
code and some consolidation to avoid creativity would be nice. The current 
solution requires

    if (argv < 2) {
        warnx(_("not enough arguments")));
        errtryhelp(EXIT_FAILURE);
    }

I think

   if (argv < 2)
       errnoargs(EXIT_FAILURE);

is shorter, seems better and provides control on the messages
(errtryhelp() call, etc).

Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
