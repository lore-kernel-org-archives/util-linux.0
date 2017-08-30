Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbdH3HcK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Aug 2017 03:32:10 -0400
Date: Wed, 30 Aug 2017 09:32:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] chsh: remove local /etc/shells parsing in favour of
 getusershell(3)
Message-ID: <20170830073205.h4czf7hv5nrnwtcd@ws.net.home>
References: <20170828203813.12698-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170828203813.12698-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 28, 2017 at 09:38:13PM +0100, Sami Kerola wrote:
> Less code, less bugs.  And if there are bugs at least share them with all
> other programs that use getusershell(3) from libc.

Is it portable? ulibC etc.. ?

> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  login-utils/chsh.c | 98 ++++++++++--------------------------------------------
>  1 file changed, 18 insertions(+), 80 deletions(-)
> 
> diff --git a/login-utils/chsh.c b/login-utils/chsh.c
> index 4721c870e..c267c7272 100644
> --- a/login-utils/chsh.c
> +++ b/login-utils/chsh.c
> @@ -67,9 +67,6 @@ struct sinfo {
>  	char *shell;
>  };
>  
> -/* global due readline completion */
> -static char **global_shells;
> -
>  static void __attribute__((__noreturn__)) usage(void)
>  {
>  	FILE *fp = stdout;
> @@ -89,79 +86,26 @@ static void __attribute__((__noreturn__)) usage(void)
>  	exit(EXIT_SUCCESS);
>  }
>  
> -/*
> - *  free_shells () -- free shells allocations.
> - */
> -static void free_shells(void)
> -{
> -	if (global_shells) {
> -		char **s;
> -
> -		for (s = global_shells; *s; s++)
> -			free(*s);
> -		free(global_shells);
> -	}
> -}
> -
> -/*
> - *  init_shells () -- reads /etc/shells into global_shells
> - */
> -static int init_shells(void)
> -{
> -	FILE *fp;
> -	char *buf = NULL;
> -	size_t sz = 0, shellsz = 8, n = 0;
> -	ssize_t len;
> -
> -	if (global_shells)
> -		return 0;	/* already initialized */
> -
> -	fp = fopen(_PATH_SHELLS, "r");
> -	if (!fp)
> -		return 1;
> -
> -	global_shells = xmalloc(sizeof(char *) * shellsz);
> -
> -	while ((len = getline(&buf, &sz, fp)) != -1) {
> -		/* ignore comments and blank lines */
> -		if (*buf == '#' || len < 2)
> -			continue;
> -		/* strip the ending newline */
> -		if (buf[len - 1] == '\n')
> -			buf[len - 1] = 0;
> -		global_shells[n++] = buf;
> -		if (shellsz < n) {
> -			shellsz *= 2;
> -			global_shells = xrealloc(global_shells, sizeof(char *) * shellsz);
> -		}
> -		buf = NULL;
> -	}
> -
> -	free(buf);
> -	global_shells[n] = NULL;
> -
> -	fclose(fp);
> -	atexit(free_shells);
> -
> -	return 0;
> -}
> -
>  /*
>   *  is_known_shell() -- if the given shell appears in /etc/shells,
>   *	return true.  if not, return false.
>   */
>  static int is_known_shell(const char *shell_name)
>  {
> -	char **s;
> +	char *s, ret = 0;
>  
> -	if (!global_shells || !shell_name)
> +	if (!shell_name)
>  		return 0;
>  
> -	for (s = global_shells; *s; s++) {
> -		if (strcmp(shell_name, *s) == 0)
> -			return 1;
> +	setusershell();
> +	while ((s = getusershell())) {
> +		if (strcmp(shell_name, s) == 0) {
> +			ret = 1;
> +			break;
> +		}
>  	}
> -	return 0;
> +	endusershell();
> +	return ret;
>  }
>  
>  /*
> @@ -169,29 +113,25 @@ static int is_known_shell(const char *shell_name)
>   */
>  static void print_shells(void)
>  {
> -	char **s;
> -
> -	if (!global_shells)
> -		return;
> +	char *s;
>  
> -	for (s = global_shells; *s; s++)
> -		printf("%s\n", *s);
> +	while ((s = getusershell()))
> +		printf("%s\n", s);
> +	endusershell();
>  }
>  
>  #ifdef HAVE_LIBREADLINE
>  static char *shell_name_generator(const char *text, int state)
>  {
> -	static size_t len, idx;
> +	static size_t len;
>  	char *s;
>  
> -	if (!global_shells)
> -		return NULL;
> -
>  	if (!state) {
> -		idx = 0;
> +		setusershell();
>  		len = strlen(text);
>  	}
> -	while ((s = global_shells[idx++])) {
> +
> +	while ((s = getusershell())) {
>  		if (strncmp(s, text, len) == 0)
>  			return xstrdup(s);
>  	}
> @@ -232,7 +172,6 @@ static void parse_argv(int argc, char **argv, struct sinfo *pinfo)
>  		case 'h':
>  			usage();
>  		case 'l':
> -			init_shells();
>  			print_shells();
>  			exit(EXIT_SUCCESS);
>  		case 's':
> @@ -386,7 +325,6 @@ int main(int argc, char **argv)
>  		    _("running UID doesn't match UID of user we're "
>  		      "altering, shell change denied"));
>  	}
> -	init_shells();
>  	if (uid != 0 && !is_known_shell(oldshell)) {
>  		errno = EACCES;
>  		err(EXIT_FAILURE, _("your shell is not in %s, "
> -- 
> 2.14.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
