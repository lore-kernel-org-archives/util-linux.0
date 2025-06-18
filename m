Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED12280CFB
	for <util-linux@vger.kernel.org>; Wed, 18 Jun 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238308; cv=none; b=lMgHaUhhYQnHF8avxAsf7tABtRODTLSEHoRjH3dmR05LkdX7gJFqDdBYAqfsiGeP1P3YwrJSKMKbcK3W5z4NGB9KOcAbPQ6IRZIhC7HTbpZnHDSslW+AyIzVfTFfLaequ0dBKrqlIpC1n1xWHtJNDHE4TzlvgvZLebd1T5pz+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238308; c=relaxed/simple;
	bh=yFprTA5W/VnXy6awQeobJOPX6fifyRQlPUMjtdl0SIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INzZd1LJ/B8ifnSPb5V+l0rsuWMkhlTmUcjxKc3AvD4v/qPTzZAJyTj3nbZDC9Lf3SVWrdmn2HwJtwylVQByw8CFBC0ngNV8wbfxMAIWg+hTnxm4bODUUsYFSE2RU4q2jgHpuFXOS+hplsam4DwcemUa2pReM+YrwtM9rfsIW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzyOeqJM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzyOeqJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750238303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o71WpMFth39xq9pg5mJ6FMsYGE9Glb2XqgnOrjEiPLo=;
	b=PzyOeqJMB+sxXr9VqTlUiYQa4STUEUByiUV1tn4MRM/XK3+bbegQl/toprsKCglcBi+os/
	ocKuBg0OIXlLMC3rTi+/ZqcUuEKnQMo4zUDQSoDRYhfv7QE+iwnmvZa5eDL9etbN+o6EVA
	28Ln+H93C2/T5pn61/E47E8byYyOXBE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-LyICxyUDMeW_RpwcW456CQ-1; Wed,
 18 Jun 2025 05:18:19 -0400
X-MC-Unique: LyICxyUDMeW_RpwcW456CQ-1
X-Mimecast-MFC-AGG-ID: LyICxyUDMeW_RpwcW456CQ_1750238298
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FEF919560AA;
	Wed, 18 Jun 2025 09:18:18 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FDBC18003FC;
	Wed, 18 Jun 2025 09:18:16 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:18:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	util-linux@vger.kernel.org
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
Message-ID: <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Jun 18, 2025 at 10:18:29AM +0200, Benno Schulenberg wrote:
> 
> Op 17-06-2025 om 20:24 schreef Madadi Vineeth Reddy:
> > Currently, chrt requires a priority argument even for scheduling
> > policies like SCHED_OTHER and SCHED_BATCH, which ignore it.
> > 
> > This change relaxes that requirement. Now, priority is only expected
> > for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
> > is set internally and no argument is required on the command line.
> 
> Doesn't this alter the "show-the-current-policy-and-priority" behavior
> when no priority is given?  Currently `./chrt --help` says (trimmed):
 
Very good point. The priority policy (--{other,...}) should be
required to ensure that the user wants to alter the setting rather
than print the current situation. Madadi, what do you think?

>   Set policy:
>    chrt [options] --pid <priority> <pid>
> 
>   Get policy:
>    chrt [options] -p <pid>

I really don't like the use of "-p." We should use "--pid" everywhere  
(in --help, man page, and examples).

> Without the proposed change, running `chrt --other --pid $$` says:
> 
>   pid 1427's current scheduling policy: SCHED_OTHER
>   pid 1427's current scheduling priority: 0
> 
> After the change, that same command outputs nothing.  Maybe that is
> fine, but it would require some adjustment of the docs.

This is bug.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

