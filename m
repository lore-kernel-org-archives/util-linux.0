Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbdKTLC2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 20 Nov 2017 06:02:28 -0500
Date: Mon, 20 Nov 2017 12:02:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Steven Smith <sos22@archy.org.uk>
Cc: util-linux@vger.kernel.org, sos22@srcf.ucam.org
Subject: Re: [PATCH] Fix a use of uninitialised memory in an agetty error
 path.
Message-ID: <20171120110223.3moy333zy7bedpby@ws.net.home>
References: <20171117164433.xtsgma2vdppjpio4@adrian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171117164433.xtsgma2vdppjpio4@adrian>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 17, 2017 at 08:44:33AM -0800, Steven Smith wrote:
> get_logname() assumes that when it calls read() it initializes c and
> errno, which isn't always true if we hit a whitelisted error or end of
> file. This occasionally shows up as agetty going into an infinite
> loop. Fix it by just delaying ten seconds and exiting when things go
> wrong, similarly to the behavior after a non-whitelisted error.
> 
> Signed-off-by: Steven Smith <sos22@srcf.ucam.org>
> ---
>  term-utils/agetty.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 9763fcd30..bc848a25a 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -317,6 +317,7 @@ static void termio_final(struct options *op,
>  static int caps_lock(char *s);
>  static speed_t bcode(char *s);
>  static void usage(void) __attribute__((__noreturn__));
> +static void exit_slowly(int code) __attribute__((__noreturn__));
>  static void log_err(const char *, ...) __attribute__((__noreturn__))
>  			       __attribute__((__format__(printf, 1, 2)));
>  static void log_warn (const char *, ...)
> @@ -1983,9 +1984,11 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
>  		while (cp->eol == '\0') {
>  
>  			char key;
> +			ssize_t readres;
>  
>  			debug("read from FD\n");
> -			if (read(STDIN_FILENO, &c, 1) < 1) {
> +			readres = read(STDIN_FILENO, &c, 1);
> +			if (readres < 0) {
>  				debug("read failed\n");
>  
>  				/* The terminal could be open with O_NONBLOCK when
> @@ -2000,12 +2003,15 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
>  				case ESRCH:
>  				case EINVAL:
>  				case ENOENT:
> -					break;
> +					exit_slowly(EXIT_SUCCESS);

OK, makes sense.

>  				default:
>  					log_err(_("%s: read: %m"), op->tty);
>  				}
>  			}
>  
> +			if (readres == 0)
> +				exit_slowly(EXIT_SUCCESS);

I'm not sure about it. Maybe it would be better to assume that readres == 0
and no error is the same as c = 0. In this case functions returns NULL
and we try another speed setting (if defined) for the terminal.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
