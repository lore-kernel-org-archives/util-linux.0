Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76B2264A0
	for <util-linux@vger.kernel.org>; Tue, 17 Jun 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161951; cv=none; b=sBElWZ1/Ma2pedkBjcZ0hc0BJVwWd/4b5ssxMM72t3uqyfOELOFF1e8J+nNWk05kU8+g9QL97j6c+ITHgQd+4oBXz86mzGqB/Vj/jILXBnrGLJE15GSHv/4HJ6Se5EmHkXJI6WSjDI0QpQ92+6y1fJUpHAA7BDpnOtjR360fYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161951; c=relaxed/simple;
	bh=ASX575cgTC2h62FDsGoJMF6FloKbWctTQlya6q/oj0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc0gBs67nkxU8ZdUsKGme9BZrsl6KosgyWloYaX4YNc7kWknkWghQBn8EZdGOQO+rTS9xVcLE0vjbKSIpQKdVQMTvfkNVFEi0GOrlt7fJfKiScQRh3b00CaBNoC5gERT8VAX45CokRcU7OC2l9R8Xp6kF4kPXFUejOLRpcQZbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzcYF/vR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzcYF/vR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750161948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdhUQaB/Hx46pdYY+0SRzJqQzvvd1RpPDFc25f6NdRY=;
	b=NzcYF/vRUMRTr230YDQpVfTiT0wPpDdxie+bmRxAn+rLrnDq3pvahz736clvlMskc7pQU2
	mK7VJSBZft509q/nkrZve9t2M8E1bO3BjlNXobSbUnrIc0fZTB1eG99IidJsPM0iXT8VgV
	jF9eFEgPYDhrGHUMgJwlzrXkU836aAY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-l2SVhD9ZPNKwFRXVfGVAPg-1; Tue,
 17 Jun 2025 08:05:47 -0400
X-MC-Unique: l2SVhD9ZPNKwFRXVfGVAPg-1
X-Mimecast-MFC-AGG-ID: l2SVhD9ZPNKwFRXVfGVAPg_1750161946
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A3BE1800343;
	Tue, 17 Jun 2025 12:05:46 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F6F619560A3;
	Tue, 17 Jun 2025 12:05:44 +0000 (UTC)
Date: Tue, 17 Jun 2025 14:05:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] chrt: Make priority optional for policies that don't use
 it
Message-ID: <4kuoetpvezrzurjsgbu37jngbu5qteqowcdvukhoh6jlz3rcso@jr2ofz4ddfwm>
References: <20250615192218.70289-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615192218.70289-1-vineethr@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jun 16, 2025 at 12:52:18AM +0530, Madadi Vineeth Reddy wrote:
> Currently, chrt requires a priority argument even for scheduling
> policies like SCHED_OTHER and SCHED_BATCH, which ignore it.
> 
> This change relaxes that requirement. Now, priority is only expected
> for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
> is set internally and no argument is required on the command line.
> 
> This simplifies usage when modifying runtime parameters like
> --sched-runtime for non-realtime tasks.
> 
> For example, to change the EEVDF tunable base_slice, one currently
> needs to run:
> chrt -v -o -T 1000000 -p 0 $PID
> 
> Passing '0' after -p is not intutive and not required as priority is
> not applicable to SCHED_OTHER tasks. Now with this patch, one can do:
> chrt -v -o -T 1000000 -p $PID
> 
> Passing '0' still works ensuring ABI doesn't break.

Looks good. It would be nice to update the man page and add a note  
that -p is not required since util-linux v2.42.

> +	bool policy_needs_priority = (ctl->policy == SCHED_FIFO || ctl->policy == SCHED_RR);

Nitpicking... can't we use a shorter name, for example "need_prio"? ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

