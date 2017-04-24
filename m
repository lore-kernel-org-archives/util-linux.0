Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168752AbdDXLGo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Apr 2017 07:06:44 -0400
Date: Mon, 24 Apr 2017 13:06:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/10] sulogin: reduce vulnerability surface
Message-ID: <20170424110634.2djny227jsufz42i@ws.net.home>
References: <20170423205821.7444-1-kerolasa@iki.fi>
 <20170423205821.7444-8-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170423205821.7444-8-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 23, 2017 at 09:58:18PM +0100, Sami Kerola wrote:
> --- a/login-utils/sulogin.c
> +++ b/login-utils/sulogin.c
...
>  static void tcinit(struct console *con)
>  {
> -	int mode = 0, flags = 0;
> +	int flags = 0;
>  	struct termios *tio = &con->tio;
> -	int fd = con->fd;
> +	const int mode = 0, fd = con->fd;

Is it correct to use const for "mode" if we use it 

    ioctl(fd, KDGKBMODE, &mode)

... I think gcc does not complain because ioclt() is promiscuous
bastard :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
