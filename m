Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3C13C675
	for <util-linux@vger.kernel.org>; Wed, 17 Apr 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356848; cv=none; b=L3R8Y/Kx+e9cC6ZQztHcxTy48ezlWE0StmKQffeuIyvqEHw/KY6A0SYA67oC97OnJziSFczW7n+CBI+Lja0VcdmGjesFqKWaoe5LQTfxVT1upX/7UzNipYPcflANG34u2aHcHUk0Ja3oWlpDvBTAPSmdp3QDDZe2qdabGYf2cJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356848; c=relaxed/simple;
	bh=26g/TB7kMdq1bG1DcHj5wZLO+Rf6vvmpFlMjhU4J4sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2pxAm0KdD12E1GSANbKsMxS/pX8ThExuHIAzcZQpNTJTHhFaKVztr4YD5j/tMgLBTkA3q4U4udStA5n8wdYRgJEu/WXi2nFGUpa97yF1K/+NJjEAQcG0WLQsIVT6eFpxzBzZSbQDNIei7LxxIxqzeVqyfiiSnIwQkLFSUV0EWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Onv2zTO5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Onv2zTO5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713356846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbcbYIsui12nnXkkbfKKJ+jr9/VZWa74d6VMpYnU2rc=;
	b=Onv2zTO5nr4mGGk2n8zvVapOcnEW4ug9FMSUCzsN5J7ooan5WT6b4nA3Ww/qv23//4gW/o
	djEwIDxgAAF36djLKep0nesmQAXU7xp/BZ/dtGZ3TCnO9/57s632KZBcrwiY5adkGS52iH
	g38dVsMDA2r8FasVEttGMgIDIsghv+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-djMEoK0lMNOCrKMoCdTQZA-1; Wed, 17 Apr 2024 08:27:24 -0400
X-MC-Unique: djMEoK0lMNOCrKMoCdTQZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E7F01807AD4;
	Wed, 17 Apr 2024 12:27:24 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.17.37])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B31A492BD4;
	Wed, 17 Apr 2024 12:27:24 +0000 (UTC)
Date: Wed, 17 Apr 2024 08:27:22 -0400
From: Phil Auld <pauld@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: Thijs Raymakers <thijs@raymakers.nl>, thomas@t-8ch.de,
	util-linux@vger.kernel.org
Subject: Re: [PATCH v8] coresched: Manage core scheduling cookies for tasks
Message-ID: <20240417122722.GB127626@lorien.usersys.redhat.com>
References: <20240410221539.GA408244@lorien.usersys.redhat.com>
 <20240411110250.292512-1-thijs@raymakers.nl>
 <20240411134640.GA413983@lorien.usersys.redhat.com>
 <20240417103138.g3bk5zamemhx6xm2@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417103138.g3bk5zamemhx6xm2@ws.net.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, Apr 17, 2024 at 12:31:38PM +0200 Karel Zak wrote:
> On Thu, Apr 11, 2024 at 09:46:40AM -0400, Phil Auld wrote:
> > On Thu, Apr 11, 2024 at 01:02:49PM +0200 Thijs Raymakers wrote:
> > > Co-authored-by: Phil Auld <pauld@redhat.com>
> > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>
> > >
> > 
> > Hi Thijs.
> > 
> > > ---
> > > 
> > > Hi Phil,
> > > 
> > > That might have been a bit too drastic from my side. I just wanted to
> > > make sure that I didn't accidentally attribute something to you that you
> > > didn't fully support, since the arguments of this version differ
> > > significantly from what we've previously discussed. I've put you back.
> > 
> > Thanks!  I support whatever we can get in that covers the use cases. If we ask
> > three engineers about commandline options we'll likely get 5 answers :)
> > 
> > What we have here looks good and works well.
> 
> +1 This version is fine.
> 
> > A couple of minor man page comments...
> 
> Okay, please finalize it and I'll merge it.
>

Thanks Karel!   v9 below looks good to me, still.


Cheers,
Phil

>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 

-- 

