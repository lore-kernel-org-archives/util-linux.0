Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07E24DD17
	for <util-linux@vger.kernel.org>; Mon, 11 May 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497859; cv=none; b=XF8IkkoRPERRgCQwjJiKhxhexV4BujHxtPuy6Soql0p1yXT8zAdEQBUYh5549Kc22Ih6lmqp1+YW6j3FjWVBTUSGLcyeODYJjUIZL2fXw8RjnI7dJRhRmNy1jZ2ikpMbyvfzBPvglk6fiI9LM/byxrKNoGs2i9RMZpk7Vd0JHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497859; c=relaxed/simple;
	bh=TuGVGz8BkdQKN0shXRmZcYCvMrrB3tfFTdq8IAnEbd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKhuBKWbDT67g/GK+tys3P7SkfNc2ftYAOOzy+BRUrA9WS3MQS6aoRK+Hb/2JtuDJLCkDRNCDkKnscqpeJL/Yrcr4UQAwWBb3FqozMjjsJ5ir184dYEq06aB/oMeVLbnJ30NogssJm6q1wjVUyqYuTR+nTEcmsmYVVuyVrhgPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxxFDSbZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxxFDSbZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778497857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4jMi3cAAIZaAofmE2LydGTnm7WoVV5u9Npv/dpzu4Oo=;
	b=CxxFDSbZXycij+HdFQ+3XWgcEJR6g7luL6NBDG/bV9ypy/1rGoTfOSCIYW/mPgp3Nf9s9n
	INgoaaAGLixJKBxGcYqRYLPQoLJGjIUBhHtEBUbZ5NjXkfCbiWhmEKoKz5mBUlDDxRzkFd
	ILfU6bi0+ujPEqKDiwNmcIlElMOpcP0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-4jKI86HNOkyY8DlDwfmb5Q-1; Mon,
 11 May 2026 07:10:54 -0400
X-MC-Unique: 4jKI86HNOkyY8DlDwfmb5Q-1
X-Mimecast-MFC-AGG-ID: 4jKI86HNOkyY8DlDwfmb5Q_1778497853
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCC451956062;
	Mon, 11 May 2026 11:10:52 +0000 (UTC)
Received: from ws (unknown [10.44.33.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C9201800349;
	Mon, 11 May 2026 11:10:50 +0000 (UTC)
Date: Mon, 11 May 2026 13:10:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Furkan Caliskan <frn1furkan10@gmail.com>
Cc: util-linux@vger.kernel.org, bensberg@telfort.nl, 
	vineethr@linux.ibm.com
Subject: Re: [PATCH] chrt: Add support for (GRUB) bandwidth reclaim
Message-ID: <qa5c2sqdvxiclkfszc7wdfdd3naa7e2w42mip3abj4auisqw6r@o2jtcbaibyep>
References: <20260423101407.35502-1-frn1furkan10@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423101407.35502-1-frn1furkan10@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


Hi Furkan,

Sorry for the delay in reviewing.

On Thu, Apr 23, 2026 at 01:14:07PM +0300, Furkan Caliskan wrote:
> --- a/schedutils/chrt.1.adoc
> +++ b/schedutils/chrt.1.adoc
> @@ -83,6 +83,9 @@ Specifies deadline parameter for *SCHED_DEADLINE* policy (Linux-specific).
>  
>  *-R*, *--reset-on-fork*::
>  Use *SCHED_RESET_ON_FORK* or *SCHED_FLAG_RESET_ON_FORK* flag. Linux-specific, supported since 2.6.31.
> +
> +*-G*, *--reclaim-grub*::
> +Enables GRUB (Greedy Reclamation of Unused Bandwidth) algorithm. 
>  +
>  Each thread has a _reset-on-fork_ scheduling flag. When this flag is set, children created by *fork*(2) do not inherit privileged scheduling policies. After the _reset-on-fork_ flag has been enabled, it can be reset only if the thread has the *CAP_SYS_NICE* capability. This flag is disabled in child processes created by *fork*(2).
>  +

You have added *--reclaim-grub* to the reset-on-fork description block.

Please, also add "Linux-specific, supported since 4.13".

> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
> index 273905e5d..1a081e566 100644
> --- a/schedutils/chrt.c
> +++ b/schedutils/chrt.c
> @@ -46,6 +46,7 @@ struct chrt_ctl {
>  	uint64_t runtime;			/* --sched-* options */
>  	uint64_t deadline;
>  	uint64_t period;
> +        uint64_t flag;                         /* For sched_attr->sched_flags member */ 

 What about to use sched_flags rather than generic 

>  
>  	unsigned int all_tasks : 1,		/* all threads of the PID */
>  		     reset_on_fork : 1,		/* SCHED_RESET_ON_FORK or SCHED_FLAG_RESET_ON_FORK */
> @@ -79,6 +80,7 @@ static void __attribute__((__noreturn__)) usage(void)
>  	fputs(USAGE_SEPARATOR, out);
>  	fputs(_("Scheduling options:\n"), out);
>  	fputs(_(" -R, --reset-on-fork       set reset-on-fork flag\n"), out);
> +	fputs(_(" -G, --reclaim-grub        set SCHED_FLAG_RECLAIM\n"), out);
>  	fputs(_(" -T, --sched-runtime <ns>  runtime parameter for DEADLINE\n"), out);
>  	fputs(_(" -P, --sched-period <ns>   period parameter for DEADLINE\n"), out);
>  	fputs(_(" -D, --sched-deadline <ns> deadline parameter for DEADLINE\n"), out);
> @@ -349,7 +351,7 @@ static int set_sched_one(struct chrt_ctl *ctl, pid_t pid)
>  	/* old API is good enough for non-deadline */
>  	if (!supports_runtime_param(ctl->policy))
>  		return set_sched_one_by_setscheduler(ctl, pid);
> -
> +	
>  	/* not changed by chrt, follow the current setting */
>  	sa.sched_nice = getpriority(PRIO_PROCESS, pid);
>  
> @@ -359,6 +361,7 @@ static int set_sched_one(struct chrt_ctl *ctl, pid_t pid)
>  	sa.sched_runtime  = ctl->runtime;
>  	sa.sched_period   = ctl->period;
>  	sa.sched_deadline = ctl->deadline;
> +        sa.sched_flags    = ctl->flag;

Please be careful and consistently use tabs. Use an editor that
follows .editorconfig.

>  
>  # ifdef SCHED_FLAG_RESET_ON_FORK
>  	/* Don't use SCHED_RESET_ON_FORK for sched_setattr()! */
> @@ -417,6 +420,7 @@ int main(int argc, char **argv)
>  		{ "sched-period",   required_argument, NULL, 'P' },
>  		{ "sched-deadline", required_argument, NULL, 'D' },
>  		{ "reset-on-fork",  no_argument,       NULL, 'R' },
> +		{ "reclaim-grub",   no_argument,       NULL, 'G' },
>  		{ "verbose",	no_argument, NULL, 'v' },
>  		{ "version",	no_argument, NULL, 'V' },
>  		{ NULL,		no_argument, NULL, 0 }


You need to add 'G' to the getopt_long() call as well; currently, only
--reclaim-grub works.

You also need to add --reclaim-grub to bash-completion/chrt.

> @@ -460,6 +464,11 @@ int main(int argc, char **argv)
>  		case 'R':
>  			ctl->reset_on_fork = 1;
>  			break;
> +		case 'G':
> +#ifdef SCHED_DEADLINE

 #ifdef SCHED_FLAG_RECLAIM

> +			ctl->flag |= SCHED_FLAG_RECLAIM;
> +#endif
> +			break;
>  		case 'i':
>  #ifdef SCHED_IDLE
>  			ctl->policy = SCHED_IDLE;
> @@ -546,6 +555,8 @@ int main(int argc, char **argv)
>  	if ((ctl->deadline || ctl->period) && ctl->policy != SCHED_DEADLINE)
>  		errx(EXIT_FAILURE, _("--sched-{deadline,period} options are "
>  				     "supported for SCHED_DEADLINE only"));
> +	if ((ctl->flag & SCHED_FLAG_RECLAIM) && ctl->policy != SCHED_DEADLINE)
> +	        errx(EXIT_FAILURE, _("--reclaim-grub is only supported for SCHED_DEADLINE"));

chrt is possible compile without sched_setattr. The ideal would be to
add there also

#indef HAVE_SCHED_SETATTR
  if (ctl->flag & SCHED_FLAG_RECLAIM)
    errx(EXIT_FAILURE, _("SCHED_FLAG_RECLAIM is unsupported"));
#endif

Thanks!
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

