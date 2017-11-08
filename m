Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751826AbdKHLbV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 8 Nov 2017 06:31:21 -0500
Date: Wed, 8 Nov 2017 12:31:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] rfkill: allow user to exit gracefully from event
 watching loop
Message-ID: <20171108113117.gjlnpoekjhibdmkz@ws.net.home>
References: <20171107160856.7648-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171107160856.7648-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 07, 2017 at 04:08:56PM +0000, Sami Kerola wrote:
> When SIGINT is raised by something else than an user running rfkill the
> watch loop will be killed by that signal with appropriate exit code.

It seems like over-engineering that introduces unnecessary code and
complex semantic. Why do you care about return code when you press
CTRL+C and why it should be different to another situations with
signals? I think we do not have such code in another utils.

> +static void event_signal(int signo, siginfo_t *info,
> +			 void *context __attribute__((__unused__)))
> +{
> +	if (!info->si_pid)
> +		user_ctrl_c = 1;
> +	else {
> +		if (info->si_code == SI_USER)
> +			warnx(_("uid: %d pid: %d sent signal %d, exiting"),
> +			      info->si_uid, info->si_pid, info->si_signo);

We should not use warn/err/printf in signals handlers.

> +		signal(signo, SIG_DFL);
> +		kill(getpid(), signo);
> +	}
> +}

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
