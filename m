Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41342 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756728AbcEEJms (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 May 2016 05:42:48 -0400
Date: Thu, 5 May 2016 11:42:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Use the plymouth local protocol instead the plymouth
 binary
Message-ID: <20160505094245.6frwtvaxoueyrfw7@ws.net.home>
References: <1461324096-29280-1-git-send-email-werner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461324096-29280-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 22, 2016 at 01:21:36PM +0200, Werner Fink wrote:
> +static int open_un_socket_and_connect(void)
> +{
> +	struct sockaddr_un su = {		/* The abstract UNIX socket of plymouth */
> +		.sun_family = AF_UNIX,
> +		.sun_path = PLYMOUTH_SOCKET_PATH,
> +	};
> +	const int one = 1;
> +	int fd, ret;
> +
> +	fd = socket(PF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0);
> +	if (fd < 0) {
> +		warnx(_("can not open UNIX socket"));
> +		goto err;
> +	}
> +
> +	ret = setsockopt(fd, SOL_SOCKET, SO_PASSCRED, &one, (socklen_t)sizeof(one));
> +	if (ret < 0) {
> +		warnx(_("can not set option for UNIX socket"));
> +		close(fd);
> +		fd = -1;
> +		goto err;
> +	}
> +
> +	ret = connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1 + strlen(su.sun_path+1));
                                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^
> +	if (ret < 0) {

This is strange code, connect() returns -1 on error, I have doubts you
will ever see ret < 0 and why connect() return value is not enough,
why we need 1 + strlen(su.sun_path+1))?

> +		if (errno != ECONNREFUSED)
> +			warnx(_("can not connect on UNIX socket"));
> +		close(fd);
> +		fd = -1;
> +		goto err;
> +	}
> +err:
> +	return fd;
> +}
> +
> +int plymouth_command(int cmd, ...)
> +{
> +	char answer[2], command[2];
> +	struct sigaction sp, op;
> +	int fdsock = -1, ret = 0;
> +
> +	sigemptyset (&sp.sa_mask);
> +	sp.sa_handler = SIG_IGN;
> +	sp.sa_flags = SA_RESTART;
> +	sigaction(SIGPIPE, &sp, &op);
> +
> +	command[1] = '\0';
> +	switch (cmd) {
> +	case MAGIC_PING:
> +		fdsock = open_un_socket_and_connect();
> +		if (fdsock >= 0) {
> +			command[0] = cmd;

maybe define cmd as char or uint8_t

> +			write_all(fdsock, command, strlen(command)+1);

why we need strlen(command)+1 everywhere if the commend is just one
char+\0, sizeof(command) would be enough.

> +		}
> +		break;
> +	case MAGIC_QUIT:
> +		fdsock = open_un_socket_and_connect();
> +		if (fdsock >= 0) {
> +			command[0] = cmd;
> +			write_all(fdsock, command, strlen(command)+1);
> +		}
> +		break;
> +	default:
> +		warnx(_("the plymouth request %c is not implemented"), cmd);
> +	case '?':
> +		goto err;
> +	}
> +
> +	answer[0] = '\0';
> +	if (fdsock >= 0) {
> +		if (can_read(fdsock, 1000))
> +			read_all(fdsock, &answer[0], sizeof(answer));
> +		close(fdsock);
> +	}
> +	sigaction(SIGPIPE, &op, NULL);
> +	ret = (answer[0] == ANSWER_ACK) ? 1 : 0;
> +err:
> +	return ret;
> +}

...

>  /*
>   * Fix the tty modes and set reasonable defaults.
>   */
> @@ -138,8 +103,9 @@ static void tcinit(struct console *con)
>  	struct termios lock;
>  	int fd = con->fd;
>  #ifdef TIOCGLCKTRMIOS
> -	int i = (plymouth_command("--ping")) ? 20 : 0;
> -
> +	int i = (plymouth_command(MAGIC_PING)) ? 20 : 0;
> +	if (i)
> +		plymouth_command(MAGIC_QUIT);

would be possible to #define PLYMOUTH_TERMIOS_FLAGS_DELAY,
now we have 20s in sulogins and 30s in agetty. Why?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
