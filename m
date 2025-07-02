Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8A219E8C
	for <util-linux@vger.kernel.org>; Wed,  2 Jul 2025 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441867; cv=none; b=G146yirks04qC5D/nztYXFVj0hSqBgiqUwO7UeG4U/L0yjnzIrY4iKRTvAV1MqkwupAcn4vVAuIw0AwnO+moxWOUL9jjlYUm565ARTCGPTX7Hb++fB+PpJc6nV01KqrknZDmBIv/R3x5GmiBJ3Ibrc+0mvR1TV+bejdTnuPLWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441867; c=relaxed/simple;
	bh=QxM8fU0N66sb2XTTa8pBQTQ8IMP/M20WTdWVbYXyufE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpf/r/tLVIoPTM7Oo4aa+5RZWKjDvzsoNcV5hp7vCx5S+ps8hdgLpUOpkhw4WiaKJIBJpH2+WTXM0jFFGrR2Rwa8fDF6MtgLRn6+cC+GjNonorE/8WZqTbdnU2tes6md1schk52e2fhqvL6+SFBXRsWdMpZStPCtjeVMc/m6Dbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsEkvv61; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsEkvv61"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751441864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m48lvvDw7UaI9yGusFQ0hMdEgoUZ33Y0dxZ6qIm/0Zk=;
	b=XsEkvv61jYocW6o/UAyM6PjWthjoEVqBwmTPrzb+EBAzPmFmUKHj2gAJ3FRogyp6t9yYzP
	38sX5OcZlals0jPcoaF2+GiG/dfYBWiq4PTDMwK91ckVfHz8eIn7LbnjS+6U01XxjJiQoD
	Qr6V1nchVGxkYcDHyjqpewJaw9g53QE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-z2Q982gnMia2PuXxjOmJRA-1; Wed,
 02 Jul 2025 03:37:41 -0400
X-MC-Unique: z2Q982gnMia2PuXxjOmJRA-1
X-Mimecast-MFC-AGG-ID: z2Q982gnMia2PuXxjOmJRA_1751441860
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C6AB1808984;
	Wed,  2 Jul 2025 07:37:40 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3130319560A7;
	Wed,  2 Jul 2025 07:37:38 +0000 (UTC)
Date: Wed, 2 Jul 2025 09:37:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Jesse Rosenstock <jmr@google.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] taskset: Accept 0 pid for current process
Message-ID: <lscxfxbzi6j667md5buwprb5muuzpmsdpvvpmbdk7jvsq2rtxo@ucpthvyj2efw>
References: <CAMZQ0rLM9UYMupEX4WLmi-J9mh0jGhruzDw3OwpU8yEf0+2E_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZQ0rLM9UYMupEX4WLmi-J9mh0jGhruzDw3OwpU8yEf0+2E_Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jul 01, 2025 at 08:35:11AM +0200, Jesse Rosenstock wrote:
> A reasonable alternative would be to interpret just `taskset` (currently
> an error) as printing the current mask.  This seems less orthogonal,
> and a better use may be found for plain `taskset` in the future.

Unfortunately, all schedutils have an odd command-line semantic.

>                 case 'p':
> -                       pid = strtopid_or_err(argv[argc - 1],
> _("invalid PID argument"));
> +                       /*
> +                        * Like strtopid_or_err() but accept 0 for this process,
> +                        * like sched_getaffinity()/sched_setaffinity() do.
> +                        */
> +                       pid = (pid_t) str2num_or_err(
> +                               argv[argc - 1], 10, _("invalid PID argument"),
> +                               0, SINT_MAX(pid_t));

chrt uses:

                     /* strtopid_or_err() is not suitable here; 0 can be passed.*/
                        ctl->pid = strtos32_or_err(argv[argc - 1], _("invalid PID argument"));

 would be this enough?

> +                       if (pid == 0)
> +                               pid = getpid();

Yes, this is probably better than make many other changes to the code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

