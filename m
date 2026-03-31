Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85720B810
	for <util-linux@vger.kernel.org>; Tue, 31 Mar 2026 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951404; cv=none; b=X+nIsmCPcBpynm7tBNgNwlMzumhHlhfR0nkquLyw9Kq10RCA6vCI/U4IqSh/suQ7B9A3anOJ5zoDQD66w3VvmlYGI8no3gVTThRhbdb2HnYjpHWeB/kVVcbcwtvRxXo451N8cXa9UPOpueZNsRRuTTN/j/f6jrxbUDKxGxi16BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951404; c=relaxed/simple;
	bh=OIxwXeW+x5Zw6w1FfettZVp6iuUwycl6wbIRyKUv6nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmW0c7www+jC7cLI+BFtDSdJNSGG6okpC49SfLVJybFjApMeJJkWeqy0Avg52rUwoVDqneDA5FeYV6r53G56BZHDRdqsES5TRlwdhZb/rhtQqaWOQthCx+ULP94CWRf8M74AmGkNFHWFwfR5oIr6OAkpHsAAIR+dl1RaT59Y3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7naESr2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7naESr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774951402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3aIS730K2vvSSqWDprm1DmJpiVg5G8WPHq8U5SOwpsk=;
	b=g7naESr2ImTsXwJ4qKLbmQgZqaHVnHThwOPsffXmEeqJo6vLHIlmFd6i3xUw+XYjLuT1hJ
	2H45GWMbv5rc1MQUMJisDqP0ezsboJCdi0k3SRpSrbvF3q5dadDR+zXEYvnmDSY8jFEqgS
	aail91nINtG+W3rkXDJGz1wayUy9MGA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-1hAQLTivMtCcInVpP13KOQ-1; Tue,
 31 Mar 2026 06:03:18 -0400
X-MC-Unique: 1hAQLTivMtCcInVpP13KOQ-1
X-Mimecast-MFC-AGG-ID: 1hAQLTivMtCcInVpP13KOQ_1774951397
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14A9218002C8;
	Tue, 31 Mar 2026 10:03:17 +0000 (UTC)
Received: from ws.localdomain (unknown [10.44.49.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2261180036E;
	Tue, 31 Mar 2026 10:03:15 +0000 (UTC)
Date: Tue, 31 Mar 2026 12:03:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Pedro Albuquerque <pmra@protonmail.com>
Subject: Re: [PATCH] blkpr: fix a typo ("sp:ec" => "spec"), and drop an
 overemphatic comma
Message-ID: <k3xfzqw7ffrurcnwgqu7zct353jsxnr4yaahw2kdfk3uap5k3u@je2orp4r4qhj>
References: <20260330142551.3706-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330142551.3706-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Mar 30, 2026 at 04:25:51PM +0200, Benno Schulenberg wrote:
>  sys-utils/blkpr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

