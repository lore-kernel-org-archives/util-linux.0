Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892418F2DD
	for <util-linux@vger.kernel.org>; Thu, 30 Jan 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738230451; cv=none; b=i2i1tDXb6p6z95Jt0B5sAoMwxizIAn6KBp7/N8CDWyvDBaeZPj7GUMpfWbMU325EadvPKkAiAaU5LBBKIDROfhJ7J2+hU8IvaJSeff2mOCFQin8MNEvm8ZqjAYPauxnq8n9WalI2q9Hv/7y2udkiCHAZElaVq1lW36dyUy/xiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738230451; c=relaxed/simple;
	bh=GFqj2Q4EqVzxhU7bG9E9LvRAFOaU1zA6owNMHozLO4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CndPrWIAUcsi+mcD8TKRA40k2DJxA24xYOSxLv2hR48qP+ciYzwc8JGeK9uhbzWBbtigR+2m2UNzl5TnLReGOnuZah9tl8ToiJbbmFJgrLNkiUjTvuWSLJE+nZM9sL3tTcJp3g6eUutnCeX/Mh+DFmJ046brcGZpAdAlWMxJbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWQAfmBJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWQAfmBJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738230448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRJUtsumlCFIHWu/jrSZLzjj27WQVxm/5IzKbRsnDjY=;
	b=BWQAfmBJaC4TY+mnSc0w4NE9lADOUPP+eDTFBM8HqH6X7m2m75i9kOhidzyYjDDb8brcp2
	2+JwYL2C7ANucf3lRNDhbwyGRiKFMADFUxbiSdpgxQQwfBrvv/LAHgr491ide5TrpZBQae
	fwuO3iLAMgjYBH6/Z+1FEAtiQy7+Ils=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-5A29paq6PAeBtyo_1yuOQg-1; Thu,
 30 Jan 2025 04:47:22 -0500
X-MC-Unique: 5A29paq6PAeBtyo_1yuOQg-1
X-Mimecast-MFC-AGG-ID: 5A29paq6PAeBtyo_1yuOQg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68A631801F15;
	Thu, 30 Jan 2025 09:47:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.106])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46CA919560A3;
	Thu, 30 Jan 2025 09:47:19 +0000 (UTC)
Date: Thu, 30 Jan 2025 10:47:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Marc =?utf-8?Q?Aur=C3=A8le?= La France <tsi@tuyoix.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix --disable-widechar compile warnings
Message-ID: <772nrb7v2gpu4wli4ecfosqkjzakaf7b34ztiujfyttafgjonk@dblf7yhg2djl>
References: <014dda0b-0d83-64b0-e0b0-366559fed323@tuyoix.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <014dda0b-0d83-64b0-e0b0-366559fed323@tuyoix.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Jan 26, 2025 at 10:38:52AM GMT, Marc Aurèle La France wrote:
> Fix warnings when compiling without wide char support.

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

