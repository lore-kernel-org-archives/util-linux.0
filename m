Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36800 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbbHaJho (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 31 Aug 2015 05:37:44 -0400
Date: Mon, 31 Aug 2015 11:37:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Chen Qi <Qi.Chen@windriver.com>
Cc: util-linux@vger.kernel.org
Subject: Re: replace siginterrupt with sigaction
Message-ID: <20150831093743.GE2726@ws.net.home>
References: <1441009426-13799-1-git-send-email-Qi.Chen@windriver.com>
 <1441009426-13799-3-git-send-email-Qi.Chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441009426-13799-3-git-send-email-Qi.Chen@windriver.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 31, 2015 at 04:23:46PM +0800, Chen Qi wrote:
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  login-utils/login.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/login-utils/login.c b/login-utils/login.c
> index ebb76f5..38c881b 100644
> --- a/login-utils/login.c
> +++ b/login-utils/login.c
> @@ -1110,6 +1110,7 @@ int main(int argc, char **argv)
>  	char *buff;
>  	int childArgc = 0;
>  	int retcode;
> +	struct sigaction act;
>  
>  	char *pwdbuf = NULL;
>  	struct passwd *pwd = NULL, _pwd;
> @@ -1123,7 +1124,9 @@ int main(int argc, char **argv)
>  	timeout = (unsigned int)getlogindefs_num("LOGIN_TIMEOUT", LOGIN_TIMEOUT);
>  
>  	signal(SIGALRM, timedout);
> -	siginterrupt(SIGALRM, 1);	/* we have to interrupt syscalls like ioctl() */
> +	(void) sigaction(SIGALRM, NULL, &act);
> +	act.sa_flags &= ~SA_RESTART;
> +	sigaction(SIGALRM, &act, NULL);


 Applied, thanks.
 
 (Please, next time be more verbose in commit message why you want to
 do the change -- I have added a note that siginterrupt is obsolete). 

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
