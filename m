Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D7221293
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489119; cv=none; b=WK/Mr2x7XlFQdCsES2UI6WITRhu9nEU1UKqCq5BPZTjVhKNlfAs777WZYXZwJTkQBTPsOuCeYFKzknahLmEcBjzae5TFu4yRSFzAlxA61+ESrhrQFOMuXi1vvQSAdrvL8nGCSOd80pxQ1NicDc/eSt7IqU5DNc04q9aMICh3BH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489119; c=relaxed/simple;
	bh=hKs2rw1+7KTAC3FI4ksI2lnydRPicKgH9+JO6HIpzfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBmZo5fWqj/tzlGT5XCcPUa3qPhGZVRW1VZH01o/P/ka1mos7rM42j200/V1NOkQDbpuRe6hMmoAtxZMMBKeZpEKXe5+D1m6Oqdies18tZ9LblfbNz2+4ws2RLtwXIz+zRIQ7eTspzMYDzl7LNbADLWxLbFWWVmwHT8tS+Hx1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTsyOLHj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTsyOLHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745489114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPlCHXpOw6chpYFPyjjo9mR91lFqBSe6/B0Yz8n3NSo=;
	b=bTsyOLHjQFX7BXWwVoLr5efb+WW4Awl/WWo4GGkaaPQ9ynD8exWXP7BxweEk+jrblqLsQR
	xYysLyhzTOtCo3IqCu7lzxLqQAyOFYOo7Qp7EKKccrKmJkshJh7PvHddiTK1n+smWL83lA
	x0M0ZRhMHXzG9e8YMPIspN9UDgYtfh4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-dXCYQAY6ORCrEWbjCtUi6Q-1; Thu,
 24 Apr 2025 06:05:12 -0400
X-MC-Unique: dXCYQAY6ORCrEWbjCtUi6Q-1
X-Mimecast-MFC-AGG-ID: dXCYQAY6ORCrEWbjCtUi6Q_1745489112
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CF0E195608E;
	Thu, 24 Apr 2025 10:05:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66984180047F;
	Thu, 24 Apr 2025 10:05:10 +0000 (UTC)
Date: Thu, 24 Apr 2025 12:05:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: bensberg@telfort.nl, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/7] lsfd: improve grammar, and use angular brackets
 around placeholder word
Message-ID: <3vy4ysebkufi3zpcv2s66nnzghsf7nu4fthkmzotj6ctxawnd5@ottmham4b2lu>
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <20250424093237.6432-3-bensberg@telfort.nl>
 <20250424.185505.855258258029883426.yamato@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424.185505.855258258029883426.yamato@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Apr 24, 2025 at 06:55:05PM +0900, Masatake YAMATO wrote:
> > Also, use dots instead of "(s)" to indicate possible multiple arguments,
> > and don't use "<when>" when the possible arguments differ from "always",
> > "never", "auto".
> > 
> > Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> > ---
> >  lsfd-cmd/lsfd.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lsfd-cmd/lsfd.c b/lsfd-cmd/lsfd.c
> > index 2eb53935c..3610de8dd 100644
> > --- a/lsfd-cmd/lsfd.c
> > +++ b/lsfd-cmd/lsfd.c
> > @@ -2190,14 +2190,14 @@ static void __attribute__((__noreturn__)) usage(void)
> >  	fputs(_(" -o, --output <list>          output columns (see --list-columns)\n"), out);
> >  	fputs(_(" -r, --raw                    use raw output format\n"), out);
> >  	fputs(_(" -u, --notruncate             don't truncate text in columns\n"), out);
> > -	fputs(_(" -p, --pid  <pid(s)>          collect information only specified processes\n"), out);
> > +	fputs(_(" -p, --pid <pid>...           collect information only for specified processes\n"), out);
> 
> This change implies that --pid 1 2 3 works.
> However, specifying multiple pids to one --pid doesn't work.
> 
>    # lsfd --pid 1 $$
>    Try 'lsfd --help' for more information.
> 
> Only --pid "1 2 3"  or works. See double-quote chars.
> 
>    # lsfd --pid "1 $$"

It also supports comma, it means --pid 1,2,3

It would be better to not announce that space is possible to use as
separator, and use comma in the help and man page

  fputs(_(" -p, --pid <list>           restrict to specified processes (command separated pids)\nn"), out);

or so ...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

