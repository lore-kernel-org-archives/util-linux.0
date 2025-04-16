Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2522D4F9
	for <util-linux@vger.kernel.org>; Wed, 16 Apr 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791805; cv=none; b=FyIb85fMak7qCVILvDJVR1OUpqAfffUgYD6exKmwu/rnT6SUtJy1v3J8khaY5HJQNHEaQvcPQ8py4vFvkBrQWAwoDqr1QV5kr+gJ46DErnyCN9E9iX079ULYU28FayfkN87yQhTQF/MvrZQQ/noOjU91lpSPvpMrulSNSXhcJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791805; c=relaxed/simple;
	bh=4+xLhchAwbAOzxRZvIcneHMim85p9u3Fi64NkegLBkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+gxxtzOmrcEyOgpUJdu/Q/gGdq//t0RO/Dy8/AYUhPn+GM61fcamCyvJVkMvYO7HcZMKiJsqqyZtS7gEfM7E4nSa+ev2BKdq80LzSf+kdk9T1t29JYxnp9aTcW0LD4TWOCBFAQtgmucuwy5HOw1mJTf93zhRWMYNsu1ZTwsy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNN90wU7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNN90wU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744791802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sta20o3a+nv9YtlaPkwsnq2cQehjLM1B0FMm8di7mrE=;
	b=VNN90wU7GaA8JaICJhBIYF56c3ma5C+GgvXQqX6diTz9zkfMJ6125AIS7P3j/EBDsN01AV
	/J5Km3jqPQvgawpJdWF2Fh2FDl+umsiyboWb0UfhyU6ZgmlxNmObtAD7yMGHxQXCzDNzvh
	403nKPag/cqcLemvHEU5KTzVKqao46k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-QaRknHj7N4W0SCC80Kt9wQ-1; Wed,
 16 Apr 2025 04:23:16 -0400
X-MC-Unique: QaRknHj7N4W0SCC80Kt9wQ-1
X-Mimecast-MFC-AGG-ID: QaRknHj7N4W0SCC80Kt9wQ_1744791794
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AB0B1955E7D;
	Wed, 16 Apr 2025 08:23:14 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55E021800352;
	Wed, 16 Apr 2025 08:23:12 +0000 (UTC)
Date: Wed, 16 Apr 2025 10:23:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/8] docs: rewrite the description of --bytes, to be
 clearer
Message-ID: <3unejsdlphzx7fuaf6fdpwffojfsjst3cc4cn75odlq3pn26dt@gxc72su4hrga>
References: <20250414094534.9504-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414094534.9504-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 14, 2025 at 11:45:27AM +0200, Benno Schulenberg wrote:
>  man-common/in-bytes.adoc | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied all 8 patches, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

