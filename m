Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33371 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdHEQo4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 5 Aug 2017 12:44:56 -0400
Received: by mail-wr0-f194.google.com with SMTP id y43so4882998wrd.0
        for <util-linux@vger.kernel.org>; Sat, 05 Aug 2017 09:44:55 -0700 (PDT)
Date: Sat, 5 Aug 2017 17:44:53 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 8/9] agetty: add --compile-time option
In-Reply-To: <20170801094119.4cgxngx757rhtulh@ws.net.home>
Message-ID: <alpine.LNX.2.20.1708051734170.4995@imuri>
References: <20170731195508.11661-1-kerolasa@iki.fi> <20170731195508.11661-9-kerolasa@iki.fi> <20170801094119.4cgxngx757rhtulh@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 1 Aug 2017, Karel Zak wrote:

> On Mon, Jul 31, 2017 at 08:55:07PM +0100, Sami Kerola wrote:
> > This command has the most compile time #ifdef code.  It is time to add an
> > option to print what was defined when the command was compiled, so that
> > debugging is easier.
> > 
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> >  term-utils/agetty.8 |   3 +
> >  term-utils/agetty.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 254 insertions(+)
> > 
> > diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
> > index 23adff3b1..230c47cd5 100644
> > --- a/term-utils/agetty.8
> > +++ b/term-utils/agetty.8
> > @@ -281,6 +281,9 @@ if the user has not yet commenced logging in.  After doing so the command will
> >  exit.  This feature might be unsupported on systems without Linux
> >  .BR inotify (7).
> >  .TP
> > +\-\-compile\-time
> > +Display compile time definitions.
> 
> I don't like the option name ;-)

It felt a bit sticky when proposing, but I'm clad that sent it anyway as 
you point out a lot better way.

> > +static void __attribute__((__noreturn__)) compile_time(void)
> > +{
> > +#ifdef B19200
> > +printf("%-30s: defined\n", "B19200");
> > +#else
> > +printf("%-30s: not in use\n", "B19200");
> > +#endif
> 
> This is overkill. I can imagine --list-speeds to list built-in speeds
> in format "<speed>\n"
> 
> static cost char *speeds[] = {
> #ifdef B19200
>     "B19200",
> #endif
> };
> 
> ... and so on.

There is already speedlist, so how about reusing it. Here is a commit that 
adds the proposed option that way.

https://github.com/kerolasa/lelux-utiliteetit/commit/11841430c9b94d4f0246005a826a1c17a5af972d

> > +#ifdef AGETTY_RELOAD
> > +printf("%-30s: defined\n", "AGETTY_RELOAD");
> > +#else
> > +printf("%-30s: not in use\n", "AGETTY_RELOAD");
> > +#endif
> 
> For this purpose we can use --version, see for example mount:
> 
>  $ mount -V
>  mount from util-linux 2.28.2 (libmount 2.28.2: selinux, btrfs, force-mountinfo, assert, debug)
> 
> the same we can use for agetty to list *really important* enabled
> features, for example:
> 
>  $ agetty -V
>  agetty from util-linux 2.31 (reload, issue, plymouth, debug)

Oh yes, that is a lot nicer way. See below for the new version of the 
output. Primary reason I introduced output_version() is to avoid having 
the features[] array in scope when it is not needed.

https://github.com/kerolasa/lelux-utiliteetit/commit/63d94613a887c9a5f741d87bff4c7979293c4baf



> > +#ifdef CRTSCTS
> > +printf("%-30s: defined\n", "CRTSCTS");
> > +#else
> > +printf("%-30s: not in use\n", "CRTSCTS");
> > +#endif
> 
> not sure if this is important
> 
> > +#ifdef DEBUGGING
> > +printf("%-30s: defined\n", "DEBUGGING");
> > +#else
> > +printf("%-30s: not in use\n", "DEBUGGING");
> > +#endif
> 
> ok
> 
> > +#ifdef HAVE_GETDOMAINNAME
> > +printf("%-30s: defined\n", "HAVE_GETDOMAINNAME");
> > +#else
> > +printf("%-30s: not in use\n", "HAVE_GETDOMAINNAME");
> > +#endif
> > +
> > +#ifdef HAVE_LIBUTIL_H
> > +printf("%-30s: defined\n", "HAVE_LIBUTIL_H");
> > +#else
> > +printf("%-30s: not in use\n", "HAVE_LIBUTIL_H");
> > +#endif
> 
> unimportant
> 
> > +#ifdef HAVE_STRUCT_TERMIOS_C_LINE
> > +printf("%-30s: defined\n", "HAVE_STRUCT_TERMIOS_C_LINE");
> > +#else
> > +printf("%-30s: not in use\n", "HAVE_STRUCT_TERMIOS_C_LINE");
> > +#endif
> > +
> > +#ifdef HAVE_SYS_PARAM_H
> > +printf("%-30s: defined\n", "HAVE_SYS_PARAM_H");
> > +#else
> > +printf("%-30s: not in use\n", "HAVE_SYS_PARAM_H");
> > +#endif
> > +
> > +#ifdef HAVE_UTMP_H
> > +printf("%-30s: defined\n", "HAVE_UTMP_H");
> > +#else
> > +printf("%-30s: not in use\n", "HAVE_UTMP_H");
> > +#endif
> 
> really unimportant
> 
> > +#ifdef HAVE_WIDECHAR
> > +printf("%-30s: defined\n", "HAVE_WIDECHAR");
> > +#else
> > +printf("%-30s: not in use\n", "HAVE_WIDECHAR");
> > +#endif
> 
> ok
> 
> > +#ifdef ISSUE
> > +printf("%-30s: defined\n", "ISSUE");
> > +#else
> > +printf("%-30s: not in use\n", "ISSUE");
> > +#endif
> 
> ok
> 
> > +#ifdef IUCLC
> > +printf("%-30s: defined\n", "IUCLC");
> > +#else
> > +printf("%-30s: not in use\n", "IUCLC");
> > +#endif
> >
> > +#ifdef IUTF8
> > +printf("%-30s: defined\n", "IUTF8");
> > +#else
> > +printf("%-30s: not in use\n", "IUTF8");
> > +#endif
> 
> unimportant
> 
> > +#ifdef KDGKBLED
> > +printf("%-30s: defined\n", "KDGKBLED");
> > +#else
> > +printf("%-30s: not in use\n", "KDGKBLED");
> > +#endif
> > +
> > +#ifdef KDGKBMODE
> > +printf("%-30s: defined\n", "KDGKBMODE");
> > +#else
> > +printf("%-30s: not in use\n", "KDGKBMODE");
> > +#endif
> 
> ok
> 
> > +#ifdef K_RAW
> > +printf("%-30s: defined\n", "K_RAW");
> > +#else
> > +printf("%-30s: not in use\n", "K_RAW");
> > +#endif
> > +
> > +#ifdef LOGIN_PROCESS
> > +printf("%-30s: defined\n", "LOGIN_PROCESS");
> > +#else
> > +printf("%-30s: not in use\n", "LOGIN_PROCESS");
> > +#endif
> > +
> > +#ifdef OLCUC
> > +printf("%-30s: defined\n", "OLCUC");
> > +#else
> > +printf("%-30s: not in use\n", "OLCUC");
> > +#endif
> > +
> > +#ifdef SYSV_STYLE
> > +printf("%-30s: defined\n", "SYSV_STYLE");
> > +#else
> > +printf("%-30s: not in use\n", "SYSV_STYLE");
> > +#endif
> 
> unimportant
> 
> > +#ifdef USE_PLYMOUTH_SUPPORT
> > +printf("%-30s: defined\n", "USE_PLYMOUTH_SUPPORT");
> > +#else
> > +printf("%-30s: not in use\n", "USE_PLYMOUTH_SUPPORT");
> > +#endif
> 
> ok
> 
> > +#ifdef USE_SYSLOG
> > +printf("%-30s: defined\n", "USE_SYSLOG");
> > +#else
> > +printf("%-30s: not in use\n", "USE_SYSLOG");
> > +#endif
> 
> ok
> 
> > +#ifdef XCASE
> > +printf("%-30s: defined\n", "XCASE");
> > +#else
> > +printf("%-30s: not in use\n", "XCASE");
> > +#endif
> > +
> > +#ifdef __FreeBSD_kernel__
> > +printf("%-30s: defined\n", "__FreeBSD_kernel__");
> > +#else
> > +printf("%-30s: not in use\n", "__FreeBSD_kernel__");
> > +#endif
> > +
> > +#ifdef __linux__
> > +printf("%-30s: defined\n", "__linux__");
> > +#else
> > +printf("%-30s: not in use\n", "__linux__");
> > +#endif
> 
> unimportant
> 
>     Karel

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
