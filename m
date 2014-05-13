Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9069 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbaEMI5G (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 May 2014 04:57:06 -0400
Date: Tue, 13 May 2014 10:56:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org, Ruediger Meier <sweet_f_a@gmx.de>
Subject: Re: [PATCH 1/4] Avoid that agetty nor sulogin are fooled by a
 running plymouth
Message-ID: <20140513085658.GM8951@x2.net.home>
References: <1399543765-31106-1-git-send-email-werner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399543765-31106-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 08, 2014 at 12:09:22PM +0200, Werner Fink wrote:
> The nowadays used plymouth locks the devices used for the system
> console which causes that agetty as well as sulogin can not modify
> the termios settings of e.g. the serial devices of the systenm console.

 All applied, thanks!

> +	int fd = con->fd, i = (plymouth_command("--ping")) ? 20 : 0;
> +
> +	while (i-- > 0) {
> +		/*
> +		 * With plymouth the termios flags become changed after this
> +		 * function had changed the termios.
> +		 */
> +		memset(&lock, 0, sizeof(struct termios));
> +		if (ioctl(fd, TIOCGLCKTRMIOS, &lock) < 0)
> +			break;
> +		if (!lock.c_iflag && !lock.c_oflag && !lock.c_cflag && !lock.c_lflag)
> +			break;
> +		if (i == 15 && plymouth_command("quit") != 0)
> +			break;
> +		sleep(1);
> +	}
> +	memset(&lock, 0, sizeof(struct termios));
> +	ioctl(fd, TIOCSLCKTRMIOS, &lock);

 I hope 20s sleep is the worst case and in normal situations we don't
 have to call plymouth "quit" from sulogin/agetty.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
