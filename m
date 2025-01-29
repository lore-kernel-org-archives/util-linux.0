Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97DBE46
	for <util-linux@vger.kernel.org>; Wed, 29 Jan 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738153983; cv=none; b=lZAmBytCf1uEHlNtTaPB8R1KZY4BzkJgC/t/+GQMH0Ed97PIELJwNYKrYD5as7O07WAw0iBxxDOB8QOABbcEjncDp33wKI0Kh6BdyN7RGTAlqv4BxcXMc02W8kFirJa4DPm4bLoU0fSUrjP/sGDrpCiwBu25gOYDdfQkgj03Q48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738153983; c=relaxed/simple;
	bh=F9gLTTNMPCn/K/0+l0w16bWLPW7ouxprd+V9epa7A5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPICIoffaGrfjC+t0SfeLoLqs8xuvxE+k+MoXtdLfedz5C6vHE3/vU1iJzt9eXJ9hh69lEBlsdu11w/WW/7ze4t4pKhtn3OrOsFd2a904r+RC4rYia+W86tC2gT31xxWIeDRPnUFEtJpgag4N07c+lNV2PVyGGzQJhj/hA0Br6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFMSbv1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFMSbv1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738153980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=46HxZGO6jym3X9k7RZEk1HHJqf++waZC3CYH00gHWkI=;
	b=VFMSbv1kVF21xg7AmdDEl7zEl6Mi0nP6hUl4yX1x2JMTeRHUlAOpEEr6UNTsqLb/exlRGB
	iVLHzovDyrEZYR1gV49AyxrjHv32/4zu12amdDjSFA5ViAnZgTY0MGW64nPEypXtzDOm4Z
	cQvuuymvIrACTbfpx3JDZgUy4PMP/u4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-wCtMAP_-M1Se9WMCGi4O9w-1; Wed,
 29 Jan 2025 07:32:59 -0500
X-MC-Unique: wCtMAP_-M1Se9WMCGi4O9w-1
X-Mimecast-MFC-AGG-ID: wCtMAP_-M1Se9WMCGi4O9w
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24AD71800269;
	Wed, 29 Jan 2025 12:32:58 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.106])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 120201800959;
	Wed, 29 Jan 2025 12:32:56 +0000 (UTC)
Date: Wed, 29 Jan 2025 13:32:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: say "override" instead of "overwrite" in the
 --help text
Message-ID: <n24jfxarkw5fyixqu2h54ixl4u5lwnykket2ubre4sjgjhrkzb@ivo4mqdcx6b4>
References: <20250127152144.11446-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127152144.11446-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Jan 27, 2025 at 04:21:44PM GMT, Benno Schulenberg wrote:
>  misc-utils/blkid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

