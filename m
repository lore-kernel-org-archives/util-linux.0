Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52B14A08E
	for <util-linux@vger.kernel.org>; Thu,  6 Feb 2025 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854922; cv=none; b=KgbhyD/zT899h+6Ly0nGnD4KSS8AMX3/FORRXxsq0TvqB2WsL8qmPP1KTvVcrXKXGydksTAfWuZsxDNTd3lvmtwEWVoXqBA+Rt+8daDpUUl6+hY8PaNNTcRa3DGzYOLh6tawb0RdwfApSRkx6qPHqCv0RpBCqNFVFaoUxYCi2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854922; c=relaxed/simple;
	bh=fWgWJ1bfbVy9EKwhVjR7ZDtIEnvBSiMjO6/E/WVftOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXZmyJ/4JAeSUU2A36y0Ynqp57p+dNsya+htIEXrfEIkHZ/Y2GwIZW7GE3jP5feaYlgbNcRBfH0oItKQjEeY6sfD48qDzRhNhXYqKvTaByXDHZQL83mwsyMCv40Wb0Sswg5qIkUTpExJV54sdZIeRfsVKSgegtEiJm9BuuUnp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMufvBe8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMufvBe8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738854917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4exuefGWvbedDkOHNX0L8QUjmwCsGt9Wgr5RiILYEQI=;
	b=VMufvBe8ehklZXht6FFfor6p7qxbu/n2MuWrKiNpeFj/An69YqzBRpwKziANCw6yL34lSP
	GhFpwHZDbYjZL5rPYfJ0D/EaEKVUgdJ882Xo+ezAKwcOnz9hMvMQwJ/H80Nw+95ubdrHdB
	dD/6GRcap+NIpy01zxgmZwhOwsfReak=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-hAa3ypBTMGuF3UlTbAvZww-1; Thu,
 06 Feb 2025 10:15:16 -0500
X-MC-Unique: hAa3ypBTMGuF3UlTbAvZww-1
X-Mimecast-MFC-AGG-ID: hAa3ypBTMGuF3UlTbAvZww
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E888519560A0;
	Thu,  6 Feb 2025 15:15:14 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB7521800358;
	Thu,  6 Feb 2025 15:15:13 +0000 (UTC)
Date: Thu, 6 Feb 2025 16:15:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.40.3 plan
Message-ID: <7duwc3kj5anayedj2irumtdz7t3vpdxfr5qu2t2pa644qnoqym@7er3y4jnov3b>
References: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
 <ezn7omtjktebuobk6jmfxy3s6t6whoiiqcm62faqocnamybvtk@dsvj5df6qj76>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ezn7omtjktebuobk6jmfxy3s6t6whoiiqcm62faqocnamybvtk@dsvj5df6qj76>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 06, 2025 at 12:51:41AM GMT, Chris Hofstaedtler wrote:
> * Karel Zak <kzak@redhat.com> [700101 01:00]:
> > The next release, v2.41-rc1, is expected to be released at the end of
> > December or in January.
> 
> I guess this got a bit delayed :-)

Yes, I had a 14-day vacation in December.

> Do you think 2.41 final will show up before 2025-03-07? Then I could
> still put it into Debian trixie.

This date seems like a challenge. I'm not sure, but I'll give it a
try:

  rc1   2025-02-10
  rc2   2025-02-24
  final 2025-03-05

 We will see ... :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

