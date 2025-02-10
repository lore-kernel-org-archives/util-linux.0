Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8607288A2
	for <util-linux@vger.kernel.org>; Mon, 10 Feb 2025 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186916; cv=none; b=mpUsSWziOTapsG38G+hD+2zdwyvRZbbNHtgZfh20E/v3/N/ASbynIsdUrPokUCoYZeyk33Ufft4t3rMm+3+KhkNPlNzgLDekRTwAsewrQfKJOS4Vs3RlEeQ3rKZSMGukldasKRD6D5SaIxbX+aJ1bRPll9FPggcHMBMu457PRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186916; c=relaxed/simple;
	bh=oMRBDw+UCwTp5gMt8XQ9Rj7glc2fUSQ2CcmNW6xu/YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY59fWBxntM9zBA2JIebQLZlmBIX73x1NLR4kOxsy4EOalthbvUYF63zxBJPeiy83/uv3oFe/VM3mHPJ6rPKh8Yl753krhnWFzfl+a2b8PdUbGDJUL9mQxADqOsIUhg2uiKJCJhK2oHYjjWJauJVgXy+jRE9oVtwdWORDohcQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xw8TKrjC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xw8TKrjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739186913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q++aueYijVGiYotlmFnNYLEs2giAms6h9fL9SBkQO/g=;
	b=Xw8TKrjCbhUouba6aa/MItjIGfRtB6Eh2fxm168f03ZSYvyMnMbsHx7/T4VynrzNqvNzGO
	oojT8dKBfBv9ZUlZdosoaFwkPaKM6OxxIeP4pGH07Zo0qvW0rLw3fRt95y7+vfc+tFwz1C
	U9hi2PX19+nH3NPrf7aWwrKtafsZ1G4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-AyjVPchmOFi4Qty0_MSZUA-1; Mon,
 10 Feb 2025 06:28:32 -0500
X-MC-Unique: AyjVPchmOFi4Qty0_MSZUA-1
X-Mimecast-MFC-AGG-ID: AyjVPchmOFi4Qty0_MSZUA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08F3119560A0;
	Mon, 10 Feb 2025 11:28:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 096E91800360;
	Mon, 10 Feb 2025 11:28:29 +0000 (UTC)
Date: Mon, 10 Feb 2025 12:28:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/14] blkzone: correct the wording of an error message,
 from ioctl to function
Message-ID: <2nhsnn5oqisd5zrqchbweiymdmloyw6p2arxuzgegiroxd3rmg@qf437ub6ehwk>
References: <20250209082330.4235-1-bensberg@telfort.nl>
 <20250209082330.4235-10-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209082330.4235-10-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Feb 09, 2025 at 09:23:26AM GMT, Benno Schulenberg wrote:
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  sys-utils/blkzone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
> index 843f3c7b0..9e648484b 100644
> --- a/sys-utils/blkzone.c
> +++ b/sys-utils/blkzone.c
> @@ -149,7 +149,7 @@ static int init_device(struct blkzone_control *ctl, int mode)
>  		errx(EXIT_FAILURE, _("%s: not a block device"), ctl->devname);
>  
>  	if (blkdev_get_sectors(fd, (unsigned long long *) &ctl->total_sectors))
> -		err(EXIT_FAILURE, _("%s: blkdev_get_sectors ioctl failed"), ctl->devname);
> +		err(EXIT_FAILURE, _("%s: blkdev_get_sectors() failed"), ctl->devname);

blkdev_get_sectors() is a local util-linux function. It should not be
used in error messages. It would be better to use something like
"failed to get sector size".

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

