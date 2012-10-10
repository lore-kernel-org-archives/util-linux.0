Return-Path: dave@gnu.org
Message-ID: <1349861169.2576.4.camel@offbook>
Subject: Re: [PATCH] dmesg colorized output
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: Ondrej Oprala <ooprala@redhat.com>, util-linux@vger.kernel.org
Date: Wed, 10 Oct 2012 11:26:09 +0200
In-Reply-To: <20121010091926.GE28457@x2.net.home>
References: <50752745.4020607@redhat.com>
	 <20121010091926.GE28457@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Wed, 2012-10-10 at 11:19 +0200, Karel Zak wrote:
> On Wed, Oct 10, 2012 at 09:44:05AM +0200, Ondrej Oprala wrote:
> > new file mode 100644

Hehe I actually started doing this last night.

I'm wondering if we actually need a new lib file for colors. I mean
AFAICT, dmesg is the only place we want to use it and I don't see that
changing any time soon - Unix hackers don't like colors, we live oh so
boring lives :)

> > index 0000000..90b62a7
> > --- /dev/null
> > +++ b/include/colors.h
> > @@ -0,0 +1,19 @@
> 
> Please, see another files in include/.
> 
>  #ifndef UTIL_LINUX_COLOR_H
>  #define UTIL_LINUX_COLOR_H
> 
> > +/*
> > + * Copyright (C) 2012 Ondrej Oprala <ooprala@redhat.com>
> > + *
> > + * This file may be distributed under the terms of the
> > + * GNU Lesser General Public License.
> > + */
> > +
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#define CLR_RST "\033[0m"
> 
>    #define UL_COLOR_RESET
> 
> to keep it readable. It would be also nice to have macros for
> individual colors (UL_COLOR_{RED,YELLOW,BLUE,...} and extra modes like
> bold.
> 
> (It's also possible to set background colors, but I guess that
> foreground colors are enough for our utils.)
> 
> > --- /dev/null
> > +++ b/lib/colors.c
> > @@ -0,0 +1,20 @@
> > +/*
> > + * Copyright (C) 2012 Ondrej Oprala <ooprala@redhat.com>
> > + *
> > + * This file may be distributed under the terms of the
> > + * GNU Lesser General Public License.
> > + */
> > +
> > +#include "colors.h"
> > +
> > +void set_clr(const char *clr_scheme, FILE *out)
> 
>   color_enable()
> 
> Is it necessary to care about "out"? Maybe we can assume that the
> output is stdout.
> 
> > +{
> > +	if (isatty(fileno(out)))
> > +		fprintf(out, clr_scheme);
> > +}
> 
>  if I good remember than isatty() is internally implemented by any
>  ioctl(). It would be probably better to have something like:
> 
>    int colors_init();
> 
>  where we check all necessary terminal features and initialize a
>  global variable, so in color_enable/disable() we will check the
>  variable only.
> 
> > +void rst_clr(FILE *out)
> 
>    color_disable()
> 
> Maybe for the functions names we should also use ul_ prefix to avoid
> collisions (for example ncurses library also uses pretty generic names
> for color functions).
> 
> > +{
> > +	if (isatty(fileno(out)))
> > +		fprintf(out, CLR_RST);
> > +}
> 
>  Please, use fputs() rather than fprintf().
> 
> > diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
> > index 4c85f9f..fc384d7 100644
> > --- a/sys-utils/dmesg.c
> > +++ b/sys-utils/dmesg.c
> > @@ -23,6 +23,7 @@
> >  #include <fcntl.h>
> >  
> >  #include "c.h"
> > +#include "colors.h"
> >  #include "nls.h"
> >  #include "strutils.h"
> >  #include "xalloc.h"
> > @@ -33,6 +34,11 @@
> >  #include "optutils.h"
> >  #include "mangle.h"
> >  
> > +#define K_PANIC 1
> > +#define K_ERR 3
> 
> really no, already defined by LOG_* macros in
> <sys/syslog.h>, see also level_names[] array in dmesg.c.
> 
> > +#define CLR_PANIC "\033[31m" //Red
> > +#define CLR_ERR "\033[1;31m" //Bright Red

how about using /* ... */

> 
> #define DMESG_COLOR_ALERT   UL_COLOR_RED
> #define DMESG_COLOR_ERR     UL_COLOR_BRIGHT_RED
> 
> 
> >  /* Close the log.  Currently a NOP. */
> >  #define SYSLOG_ACTION_CLOSE          0
> >  /* Open the log. Currently a NOP. */
> > @@ -147,7 +153,8 @@ struct dmesg_control {
> >  			notime:1,	/* don't print timestamp */
> >  			delta:1,	/* show time deltas */
> >  			reltime:1,	/* show human readable relative times */
> > -			ctime:1;	/* show human readable time */
> > +			ctime:1,	/* show human readable time */
> > +			color:1;	/* colorize error and panic messages */
> >  };
> >  
> >  struct dmesg_record {
> > @@ -193,6 +200,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
> >  		" -f, --facility <list>       restrict output to defined facilities\n"
> >  		" -h, --help                  display this help and exit\n"
> >  		" -k, --kernel                display kernel messages\n"
> > +		" -L, --color                 colorize error and panic messages\n"
> >  		" -l, --level <list>          restrict output to defined levels\n"
> >  		" -n, --console-level <level> set level of messages printed to console\n"
> >  		" -r, --raw                   print the raw message buffer\n"
> > @@ -839,8 +847,16 @@ static void print_record(struct dmesg_control *ctl,
> >  		printf("[%5d.%06d] ", (int) rec->tv.tv_sec, (int) rec->tv.tv_usec);
> >  
> >  mesg:
> > +  //Change the output color for panic and error messages
> > +  if (ctl->color)
> > +    set_clr(rec->level == K_PANIC ? CLR_PANIC :
> > +        rec->level == K_ERR ? CLR_ERR : CLR_RST, stdout);
> 
> keep it elegant:
> 
>     if (ctl->color)
>         set_level_color(rec->level);
> 
> :-)
> 
> >  	safe_fwrite(rec->mesg, rec->mesg_size, stdout);
> >  
> > +  if (ctl->color)
> > +    rst_clr(stdout);
> > +
> >  	if (*(rec->mesg + rec->mesg_size - 1) != '\n')
> >  		putchar('\n');
> >  }
> > @@ -1046,6 +1062,7 @@ int main(int argc, char *argv[])
> >  	static const struct option longopts[] = {
> >  		{ "buffer-size",   required_argument, NULL, 's' },
> >  		{ "clear",         no_argument,	      NULL, 'C' },
> > +		{ "color",         no_argument,	      NULL, 'L' },
> >  		{ "console-level", required_argument, NULL, 'n' },
> >  		{ "console-off",   no_argument,       NULL, 'D' },
> >  		{ "console-on",    no_argument,       NULL, 'E' },
> > @@ -1080,7 +1097,7 @@ int main(int argc, char *argv[])
> >  	textdomain(PACKAGE);
> >  	atexit(close_stdout);
> >  
> > -	while ((c = getopt_long(argc, argv, "CcDdEeF:f:hkl:n:rSs:TtuVwx",
> > +	while ((c = getopt_long(argc, argv, "CcDdEeF:f:hkLl:n:rSs:TtuVwx",
> >  				longopts, NULL)) != -1) {
> >  
> >  		err_exclusive_options(c, longopts, excl, excl_st);
> > @@ -1123,6 +1140,9 @@ int main(int argc, char *argv[])
> >  			ctl.fltr_fac = 1;
> >  			setbit(ctl.facilities, FAC_BASE(LOG_KERN));
> >  			break;
> > +		case 'L':
> > +			ctl.color = 1;
> > +			break;
> >  		case 'l':
> >  			ctl.fltr_lev= 1;
> >  			if (string_to_bitarray(optarg,
> > @@ -1180,9 +1200,9 @@ int main(int argc, char *argv[])
> >  		usage(stderr);
> >  
> >  	if (ctl.raw && (ctl.fltr_lev || ctl.fltr_fac || ctl.delta ||
> > -			ctl.notime || ctl.ctime || ctl.decode))
> > +			ctl.notime || ctl.ctime || ctl.decode || ctl.color))
> >  		errx(EXIT_FAILURE, _("--raw can't be used together with level, "
> > -		     "facility, decode, delta, ctime or notime options"));
> > +		     "facility, decode, delta, ctime, notime or color options"));
> 
>    if (ctl.color && ul_color_init() != 0)
>      ctl.color = 0;
> 
>   Thanks!
> 
>     Karel
> 
