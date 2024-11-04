Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A07C0BE
	for <util-linux@vger.kernel.org>; Mon,  4 Nov 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722115; cv=none; b=WkG6K76ylfLE+qY5GDP7L7sx5ZZKWLwZEx/JX9zxo1B3RR2Ik+/1zU8yyL43Ub6YEWbhvzNACf5XM6WqiPcR9S8GyRSoIAamSlJvvP2H+H63aZTjQqhzLn4SkP3e1Nlk3ePbC3j8I2hmeRQPQ3a3QTKI1+gL+eGP34QpnCGvbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722115; c=relaxed/simple;
	bh=A8V/dist4bozv3uByE75kbJT8nh7wtWAy8HuJXA9Su0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APQVpr8zWT7hRi6yGUhAkSkG4jGNHWE8yICAJx3wXogcLAZhyX+MWifDRHBvMfxCQ/xW7PGzfRbw7awGoqUdOHseJNY54NYKA8B//nNfvFLHQyzreRaIx6rxb2py4GmvH9Uq5RRVVNDQFs4ichxSq2O/E/JDVX3rgtM29IVqam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NERtBorS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NERtBorS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730722112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G43zUAPZBMyLGBvuAMHykuyWCj60VuJIBlWF6NZWmpo=;
	b=NERtBorSruoPamOt1c2OwZMCdG8rpBjIukc8NwmcXkoWK3MFcCTL1RjjW2oWNS6x9EzVyo
	66qB222jtl819GXqkcwu+oYWaD+Sd3eGA2sBPoYe4dQRYmQBrmk5wO8rtByFsoikOomVIq
	9Q1lVWKrEaI2afzqRjM7gUCogNYoHVw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122--yUWNQXxMuKgFZjIcie0dw-1; Mon,
 04 Nov 2024 07:08:29 -0500
X-MC-Unique: -yUWNQXxMuKgFZjIcie0dw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 356EA1955F0B;
	Mon,  4 Nov 2024 12:08:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.59])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B827300018D;
	Mon,  4 Nov 2024 12:08:26 +0000 (UTC)
Date: Mon, 4 Nov 2024 13:08:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Anjali K <anjalik@linux.ibm.com>
Cc: util-linux@vger.kernel.org, anushree.mathur@linux.ibm.com
Subject: Re: [PATCH v2] lscpu: fix incorrect number of sockets during hotplug
Message-ID: <ri2g2km4okmry3o3zl3iglu3tjokr7wawm774odyybnsgmhixj@xfttusguf7sr>
References: <20241104063226.172077-1-anjalik@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104063226.172077-1-anjalik@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


Thank you, it looks good. I made some cosmetic changes to the patch
and created a pull request to run it through CI tests on GitHub.

 https://github.com/util-linux/util-linux/pull/3265

 Thanks!

On Mon, Nov 04, 2024 at 12:02:26PM GMT, Anjali K wrote:
>  sys-utils/lscpu-topology.c | 71 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 7 deletions(-)
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

