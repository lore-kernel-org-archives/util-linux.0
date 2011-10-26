Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab1JZVZm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Oct 2011 17:25:42 -0400
Date: Wed, 26 Oct 2011 23:25:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] prlimit: add a units column
Message-ID: <20111026212538.GA24870@nb.redhat.com>
References: <1319452258.2170.7.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319452258.2170.7.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 24, 2011 at 12:30:58PM +0200, Davidlohr Bueso wrote:
> +	[AS]         = { "AS",         N_("address space limit"),                "bytes",     RLIMIT_AS },
> +	[CORE]       = { "CORE",       N_("max core file size"),                 "blocks",    RLIMIT_CORE },
> +	[CPU]        = { "CPU",        N_("CPU time"),                           "seconds",   RLIMIT_CPU },
> +	[DATA]       = { "DATA",       N_("max data size"),                      "bytes",     RLIMIT_DATA },
> +	[FSIZE]      = { "FSIZE",      N_("max file size"),                      "blocks",    RLIMIT_FSIZE },
> +	[LOCKS]      = { "LOCKS",      N_("max amount of file locks held"),      NULL,        RLIMIT_LOCKS },
> +	[MEMLOCK]    = { "MEMLOCK",    N_("max locked-in-memory address space"), "kbytes",    RLIMIT_MEMLOCK },
> +	[MSGQUEUE]   = { "MSGQUEUE",   N_("max bytes in POSIX mqueues"),         "bytes",     RLIMIT_MSGQUEUE },
> +	[NICE]       = { "NICE",       N_("max nice prio allowed to raise"),     NULL,        RLIMIT_NICE },
> +	[NOFILE]     = { "NOFILE",     N_("max amount of open files"),           NULL,        RLIMIT_NOFILE },
> +	[NPROC]      = { "NPROC",      N_("max number of processes"),            NULL,        RLIMIT_NPROC },
> +	[RSS]        = { "RSS",        N_("max resident set size"),              "pages",     RLIMIT_RSS },
> +	[RTPRIO]     = { "RTPRIO",     N_("max real-time priority"),             NULL,        RLIMIT_RTPRIO },
> +	[RTTIME]     = { "RTTIME",     N_("timeout for real-time tasks"),        "microsecs", RLIMIT_RTTIME },
> +	[SIGPENDING] = { "SIGPENDING", N_("max amount of pending signals"),      NULL,        RLIMIT_SIGPENDING },
> +	[STACK]      = { "STACK",      N_("max stack size"),                     "kbytes",    RLIMIT_STACK }

 Why without N_() ?

> +		case COL_UNITS:
> +			rc =  l->desc->unit ? asprintf(&str, "%s", l->desc->unit) :
> +			                      asprintf(&str, "------");
> +			break;

  str = l->desc->unit ? xstrdup(_(l->desc->unit)) : NULL;
 
 NULL should not be a problem for tt_* functions.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
