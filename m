Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbcKGLhX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Nov 2016 06:37:23 -0500
Date: Mon, 7 Nov 2016 12:37:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] tests: always quote $LODEV
Message-ID: <20161107113721.z53bvekbw3swgaxc@ws.net.home>
References: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
 <201611070958.25232.sweet_f_a@gmx.de>
 <20161107094101.jit57km4ymbdumy6@ws.net.home>
 <201611071121.55542.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201611071121.55542.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 07, 2016 at 11:21:55AM +0100, Ruediger Meier wrote:
> > > auto-help feature. Don't understand why we are doing that instead
> > > of just printing "unkown option" or "missing argument".
> >
> > I'd like to change it for v2.30.
> >
> > Optionally, it would be also nice to have a way how to suggest the
> > correct option on typos. I like the way how git react on typos:
> >
> >         $ git cxmmit
> >         git: 'cxmmit' is not a git command. See 'git --help'.
> >
> >         Did you mean this?
> >             commit
> >
> 
> This is nice, allthough for getopt(3) option parsing this functionality 
> would IMO belong to getopt() itself. Like we have already this
>  
> $ mount --make
> mount: option '--make' is ambiguous; 
> possibilities: '--make-shared' '--make-runbindable' '--make-rprivate' ...
>
> Maybe just patch gnulib/getopt?

We don't have a problem with getopt_long() from libc, it works as
expected and it's good enough, so I don't think we need some 
complete fallback like gnulib/getopt. 

All we need is to:

 * print error message on unrecognized option (usually done by libc)
 * suggest --help
 * maybe detect typo and suggest correct option (unimportant)

The most trivial way would be to add ul_getopt_long() to c.h and
remove "default:" cases from getopt blocks. In the function we can do
all the funny things.

> BTW would be also very nice to ensure by design that --help, manpage and 
> the actual commands are always synchron.

It depends what do you mean with synchron. All options should be
documented by --help and man page, but the description should be
different. For --help we want really minimalistic and easy to
translate description. The man page is unlimited area for creative
writers :-)

> For my own projects I've 
> used "gengetopt" for this. Unfortunately it has some unfixed bugs and 
> it seems unmaintained. One of my colleagues has a nice project "yuck" 
> adressing this, http://www.fresse.org/yuck/ It's basically a 
> replacement for gengetopt and help2man.

Frankly, all we need is to detect mistakes (undocumented options).

I'd like to be conservative and avoid complex solutions. I think our
--help is nice and works as expected :-)

This is "color of the bikeshed" topic :-) I'm sure there s many ways
and many solutions, but we have no any real problem in this area. All
we need is to avoid auto-help. That's all.

> I could send a patch to introduce yuck in UL to see how it would look. 

Well, I see many another more important tasks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
