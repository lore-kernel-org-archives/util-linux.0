Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B9328638
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610544; cv=none; b=JN6HUKAFpxKeyIYCO8AjHrb01aOBv5s9TEZvEQs3hX+H5nucryNBZ1zEZ2oDXLHAmeDCvGqLveSGTKs8Mi99UPxJlT1mZKp5ObxpCQ9/LE1HmmdGvSxfifIW6XgooFkHrHoKL7jxMtfuCPqtWJNuhcf8Ocpozsln0FgIlf2zE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610544; c=relaxed/simple;
	bh=Den15McWJks3fPX3BaYAgmlNUDCYoYPbPdeyr0uvQw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0eBzr7aukMMHZHCc2R712gMEnsKdhye/XB3gx+Wnr6g2/bFnHzUvGLYwxGiBDRp4BxXEYlbhggmnySzmGCeza4aZnWoYuBRo0jrRRklm4fKqY6KcmDC1uv+ij1lzq5hWswj+xigSVqXpsPbz0LuqYelzmjOZvQtkRvLh9ohBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPlFb7JB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPlFb7JB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760610541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mih35TTIpgNanGdm/FJmcwRld9F83O+W44OmDVdQ6V0=;
	b=HPlFb7JBLOCXv0xW9fSZQ3k1xeKcOm5UGZ//R1bXDmgwZKHz7LyTR9J6d4ZRIFDXE/hv5E
	XNg0gUyKzRPOiXhfkEXtGV2wOqLBLNbGbl1B5ADfRTjG9qq1VBZ4HVZ7yh03u5oLOefnZH
	CI7IE1EfGUrm/8RjzMC27qkvTELN3J0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-gEOKnqz1OlqU3rjBn_gEfA-1; Thu,
 16 Oct 2025 06:28:58 -0400
X-MC-Unique: gEOKnqz1OlqU3rjBn_gEfA-1
X-Mimecast-MFC-AGG-ID: gEOKnqz1OlqU3rjBn_gEfA_1760610537
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17CFF18002EC;
	Thu, 16 Oct 2025 10:28:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92FE819560AD;
	Thu, 16 Oct 2025 10:28:55 +0000 (UTC)
Date: Thu, 16 Oct 2025 12:28:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Util-Linux <util-linux@vger.kernel.org>, 
	wguanghao <wuguanghao3@huawei.com>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
Message-ID: <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Oct 10, 2025 at 11:41:08AM +0200, Benno Schulenberg wrote:
> After setting up a loop device with:
> 
>   # ./losetup loop4 some.img
> 
> I wanted to see what happens when trying to "remove" it
> (since the man page says it is "not recommended"):

https://github.com/util-linux/util-linux/pull/3803

A new PR, summary:

 - losetup: add error feedback for --remove command - Improves error
   reporting in the remove_loop() function so users see meaningful
   error messages when removal fails.

 - losetup: make --remove a long-only option with mutual exclusivity -
   Removes the -R short option (keeping only --remove) and adds mutual
   exclusivity with other major operations like -d, -D, -a, -c, -f,
   -j, -l, and -O. Updates man page, bash completion, and usage text.

 - losetup: improve --remove documentation - Rewrites the --remove
   description and adds a new "LOOP DEVICE LIFECYCLE" section
   explaining the difference between creation, detachment, and removal
   operations.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

