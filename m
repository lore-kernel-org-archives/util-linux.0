Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217F1EB46
	for <util-linux@vger.kernel.org>; Tue,  9 Apr 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663400; cv=none; b=sthEeekJIQ/qoIdrbpvWQkV+Cfv/uTl1i6lKEF5/vkXlVuOTM5l9AkIIggGAPpaTCpfraLgvq3ttl08jZ6Xe2atezOwsn91DVfg+lMtvZ/H9o331kVMZickWGR62k+n4N7m23iUwZ3IgZIt8Pe91viBMupEg+flc3htrODv4wT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663400; c=relaxed/simple;
	bh=NBkRhal32zrqXtm+KUYuP3OMsxSvCtEFUgEOx29wXJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM2+q0ZWFbB4q+Cc5rjcWjyFBgOjb8E2tYCplPtfSvB9kfB+AY2BXcluiIrZl7Nuy7Ugeluu2MjgDXR4tfIT88j0I1dCmShcP0o2oQmQHojabtj7GVjJjUbvt3gSTEeS88GCQtQeKvwxO6LNMVqGlABmQndhQ4KJlqPR67zs6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPxnAHBi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPxnAHBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712663398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wlCgC8s1sotDKTfQbKMy6ClHgX+vHZNaGHg8oHd7SBg=;
	b=WPxnAHBixsbnRUv9ZBtdjUrKgBAdJzk9dTTzm9UELFzIakrOvuI1FzHuFAigdx25qJAY5C
	HW16ISOPf6ArJSeP1qds2hKDO7bZsSmWZNGLvdZPdcbNb8WG7GsOI5JJMlmOJ+KCyRISe9
	+cshGQdUC+0Pf70KdOjswbd/7eE4X48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-M4xtF-FLO-mYYHbq_iuNvQ-1; Tue, 09 Apr 2024 07:49:56 -0400
X-MC-Unique: M4xtF-FLO-mYYHbq_iuNvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DDDD889AA3;
	Tue,  9 Apr 2024 11:49:56 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A8B7B1121313;
	Tue,  9 Apr 2024 11:49:55 +0000 (UTC)
Date: Tue, 9 Apr 2024 13:49:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] audit-arch.h: add defines for m68k, sh
Message-ID: <20240409114949.lb6wv7hcyso2gtfz@ws.net.home>
References: <20240409083459.346888-1-zeha@debian.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409083459.346888-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Tue, Apr 09, 2024 at 10:34:59AM +0200, Chris Hofstaedtler wrote:
>  include/audit-arch.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

