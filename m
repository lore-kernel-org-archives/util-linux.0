Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA62AEE1
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743419353; cv=none; b=fMtSr42tI1iZiG+CWgek+tec9y52vM1i4c7iNJWRVa7aC3VZCc39xd//oDSaYGp+cF1cGqAYNnnEgmLPvm2w1fIOiDiwbVgZVUeCWnBJHQrvxwMvgh4qUkVZwLhD60v9Ge6T8fzHyVp1Oy+wV95OoHuBPcHpHWKfazCYt+0mRUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743419353; c=relaxed/simple;
	bh=F4dKOqTMACNbC2N1FGmjOpTq/7GVVEOaVCsphZSjLF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEW6SJSxqHVgMaou1L7/IjAfn7dYfZvoSRlRJO3XAD+zAJ7LozslOSP1Kx49W6xKpJCnMqt31ox8JLKoXHW+H/FAarXYc5TJexjsgf9vqoikG97WFvy3K7PnYeh3Hii4vjnVpy+q7FkAitjznO4GHNrIv9ePwdeXXCKstM4PxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOOPVjik; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOOPVjik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743419350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZCF+smSHYhBzoDyLY8l5FEgOzEXkMAEVLZ+Sb1z9jo=;
	b=hOOPVjikMk0csIh6igzR5V7BbatrhPg0X7offJZ5q6LwnkDs4qG57Uvc6fqfH4v920imQb
	KP67oBbP7HOhQxCj9kBN+RGPtgZ9EZJwJkUrSLzw/JxONWcEiul8S4l6roKLp/nSj0v+G+
	08Owzek483VZ5lcrVODYhAQlv1ioMSM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-lFkLCJbEP162fJlZyb6fnQ-1; Mon,
 31 Mar 2025 07:09:07 -0400
X-MC-Unique: lFkLCJbEP162fJlZyb6fnQ-1
X-Mimecast-MFC-AGG-ID: lFkLCJbEP162fJlZyb6fnQ_1743419346
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8660419560BB;
	Mon, 31 Mar 2025 11:09:06 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.80])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B02A719560AD;
	Mon, 31 Mar 2025 11:09:05 +0000 (UTC)
Date: Mon, 31 Mar 2025 07:09:02 -0400
From: Phil Auld <pauld@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Thijs Raymakers <thijs@raymakers.nl>
Subject: Re: [PATCH 10/10] coresched: rename option '--dest-type' to just
 '--type'
Message-ID: <20250331110902.GB120637@pauld.westford.csb>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-10-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331094443.9619-10-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Benno,

On Mon, Mar 31, 2025 at 11:44:43AM +0200 Benno Schulenberg wrote:
> Long options are nice, but they should be as different from each other
> as possible, so that one can abbreviate them to just a few letters.
> (Not that abbreviating matters here, but that is the general idea.)
> 
> The side effect of this change is that the usage text becomes more
> readable.
>

This one seems a bit more like bike-shedding. We did go around a bit
during development.  I don't remember if a version of util-linux has
shipped with this in it or not yet but this could break users. There
may not be that many yet anyway, of course.


Cheers,
Phil


> CC: Phil Auld <pauld@redhat.com>
> CC: Thijs Raymakers <thijs@raymakers.nl>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  bash-completion/coresched |  6 +++---
>  schedutils/coresched.c    | 19 +++++++++----------
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/bash-completion/coresched b/bash-completion/coresched
> index 3a14c5080..a502207e4 100644
> --- a/bash-completion/coresched
> +++ b/bash-completion/coresched
> @@ -18,7 +18,7 @@ _coresched_module()
>        COMPREPLY=( $(compgen -W "$sorted_pids" -- "$2") )
>        return 0
>        ;;
> -    "-t"|"--dest-type")
> +    "-t"|"--type")
>        COMPREPLY=( $(compgen -W "pid tgid pgid" -- "$2") )
>        return 0
>        ;;
> @@ -35,11 +35,11 @@ _coresched_module()
>        return 0
>        ;;
>      'new')
> -      COMPREPLY=( $(compgen -W "--dest -- --dest-type --verbose" -- "$2") )
> +      COMPREPLY=( $(compgen -W "--dest -- --type --verbose" -- "$2") )
>        return 0
>        ;;
>      'copy')
> -      COMPREPLY=( $(compgen -W "--source --dest -- --dest-type --verbose" -- "$2") )
> +      COMPREPLY=( $(compgen -W "--source --dest -- --type --verbose" -- "$2") )
>        return 0
>        ;;
>      '-h'|'--help'|'-V'|'--version')
> diff --git a/schedutils/coresched.c b/schedutils/coresched.c
> index 7634d988c..62eac4b98 100644
> --- a/schedutils/coresched.c
> +++ b/schedutils/coresched.c
> @@ -91,16 +91,16 @@ static void __attribute__((__noreturn__)) usage(void)
>  
>  	fputs(USAGE_OPTIONS, stdout);
>  	fprintf(stdout,
> -		_(" -s, --source <PID>       which PID to get the cookie from; if this option\n"
> -		  "                            is omitted, the PID of %s itself is used\n"),
> +		_(" -s, --source <PID>   which PID to get the cookie from; if this option\n"
> +		  "                        is omitted, the PID of %s itself is used\n"),
>  		program_invocation_short_name);
> -	fputsln(_(" -d, --dest <PID>         which PID to modify the cookie of"), stdout);
> -	fputsln(_(" -t, --dest-type <TYPE>   type of the new or destination PID; can be one\n"
> -		  "                            of: pid, tgid, pgid; default: tgid"), stdout);
> +	fputsln(_(" -d, --dest <PID>     which PID to modify the cookie of"), stdout);
> +	fputsln(_(" -t, --type <TYPE>    the type of the new or destination PID; can be\n"
> +		  "                        one of: pid, tgid, pgid; default: tgid"), stdout);
>  
>  	fputs(USAGE_SEPARATOR, stdout);
> -	fputsln(_(" -v, --verbose      verbose"), stdout);
> -	fprintf(stdout, USAGE_HELP_OPTIONS(20));
> +	fputsln(_(" -v, --verbose        say what is being done"), stdout);
> +	fprintf(stdout, USAGE_HELP_OPTIONS(22));
>  	fprintf(stdout, USAGE_MAN_TAIL("coresched(1)"));
>  	exit(EXIT_SUCCESS);
>  }
> @@ -210,8 +210,7 @@ static sched_core_scope parse_core_sched_type(char *str)
>  	else if (!strcmp(str, "pgid"))
>  		return PR_SCHED_CORE_SCOPE_PROCESS_GROUP;
>  
> -	bad_usage(_("'%s' is an invalid option. Must be one of pid/tgid/pgid"),
> -		  str);
> +	bad_usage(_("'%s' is an invalid type; must be one of pid/tgid/pgid"), str);
>  }
>  
>  static void parse_and_verify_arguments(int argc, char **argv, struct args *args)
> @@ -221,7 +220,7 @@ static void parse_and_verify_arguments(int argc, char **argv, struct args *args)
>  	static const struct option longopts[] = {
>  		{ "source", required_argument, NULL, 's' },
>  		{ "dest", required_argument, NULL, 'd' },
> -		{ "dest-type", required_argument, NULL, 't' },
> +		{ "type", required_argument, NULL, 't' },
>  		{ "verbose", no_argument, NULL, 'v' },
>  		{ "version", no_argument, NULL, 'V' },
>  		{ "help", no_argument, NULL, 'h' },
> -- 
> 2.48.1
> 
> 

-- 

