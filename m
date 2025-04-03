Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3B242901
	for <util-linux@vger.kernel.org>; Thu,  3 Apr 2025 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743667879; cv=none; b=R46Qa2P297efWiv9ANcYPFEuTILorMPr+wS313vVe5W4k797a6fWc6SW2MZaD12XlDrH/Ymcgg/6IZOJVtB3LbX89fvMS75Nb7AUnoL3cF/4rnSocU7C+qihOWvEN7My3J/fnNzFZszPoEJhCvmed+7SHTKxReNR+c3sIrEow4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743667879; c=relaxed/simple;
	bh=FYIFMdytAXQjK+L6GBC7gTKDds1zLJm7noeepBncYAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVDrcMyX3+BdXIPjz2BDDok+suWh0nhJZD3vdcfg5Zs/+k1ccfcna9idD7DsshyFSuaFvy9Gug0WpGeHNQw4wPWyzAiuTXA+AU4sYSGkB9S2uqcmeGgmqUN2G/K833DTWYjetEvVWMXMvQLJ1yz+vOu9hQR3um13JfSNrwD7cUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2eI9/tX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2eI9/tX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743667877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTKFwamn3AzzhuMf232XKR3pk0ocY9VBYGZZr+T3bYQ=;
	b=V2eI9/tXtTXQb+W5wfInpEHZtSfnM+Cs9kcKkzvfjvwOYwG92RdXkFkLX0v/Z9VUDT9rO9
	h/GWuK6/RwG8lf50plJSF75nxO2NqOiA2lo25PgEIDpyaBOovUYHaJlJriyyH+hwNA/1WA
	6jwwDMTX9Z7+vWFL718hMbpg7iWcObE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-YEDPSb3wMr-6VoCuMCh25Q-1; Thu,
 03 Apr 2025 04:11:14 -0400
X-MC-Unique: YEDPSb3wMr-6VoCuMCh25Q-1
X-Mimecast-MFC-AGG-ID: YEDPSb3wMr-6VoCuMCh25Q_1743667873
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5C011801A06;
	Thu,  3 Apr 2025 08:11:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F5DD192C7C3;
	Thu,  3 Apr 2025 08:11:10 +0000 (UTC)
Date: Thu, 3 Apr 2025 10:11:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Phil Auld <pauld@redhat.com>, 
	Thijs Raymakers <thijs@raymakers.nl>
Subject: Re: [PATCH 09/10] coresched: reduce excessive whitespace and
 verbosity in usage text
Message-ID: <cztqfu3prb4v2urpxrujq5wqqdclnxwsny4h5ejbml7d7kll2n@yj3dgreqhtrl>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Mar 31, 2025 at 11:44:42AM +0200, Benno Schulenberg wrote:
> Also, use semicolons instead of periods in option descriptions.
> 
> And consistently use an uppercased "PID" in feedback messages.
> 
> CC: Phil Auld <pauld@redhat.com>
> CC: Thijs Raymakers <thijs@raymakers.nl>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
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

There is a comment from Thijs that kernel docs does not use hyphen, it
means "core scheduling" rather than "core-scheduling". Maybe it would
be better to follow kernel.
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/core-scheduling.html

https://github.com/util-linux/util-linux/pull/3500

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

