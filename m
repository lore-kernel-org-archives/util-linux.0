Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10E243370
	for <util-linux@vger.kernel.org>; Wed,  2 Jul 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447599; cv=none; b=bQx9syonnAEQOVmF9TYrsBVzWKLSV4HomMsHyOQ9Qgd7N32PjkEoRyNC1+hYh9RA1LlIBdUakuMPxiQSms+WGkAAVOUv9AH5H3fNFQVK+XIKM6mFXujnJL8bEvSxGDJs+SHjXK8PSIEaHgqIbh+MxAUAd8GOTDu8HpI8c5m1xds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447599; c=relaxed/simple;
	bh=UxbPUP0CxIQy83z5J5zfmOqGmIP9bFSwt69xO6bCu7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gxm+B98IzT46vQbAi76+xiEdponRwtyCUS5gJAXHLDuRGCP7vO01mdCShp/vNOI00SYgX4m/HZ4qKpZgkChqJ2X6YPxjtCbhnqoPpQ6Zl4jJF9hWsWTiplPOXmrvmU6DmJXuGDbZi3qVKrnQudyCCCrSceJBiumWcWnGLKOOHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZu3G/t3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZu3G/t3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751447597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXoLHbtFWIVWpFCv1h7cx2I8g0pLgQhJumw1cxxL6NA=;
	b=aZu3G/t3wLQ1u4b08fmIZSDqJGLJUPj3jczitcy7g+ecV89CK7hsRrxEnLM1mq85kKXici
	dnJQKYdCTPUwJkGXEMaSGQbghL9Ajng3Pzv7y7oJCVcTRLLSJjkh2a7nBjsi3hxF06ilnQ
	QNtW3uZAW5mS4NmUZLSSNfrUX+UIhlk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-05gwwIuKNMO7hA9ktmckJw-1; Wed,
 02 Jul 2025 05:13:14 -0400
X-MC-Unique: 05gwwIuKNMO7hA9ktmckJw-1
X-Mimecast-MFC-AGG-ID: 05gwwIuKNMO7hA9ktmckJw_1751447593
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6E7F193F05D;
	Wed,  2 Jul 2025 09:13:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB1B9180035C;
	Wed,  2 Jul 2025 09:13:12 +0000 (UTC)
Date: Wed, 2 Jul 2025 11:13:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Jesse Rosenstock <jmr@google.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] man: Replace RETURN VALUE with EXIT STATUS in section 1
Message-ID: <5tdfrwsxwos4j7lvvqlr3j6zmwr5oyrhrj6vc5fk2o3mclnjkn@wkx44lh735qc>
References: <CAMZQ0rKb4J1LqtQ_vYbCi7sBvD9pp-jQpcmwzeY2y=vFDCLgPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZQ0rKb4J1LqtQ_vYbCi7sBvD9pp-jQpcmwzeY2y=vFDCLgPw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Jun 30, 2025 at 08:59:55PM +0200, Jesse Rosenstock wrote:
>  schedutils/coresched.1.adoc | 2 +-
>  schedutils/taskset.1.adoc   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied (from github), thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

