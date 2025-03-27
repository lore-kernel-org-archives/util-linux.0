Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB046211460
	for <util-linux@vger.kernel.org>; Thu, 27 Mar 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069272; cv=none; b=prGJIeKKd6TeTMHQpRaOhWhY6Tkb3p3I53lrVRn444zo4YXRyXOm8KS9lUSehwa7lWSIjVo/7UsD3ynR/44Zj7vvITfRq11RIaaI1ugOvmMEzzZSbPsZNGLjt+Mu7bYrYbdm4U2JryjWjiTgcxlR+w6KfvlDEFD8ISQD97UjTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069272; c=relaxed/simple;
	bh=3wLaexQIpN98pcwOR82c/iiGeEfV53ZDYk3/F8AGpU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAnCky7rRkABYg0IaE74Yf5Yt/Ix4rH1eIQpnkCocNeq9ZSmobnKS9hoodfj8ma577yKiflalde+BRL8WUxKU5pS+55p5g91EZMbflIvrw23ts0HFl7VXW8oeFOvDGCfJOIGdfv1q5kYLHOgA7IvlOQfRYWsNUY4REgP60ftphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O//SXcIo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O//SXcIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLV7NlLW0FfK0KXF214WFAZP1Nfaeqpsw3MjQ5mXPbs=;
	b=O//SXcIoPFH/vILbRflkoR9BCGio/w0nEXbgtvE+xdXhUx74ISukSd/ZYgs8kZxWSxYYum
	+AHevVXAe/5IcIyzjaSpo6U+6W/wrBwTATionpFM4t6w2C0TLjC2CumUbiD3RhKClgfxTg
	pzfb1V7f7930Hm0bRQlCdH0Py6oQb9U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-mQX3xzZ5O2q5AwE4BHtAsA-1; Thu,
 27 Mar 2025 05:54:28 -0400
X-MC-Unique: mQX3xzZ5O2q5AwE4BHtAsA-1
X-Mimecast-MFC-AGG-ID: mQX3xzZ5O2q5AwE4BHtAsA_1743069267
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B5181933B50;
	Thu, 27 Mar 2025 09:54:27 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FCDE1801750;
	Thu, 27 Mar 2025 09:54:25 +0000 (UTC)
Date: Thu, 27 Mar 2025 10:54:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/11] ipcrm: move a constant argument in order to
 gettextize the message
Message-ID: <mmdq7y7gorsjsds4zqmjpjvsdcxxryho4k5rcpkksbjcm2midp@464h6xttsbr5>
References: <20250325104305.23980-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325104305.23980-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 25, 2025 at 11:42:55AM +0100, Benno Schulenberg wrote:
>  sys-utils/ipcrm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied (all 11 patches), thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

