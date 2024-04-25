Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75614A0A8
	for <util-linux@vger.kernel.org>; Thu, 25 Apr 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053331; cv=none; b=G9wBYCVZt7URcZCp9eNOkDU4NuIyjTwBTl/IdRIM/kt3RWtJ3nvwYqoe9jlDDK1itEMCHxD3PEZl3mhNRthzAmFc96jLcXy4Ai0C+eWE4k6KVbv40rBZmEtdxOrnLFTRHolIRBBtlDB5BskAe+UulUTTtqBA23xDCKAYRekU4OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053331; c=relaxed/simple;
	bh=2tfTwEzy7sYER+xgNhSUaB6lHNpaCBFn42yp1yIl//8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfkMjRKM4Bix4+RyboKRfn80t3PwUdD64e4H4rmpSyzEN4YBGB/m+RJoQGKclHM8Pzy7Z+i/Rl9KYJMNE1X5qYi0qAaO7jLJoAWrv3VbAe3NptvJkF1+sUkzZN5WEHd7pvIJFMRBAH18j5Q/GpFM2Nq7OOxB2afvq1RQVEUzp2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSNb6GP4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSNb6GP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714053328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Miw0L4RUI7OXGqXpaQX5banERuguZZTZZ+s9AjcAA7s=;
	b=cSNb6GP4prpESfaU5dbAclwwpuPVkSq1Va5PUku85M/UBEohhNocPV5KmpVr6uTvbWWIj0
	ElWs14WuxqJQEDA7upFnrnUVhtzZGI3W9Hyp5uoVc0ZfCkfLVJnOzKduiJfdzYpvGQ9qXt
	riS04ssE+Ke2C+ygeN0i9T3UF29s1Ak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-P1pMc7HIOh-oetrSydANbA-1; Thu, 25 Apr 2024 09:55:25 -0400
X-MC-Unique: P1pMc7HIOh-oetrSydANbA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F250B89A7E4;
	Thu, 25 Apr 2024 13:55:24 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 567E8EC686;
	Thu, 25 Apr 2024 13:55:24 +0000 (UTC)
Date: Thu, 25 Apr 2024 15:55:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: util-linux@vger.kernel.org, Masatake YAMATO <yamato@redhat.com>
Subject: Re: [PATCH v2] flock: add support for using fcntl() with open file
 description locks
Message-ID: <20240425135522.hu6wrdwoanresvvi@ws.net.home>
References: <20240423120819.571181-1-rasmus.villemoes@prevas.dk>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423120819.571181-1-rasmus.villemoes@prevas.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Tue, Apr 23, 2024 at 02:08:19PM +0200, Rasmus Villemoes wrote:
>  configure.ac      |  6 ++++
>  meson.build       |  3 ++
>  sys-utils/flock.c | 82 +++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 89 insertions(+), 2 deletions(-)

Thanks, created pull-request to check it by our CI.
https://github.com/util-linux/util-linux/pull/2993

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

