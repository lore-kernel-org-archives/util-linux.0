Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:56753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751495AbdF1T3z (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 15:29:55 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: fputs() vs puts() (was: [PATCH] hwclock: remove unused usage() FILE argument)
Date: Wed, 28 Jun 2017 21:29:40 +0200
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com> <ce8ce9d6-d266-12da-8e7e-c41e6a185714@gmx.com> <20170620085610.5eacn7kl5agfemmk@ws.net.home>
In-Reply-To: <20170620085610.5eacn7kl5agfemmk@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706282129.41161.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 20 June 2017, Karel Zak wrote:
> On Sun, Jun 18, 2017 at 08:49:49PM -0400, J William Piggott wrote:
> >  sys-utils/hwclock.c | 74
> > ++++++++++++++++++++++++++--------------------------- 1 file
> > changed, 37 insertions(+), 37 deletions(-)
>
> It would be better to remove this patch from the pull-request; let's
> keep fputs() in the code and wait for any solution from Rudi :-)

I have now finished my cleanup regarding stdout only. To make the diffs 
small I have left a useless definition "FILE *out = stdout;" in almost 
any usage function.

We can remove this "out" variable now everwhere using a sed or awk. But 
a few questions about what would be the best end state.

1. fputs vs puts?:

   Is it a problem for translators if we remove a newline from almost
   any string? And, does puts() look more nice at all? I mean many usage
   functions have to use printf too, so does it look good if some
   strings are '\n' terminated and others not?

2. Alignment for better readabilty in the code.

   I would prefer leading spaces before the first string argument to
   match the longest possible prefix 'printf(_("'. Is that ok?:

   puts(  _(" -q             quiet mode"));
   fputs( _(" -v, --verbose  verbose mode"), stdout);
   printf(_(" -f, --rtc      use alternate to %1$s\n"), _BLA);
   printf(  "     --help     %s\n", USAGE_OPTSTR_HELP);

3. Maybe we should always decouple options and descriptions?

   Introducing a macro like:

   #define prnt_opt(opt, marg_dsc, dsc) \
       printf( "%-" #marg_dsc "s%s\n", opt, dscr)

   /* the magic margin number for the whole function */
   int m = 16;
   prnt_opt(" -q",              m, _("quiet mode");
   prnt_opt(" -v, --verbose",   m, _("verbose mode");
   prnt_opt("      --help",     m, USAGE_OPTSTR_HELP);
   /* or standard help, as exist already */
   print_usage_help_options(m);

4. About our USAGE_* macros

   We can remove the trailing newlines in all macros if puts() is
   preferred (regarding 1.). Or we can just let them print like
   print_usage_help_options().

5. We can leave everything as is and touch all these usage lines only
   if needed. For example I did it without extra noise in a861538c.
   Karel missed his chance in 4fb515f9 ;)

   Note since introducing print_usage_help_options() we *are* already
   mixing hardcoded stdout and variable out. So we can also convert
   single lines from fprintf to printf, like i did in my last pending
   hwclock patch "don't ifdef printf arguments".

cu,
Rudi
