Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751435AbdFZUiC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 16:38:02 -0400
Date: Mon, 26 Jun 2017 22:37:58 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/13] usage cleanup part 1
Message-ID: <20170626203758.2ad3kvzzuo5zd3pz@ws.net.home>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
 <86e4396d-ee18-c049-a660-b03f6db951a5@gmx.de>
 <20170626140746.zv5vfomubhy7437u@ws.net.home>
 <f521dab1-98b2-e7da-2a5d-41f6779b0245@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <f521dab1-98b2-e7da-2a5d-41f6779b0245@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 26, 2017 at 04:44:59PM +0200, Rüdiger Meier wrote:
> 
> 
> On 06/26/2017 04:07 PM, Karel Zak wrote:
> > On Mon, Jun 26, 2017 at 03:04:30PM +0200, Rüdiger Meier wrote:
> > > On 06/22/2017 04:37 AM, Ruediger Meier wrote:
> > > > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > > > 
> > > > This is pull request #467 on github
> > > > https://github.com/karelzak/util-linux/pull/467
> > > 
> > > > The major goal is to avoid printing usage/help messages on stderr.
> > > > 
> > > > This is the preparing first part of a bigger patch-set. There are
> > > > some minor bug fixes and finally we add --help options to all our
> > > > commands (just 5 commands were missing it).
> > > > 
> > > > The next completing patch-set (part 2) will be more invasive but
> > > > even more trivial.
> > > 
> > > Thanks for merging.
> > > 
> > > FYI I've PR'ed the second part on github only because it's almost
> > > trivial but invasive.
> > >     https://github.com/karelzak/util-linux/pull/471
> > 
> > Merged, thanks!
> > 
> > It seems we have many places with "not enough arguments" or "device no
> > specified" or "bad usage". What about to create some inline function
> > for these things?
> > 
> > static inline err_usage(int eval, char *msg)
> > {
> >      warnx(msg);
> >      errtryhelp(eval);
> > }
> > 
> > #define errnoargs(x)    err_usage(x, _("not enough arguments"))
> > #define errnodevice(x)  err_usage(x, _("no device specified"))
> > #define errbadusage(x)  err_usage(x, _("bad usage"))
> 
> > 
> > Maybe it seems like over-engineering, but it's pretty common in the
> > code and some consolidation to avoid creativity would be nice. The current
> > solution requires
> > 
> >      if (argv < 2) {
> >          warnx(_("not enough arguments")));
> >          errtryhelp(EXIT_FAILURE);
> >      }
> > 
> > I think
> > 
> >     if (argv < 2)
> >         errnoargs(EXIT_FAILURE);
> > 
> > is shorter, seems better and provides control on the messages
> > (errtryhelp() call, etc).
> > 
> > Comments?
> 
> I was already playing around with something like this
> 
> #define werrtryhelp(eval, s...) __extension__ ({ \
>     warnx(s); \
>     errtryhelp(eval); \
> })
> 
> This would make things 1simple in about 100 cases, for example
> 
>   -       if (argc > 0) {
>   -               warnx(_("%d too many arguments given"), argc);
>   -               errtryhelp(EXIT_FAILURE);
>   -       }
>   +       if (argc > 0)
>   +               werrtryhelp(EXIT_FAILURE, _("%d too many arguments given"), argc);
> 
> 
> For the standard errors we would only need defines like:
> 
> 
> #define ERR_MSG_NOARGS _("not enough arguments"))
> 
>   if (argv < 2)
>       errtryhelp(EXIT_FAILURE, ERR_MSG_NOARGS);

 I'd like to avoid things like ERR_MSG_NOARGS in the standard code 
 for basic messages. 

    if (argv < 2)
        errnoargs(EXIT_FAILURE);

 seems as a way how to keep it simple and stupid. It's fine to have
 ERR_MSG_* somewhere in the header files, but details for standard
 things should be hidden by errxxxxx() macros.
 
> Funny, I've had already deleted my werrtryhelp branch because I got
> already tired of this cleanup. I just got it back from git-reflog
> and safe it for later ;)

 I understand :-) It's nothing critical -- just idea.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
