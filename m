Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8441EB39
	for <util-linux@vger.kernel.org>; Mon, 21 Jul 2025 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081314; cv=none; b=FN1IG25JHmRO6qx/dhNnCYIFV9RpjpLnvr9WJk3UZ6cPQCDuSO+UfEt0Kxov+OBGKUJwJp/+WfiqbVccEW91AFLA7DPSCYYX6/pY2myLxMa/NXC3JD1LJBZeDmMd5tER7/yO3+rrbX8Rg3NrbqiPaPb3OwU3ITwh0D1p/uTY3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081314; c=relaxed/simple;
	bh=L6oATSc/nfEktuRA+UeCmCy7KWmg8pGKdMGKI5tE86w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOAYzKmNouc6BTAzR/LfS0ZT407kzMawGxYoAeGj5/CV6BOM+UvsGyrpmxNV0DX+VXxbmXq2arha5CwVO7u43Tzebeycz10S0QoHrjFXxVSlCqMPbfxDYx5ZYCbPb4xL0ZnqPbnCBcEWPlun0/vDc6VDT8oq65t44jRA6EqOf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTb7ihvQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTb7ihvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753081311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehtMCO8EqZyyqXdi1hoA6BdrNttl0Yy3Oh3eJogjAv0=;
	b=YTb7ihvQ+vO+WPIxVsg4QdCdDO9F/93bKRTJa3xTX+3af+oizpupb7Z6kETL90tTKPdL9n
	ZQsWKRqv3FlfbXrcfnIxA4a7HFJ3C8p4GZO2U+6qsoeSVWMfp2UevAw+p/WYl8/gAMiOJj
	IrKVLpxIO44bbkP/SLQEI0icsOAu1n0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-puC_sFTKNpu17w9A4Dv30w-1; Mon,
 21 Jul 2025 03:01:49 -0400
X-MC-Unique: puC_sFTKNpu17w9A4Dv30w-1
X-Mimecast-MFC-AGG-ID: puC_sFTKNpu17w9A4Dv30w_1753081308
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B1F31956080;
	Mon, 21 Jul 2025 07:01:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.130])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 759B7180049D;
	Mon, 21 Jul 2025 07:01:46 +0000 (UTC)
Date: Mon, 21 Jul 2025 09:01:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: util-linux@vger.kernel.org, Benno Schulenberg <bensberg@telfort.nl>
Subject: Re: [PATCH] chrt: Allow optional priority for =?utf-8?B?bm9u4oCR?=
 =?utf-8?Q?prio?= policies without --pid
Message-ID: <eu5csrk3f4jmwf7olhle3ukcxvdcofhgk7etss6dko3h364qhn@bxaakyetv7uk>
References: <20250718190439.85359-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718190439.85359-1-vineethr@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Jul 19, 2025 at 12:34:39AM +0530, Madadi Vineeth Reddy wrote:
> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
> index 10ba7fbf6..44b9b9e20 100644
> --- a/schedutils/chrt.c
> +++ b/schedutils/chrt.c
> @@ -395,6 +395,18 @@ static void set_sched(struct chrt_ctl *ctl)
>  	ctl->altered = 1;
>  }
>  
> +static bool is_number(const char *s)
> +{
> +	if (!s || *s == '\0')
> +		return false;
> +
> +	for (const char *p = s; *p; p++) {
> +		if (!isdigit((unsigned char)*p))
> +			return false;
> +	}
> +	return true;
> +}

It seems you can replace this function with isdigit_string() from  
include/strutils.h.

> +
>  int main(int argc, char **argv)
>  {
>  	struct chrt_ctl _ctl = { .pid = -1, .policy = SCHED_RR }, *ctl = &_ctl;
> @@ -503,7 +515,7 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	if (argc - optind < (ctl->pid == 0 ? 1 : 2)) {
> +	if (argc - optind < 1) {
>  		warnx(_("too few arguments"));
>  		errtryhelp(EXIT_FAILURE);
>  	}
> @@ -527,7 +539,10 @@ int main(int argc, char **argv)
>  	if (ctl->verbose)
>  		show_sched_info(ctl);
>  
> -	if (argc - optind > 1) {
> +	bool have_prio = need_prio ||
> +		(ctl->pid == -1 ? (optind < argc && is_number(argv[optind])) : (argc - optind > 1));
> +
> +	if (have_prio) {
>  		errno = 0;
>  		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
>  	} else
> @@ -568,9 +583,19 @@ int main(int argc, char **argv)
>  		show_sched_info(ctl);
>  
>  	if (!ctl->pid) {
> -		argv += optind + 1;
> -		if (strcmp(argv[0], "--") == 0)
> +		argv += optind;
> +
> +		if (need_prio)
> +			argv++;
> +		else if (argv[0] && is_number(argv[0]))
> +			argv++;
> +
> +		if (argv[0] && strcmp(argv[0], "--") == 0)
>  			argv++;
> +
> +		if (!argv[0])
> +			errx(EXIT_FAILURE, "Missing command to execute");

You need to use _() for translation, ideally with string already used in  
other tools. For example, _("no command specified").

Thanks!
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

