Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sun, 1 Mar 2015 11:49:26 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/16] eject: use parse_switch()
In-Reply-To: <20150224113727.GK19430@ws.net.home>
Message-ID: <alpine.LNX.2.03.1503011147050.822@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi> <1424616106-580-10-git-send-email-kerolasa@iki.fi> <20150224113727.GK19430@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Tue, 24 Feb 2015, Karel Zak wrote:

> On Sun, Feb 22, 2015 at 02:41:39PM +0000, Sami Kerola wrote:
> >  		case 'a':
> >  			ctl->a_option = 1;
> > -			if (!strcmp(optarg, "0") || !strcmp(optarg, "off"))
> > -				ctl->a_arg = 0;
> > -			else if (!strcmp(optarg, "1") || !strcmp(optarg, "on"))
> > -				ctl->a_arg = 1;
> > -			else
> > -				errx(EXIT_FAILURE, _("invalid argument to --auto/-a option"));
> > +			ctl->a_arg = parse_switch(optarg, "on", "off");
> 
> I have extended parse_switch() to accept arbitrary number of 1|0 pairs
> and also error message, so:
> 
>   ctl->a_arg = parse_switch(optarg, _("argument error"),
>                         "on", "off",  "1", "0",  NULL);
> 
> 
> Idea: maybe we can remove all the _("argument error") strings from all
> strtoxxx_ functions and use some global function to generate proper user 
> friendly error messages from longopts[], something like:
> 
> 
> while ((c = getopt_long(argc, argv, "a:b:", longopts, NULL)) != -1) {
> 
>     err_strtoxxx_set_options(c, longopts);       <--- !!!
> 
>     switch (c) {
>     case 'a':
>         foo = strtol_or_err(optarg);
>         break;
>     case 'b':
>         bar = parse_switch(optarg, "on", "off", NULL);
>         break;
>     }
> }
> 
> 
> where err_strtoxxx_set_options() sets in strutils.c static
> 
>         ul_cur_option = c;
>         ul_lonfopts = longopts;
> 
> then on error strtol_or_err() and parse_switch() will use the ul_
> variables to print
> 
>      "invalid argument to --auto/-a: %s", optarg
> 
> and if ul_* are not initialized then something generic ("argument
> error"). The result will be less code in main(), better error messages,
> and code independent on the names of the options.

Thanks Karel,

Updated version of parse_switch() is now in use in 'tunelp: use 
parse_switch()' change.

https://github.com/kerolasa/lelux-utiliteetit/commit/d5ea22b18085c8a16621bc2e2cf45200afe3fe9c

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
