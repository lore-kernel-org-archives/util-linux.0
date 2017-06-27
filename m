Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752090AbdF0MTV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Jun 2017 08:19:21 -0400
Date: Tue, 27 Jun 2017 14:19:17 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/6] misc: introduce PRINT_USAGE_HELP()
Message-ID: <20170627121917.v3ghpw4ap2wyyoot@ws.net.home>
References: <20170626182952.15988-1-sweet_f_a@gmx.de>
 <20170626182952.15988-3-sweet_f_a@gmx.de>
 <20170627094652.fz3grdtj5qe5cmhi@ws.net.home>
 <e39a60ec-8aaf-de01-1d22-0064b1b2b2ed@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <e39a60ec-8aaf-de01-1d22-0064b1b2b2ed@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 27, 2017 at 12:48:44PM +0200, Rüdiger Meier wrote:
> 
> 
> On 06/27/2017 11:46 AM, Karel Zak wrote:
> > On Mon, Jun 26, 2017 at 08:29:48PM +0200, Ruediger Meier wrote:
> > > --- a/include/c.h
> > > +++ b/include/c.h
> > > @@ -315,8 +315,18 @@ static inline int xusleep(useconds_t usec)
> > >   #define USAGE_COMMANDS   _("\nCommands:\n")
> > >   #define USAGE_COLUMNS    _("\nAvailable output columns:\n")
> > >   #define USAGE_SEPARATOR    "\n"
> > > -#define USAGE_HELP       _(" -h, --help     display this help and exit\n")
> > > -#define USAGE_VERSION    _(" -V, --version  output version information and exit\n")
> > > +
> > > +#define USAGE_HELP_TXT    _("display this help and exit")
> > > +#define USAGE_VERSION_TXT _("output version information and exit")
> > > +
> > > +#define PRINT_USAGE_HELP(marg_dsc) \
> > > +	printf( \
> > > +		"%-" #marg_dsc "s%s\n" \
> > > +		"%-" #marg_dsc "s%s\n" \
> > > +		, " -h, --help",    USAGE_HELP_TXT \
> > > +		, " -V, --version", USAGE_VERSION_TXT \
> > > +	)
> > 
> > Would be possible to use lowercase for the macro name?
> > 
> > For example USAGE_HELP_TXT is fine, but for something like function I
> > would prefer
> > 
> >   #define print_usage_help(marg_dsc)
> 
> I've updated on github to

 Cool, merged.

> > and what about USAGE_SEPARATOR that we have always before --help?
> > Maybe we can add \n to  the print_usage_help() too.
> 
> No, because
> 
> 1. There are commands with help options only:
> 
> $ ctrlaltdel --help
>  [...]
>  Options:
>  -h, --help     display this help
>  -V, --version  print version
> 
> 2. Since we have we help descriptions now aligned we do not need
>    the separator always IMO. ipcs(1) and also others which
>    still don't have separators are looking ok:

 I see (I've expected this reply :-).

 Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
