Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10653 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932508Ab3BMNPn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Feb 2013 08:15:43 -0500
Date: Wed, 13 Feb 2013 14:15:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Cody Maloney <cmaloney@theoreticalchaos.com>
Cc: util-linux@vger.kernel.org, mitr@redhat.com
Subject: Re: [PATCH v3 4/4] chfn: Add libuser support
Message-ID: <20130213131539.GE7799@x2.net.home>
References: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
 <1360218141-4463-5-git-send-email-cmaloney@theoreticalchaos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1360218141-4463-5-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 06, 2013 at 11:22:21PM -0700, Cody Maloney wrote:
> @@ -149,17 +156,24 @@ int main(int argc, char **argv)
>  	}
>  #endif
>  
> -	/* Reality check */
> -	if (uid != 0 && uid != oldf.pw->pw_uid) {
                           ^^^^^^^^^^^^^^^
> +#ifdef HAVE_LIBUSER
> +	/* If we're setuid and not really root, disallow the password change. */
> +	if (geteuid() != getuid() && uid != pw->pw_uid) {
> +#else
> +	if (uid != 0 && uid != pw->pw_uid) {
> +#endif

 Copy & past from chsh, right? 
 
login-utils/chfn.c: In function ‘main’:
login-utils/chfn.c:161:38: error: ‘pw’ undeclared (first use in this function)
login-utils/chfn.c:161:38: note: each undeclared identifier is
reported only once for each function it appears in

>  		errno = EACCES;
> -		err(EXIT_FAILURE, NULL);
> +		err(EXIT_FAILURE, _("running UID doesn't match UID of user we're "
> +		      "altering, change denied")););
                                       ^^^
>  	}

login-utils/chfn.c:167:37: error: expected statement before ‘)’ token


Man, that's suid binary... 

Fixed and applied.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
