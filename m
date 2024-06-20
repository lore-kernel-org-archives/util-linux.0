Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34311A8C04
	for <util-linux@vger.kernel.org>; Thu, 20 Jun 2024 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879088; cv=none; b=Y7FtIS+EV9xvCMhr5IhRijsl+SsK8cQ4nUsW7Q+m6NZOGNk9T+lQJuatFBut+0btzv0macXBKBQIoCUXYZO2ykwIeQ/O398SBF6oucYwPmEV09p+AbDh5OVvNpXagWLG6ixJRzNAVnm9PYpV0CcJonM3m6RG0SMZGP/DAPwbxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879088; c=relaxed/simple;
	bh=D9cyK+4Fbcxx3NCCQUAj6HU4/B5S4cNuVnPGC6rq10Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7G83W9FVFTozBNI0wz8Ufufm3Lejrx8Fmsxvx10GTJc0NUZKSeg+eQ5wSYRKBQgPD8NxR7T8SR/Oa5yKj03OU1olYbAxfF5yqkIwrAeHM5KnFxAvmA+0xd1hQRvQyyIZ4Q3eEIECmki7lqLTGAf/V/NdGqb2B2ALvR7lfpy5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TS7CS3RN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TS7CS3RN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718879085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s7Wetc+wFmcz3m5dtcLCCH2rH90NlKbJuN/BLMQ4ePs=;
	b=TS7CS3RNEOqeZViLOMCSVRO4+vzXVpvPqVc/XBVKHt9pY0UsT5GWd+Dm+UH/wogB7qHFGE
	dZsDPPZTm5F9ic/NH5f548EMBI03FNMbyN9+JJeEJGuvAdojnRpXcDyh6nFysWE9G5OFax
	eMXuPTGb6jYgEFAxHcoNXrpjmW/0qfQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-HSTE9fUxPyKXn8CObbg79w-1; Thu,
 20 Jun 2024 06:24:44 -0400
X-MC-Unique: HSTE9fUxPyKXn8CObbg79w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84A7319560B2;
	Thu, 20 Jun 2024 10:24:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.185])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 823371956087;
	Thu, 20 Jun 2024 10:24:42 +0000 (UTC)
Date: Thu, 20 Jun 2024 12:24:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] umount, losetup: Document loop destroy behavior
Message-ID: <wcxx6ceghwtv5ocbr3w7uuipy4zah6yftunicvvvanovaah5nz@dqporrr2rjiu>
References: <20240619153133.4628-2-sbrabec@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619153133.4628-2-sbrabec@suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jun 19, 2024 at 05:31:34PM GMT, Stanislav Brabec wrote:
>  sys-utils/losetup.8.adoc | 2 +-
>  sys-utils/umount.8.adoc  | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

 Applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

