Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2951DF973
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418811; cv=none; b=MjK6KZiF65dnA2cVMJHRjXG/8YYi3bMakW5+9dVkLQnQYfhK2HrWvpxKp9bx3QTo5Dv/xJ66RL5w3m70RDUADBkPEkfzpKDTtxz0OgrAOOzGBGgJFOmF5U/l36hYj5dy1FP1RKWcMR+yEDbXM0WatPTHgiCfH43TFqNL0vfJVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418811; c=relaxed/simple;
	bh=tk7nyZYvt8DSEDxR+4876T6X9bTFW1Tbz5VIcd/Dlpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGtP094JUfNfYiQzaAjGHQhn079vm4DJ4b+o+tzqtknHxcdvWzZL8R6q5gUxCFpocN8WUxkwWIHPp2ZV7yt+wgD5OszO/y5jkLSBGQ0o5fJUp2zmn+46xbq30ETVpU3FIxMxtT6TBt/pfqT8+mMN5MQ84/H+k8sByIEfrGOtvJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlXSLzDc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlXSLzDc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743418808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxiKw4OW/9Sqbm+jow0d3wDNDmwc7BOASRUfg0YEL70=;
	b=MlXSLzDcKlirTiKtvV+ECtH6k/SGyj46rbVhbLOTEQYovefS0iAprp4QzujHQSU9G3U4+O
	TDsz5LDTt7J7l1C8v3a/ojjPe4HLahJtRKLN8Pe1AaT5aitRDCpe7ruUHw/1rHp0dZedna
	DbA4OdcwKT+TX+CtGsG3GrRGy8OydL8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-xnXx3FnQMrGmu9-1QtabVA-1; Mon,
 31 Mar 2025 07:00:04 -0400
X-MC-Unique: xnXx3FnQMrGmu9-1QtabVA-1
X-Mimecast-MFC-AGG-ID: xnXx3FnQMrGmu9-1QtabVA_1743418803
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEDF8195609E;
	Mon, 31 Mar 2025 11:00:03 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.80])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFC1B1955BEF;
	Mon, 31 Mar 2025 11:00:02 +0000 (UTC)
Date: Mon, 31 Mar 2025 07:00:00 -0400
From: Phil Auld <pauld@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Thijs Raymakers <thijs@raymakers.nl>
Subject: Re: [PATCH 09/10] coresched: reduce excessive whitespace and
 verbosity in usage text
Message-ID: <20250331110000.GA120637@pauld.westford.csb>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-9-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331094443.9619-9-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Mar 31, 2025 at 11:44:42AM +0200 Benno Schulenberg wrote:
> Also, use semicolons instead of periods in option descriptions.
> 
> And consistently use an uppercased "PID" in feedback messages.
> 
> CC: Phil Auld <pauld@redhat.com>
> CC: Thijs Raymakers <thijs@raymakers.nl>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>

This looks like a reasonble cleanup I guess.


Acked-by; Phil Auld <pauld@redhat.com>


Cheers,
Phil

> ---
>  schedutils/coresched.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/schedutils/coresched.c b/schedutils/coresched.c
> index 9d8be3e12..7634d988c 100644
> --- a/schedutils/coresched.c
> +++ b/schedutils/coresched.c
> @@ -80,31 +80,24 @@ static void __attribute__((__noreturn__)) usage(void)
>  		program_invocation_short_name);
>  
>  	fputs(USAGE_SEPARATOR, stdout);
> -	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
> +	fputsln(_("Manage core-scheduling cookies for tasks."), stdout);
>  
>  	fputs(USAGE_FUNCTIONS, stdout);
> -	fputsln(_(" get                      retrieve the core scheduling cookie of a PID"),
> -		stdout);
> -	fputsln(_(" new                      assign a new core scheduling cookie to an existing\n"
> -		  "                            PID or execute a program with a new cookie"),
> -		stdout);
> -	fputsln(_(" copy                     copy the core scheduling cookie from an existing PID\n"
> -		  "                            to another PID, or execute a program with that\n"
> -		  "                            copied cookie"),
> -		stdout);
> +	fputsln(_(" get      retrieve the core-scheduling cookie of a PID"), stdout);
> +	fputsln(_(" new      assign a new cookie to an existing PID,\n"
> +		  "            or execute a program with a new cookie"), stdout);
> +	fputsln(_(" copy     copy the cookie from an existing PID to another PID,\n"
> +		  "            or execute a program with that copied cookie"), stdout);
>  
>  	fputs(USAGE_OPTIONS, stdout);
>  	fprintf(stdout,
> -		_(" -s, --source <PID>       which PID to get the cookie from\n"
> -		  "                            If omitted, it is the PID of %s itself\n"),
> +		_(" -s, --source <PID>       which PID to get the cookie from; if this option\n"
> +		  "                            is omitted, the PID of %s itself is used\n"),
>  		program_invocation_short_name);
> -	fputsln(_(" -d, --dest <PID>         which PID to modify the cookie of\n"),
> -		stdout);
> -	fputsln(_(" -t, --dest-type <TYPE>   type of the destination PID, or the type of the PID\n"
> -		  "                            when a new core scheduling cookie is created.\n"
> -		  "                            Can be one of the following: pid, tgid or pgid.\n"
> -		  "                            The default is tgid."),
> -		stdout);
> +	fputsln(_(" -d, --dest <PID>         which PID to modify the cookie of"), stdout);
> +	fputsln(_(" -t, --dest-type <TYPE>   type of the new or destination PID; can be one\n"
> +		  "                            of: pid, tgid, pgid; default: tgid"), stdout);
> +
>  	fputs(USAGE_SEPARATOR, stdout);
>  	fputsln(_(" -v, --verbose      verbose"), stdout);
>  	fprintf(stdout, USAGE_HELP_OPTIONS(20));
> @@ -341,7 +334,7 @@ int main(int argc, char **argv)
>  	switch (args.cmd) {
>  	case SCHED_CORE_CMD_GET:
>  		cookie = core_sched_get_cookie(args.src);
> -		printf(_("cookie of pid %d is 0x%llx\n"), args.src, cookie);
> +		printf(_("cookie of PID %d is 0x%llx\n"), args.src, cookie);
>  		break;
>  	case SCHED_CORE_CMD_NEW:
>  		if (args.exec_argv_offset) {
> -- 
> 2.48.1
> 
> 

-- 

