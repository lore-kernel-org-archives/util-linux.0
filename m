Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E262DECD4
	for <util-linux@vger.kernel.org>; Wed,  1 Oct 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324009; cv=none; b=DZmng3TPN+383flpxNOHdqYixTXh0IdSxnASANlksyPPaATZa63gPqpOw8WABwBIW7vYo6QkYI4Ok2Vnux/8b9GCEUrRdzD6viP2VqJWYVcnHOT7kaShxJIfuDnDy8ZeGUdxB7PpGn0bPVVmHssBLIc79dv/Zikebk1XEA1x4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324009; c=relaxed/simple;
	bh=qZk7yuX7HjgY3XmK83nCca/gqzgGhCyuQR+RECnRgKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL1Hzye0y8w/b0PelptxaC42sqstj09VN6KtJiCU3p6WRn549np9TfX47MaOxjLjj03JMoAJT3f6iB49df1ZkjJPv9TF1tmum1/Yg7CQsFBtyukx3T7pSgA7HCZB/+etB2rE1etMCCnUwcpUvP6oQ2F2FBAPA/KRzfVeHGvfa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5ASlPDI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5ASlPDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759324007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wtVdAa0rI8O8nF6Ov1XftCn7DPpuJQvJGK7lXDpT9w0=;
	b=G5ASlPDIzqUJUs0V7gw3sxpEJ4Z1egdn+vM02bC12qLQNfLTokvMmmgqwrGJ2M3xL+TA12
	PwEMmaWzgBrsWWDN9hN7iTlPjmoJc+mpkypoYJnqMyOCNppDKxMWnTorLPqIR7W1dclnEn
	anntFjw1G1JmvnXm+byVtkxXeHwwMVo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-FWPzfZtKODe5t31SqEWolg-1; Wed,
 01 Oct 2025 09:06:44 -0400
X-MC-Unique: FWPzfZtKODe5t31SqEWolg-1
X-Mimecast-MFC-AGG-ID: FWPzfZtKODe5t31SqEWolg_1759323999
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 985581800366;
	Wed,  1 Oct 2025 13:06:36 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.93])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E16C1800577;
	Wed,  1 Oct 2025 13:06:34 +0000 (UTC)
Date: Wed, 1 Oct 2025 15:06:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fallocate: allow O_CREATE if mode is
 FALLOC_FL_WRITE_ZEROES
Message-ID: <vrxuesicvzknwfrkesxoaoiozxpgzga5q3c7sde247535l6why@qle4befw3gnk>
References: <20251001115448.1646647-3-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001115448.1646647-3-lukas@herbolt.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Oct 01, 2025 at 01:54:50PM +0200, Lukas Herbolt wrote:
> With the new flag we can create the ZEROED allcoated files directly and not 
> in the two steps. Removing FALLOC_FL_WRITE_ZEROES from the flags of not using
> O_CREATE on open().
> 
> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> ---
>  sys-utils/fallocate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

