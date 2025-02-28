Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852F242907
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2025 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730782; cv=none; b=pvSmZQC4J2/UjqvOAsQr/m3DOZOWvNMo/DWUnCh5VEc6CmBJRYs8XRdVII+jMEInjN08soCRFQNslpXrg5mYjlZgLse35OVeax/iWkuqw2Jpi1JygWKX/vEJyNH/IrDtdJju76NxnRwSrFjEeBMqnqh/KulNY1gDF7/9i2iKxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730782; c=relaxed/simple;
	bh=uBD4C4IjxuJ9QVnzW5KzAaNUoEgoCQwmL1bRdvMxJwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhyzQgtu5olzoERJs9vYJSxywqp8u4zwX2mNeGSIxQGu0c/l6ZUOfFZ82DiMdPJf/LajDGLCwWZlsAb5zWbEvKZ0VzDi3EU5WlnhZtW2IpIhuvuYbxefjFirW+Pb6y3ATk/lWmNFGmZ1BczRunn+jh7UZYccWOnAruSRMezJfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8fpnTt6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8fpnTt6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hT/gKLHBAudBuikPtghSQhwGnidCKZ+RhsS+8ntjBsI=;
	b=h8fpnTt6X3BDa3IFrM3FhUSjm4cHfqUU5UB0e9VYdRAmsdZsxsPTP5pNMmizxp4GF1Hj5N
	BsL3OWSTUqNGuQv2HO70MKgDUp3RjuJub7+GgV4LCdx+UnkktSx3OFcHXW41Rkrvl/ewQV
	3XKLIaIRLybRqYZvNfDSGk8YOMpMpew=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-AaT2dfNOPuCcdPpTUTuSdg-1; Fri,
 28 Feb 2025 03:19:34 -0500
X-MC-Unique: AaT2dfNOPuCcdPpTUTuSdg-1
X-Mimecast-MFC-AGG-ID: AaT2dfNOPuCcdPpTUTuSdg_1740730773
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 261611954B20;
	Fri, 28 Feb 2025 08:19:33 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6911419560AB;
	Fri, 28 Feb 2025 08:19:31 +0000 (UTC)
Date: Fri, 28 Feb 2025 09:19:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>, 
	util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] irqtop: add max iteration support
Message-ID: <4ahjcd2zdzcbd7gbq3oc2qaqsqnkhcazzxr665uzgj7mhpbtyu@sa6iwil6bp7a>
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <20250227044916.89925-3-joe.jin@oracle.com>
 <pr4fky3knju6kxdk7tkdffc6qcxrintim4y42aoj4rcfrn2wk4@2no665wcutja>
 <df430d5e-3973-4553-80ee-1ae3bb868a22@oracle.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df430d5e-3973-4553-80ee-1ae3bb868a22@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Feb 27, 2025 at 10:32:11AM GMT, Joe Jin wrote:
> On 2/27/25 01:28, Karel Zak wrote:
> > On Wed, Feb 26, 2025 at 08:49:15PM GMT, Joe Jin wrote:
> >>  	enum irqtop_cpustat_mode cpustat_mode;
> >> +	int64_t	number;
> > Can we find a better name for the variable and the option?
> >
> >   --nloops 
> >   --repeat
> 
> How about of "--iter"?

Yes, better than --number :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

