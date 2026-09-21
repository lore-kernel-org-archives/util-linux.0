Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854649B1F9
	for <util-linux@vger.kernel.org>; Mon, 21 Sep 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997143; cv=none; b=ZvEtvxcqHH4KTCyJBqHGkIw7gLbwCF9BFgrzclyuQaLsnHflj3dHar3lycoytBuQUeFAXHs3tL5AUDaLv5hieicRcj9ba9W3CHmqQJ9ddKARpMH2cliFiLYxD9Pdq7nn8IzDrtxMBw3fSDl79HWmuiPjpeBGbo42IlcIvLm/Yx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997143; c=relaxed/simple;
	bh=pUadWtAzUqkUZDyIXMyUcXGrIB5JYwWovPczJLvkmN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOwaSXdCWkUstBLN73j6Yv+D9H3aL8Xmtk2FWHIdutYwwWNwvzYLgfLDORbwS1leKRB0+3Rv47Ub5krm5gA/uVnghvnv6F0ZtZVQu0/HXZo/YLpgb5sUbe1+fF8CFBMupzmjJCoJuxjmEhuZajtCQ4tVuIeKn2BCM1zQgo6bM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxCDQR8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxCDQR8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789997141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgpIf9L/Jra7VXRI8UHMivD+gQu+MA4vZbVDf5f63A4=;
	b=gxCDQR8pywJjFxYF+qpK0BrtCPAcCMSa1Tol57EH7WmCRuA+Wf4ISAAihd50wD3Rmtyqk6
	8o/uHarTw8G0FtKIqOMKxJEOmkSGnlxQaDmrf1Bh9l43kfRJ7MPuC3V7I75t6BwN7OeTgj
	1LAz7iZ0jwjRSzbHxG80G/H4vm94tvU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-N00EryRAPPCbdPJIGqSOoA-1; Mon,
 21 Sep 2026 09:25:39 -0400
X-MC-Unique: N00EryRAPPCbdPJIGqSOoA-1
X-Mimecast-MFC-AGG-ID: N00EryRAPPCbdPJIGqSOoA_1789997138
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75CD018345A9;
	Mon, 21 Sep 2026 13:25:38 +0000 (UTC)
Received: from ws (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B3D9180036E;
	Mon, 21 Sep 2026 13:25:37 +0000 (UTC)
Date: Mon, 21 Sep 2026 15:25:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Tianyi Chen <hi@tychen.cc>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: support explicit loop direct I/O requests
Message-ID: <zlt4jkxzw6rn6h4zyv6nppro6grujyzsklknfgzcam3anjicmf@uv5iw2n65hwn>
References: <20260921073613.99690-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921073613.99690-1-hi@tychen.cc>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Sep 21, 2026 at 04:36:13PM +0900, Tianyi Chen wrote:
>  libmount/src/hook_loopdev.c         | 27 ++++++++-
>  sys-utils/mount.8.adoc              | 10 +++-
>  tests/expected/mount/loop-direct-io |  6 ++
>  tests/ts/mount/loop-direct-io       | 91 +++++++++++++++++++++++++++++
>  4 files changed, 132 insertions(+), 2 deletions(-)
>  create mode 100644 tests/expected/mount/loop-direct-io
>  create mode 100755 tests/ts/mount/loop-direct-io

Created https://github.com/util-linux/util-linux/pull/4646 to test it
by CI and for review. Thanks.

> +	if (hd && hd->reused)
> +		return 0;

This is a good catch!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

