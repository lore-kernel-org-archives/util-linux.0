Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:64072 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbdF2Khc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Jun 2017 06:37:32 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: fputs() vs puts() (was: [PATCH] hwclock: remove unused usage() FILE argument)
Date: Thu, 29 Jun 2017 12:37:19 +0200
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com> <201706282129.41161.sweet_f_a@gmx.de> <20170629085114.66lbbszwxnooszbb@ws.net.home>
In-Reply-To: <20170629085114.66lbbszwxnooszbb@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706291237.19507.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 29 June 2017, Karel Zak wrote:
> On Wed, Jun 28, 2017 at 09:29:40PM +0200, Ruediger Meier wrote:
> > On Tuesday 20 June 2017, Karel Zak wrote:
> > > On Sun, Jun 18, 2017 at 08:49:49PM -0400, J William Piggott wrote:
> > > >  sys-utils/hwclock.c | 74
> > > > ++++++++++++++++++++++++++--------------------------- 1 file
> > > > changed, 37 insertions(+), 37 deletions(-)
> > >
> > > It would be better to remove this patch from the pull-request;
> > > let's keep fputs() in the code and wait for any solution from
> > > Rudi :-)
> >
> > I have now finished my cleanup regarding stdout only. To make the
> > diffs small I have left a useless definition "FILE *out = stdout;"
> > in almost any usage function.
> >
> > We can remove this "out" variable now everwhere using a sed or awk.
> > But a few questions about what would be the best end state.
> >
> > 1. fputs vs puts?:
> >
> >    Is it a problem for translators if we remove a newline from
> > almost any string? And, does puts() look more nice at all? I mean
> > many usage functions have to use printf too, so does it look good
> > if some strings are '\n' terminated and others not?
>
> Frankly, I prefer to have \n in the string, because in this case you
> have full control on the output. And it also means all the strings
> modification... for me fputs() is the winner :-)
>
> > 2. Alignment for better readabilty in the code.
> >
> >    I would prefer leading spaces before the first string argument
> > to match the longest possible prefix 'printf(_("'. Is that ok?:
> >
> >    puts(  _(" -q             quiet mode"));
> >    fputs( _(" -v, --verbose  verbose mode"), stdout);
> >    printf(_(" -f, --rtc      use alternate to %1$s\n"), _BLA);
> >    printf(  "     --help     %s\n", USAGE_OPTSTR_HELP);
>
> Yes, good idea.
>
> > 3. Maybe we should always decouple options and descriptions?
> >
> >    Introducing a macro like:
> >
> >    #define prnt_opt(opt, marg_dsc, dsc) \
> >        printf( "%-" #marg_dsc "s%s\n", opt, dscr)
> >
> >    /* the magic margin number for the whole function */
> >    int m = 16;
> >    prnt_opt(" -q",              m, _("quiet mode");
> >    prnt_opt(" -v, --verbose",   m, _("verbose mode");
> >    prnt_opt("      --help",     m, USAGE_OPTSTR_HELP);
> >    /* or standard help, as exist already */
> >    print_usage_help_options(m);
>
> Hmm... now translator can also translate option arguments
>
>   --something <time>     this is nice option
>
> in this case <time> is possible to translate too, and maybe in some
> languages it's possible that you will need to change number of blank
> spaces between option and option description.
>
> IMHO it's against KISS principle :-)
>
> > 4. About our USAGE_* macros
> >
> >    We can remove the trailing newlines in all macros if puts() is
> >    preferred (regarding 1.). Or we can just let them print like
> >    print_usage_help_options().
>
> Frankly, for me it's more readable to have
>
>     fputs(USAGE_OPTIONS, stdout);
>
> than introduce another function. (It was also reason why I was not
> sure with print_usage_help_options(), but it resolves more issues.)

I can still change it to be used like MAN_TAIL, then we are consistent 
again.

  print_usage_help_options(16);
  vs.
  printf( USAGE_HELP_OPTIONS(16) );

> > 5. We can leave everything as is and touch all these usage lines
> > only if needed. For example I did it without extra noise in
> > a861538c. Karel missed his chance in 4fb515f9 ;)
>
> It was my goal not to do any change if you work in this area. And
> yes, "touch only if needed" is good idea. The blockdev usage() is
> nice example that mix more things together is no problem, it's still
> readable and without extra complexity (well, maybe use COMMANDS:
> there :-).
>
> >    Note since introducing print_usage_help_options() we *are*
> > already mixing hardcoded stdout and variable out. So we can also
> > convert single lines from fprintf to printf, like i did in my last
> > pending hwclock patch "don't ifdef printf arguments".
>
> All the issue is libc stupidity, imagine world where puts() is
> without \n junk (like printf and fprintf). I think printf() is no
> problem there.
>
> For me it's about:
>
>     * nice usage() output
>     * usage() function readability
>     * all without extra complexity (random contributor has to be able
>       add new option easily)
>     * translators-friendly (minimize changes, keep it open as much as
>       possible)


I see it all like you, so let's stop code cosmetics unless we have real 
changes. I'll send a patch for boilerpalate.c only. and maybe the 
mentioned help_options macro.

cu,
Rudi
