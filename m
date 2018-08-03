Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732367AbeHCM0S (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 3 Aug 2018 08:26:18 -0400
Date: Fri, 3 Aug 2018 12:30:34 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] mesg: do not print 'ttyname failed' message unless
 --verbose requested
Message-ID: <20180803103034.qtpcoacdcjxszaxc@ws.net.home>
References: <20180801212644.1652-1-kerolasa@iki.fi>
 <20180802085117.vwbtc7kwkcphhelv@ws.net.home>
 <CAG27Bk0qkNb=0K+X0aMmQBL96OWhOLL1ZZov1SSm8PUa_Mjrtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0qkNb=0K+X0aMmQBL96OWhOLL1ZZov1SSm8PUa_Mjrtw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 02, 2018 at 07:38:08PM +0100, Sami Kerola wrote:
> On 2 August 2018 at 09:51, Karel Zak <kzak@redhat.com> wrote:
> > On Wed, Aug 01, 2018 at 10:26:44PM +0100, Sami Kerola wrote:
> >> Lots of people are confused why mesg(1) is priting this message.  Usual
> >> cause seems to be an uninteractive shell trying to turn running 'mesg n'
> >> from a /root/.profile where command invocation is by default on debian based
> >> systems.  This might be rare case when failing silently is better.
> >>
> >> Reference: https://www.google.com/search?q=mesg+ttyname+failed
> >> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> >> ---
> >>  term-utils/mesg.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/term-utils/mesg.c b/term-utils/mesg.c
> >> index 8714ad1aa..7c4e390bb 100644
> >> --- a/term-utils/mesg.c
> >> +++ b/term-utils/mesg.c
> >> @@ -121,8 +121,11 @@ int main(int argc, char *argv[])
> >>       argc -= optind;
> >>       argv += optind;
> >>
> >> -     if ((tty = ttyname(STDERR_FILENO)) == NULL)
> >> -             err(MESG_EXIT_FAILURE, _("ttyname failed"));
> >> +     if ((tty = ttyname(STDERR_FILENO)) == NULL) {
> >> +             if (verbose == TRUE)
> >> +                     err(MESG_EXIT_FAILURE, _("ttyname failed"));
> >> +             exit(MESG_EXIT_FAILURE);
> >> +     }
> >
> > What about:
> >
> > if (isatty(STDERR_FILENO)) {
> >     if (verbose)
> >         warnx(_("no tty"));
> >     exit(MESG_EXIT_FAILURE);
> > }
> >
> > tty = ttyname(STDERR_FILENO);
> > if (!tty)
> >    ... the current code ...
> 
> Hi Karel
> 
> That's probably better. I pushed that version to my remote branch
> 'mesg' and made pull request:

It's mistake to copy & past without testing. Should be 

    if (!isatty(STDERR_FILENO))

Fixed. I have also added a note to the man page as hide a warning is
little bit controversial.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
