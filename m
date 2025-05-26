Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D678335BA
	for <util-linux@vger.kernel.org>; Mon, 26 May 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748280644; cv=none; b=ZqCWxZSxnbdlZV+nTsmk4YidYpvjebFfMMCaf6YPaGJ/U8qwKhiI+ecupBn81icKmik9R0vnAFIxZ6ntoqDVylYP3rldSvBPZsK8GVj0dJzouGY6MEYoaaSXcjoGDl5fVeJmndls25QWA6RN27qpTX5/P3LdYt5RG1zcDdy6UPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748280644; c=relaxed/simple;
	bh=mytdSUhdqw1Gpow+GT42gPKqDbwMc4Wk/iyWykunILM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMb55pcHF3XEIbac2DIhWyW7FvmxUaTS6+2uLk0ab95fyt2jlfEKuY9owaC0m4ra63RVAnwgxAfkO0GHExVWZ0WWn+zJ5RYB9FV8yu8f+Z4ugET/TjJ0OfxtD5DPEmK+7fLub+Md5cotSKAeB0ynCVOXM6tTubKPkrESskybHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmL7nbrV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmL7nbrV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748280640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2NedIUPLJplaIGUGZnvK9IQW0m/9dCiPOLhTg70hAY=;
	b=hmL7nbrVvNVpHvKIEdHnU7+9+kOQeU54h4t92nHgj+AU3PhG/8fPXUfjUc9nBdw+9cM966
	PqtPqmdZhu/8H6gteCARwAXmMqBqCIycEB3S4Sho/NZfFD9uSsO0aTnygf7wd08kQZb5HS
	BEYOP43qIdiSav31OHMFCVWezfIqfLk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-znwgIVaON9u2eciPfsi1RA-1; Mon,
 26 May 2025 13:30:37 -0400
X-MC-Unique: znwgIVaON9u2eciPfsi1RA-1
X-Mimecast-MFC-AGG-ID: znwgIVaON9u2eciPfsi1RA_1748280636
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 330CA1956095;
	Mon, 26 May 2025 17:30:36 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.54])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1EB81956095;
	Mon, 26 May 2025 17:30:34 +0000 (UTC)
Date: Mon, 26 May 2025 19:30:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] hardlink: (usage) improve the descriptions of three
 options
Message-ID: <ob2ygbs5oa5ygs6b7t6llxqam6lihvdgtu7cfyhch3zo6kssk5@tqhazyfgl5xx>
References: <20250523120407.75188-1-bensberg@telfort.nl>
 <20250523120407.75188-3-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523120407.75188-3-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, May 23, 2025 at 02:04:06PM +0200, Benno Schulenberg wrote:
> (Note: the choice for -m for --maximize and -M for --minimize is
> unfortunate, as most people would guess the opposite, especially
> since -s is used for --minimum-size and -S for --maximum-size.)

Long history: it originates from the Debian hardlink implementation
(13 years ago), and it seems that the origin is from a previous version
implemented in Python (the original patch is missing).

https://salsa.debian.org/jak/hardlink/-/commit/bc0a8d544e3866a6ba62ea5f1bf7b8da6e616c11

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

