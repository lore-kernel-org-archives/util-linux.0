Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8713B7AF
	for <util-linux@vger.kernel.org>; Fri, 26 Apr 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118237; cv=none; b=uY5uxqiYlRUuvg+wOOqcWyiJECB0GwmR0tQMUTwYcavZFPIdudFIiYq0QyB7vkVqfziAJGtLLe8F1Te7UNocnBO+X3XSve+xH6NAoN0m1TUZ1IUeXtPLNkhPsA4MysYQf56n1q7Nd7uMW3WYXeTR05YysWBgMRVYPaCRlw+hFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118237; c=relaxed/simple;
	bh=fhFIpXyHHZll+CqhUEGFHZ/j2THLJgjj1qYxXqi2ipk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpyJcoABR6vHTI9GE4M0opHBh5ii0rseYpfQVpSxKW64SiWlxST8PLzapJlSWmxz+ICjGD44wtEzZlUaPA+D/rH+w8CQo1ptfl9QI8GW0ZHXMl0GYIIzTF60ZTCMNBAfM7g2V/JqHU3Lf8o2M4U3DopEOhEeumGQ/38CTKnA2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZesXNmR5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZesXNmR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714118234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+GQ2wKgY2QIyAnGGxeoc/4ygUg6xKYS9rRAI0uxLWE=;
	b=ZesXNmR5i87PKk/BVc4rd6yJqulSXvRNhuzhVAzb7hnkuH8CzEH86dX2vF9fKat97qQGab
	//u4APlUxIlzIFIT/elpbiqq6NdE89E/nliQPpRrZlTZM8nWZkENycr/5Xt+YZ/5jeG3Iu
	EN2/oYL4hPzwdtLI7MKuJ+y+PVInRTQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-X-oOz0BHPhKrsOB6W3RoZQ-1; Fri,
 26 Apr 2024 03:57:10 -0400
X-MC-Unique: X-oOz0BHPhKrsOB6W3RoZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A78851C0AF4B;
	Fri, 26 Apr 2024 07:57:10 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CB14C13FA4;
	Fri, 26 Apr 2024 07:57:09 +0000 (UTC)
Date: Fri, 26 Apr 2024 09:57:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: util-linux@vger.kernel.org, Masatake YAMATO <yamato@redhat.com>
Subject: Re: [PATCH v2] flock: add support for using fcntl() with open file
 description locks
Message-ID: <20240426075707.tmfn4jqdqwbu2xox@ws.net.home>
References: <20240423120819.571181-1-rasmus.villemoes@prevas.dk>
 <20240425135522.hu6wrdwoanresvvi@ws.net.home>
 <0ebbe2b6-7f2d-451f-8f43-3765915a462e@prevas.dk>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ebbe2b6-7f2d-451f-8f43-3765915a462e@prevas.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Fri, Apr 26, 2024 at 07:55:04AM +0200, Rasmus Villemoes wrote:
> On 25/04/2024 15.55, Karel Zak wrote:
> > On Tue, Apr 23, 2024 at 02:08:19PM +0200, Rasmus Villemoes wrote:
> >>  configure.ac      |  6 ++++
> >>  meson.build       |  3 ++
> >>  sys-utils/flock.c | 82 +++++++++++++++++++++++++++++++++++++++++++++--
> >>  3 files changed, 89 insertions(+), 2 deletions(-)
> > 
> > Thanks, created pull-request to check it by our CI.
> > https://github.com/util-linux/util-linux/pull/2993
> 
> Thanks, but I sent a v3 eliding the configure-time checks. Can I get you
> to consider that?
> 
> In general, do you prefer PRs, or is using the ML as I've done fine? I
> can do it either way.

If you are able to use PR on Github, it would be easier for me.
However, the mailing list is still a supported option, of course. :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

