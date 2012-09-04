Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44097 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab2IDPpH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 4 Sep 2012 11:45:07 -0400
Date: Tue, 4 Sep 2012 17:45:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Iain Paton <selsinork@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: problem with script -e
Message-ID: <20120904154504.GE21432@x2.net.home>
References: <4FEF26A0.3010901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FEF26A0.3010901@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 30, 2012 at 05:17:36PM +0100, Iain Paton wrote:
> Came across an unexpected feature with script today. Can't make my mind up if 
> it's a bug or not, but it certainly makes some things difficult.

 Sorry for delay...

> Seems that there's an implicit assumption that stdin will always be a tty for 
> the script process - strace shows all sorts of -ENOTTY stuff when it's not.

 Yes, "script - make typescript of terminal sessions". It initializes
 a new pseudoterminal and makes connection between the current session
 and the new terminal.

> I came up with the following that works for my use case, but maybe there's a 
> better way ?
> 
> --- script.c.org	2011-08-29 09:31:19.000000000 +0100
> +++ script.c	2012-06-30 16:24:42.896997422 +0100
> @@ -295,18 +295,29 @@
>  
>  	fclose(fscript);
>  
> -	while (die == 0) {
> -		if ((cc = read(STDIN_FILENO, ibuf, BUFSIZ)) > 0) {
> -			ssize_t wrt = write(master, ibuf, cc);
> -			if (wrt < 0) {
> -				warn (_("write failed"));
> -				fail();
> +	if(isatty(STDIN_FILENO)) {
> +
> +		while (die == 0) {
> +			if ((cc = read(STDIN_FILENO, ibuf, BUFSIZ)) > 0) {
> +				ssize_t wrt = write(master, ibuf, cc);
> +				if (wrt < 0) {
> +					warn (_("write failed"));
> +					fail();
> +				}
>  			}
> +			else if (cc < 0 && errno == EINTR && resized)
> +				resized = 0;
> +			else
> +				break;
> +		}
> +	} else {
> +	
> +		while(die == 0) {
> +			
> +			fd_set fs;
> +			FD_ZERO(&fs);
> +			select(1, &fs, &fs, &fs, NULL);


 Hmm... what the others things like tcsetattr(), etc. Anyway, I'll try
 to play with the patch. It seems like interesting idea.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
