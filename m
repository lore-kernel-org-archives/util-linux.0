Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9DD1327E0
	for <util-linux@vger.kernel.org>; Wed, 17 Apr 2024 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349912; cv=none; b=qBdh5lnhtZtumrJpAqJNrn1C2EG721fbigQSEjD31AWyueQ0qTB2u2WZz46w5Rc2iGlOv5DrycwbhbpWqvj0bMZCaCbHTh2/J35oE0irOlgyv/hd3X+IZVjmfCEAi8jc2K7YZaRcDXq+T1COmCdFG4K7EGx+tOasjprgVvSlsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349912; c=relaxed/simple;
	bh=gh3VEBra78YiUhB1RCpjf6SSSzToFxFWAWh74arQO5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+AjYLoNSs5Ut0nt3lcxZsVywHGPz4iCWJjdIPCFU1dcFuiYvwsK6/LqNC5lQ7rXet5HlLcDE2QwV9kSPwA/cneSPU7nPMmDawbmwOX/2yCowcfhBvyiKwdd3MnzSIOHmcyZzsLd+WocHHVkqF6neBn1Kr+mFQRiID5rrW3z6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aV6aiopy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aV6aiopy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713349909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4OEKhoiey9Ez+xiETKJhOGzB2Rnkpx61PEtrWLpQb4=;
	b=aV6aiopypwg+2MLEYYg7UsVwX43O2YYtEC3rTFk+HUSVz3Mt34XspvhASQQKUHfJRRiOFn
	3xP+WJPULQzxFURTRB1LvcaJxAlYxw7k9m942OsZva1A/+cS9S+dYrY6UyOC9nwbt7YBm8
	Igi8efitslhQ9zzRjpYYnKb5PHrGLNM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-TFIoXbvAOAyfKHYr1EWTwA-1; Wed, 17 Apr 2024 06:31:46 -0400
X-MC-Unique: TFIoXbvAOAyfKHYr1EWTwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A244D80653C;
	Wed, 17 Apr 2024 10:31:45 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E7848C13FA8;
	Wed, 17 Apr 2024 10:31:44 +0000 (UTC)
Date: Wed, 17 Apr 2024 12:31:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Phil Auld <pauld@redhat.com>
Cc: Thijs Raymakers <thijs@raymakers.nl>, thomas@t-8ch.de,
	util-linux@vger.kernel.org
Subject: Re: [PATCH v8] coresched: Manage core scheduling cookies for tasks
Message-ID: <20240417103138.g3bk5zamemhx6xm2@ws.net.home>
References: <20240410221539.GA408244@lorien.usersys.redhat.com>
 <20240411110250.292512-1-thijs@raymakers.nl>
 <20240411134640.GA413983@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411134640.GA413983@lorien.usersys.redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Thu, Apr 11, 2024 at 09:46:40AM -0400, Phil Auld wrote:
> On Thu, Apr 11, 2024 at 01:02:49PM +0200 Thijs Raymakers wrote:
> > Co-authored-by: Phil Auld <pauld@redhat.com>
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>
> >
> 
> Hi Thijs.
> 
> > ---
> > 
> > Hi Phil,
> > 
> > That might have been a bit too drastic from my side. I just wanted to
> > make sure that I didn't accidentally attribute something to you that you
> > didn't fully support, since the arguments of this version differ
> > significantly from what we've previously discussed. I've put you back.
> 
> Thanks!  I support whatever we can get in that covers the use cases. If we ask
> three engineers about commandline options we'll likely get 5 answers :)
> 
> What we have here looks good and works well.

+1 This version is fine.

> A couple of minor man page comments...

Okay, please finalize it and I'll merge it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

