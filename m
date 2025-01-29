Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176418C31
	for <util-linux@vger.kernel.org>; Wed, 29 Jan 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738153348; cv=none; b=VHV2n1p6AaoFA7rNYUj1194CjU68GE+rPADhx7MpQWP6SntawmfxT4zawH2+eB9gCdzsO4Hn71lhNMhwwecym5QnrCEpbtLwhDt2zyU6DpHd4HMcAhoyi0u8/3jiiITNL7K7idtVFG3qyZm/36mAof5BM7qhiAsA0i4FFtIRQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738153348; c=relaxed/simple;
	bh=ZsxZDueehl4Ib3eUyhS7rizBzsBfT8s7e8ozsyhLTLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV0Mw67DCrQh51FUvH7rgIHzEbsS9l+NLuvFj/y7ytW20r/E247hkcYDlM0YnQ+tkXdCYDQMadU+ceht1CIslGVEuwh92d9Q76A8SEMdzeKaOcqzDFw/BKXAbfeXCiBGkw6wW8qVVyxlGlNgzLcMBCU3ucnabnidQJL47kqGqFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=il53v+Cl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="il53v+Cl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738153345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/s24UcRLTnEzRq0ph2RjJ51iVDXK153WM3IWi7QfHCQ=;
	b=il53v+ClQtLfag9fpli9JREXTiDNl5hJRrSombpaRtOCKoJiNmGgabL4F5NZp8p6XNeTB1
	iQTyn9Jz9cDSEFwYPgW2x/1rbaqAQ9TZZFFLEXjNQHCpD+BP63jpvMf4zGHxi/XPbkFPTt
	a0Y97GkfNdYW4Orh0ODVMMMToFDwP1A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453--Ed9APE_NWO2T4FZpVulGA-1; Wed,
 29 Jan 2025 07:22:22 -0500
X-MC-Unique: -Ed9APE_NWO2T4FZpVulGA-1
X-Mimecast-MFC-AGG-ID: -Ed9APE_NWO2T4FZpVulGA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CF8A1800370;
	Wed, 29 Jan 2025 12:22:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9FBB18008E4;
	Wed, 29 Jan 2025 12:22:19 +0000 (UTC)
Date: Wed, 29 Jan 2025 13:22:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: make three column descriptions more grammatical
Message-ID: <auzom7cajj3orgytlo7d4d3mtvy5xzpdi5yvhxfp34wr3g74eg@h7x7kw6uwek4>
References: <20250126110924.5611-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126110924.5611-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Jan 26, 2025 at 12:09:24PM GMT, Benno Schulenberg wrote:
>  sys-utils/lscpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

