Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04559205E00
	for <util-linux@vger.kernel.org>; Wed, 16 Apr 2025 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791742; cv=none; b=otcuBlKr5pDzSZzeGEXxW/fA/njJTA/RthTVaOTSMonVPRt5H4RGgZeUpvlFDTAHEK7nNtPaISCXGMDOKIitfcPxJ+huQZaFzp0SpJNbJios8ES7leo4Tl7R+H0JC3sTSMhcDyYlQNGDLGm35IMrxPtepzcmLR7LACYy5iZPoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791742; c=relaxed/simple;
	bh=sa7MLg+45ssrq7n6goT3JYddqP/1jP0tBbM3OV4Jq4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibQv1XlM2c6cFsv84jv1WezVonMCl1sla2+2kesTf0SlKH00NCkyPS6cbLOHSPr63baZ/WvxWyRZBP17HH1/mEH9N2Xvb12/IeOREg0XA5gG3koWgAWHyrM6D9IX6RA+1A+r4/0vnbzn6lHlnC9jYnmilBoag2Oo7EoKsvr6ikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkED5zLg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkED5zLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744791739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OjcjolA7dEPmNPpJ3tp5HO7AzbWANq8jh3vWiEKXXgY=;
	b=MkED5zLgpqkuKvGQie0emt1EaXaHedJy1dnb36yRCsyMa7IJD9z5K0kzR7D/nhR2tdyoCa
	Qk3wWKqKvqNN/zN5ARQ5R8f6nIMpkgVf5jdG47bb7YGOZbcPNxbXdEP/isCvbdB9ccbmX0
	ZnxCPRXiW+vKh0bTtpiH4p4Qb21r5tM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-U9-mc6OoOQG0uIkddu5JXQ-1; Wed,
 16 Apr 2025 04:22:16 -0400
X-MC-Unique: U9-mc6OoOQG0uIkddu5JXQ-1
X-Mimecast-MFC-AGG-ID: U9-mc6OoOQG0uIkddu5JXQ_1744791734
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8645D19560A2;
	Wed, 16 Apr 2025 08:22:14 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 627C2180045B;
	Wed, 16 Apr 2025 08:22:12 +0000 (UTC)
Date: Wed, 16 Apr 2025 10:22:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] setarch: (man) correct the markup of the synopsis and of
 two options
Message-ID: <2ujt7563btksspjmsbysohezbt4eq5pmmnruijxnd47mu3vede@erx6yybw6gud>
References: <20250409093635.6973-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409093635.6973-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Apr 09, 2025 at 11:36:35AM +0200, Benno Schulenberg wrote:
>  sys-utils/setarch.8.adoc | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)

Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

