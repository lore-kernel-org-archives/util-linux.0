Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792933BBAE
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969307; cv=none; b=enfMELACbPQOA/s2qVF+vxJMCj88KvfzsCeuJWyFJ1eg8xVFUKdNkY0T5wZ4hgAnRp9O6BSbpn3QomVPSx2aNplP1wjcslQFzqQfFN+/av4CqOLOLg1Qx0pvUEyBG9OCW8O2Qm5t2Wx84GmWICEiLdyz+YXN9DZvHWRXHJ9KaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969307; c=relaxed/simple;
	bh=ElmdVDru2temBYMMX1k4FwddRlpVkvfU4w4Mg/Bxuv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juf6fm3dATNHFZOylDnlsc/xIELEo51LjYXWcNuypHNKFjXIM/jE4ihgVkIbvhj1/nPKCSODPKgLuwGLGFQ4hbD6LX5an1e+fivxM6teInp78cA9S6MKvOCTVBUwDcG4vXDK9q8v8nbpsB3W/I5eAqj0Jp/WQnDu3mpXsipyN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAmi2WA2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAmi2WA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765969301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTNyjL9jECTgqjbt4jKN1+QDgOv89vVRl+0vrZS8kss=;
	b=HAmi2WA2IhVI/Dn6YnggTMRj6P3vIF5nTgNsfBzlTPQap+s+l07Kac8jYi9teQOXVlEVj8
	GaGZ9gNeG5d9HKk144dpgUly6Itmi35jXoWY+0r0MiXGlmI0EQaYwcQrhhamldnsK7TdwP
	WjgklulWdYtMrPJc0+fK2QpowBOi2s8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633--vLmAplpNSSzndjTrucPaw-1; Wed,
 17 Dec 2025 06:01:38 -0500
X-MC-Unique: -vLmAplpNSSzndjTrucPaw-1
X-Mimecast-MFC-AGG-ID: -vLmAplpNSSzndjTrucPaw_1765969297
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44C861955F04;
	Wed, 17 Dec 2025 11:01:37 +0000 (UTC)
Received: from ws (unknown [10.45.242.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6154930001A2;
	Wed, 17 Dec 2025 11:01:36 +0000 (UTC)
Date: Wed, 17 Dec 2025 12:01:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Kiran Rangoon <kiranrangoon0@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libuuid: Fix pre-1970 UUID v1 timestamp wraparound
Message-ID: <sjpjsmdarsoo2vkllsd34fg26jzn543phdxomqzhubncpso7kl@hn2rx4rx3g73>
References: <20251213200410.31256-1-kiranrangoon0@gmail.com>
 <20251214010108.29535-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214010108.29535-1-kiranrangoon0@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Dec 13, 2025 at 08:01:08PM -0500, Kiran Rangoon wrote:
>  libuuid/src/uuid_time.c       | 15 +++++++++++----
>  tests/expected/uuid/uuidparse |  2 +-
>  2 files changed, 12 insertions(+), 5 deletions(-)

Submitted as a pull request to https://github.com/util-linux/util-linux/pull/3911
for CI testing.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

