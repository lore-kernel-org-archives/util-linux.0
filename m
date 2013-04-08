Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40868 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964984Ab3DHOjQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Apr 2013 10:39:16 -0400
Date: Mon, 8 Apr 2013 16:39:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] logger: allow to log using tcp transport protocol
Message-ID: <20130408143905.GO14350@x2.net.home>
References: <1365193044-14783-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365193044-14783-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 05, 2013 at 09:17:24PM +0100, Sami Kerola wrote:
>  misc-utils/logger.1 |  37 ++++++++++-----
>  misc-utils/logger.c | 130 +++++++++++++++++++++++++++++++++-------------------
>  2 files changed, 108 insertions(+), 59 deletions(-)

 Applied, thanks.

> -myopenlog(const char *sock, int optd)
> +myopenlog(const char *sock, const int socket_type)

 I have renamed the function to unix_socket() to keep the code more
 consistent.

>  {
> -	int fd;
> +	int fd, i, st = -1;
>  	static struct sockaddr_un s_addr;	/* AF_UNIX address of local logger */
>  
>  	if (strlen(sock) >= sizeof(s_addr.sun_path))
> @@ -107,46 +113,72 @@ myopenlog(const char *sock, int optd)
>  	s_addr.sun_family = AF_UNIX;
>  	(void)strcpy(s_addr.sun_path, sock);
>  
> -	if (optd == 0) {
> -		if ((fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1)
> -			goto udp_socket;
> +	for (i = 2; i; i--) {

 you need to reset 'st' here

        int st = -1;

> +		if (i == 2 && socket_type & TYPE_UDP)
> +			st = SOCK_DGRAM;
> +		if (i == 1 && socket_type & TYPE_TCP)
> +			st = SOCK_STREAM;
> +		if (st == -1 || (fd = socket(AF_UNIX, st, 0)) == -1)
> +			continue;
>  		if (connect(fd, (struct sockaddr *)&s_addr, sizeof(s_addr)) == -1) {
>  			close(fd);
> -			goto udp_socket;
> +			continue;
>  		}

  Karel 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
