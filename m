Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9B369239
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765968835; cv=none; b=IV05Wyh4LtQPMBxVlwsRTWjJJrCwOIvo92mR/pqiY/moWM3Fs+Kdo6tSAmbobLuz9qi6ffsKsDzloXxiSr9yJ4FHwki43dr02qMACdbOuvtju1R8L2W8JjDljaU+Ku2YUkMVX4Kl+msldCeet8QmztPPRrPydC/FDcXP9dYvdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765968835; c=relaxed/simple;
	bh=EaTp7GY+s4XgGqVMGYV+2vngx2llhU1f71zrmAxSyIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkT2s6mLIvF34p19gw432OV9gPZOjB6OOXqRcjs3LXtTflxHMgQc2oiRrsW1ofCHEIIorqhZF7a0pI1gMbLWCUzry5R6/Hq1A6DViijb/1oj6/Xlh4AKYO8Dqlml2HDQuh4fusetCqYXNx4m60VMBQGLS1P4I66wCBFpF3z8qIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpigNR4I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpigNR4I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765968832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHA+FvoAT1ETN9vA39vHOzuR7Ib7ACKq0MMzdI5wMsU=;
	b=RpigNR4IWXEqvNX7VEnUg1CRf+v2dggUibZA+FyOqqO/7qOtS1qpil5gSmpiGXjVcc62CX
	LbRO+lQQEOGTnEbKVbhhi9BlRG0B/OUSWPhvGJPNsR1Bs/SBxG9yAasNkNZO5zX8tha+k1
	tgwKAcq3z/JxefewO+nppupMyflXdZY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-DNwDR0jBPQaFxP5O1jltIA-1; Wed,
 17 Dec 2025 05:53:51 -0500
X-MC-Unique: DNwDR0jBPQaFxP5O1jltIA-1
X-Mimecast-MFC-AGG-ID: DNwDR0jBPQaFxP5O1jltIA_1765968830
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84B6E18001FE
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 10:53:50 +0000 (UTC)
Received: from ws (unknown [10.45.242.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99B061956056;
	Wed, 17 Dec 2025 10:53:49 +0000 (UTC)
Date: Wed, 17 Dec 2025 11:53:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] blkpr: add read-reservation command
Message-ID: <ce5rsy5oycyuyfke6kcyrqokgim3cctjewhuv4gw2ptbkev7zh@ehw77wgurx7y>
References: <20251211160956.1540114-1-stefanha@redhat.com>
 <20251211160956.1540114-4-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211160956.1540114-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Dec 11, 2025 at 11:09:56AM -0500, Stefan Hajnoczi wrote:
> 
> diff --git a/meson.build b/meson.build
> index 47b43c2af..b759e992f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -768,6 +768,9 @@ conf.set('HAVE_DECL_PR_REP_CAPACITY', have ? 1 : false)
>  have = cc.has_header_symbol('linux/pr.h', 'IOC_PR_READ_KEYS')
>  conf.set('HAVE_DECL_IOC_PR_READ_KEYS', have ? 1 : false)
>  
> +have = cc.has_header_symbol('linux/pr.h', 'IOC_PR_READ_RESERVATION')
> +conf.set('HAVE_DECL_IOC_PR_READ_RESERVATION', have ? 1 : false)

It seems you do not need to define HAVE_DECL_IOC_PR_READ_RESERVATION
and care about this in meson.build or configure.ac.

> +#if HAVE_DECL_IOC_PR_READ_RESERVATION
> +	{IOC_PR_READ_RESERVATION, "read-reservation",
> +	"  * read-reservation: This command shows the current reservation.\n"},
> +#endif

I think you can use directly

        #ifdef IOC_PR_READ_RESERVATION

        #endif

as IOC_PR_READ_RESERVATION is macro in linux/pr.h

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

