Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2B2DA774
	for <util-linux@vger.kernel.org>; Mon, 11 Aug 2025 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904244; cv=none; b=VY7Wf5N/q3rzXqWfcepjd0mqtUDkyrdtE0pRLNKAUDxH0N6qwJXfCVBtRngQPEIGyR/2vir1P68AtNOJDIwpHCI62eJz2oa/cpMlvvaSs0Ut6oL+87Y3/SRaKOQWvmJtUIaqq3/2Ss2ddmlmfG3HUsnvi8or3eVNaOe7nh7PIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904244; c=relaxed/simple;
	bh=etky6gcZN32YCx4LAWm+kcernBW3qBhv3W9Q429wSps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1Gx4+ublHZ5wD59p+eOQhDdBXBfpNIOOZGAa3JG0ihNBoBA2GpHgrV7qZh+ZSggE0Xc35Fs+QVZIV89l6D9pGXLeFLQ4m3UNkDzxbFsjw3rKLCKXuivO6S8U+ItKJKJ04VreclYCXoZesO8iLomZd45JCh6tukU/W/iyBNWkTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBdkRNSQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBdkRNSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754904241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v/gigQ0UwHMMM9ZPe/8QkbTAC5N5W4W/OoJW90yJmqE=;
	b=KBdkRNSQdE13kvDH9SjEpu8cqLjVucMOsEmGMtZxXL8jdx8SrRWVEurtk3iH0OD3x79y6T
	yjYE0kqAwZIryA3YfB3hjTDTsIdPb5kmC3Ya1y1m+8qhuZnI8o43RK1/X71ITbRKj+O5Bq
	UhFSkc+U7yA8z6r8ctftWYy2k67eXYs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-jyags1FjNaKfzVAOll4upw-1; Mon,
 11 Aug 2025 05:23:58 -0400
X-MC-Unique: jyags1FjNaKfzVAOll4upw-1
X-Mimecast-MFC-AGG-ID: jyags1FjNaKfzVAOll4upw_1754904238
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF1BA19560AF;
	Mon, 11 Aug 2025 09:23:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.95])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DBD2300145E;
	Mon, 11 Aug 2025 09:23:56 +0000 (UTC)
Date: Mon, 11 Aug 2025 11:23:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH 1/4] chrt: produce better error message for missing
 priority with implied -r
Message-ID: <pzovsu5w3djfulmmsr44hdv5xjbupyev53hkscodyrplpgmyjf@qjb7lg3epi4m>
References: <20250805092443.5847-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805092443.5847-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Aug 05, 2025 at 11:24:40AM +0200, Benno Schulenberg wrote:
>  schedutils/chrt.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied (all 4 patches), thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

