Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2633 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932901AbaGXKLQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Jul 2014 06:11:16 -0400
Date: Thu, 24 Jul 2014 12:11:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/10] logger: add process --id=parent optional argument
Message-ID: <20140724101105.GL26781@x2.net.home>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
 <1406066459-4816-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406066459-4816-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 22, 2014 at 11:00:58PM +0100, Sami Kerola wrote:

> +	unsigned int	parent:1,

  ppid : 1

> +			rfc5424_time:1,
>  			rfc5424_tq:1,
>  			rfc5424_host:1;
>  };
> @@ -281,15 +282,29 @@ static char *xgetlogin()
>  	return cp;
>  }
>  
> +static pid_t get_process_id(struct logger_ctl *ctl)
> +{
> +	pid_t id = 0;
> +
> +	if (ctl->logflags & LOG_PID) {
> +		if (ctl->parent)
> +			id = getppid();
> +		else
> +			id = getpid();

  id = ctl->ppid ? getppid() : getpid();

 :-)

> -	fputs(_(" -i, --id              log the process ID too\n"), out);
> +	fputs(_(" -i, --id[=parent]     log the [parent] process ID too\n"), out);

 what about:

              -i, --id[=pid|ppid]   log PID or PPID (default is PID)


 I think it's more robust and readable when you can specify also
 default setting in scripts.

 And please, don't use "parent" in code and in the man page. It's
 confusing. It's PID and PPID. 


 (I personally don't like "process ID" too, "PID" is the term.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
