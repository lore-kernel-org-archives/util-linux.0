Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1321B9DB
	for <util-linux@vger.kernel.org>; Wed,  2 Jul 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443440; cv=none; b=sZB8TA3GfhQbi21JdGGDX54bjfygrNB8x33WX5/qvMpsSRzB3SdcuoXn8QKcIrBdkPpV5uWyvtx4HFCr11lEczT0TcyJBZItjN0bDdeM2gdbupADD1UZvaRYYIf/6StQFigu3na3p/B7kerkP72CRVTxADHv7Yq6WsPKv31HgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443440; c=relaxed/simple;
	bh=5VOD1EYTGVbv7ZP1jkD/HyMa3rTtpiyNAloSrdoyB/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdUmfFYwzsihvEw8OyJLwV6VlGIwWm7wLx1z/xykxxlTaFFsW/xj5bDe4PtJl4F83d7GjdRwLQciApo0/dK+cocTUzarjctFZxWA8dg9zMFEJ33jEkObHblhjrvRlDThcZe+QUMSVraFrbfaKSxs0+Kxw/CcgWhZ7RCKAmP/uvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVHsUmTa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVHsUmTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751443437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rLgd+M2G6HYruNkx+ZCBEOAwqobDJvOrC4vjVptUcI=;
	b=SVHsUmTazN8NiSFRyZ3C1PCrk+1+Yh1s0mYe1PyM536OT+DgyUIP52+UiutmThVcw3O4i3
	2xf9Ae4MjEN2eQuaBghw6XUup/oMoYwHNSVL8Hv2C1TlM50nTHBnGtPxAHoh2q9d5axfdd
	+YEqDN/yhfvx6+UC7EX+kI0rXBka6rQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-XQd4_IymNuaZ1Lgkwj7B_Q-1; Wed,
 02 Jul 2025 04:03:56 -0400
X-MC-Unique: XQd4_IymNuaZ1Lgkwj7B_Q-1
X-Mimecast-MFC-AGG-ID: XQd4_IymNuaZ1Lgkwj7B_Q_1751443435
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46D221800368;
	Wed,  2 Jul 2025 08:03:50 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 559F619560A7;
	Wed,  2 Jul 2025 08:03:42 +0000 (UTC)
Date: Wed, 2 Jul 2025 10:03:39 +0200
From: Karel Zak <kzak@redhat.com>
To: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] rename: change "expression" to "substring"
Message-ID: <z4dooqsx5t5yl5q3hron5tjm6hmcgxdeehdhhnm7vjrwxx637l@kw3eczmgqugr>
References: <20250621232642.17613-2-contact@hacktivis.me>
 <20250701160139.24110-1-contact@hacktivis.me>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701160139.24110-1-contact@hacktivis.me>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jul 01, 2025 at 06:01:05PM +0200, Haelwenn (lanodan) Monnier wrote:
>  misc-utils/rename.1.adoc | 12 ++++++------
>  misc-utils/rename.c      |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

