Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBEF2D97A9
	for <util-linux@vger.kernel.org>; Wed, 10 Dec 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359636; cv=none; b=jMv0vl7d3mC9Q0benKZPVDn/huRBwo5tmyUBnWTpw8CZBv5iwKzvPyWUGciXnGCquylC9bP0M3geoi/mj58wUFXbSB+vd2KxBtdNPUgxp+WycWaMPJquXMJii5UULNwT0s6rZIRdzX+5vZpQhaTnM6RZVqTio9g2GGU9WNfU+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359636; c=relaxed/simple;
	bh=LlZkY2TUbrgrhf0sol0frw59vxiTrzWIL4dsRJbyj5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHVUs2NGfYyd6veNjTFaQxamLLxZGZ73UA8HHyYFDwIsRyjBzo0R2+uLgbpHCPz3NSz7XQVHu8GOgm6b3GEffEO7TMQh15Fsfn5GmzSQZj3J6FEOhzt6fdgeui+dW2qL02YYJygh90I1cr/nF8wcsQ78GNm7vCGnfWNNAXGUbw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXdN6xj+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXdN6xj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765359633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu4xjgA8GAvmg26ut9M8Fa1Ba5Zbdmk4NOSYCpEfM3M=;
	b=ZXdN6xj+pp+FpzEt65cAfAd88110b72lv8LFsPkvGdxzkRsmMY7ADrP0U5r/92XWavpiez
	kgTxgDinEv213r0c0LQmDx3EaTcwmOjUOii65+b/I8+Ce9sfpohqfMF6jFNTeKM2fhM6Pw
	C9xl+DEmPsm+DrlkBfwJ9lJWNMgDtqI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-wMwFTAH3PTSpRZyWZgsIBg-1; Wed,
 10 Dec 2025 04:40:29 -0500
X-MC-Unique: wMwFTAH3PTSpRZyWZgsIBg-1
X-Mimecast-MFC-AGG-ID: wMwFTAH3PTSpRZyWZgsIBg_1765359629
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 191B4180065F;
	Wed, 10 Dec 2025 09:40:29 +0000 (UTC)
Received: from ws (unknown [10.45.242.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 327C319560AD;
	Wed, 10 Dec 2025 09:40:27 +0000 (UTC)
Date: Wed, 10 Dec 2025 10:40:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.41.3 planning
Message-ID: <43wy3erpcifhnqydry4rpfwaaexmkc626cbz3igfacay3mjop2@2n7ojgbksjty>
References: <ajxw7xn6mh3puhs44cmj5mxxe7stxqwqi3vzzzueqa4srn2zgx@iukpxdgp4dkk>
 <oegibjegz34kkaahppwq6rkpitwc5hd6bmpne7ubpn7e4vb35e@wwbtzujfrvzo>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oegibjegz34kkaahppwq6rkpitwc5hd6bmpne7ubpn7e4vb35e@wwbtzujfrvzo>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Dec 09, 2025 at 07:50:59PM +0100, Chris Hofstaedtler wrote:
> Hi Karel,
> 
> * Karel Zak <kzak@redhat.com> [251208 15:01]:
> > I'd like to release the stable update v2.41.3, primarily to provide an
> > upstream tarball with the fixed CVE-2025-14104 and to fix compilation
> > with gcc-15, along with some other minor fixes.
> > 
> > Do you see anything in the master branch that we need to include in
> > this stable maintenance update?
> 
> Thank you. In Debian we picked c332544d215ccb466a64a441eb5a421b9fe8cdfd
> "lscpu: use maximum CPU speed from DMI, avoid duplicate version string"
> because that seemed like a good fix to have.
> 
> I think this is not in stable/v2.41 so far. *Maybe* you want to consider it.

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

