Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B170C433B4
	for <util-linux@archiver.kernel.org>; Thu,  6 May 2021 10:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36121610D2
	for <util-linux@archiver.kernel.org>; Thu,  6 May 2021 10:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhEFK7W (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 May 2021 06:59:22 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:47069 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234508AbhEFK7U (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 May 2021 06:59:20 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          for util-linux@vger.kernel.org with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lebi1-001Vy8-7d; Thu, 06 May 2021 12:58:21 +0200
Received: from p5b13abb0.dip0.t-ipconnect.de ([91.19.171.176] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          for util-linux@vger.kernel.org with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lebi1-000cCv-0q; Thu, 06 May 2021 12:58:21 +0200
Subject: Re: [PATCH] sulogin: ignore not existing console devices
To:     util-linux@vger.kernel.org
References: <YJPK1JUPtKTuMJ1J@boole.suse.de>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <d7291735-af45-f590-e741-05487567e89d@physik.fu-berlin.de>
Date:   Thu, 6 May 2021 12:58:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJPK1JUPtKTuMJ1J@boole.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.171.176
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 5/6/21 12:54 PM, Werner Fink wrote:
> and also not functional console devices. Redirect the error
> messages to the appropiate console device.

I guess that should be:

	s/not existing/non-existing/

and

	s/not functional/non-functional/

Adrian

> Signed-off-by: Werner Fink <werner@suse.de>
> 
> ---
>  login-utils/sulogin-consoles.h |  1 +
>  login-utils/sulogin.c          | 97 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 82 insertions(+), 16 deletions(-)
> 
> diff --git a/login-utils/sulogin-consoles.h b/login-utils/sulogin-consoles.h
> index 0bfbc3871..12032c997 100644
> --- a/login-utils/sulogin-consoles.h
> +++ b/login-utils/sulogin-consoles.h
> @@ -40,6 +40,7 @@ struct console {
>  	int fd, id;
>  #define	CON_SERIAL	0x0001
>  #define	CON_NOTTY	0x0002
> +#define	CON_EIO		0x0004
>  	pid_t pid;
>  	struct chardata cp;
>  	struct termios tio;
> diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
> index 9091caf14..c833796e7 100644
> --- a/login-utils/sulogin.c
> +++ b/login-utils/sulogin.c
> @@ -52,6 +52,7 @@
>  #ifdef __linux__
>  # include <sys/kd.h>
>  # include <sys/param.h>
> +# include <linux/serial.h>
>  #endif
>  
>  #include "c.h"
> @@ -104,6 +105,9 @@ static void tcinit(struct console *con)
>  	int flags = 0, mode = 0;
>  	struct termios *tio = &con->tio;
>  	const int fd = con->fd;
> +#if defined(TIOCGSERIAL)
> +	struct serial_struct serinfo;
> +#endif
>  #ifdef USE_PLYMOUTH_SUPPORT
>  	struct termios lock;
>  	int i = (plymouth_command(MAGIC_PING)) ? PLYMOUTH_TERMIOS_FLAGS_DELAY : 0;
> @@ -123,27 +127,72 @@ static void tcinit(struct console *con)
>  	}
>  	memset(&lock, 0, sizeof(struct termios));
>  	ioctl(fd, TIOCSLCKTRMIOS, &lock);
> +	errno = 0;
>  #endif
> +
> +#if defined(TIOCGSERIAL)
> +	if (ioctl(fd, TIOCGSERIAL,  &serinfo) >= 0)
> +	    	con->flags |= CON_SERIAL;
> +	errno = 0;
> +#else
> +# if defined(KDGKBMODE)
> +	if (ioctl(fd, KDGKBMODE, &mode) < 0)
> +		con->flags |= CON_SERIAL;
>  	errno = 0;
> +# endif
> +#endif
>  
>  	if (tcgetattr(fd, tio) < 0) {
> -		warn(_("tcgetattr failed"));
> -		con->flags |= CON_NOTTY;
> -		return;
> +		int saveno = errno;
> +#if defined(KDGKBMODE) || defined(TIOCGSERIAL)
> +		if (con->flags & CON_SERIAL) {			/* Try to recover this */
> +
> +# if defined(TIOCGSERIAL)
> +			serinfo.flags |= ASYNC_SKIP_TEST;	/* Skip test of UART */
> +
> +			if (ioctl(fd, TIOCSSERIAL, &serinfo) < 0)
> +				goto tcgeterr;
> +			if (ioctl(fd, TIOCSERCONFIG) < 0)	/* Try to autoconfigure */
> +				goto tcgeterr;
> +			if (ioctl(fd, TIOCGSERIAL,  &serinfo) < 0)
> +				goto tcgeterr;			/* Ouch */
> +# endif
> +			if (tcgetattr(fd, tio) < 0)		/* Retry to get tty attributes */
> +				saveno = errno;
> +		}
> +# if defined(TIOCGSERIAL)
> +	tcgeterr:
> +# endif
> +		if (saveno)
> +#endif
> +		{
> +			FILE *fcerr = fdopen(fd, "w");
> +			if (fcerr) {
> +				fprintf(fcerr, _("tcgetattr failed"));
> +				fclose(fcerr);
> +			}
> +			warn(_("tcgetattr failed"));
> +
> +			con->flags &= ~CON_SERIAL;
> +			if (saveno != EIO)
> +				con->flags |= CON_NOTTY;
> +			else
> +				con->flags |= CON_EIO;
> +
> +			errno = 0;
> +			return;
> +		}
>  	}
>  
>  	/* Handle lines other than virtual consoles here */
> -#if defined(KDGKBMODE)
> -	if (ioctl(fd, KDGKBMODE, &mode) < 0)
> +#if defined(KDGKBMODE) || defined(TIOCGSERIAL)
> +	if (con->flags & CON_SERIAL)
>  #endif
>  	{
>  		speed_t ispeed, ospeed;
>  		struct winsize ws;
>  		errno = 0;
>  
> -		/* this is a modem line */
> -		con->flags |= CON_SERIAL;
> -
>  		/* Flush input and output queues on modem lines */
>  		tcflush(fd, TCIOFLUSH);
>  
> @@ -220,6 +269,8 @@ static void tcfinal(struct console *con)
>  	struct termios *tio = &con->tio;
>  	const int fd = con->fd;
>  
> +	if (con->flags & CON_EIO)
> +		return;
>  	if ((con->flags & CON_SERIAL) == 0) {
>  		xsetenv("TERM", "linux", 1);
>  		return;
> @@ -557,12 +608,16 @@ err:
>  static void setup(struct console *con)
>  {
>  	int fd = con->fd;
> -	const pid_t pid = getpid(), pgrp = getpgid(0), ppgrp =
> -	    getpgid(getppid()), ttypgrp = tcgetpgrp(fd);
> +	const pid_t pid = getpid(), pgrp = getpgid(0), ppgrp = getpgid(getppid());
> +	pid_t ttypgrp;
>  
>  	if (con->flags & CON_NOTTY)
> +		goto notty;
> +	if (con->flags & CON_EIO)
>  		return;
>  
> +	ttypgrp = tcgetpgrp(fd);
> +
>  	/*
>  	 * Only go through this trouble if the new
>  	 * tty doesn't fall in this process group.
> @@ -585,6 +640,7 @@ static void setup(struct console *con)
>  		ioctl(fd, TIOCSCTTY, (char *)1);
>  		tcsetpgrp(fd, ppgrp);
>  	}
> +notty:
>  	dup2(fd, STDIN_FILENO);
>  	dup2(fd, STDOUT_FILENO);
>  	dup2(fd, STDERR_FILENO);
> @@ -608,20 +664,25 @@ static const char *getpasswd(struct console *con)
>  	struct termios tty;
>  	static char pass[128], *ptr;
>  	struct chardata *cp;
> -	const char *ret = pass;
> +	const char *ret = NULL;
>  	unsigned char tc;
>  	char c, ascval;
>  	int eightbit;
>  	const int fd = con->fd;
>  
> -	if (con->flags & CON_NOTTY)
> +	if (con->flags & CON_EIO)
>  		goto out;
> +
>  	cp = &con->cp;
>  	tty = con->tio;
> +	tc = 0;
> +	ret = pass;
>  
>  	tty.c_iflag &= ~(IUCLC|IXON|IXOFF|IXANY);
>  	tty.c_lflag &= ~(ECHO|ECHOE|ECHOK|ECHONL|TOSTOP|ISIG);
> -	tc = (tcsetattr(fd, TCSAFLUSH, &tty) == 0);
> +
> +	if ((con->flags & CON_NOTTY) == 0)
> +		tc = (tcsetattr(fd, TCSAFLUSH, &tty) == 0);
>  
>  	sigemptyset(&sa.sa_mask);
>  	sa.sa_handler = alrm_handler;
> @@ -647,11 +708,12 @@ static const char *getpasswd(struct console *con)
>  			}
>  			ret = NULL;
>  			switch (errno) {
> -			case 0:
>  			case EIO:
> +				con->flags |= CON_EIO;
>  			case ESRCH:
>  			case EINVAL:
>  			case ENOENT:
> +			case 0:
>  				break;
>  			default:
>  				warn(_("cannot read %s"), con->tty);
> @@ -775,7 +837,7 @@ static void sushell(struct passwd *pwd)
>  
>  #ifdef HAVE_LIBSELINUX
>  	if (is_selinux_enabled() > 0) {
> -		security_context_t scon=NULL;
> +		char *scon=NULL;
>  		char *seuser=NULL;
>  		char *level=NULL;
>  		if (getseuserbyname("root", &seuser, &level) == 0) {
> @@ -968,10 +1030,13 @@ int main(int argc, char **argv)
>  		con = list_entry(ptr, struct console, entry);
>  		if (con->id >= CONMAX)
>  			break;
> +		if (con->flags & CON_EIO)
> +			goto next;
>  
>  		switch ((con->pid = fork())) {
>  		case 0:
>  			mask_signal(SIGCHLD, SIG_DFL, NULL);
> +			dup2(con->fd, STDERR_FILENO);
>  		nofork:
>  			setup(con);
>  			while (1) {
> @@ -1026,7 +1091,7 @@ int main(int argc, char **argv)
>  		default:
>  			break;
>  		}
> -
> +	next:
>  		ptr = ptr->next;
>  
>  	} while (ptr != &consoles);
> 

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
