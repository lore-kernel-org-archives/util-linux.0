Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19280 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756753Ab3BMNwQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Feb 2013 08:52:16 -0500
Date: Wed, 13 Feb 2013 14:52:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] unshare,nsenter: spawn shell by default
Message-ID: <20130213135212.GF7799@x2.net.home>
References: <1360282142-1943-1-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1360282142-1943-1-git-send-email-zbyszek@in.waw.pl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 07, 2013 at 07:09:01PM -0500, Zbigniew Jędrzejewski-Szmek wrote:
> +#define DEFAULT_SHELL "/bin/sh"
> +
> +void __attribute__((__noreturn__)) exec_shell(void) {
> +	const char *shell = getenv("SHELL");
> +	if (!shell)
> +		shell = DEFAULT_SHELL;
> +	execl(shell, basename(shell), "-i", NULL);
> +	err(EXIT_FAILURE, _("exec %s failed"), shell);
> +}

 Do we really need "-i", for example su(1) uses

     arg0[0] = '-';
     strcpy (arg0 + 1, shell_basename);

     execv (shell, (char **) args);

 see login-utils/su-common.c

 man bash:

   A login shell is one whose first character of argument zero is a -,
   or one started with the --login option.

 Not sure, but I guess that "-basename" as argv[0] is more portable
 solution (it's originally from coreutils, it has to be portable :-).

> +	if (optind < argc)
> +		execvp(argv[optind], argv + optind);
> +	else
> +		exec_shell();
>  
>  	err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);

 It would be more readable:

   if (optind < argc) {
        execvp(argv[optind], argv + optind);
        err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
   }
   exec_shell();

   
   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
