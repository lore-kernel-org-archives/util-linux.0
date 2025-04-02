Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F01EF37D
	for <util-linux@vger.kernel.org>; Wed,  2 Apr 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592273; cv=none; b=ZQNyhGKND/+R0F1xIrMn+STgb+WTAMq70Qa9KPKKn0zu8t/dxcRG3EDCAAmm3yfq73KSD2MbSXkAuyiE3RaSS3sg6kSX0OJOI8y9pFnU8rurgvaG5kVSgmBWFmaF+3VPDrxIevffA9Ew8CJjPiLCDM8t4y7N090wN73wZeEuM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592273; c=relaxed/simple;
	bh=KJ7QNLMlELMn4eknHpDLSgkLdeZNN8TTONc3l0Nf19Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON0hzBpu9VjC2Fbr9XzQTqqJCXqmoXvYPJH6LOqenlZejI+raGDrbXN2dPyK+7X/9a5Y64/zexCDpIGh3KlSyyEIDmDu76L/93UfPs18CC2qkHO5w/iQbzbhCEE75lGeTFxN3hX/r3+2cLX/03QEOvRoZhVtfpJVbdMeVlEZJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/+YuTXa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/+YuTXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743592270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQvfpoL3gk5h/hA55Ea1vZABPTdrRk2OWf4/oDEC2DU=;
	b=B/+YuTXaYvZstc8Gmg7ri/ANRlA9wuueR99zMKbQg9c8kod/ieEpgksuTWBmFp1Sl+uzOJ
	MHlAcEnlLkbANZSVKYbmVS4hBcuA/A+X1n3mXJWCjIsEs9sY7DwOLgUVoHemJTZhFRy+JK
	MuX70E7j8jH0adbSeR8236GuHMkR0Ig=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-Je3EauU-MNiwigS4Jjs8yg-1; Wed,
 02 Apr 2025 07:11:09 -0400
X-MC-Unique: Je3EauU-MNiwigS4Jjs8yg-1
X-Mimecast-MFC-AGG-ID: Je3EauU-MNiwigS4Jjs8yg_1743592268
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B70B1801A12;
	Wed,  2 Apr 2025 11:11:08 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 810A8195609D;
	Wed,  2 Apr 2025 11:11:05 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:11:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] enosys: add the missing arguments of -s and -i to
 the usage text
Message-ID: <hycvm627ihe4q4n5xqcwnhenb2bjvrwm6hpjxjr2biku2vq3lw@ldce3tx6l3rg>
References: <20250331094443.9619-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331094443.9619-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17




PR for all patches, except the last one (--dest-type rename), on
GitHub: https://github.com/util-linux/util-linux/pull/3500. 

It will be merged if it passes the relevant tests.

Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

