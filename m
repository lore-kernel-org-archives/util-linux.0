Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 3/3] tests: always quote $LODEV
Date: Mon, 7 Nov 2016 11:21:55 +0100
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org
References: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de> <201611070958.25232.sweet_f_a@gmx.de> <20161107094101.jit57km4ymbdumy6@ws.net.home>
In-Reply-To: <20161107094101.jit57km4ymbdumy6@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201611071121.55542.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 07 November 2016, Karel Zak wrote:
> On Mon, Nov 07, 2016 at 09:58:25AM +0100, Ruediger Meier wrote:
> > On Sunday 06 November 2016, Bernhard Voelker wrote:
> > > So what happens now when losetup is fed with ""?
> > > Wouldn't it be better to handle the error instead?
> >
> > Actually the failure is generally handled in terms that the test
> > will fail and exit 1.
>
> This is the basic idea of the tests; it would be nice to keep it
> simple and stupid :-)
>
> > the whole --help output on usage errors. I really hate that
> > auto-help feature. Don't understand why we are doing that instead
> > of just printing "unkown option" or "missing argument".
>
> I'd like to change it for v2.30.
>
> Optionally, it would be also nice to have a way how to suggest the
> correct option on typos. I like the way how git react on typos:
>
>         $ git cxmmit
>         git: 'cxmmit' is not a git command. See 'git --help'.
>
>         Did you mean this?
>             commit
>

This is nice, allthough for getopt(3) option parsing this functionality 
would IMO belong to getopt() itself. Like we have already this
 
$ mount --make
mount: option '--make' is ambiguous; 
possibilities: '--make-shared' '--make-runbindable' '--make-rprivate' ...

Maybe just patch gnulib/getopt?

BTW would be also very nice to ensure by design that --help, manpage and 
the actual commands are always synchron. For my own projects I've 
used "gengetopt" for this. Unfortunately it has some unfixed bugs and 
it seems unmaintained. One of my colleagues has a nice project "yuck" 
adressing this, http://www.fresse.org/yuck/ It's basically a 
replacement for gengetopt and help2man.

I could send a patch to introduce yuck in UL to see how it would look. 
Maybe I could also convince my colleague to add such generic 
option-guessing feature.

cu,
Rudi
