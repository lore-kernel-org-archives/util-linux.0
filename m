Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbdHAJlX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 05:41:23 -0400
Date: Tue, 1 Aug 2017 11:41:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 8/9] agetty: add --compile-time option
Message-ID: <20170801094119.4cgxngx757rhtulh@ws.net.home>
References: <20170731195508.11661-1-kerolasa@iki.fi>
 <20170731195508.11661-9-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170731195508.11661-9-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 31, 2017 at 08:55:07PM +0100, Sami Kerola wrote:
> This command has the most compile time #ifdef code.  It is time to add an
> option to print what was defined when the command was compiled, so that
> debugging is easier.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/agetty.8 |   3 +
>  term-utils/agetty.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 254 insertions(+)
> 
> diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
> index 23adff3b1..230c47cd5 100644
> --- a/term-utils/agetty.8
> +++ b/term-utils/agetty.8
> @@ -281,6 +281,9 @@ if the user has not yet commenced logging in.  After doing so the command will
>  exit.  This feature might be unsupported on systems without Linux
>  .BR inotify (7).
>  .TP
> +\-\-compile\-time
> +Display compile time definitions.

I don't like the option name ;-)

> +static void __attribute__((__noreturn__)) compile_time(void)
> +{
> +#ifdef B19200
> +printf("%-30s: defined\n", "B19200");
> +#else
> +printf("%-30s: not in use\n", "B19200");
> +#endif

This is overkill. I can imagine --list-speeds to list built-in speeds
in format "<speed>\n"

static cost char *speeds[] = {
#ifdef B19200
    "B19200",
#endif
};

... and so on.

> +#ifdef AGETTY_RELOAD
> +printf("%-30s: defined\n", "AGETTY_RELOAD");
> +#else
> +printf("%-30s: not in use\n", "AGETTY_RELOAD");
> +#endif

For this purpose we can use --version, see for example mount:

 $ mount -V
 mount from util-linux 2.28.2 (libmount 2.28.2: selinux, btrfs, force-mountinfo, assert, debug)

the same we can use for agetty to list *really important* enabled
features, for example:

 $ agetty -V
 agetty from util-linux 2.31 (reload, issue, plymouth, debug)


> +#ifdef CRTSCTS
> +printf("%-30s: defined\n", "CRTSCTS");
> +#else
> +printf("%-30s: not in use\n", "CRTSCTS");
> +#endif

not sure if this is important

> +#ifdef DEBUGGING
> +printf("%-30s: defined\n", "DEBUGGING");
> +#else
> +printf("%-30s: not in use\n", "DEBUGGING");
> +#endif

ok

> +#ifdef HAVE_GETDOMAINNAME
> +printf("%-30s: defined\n", "HAVE_GETDOMAINNAME");
> +#else
> +printf("%-30s: not in use\n", "HAVE_GETDOMAINNAME");
> +#endif
> +
> +#ifdef HAVE_LIBUTIL_H
> +printf("%-30s: defined\n", "HAVE_LIBUTIL_H");
> +#else
> +printf("%-30s: not in use\n", "HAVE_LIBUTIL_H");
> +#endif

unimportant

> +#ifdef HAVE_STRUCT_TERMIOS_C_LINE
> +printf("%-30s: defined\n", "HAVE_STRUCT_TERMIOS_C_LINE");
> +#else
> +printf("%-30s: not in use\n", "HAVE_STRUCT_TERMIOS_C_LINE");
> +#endif
> +
> +#ifdef HAVE_SYS_PARAM_H
> +printf("%-30s: defined\n", "HAVE_SYS_PARAM_H");
> +#else
> +printf("%-30s: not in use\n", "HAVE_SYS_PARAM_H");
> +#endif
> +
> +#ifdef HAVE_UTMP_H
> +printf("%-30s: defined\n", "HAVE_UTMP_H");
> +#else
> +printf("%-30s: not in use\n", "HAVE_UTMP_H");
> +#endif

really unimportant

> +#ifdef HAVE_WIDECHAR
> +printf("%-30s: defined\n", "HAVE_WIDECHAR");
> +#else
> +printf("%-30s: not in use\n", "HAVE_WIDECHAR");
> +#endif

ok

> +#ifdef ISSUE
> +printf("%-30s: defined\n", "ISSUE");
> +#else
> +printf("%-30s: not in use\n", "ISSUE");
> +#endif

ok

> +#ifdef IUCLC
> +printf("%-30s: defined\n", "IUCLC");
> +#else
> +printf("%-30s: not in use\n", "IUCLC");
> +#endif
>
> +#ifdef IUTF8
> +printf("%-30s: defined\n", "IUTF8");
> +#else
> +printf("%-30s: not in use\n", "IUTF8");
> +#endif

unimportant

> +#ifdef KDGKBLED
> +printf("%-30s: defined\n", "KDGKBLED");
> +#else
> +printf("%-30s: not in use\n", "KDGKBLED");
> +#endif
> +
> +#ifdef KDGKBMODE
> +printf("%-30s: defined\n", "KDGKBMODE");
> +#else
> +printf("%-30s: not in use\n", "KDGKBMODE");
> +#endif

ok

> +#ifdef K_RAW
> +printf("%-30s: defined\n", "K_RAW");
> +#else
> +printf("%-30s: not in use\n", "K_RAW");
> +#endif
> +
> +#ifdef LOGIN_PROCESS
> +printf("%-30s: defined\n", "LOGIN_PROCESS");
> +#else
> +printf("%-30s: not in use\n", "LOGIN_PROCESS");
> +#endif
> +
> +#ifdef OLCUC
> +printf("%-30s: defined\n", "OLCUC");
> +#else
> +printf("%-30s: not in use\n", "OLCUC");
> +#endif
> +
> +#ifdef SYSV_STYLE
> +printf("%-30s: defined\n", "SYSV_STYLE");
> +#else
> +printf("%-30s: not in use\n", "SYSV_STYLE");
> +#endif

unimportant

> +#ifdef USE_PLYMOUTH_SUPPORT
> +printf("%-30s: defined\n", "USE_PLYMOUTH_SUPPORT");
> +#else
> +printf("%-30s: not in use\n", "USE_PLYMOUTH_SUPPORT");
> +#endif

ok

> +#ifdef USE_SYSLOG
> +printf("%-30s: defined\n", "USE_SYSLOG");
> +#else
> +printf("%-30s: not in use\n", "USE_SYSLOG");
> +#endif

ok

> +#ifdef XCASE
> +printf("%-30s: defined\n", "XCASE");
> +#else
> +printf("%-30s: not in use\n", "XCASE");
> +#endif
> +
> +#ifdef __FreeBSD_kernel__
> +printf("%-30s: defined\n", "__FreeBSD_kernel__");
> +#else
> +printf("%-30s: not in use\n", "__FreeBSD_kernel__");
> +#endif
> +
> +#ifdef __linux__
> +printf("%-30s: defined\n", "__linux__");
> +#else
> +printf("%-30s: not in use\n", "__linux__");
> +#endif

unimportant

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
