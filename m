Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18735 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219Ab3KSNYR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Nov 2013 08:24:17 -0500
Date: Tue, 19 Nov 2013 14:24:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] setsid: don't fork
Message-ID: <20131119132412.GG5572@x2.net.home>
References: <1384456993-3721-1-git-send-email-psusi@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384456993-3721-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 14, 2013 at 02:23:13PM -0500, Phillip Susi wrote:
> 2.24 added a switch to setsid to wait for the child to exit
> and return its exit status.  I believe this was the wrong way
> to fix the underlying bug since the behavior of the program
> still differs depending on whether it is run as the group leader
> or not, and requires a switch to get the correct behavior.

Yep, it was our goal to not change the default behaviour that exists
for years.

> Instead of this --wait switch, just make sure the parent
> process is the one that execs the new program rather than
> the child process.

>  		case 0:
>  			/* child */
> +			sleep(5);

 pause() ?

>  			break;
>  		default:
>  			/* parent */
> -			if (!status)
> -				return EXIT_SUCCESS;
> -			if (wait(&status) != pid)
> -				err(EXIT_FAILURE, "wait");
> -			if (WIFEXITED(status))
> -				return WEXITSTATUS(status);
> -			err(status, _("child %d did not exit normally"), pid);
> +			if (setpgid(pid, 0) == -1)
> +				err(EXIT_FAILURE, _("setpgid failed"));
> +			if (setpgid(0, pid) == -1)
> +				err(EXIT_FAILURE, _("setpgid failed"));
> +
>  		}
>  	}
>  	if (setsid() < 0)
>  		/* cannot happen */
>  		err(EXIT_FAILURE, _("setsid failed"));
> -
> +	if (pid)
> +		kill(pid, SIGTERM);

It does not seem too elegant :-) If you really want to change the
default behaviour than it would be better to make --wait default
and exec() in child, then you don't need setpgid(), kill() and
sleep/pause() at all.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
