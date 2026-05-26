Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5FE3A874B
	for <util-linux@vger.kernel.org>; Tue, 26 May 2026 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811239; cv=none; b=WfJzP+dj9zrNh7U4H7GitvJXBI8oH7onTcRIgZEJLggqyQ2eL0E71MU4pBc1gt957AFtPkvCatlF6c1uwO/L20A+ObA9aLpcV8Mxe8+HEMW0LGffDgdNkvShlUpd2f4FEBHpOnE0vHCRY/43hKGD72dmXHV8En1mcai6PYG1z2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811239; c=relaxed/simple;
	bh=JYCIrKst6ZLSKaLeBFBzxnDeHMzPwp65lRPFZ7r7auQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA5mQYFp5g0aUIReJUt58vd6UXqg/WC1BpbRmxVvBk8lJb5Wsollp57Qk4URq2MGXWk0hQ75rwZMsRuvP+Ue5RQ/Y9xAad30ktcvet+tKw6jKrQ09eXBvDld5AMknlX9aqj/BVs/0zjMZwMBrEfRjnW5DyLj1v4acJA46zOjyH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goeXKdK8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goeXKdK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779811237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aa+zlvWYA8QVvyYxTxGnVJhUMYseXWUv4k/9gmBDUcg=;
	b=goeXKdK8PnbMOSPQ3TZrTJ+RQELY41JUUVMlrHxPbTNZf9AiF7016ThLW4VcO1SVveE0rI
	t80CJYlQ0nLd8mMwHgwcAc75Q2bh5ndV9uiCGfylIPpbepS7Sd2xim/huUnz70jeSX/seR
	qHnStePZHIvfySGEuVaSJGODVo8r7ec=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-EJoeNbnPMyu6pW3tnMyPrw-1; Tue,
 26 May 2026 12:00:35 -0400
X-MC-Unique: EJoeNbnPMyu6pW3tnMyPrw-1
X-Mimecast-MFC-AGG-ID: EJoeNbnPMyu6pW3tnMyPrw_1779811232
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01D1418005BA
	for <util-linux@vger.kernel.org>; Tue, 26 May 2026 16:00:32 +0000 (UTC)
Received: from ws (unknown [10.44.33.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20B2A300019F;
	Tue, 26 May 2026 16:00:30 +0000 (UTC)
Date: Tue, 26 May 2026 18:00:28 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: Repost: [PATCH] Secure login and sulogin on S390x
Message-ID: <eapscxbug6aosaxj7z2i4a66hsg6h7kateta72oq6dd6o43cae@xxvcyjnrow5i>
References: <20260429092825.17623-2-werner@suse.de>
 <afjqh57bXkLJ_FKr@zeha.at>
 <afm64TLjowwedG4l@boole.nue2.suse.org>
 <ag7Mi1xhgyHjWhNn@boole.nue2.suse.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag7Mi1xhgyHjWhNn@boole.nue2.suse.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


Hi Werner,

On Thu, May 21, 2026 at 11:12:39AM +0200, Dr. Werner Fink wrote:
> just to be sure that this change for s390x does not fall down behind.
> Are there some changes required?

Sorry for the delay. I have pushed it to GitHub for CI to check:
https://github.com/util-linux/util-linux/pull/4325. I haven't had time
to work on it further.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

