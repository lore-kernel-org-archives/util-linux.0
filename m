Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26562 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758355Ab2IKRTk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Sep 2012 13:19:40 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8BHJeoe026779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 11 Sep 2012 13:19:40 -0400
Message-ID: <504F72A9.1090704@draigBrady.com>
Date: Tue, 11 Sep 2012 18:19:37 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Ondrej Oprala <ooprala@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: segfault message supressed with su -c
References: <504F5246.4030304@redhat.com>
In-Reply-To: <504F5246.4030304@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/11/2012 04:01 PM, Ondrej Oprala wrote:
> Hi,
> I've written a tiny patch that should fix this issue with su:
> https://bugzilla.redhat.com/show_bug.cgi?id=747592.
> None of the shells' output propagates back
> to the shell where su was called (except TCSH, which reports segfault
> to stdout; I've tested this with sh,ksh,zsh,bash).
> So, with this patch, su should print a warning if
> WIFSIGNALED(status) && WCOREDUMP(status) is true.
>
> Cheers,
>   Ondrej
>
> DIFF
>
>
>> From d4776f487e283649d65be3f3865141a0171a80e7 Mon Sep 17 00:00:00 2001
> From: Ondrej Oprala<ooprala@redhat.com>
> Date: Tue, 11 Sep 2012 16:39:17 +0200
> Subject: [PATCH] su: add segmentation fault reporting of the child process
>
> Child processes that ended with segmentation fault previously
> indicated this with return status only. The report is now more
> verbose if core dump is allowed.
> ---
>   login-utils/su-common.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/login-utils/su-common.c b/login-utils/su-common.c
> index 23ad57d..b0dbed2 100644
> --- a/login-utils/su-common.c
> +++ b/login-utils/su-common.c
> @@ -300,7 +300,11 @@ create_watching_parent (void)
>   	}
>         if (pid != (pid_t)-1)
>   	if (WIFSIGNALED (status))
> -	  status = WTERMSIG (status) + 128;
> +	  {
> +	    status = WTERMSIG (status) + 128;
> +	    if (WCOREDUMP (status))
> +	      fprintf (stderr, _("Segmentation fault (core dumped)\n"));
> +	  }
>   	else
>   	  status = WEXITSTATUS (status);
>         else
> -- 1.7.11.4

You'll need to key on WTERMSIG (status).
"Segmentation fault" will not always be appropriate.
You'll get a core just with Ctrl-\ (SIGQUIT) too for example.
Something along the lines of:

"%s (core dumped)", strsignal (WTERMSIG (status))

cheers,
Pádraig.
