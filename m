Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE57F48C
	for <util-linux@vger.kernel.org>; Wed, 19 Jun 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793839; cv=none; b=qu98ZJOomZCcmpveeCht02UOnwoNqwtfnXot8ujQcmQHinYG6MjRn2YfST70frl01Ceuj4cI1cgeZjZrIeinQRcflEr51VvJQdNFJFCDqp/myCDwOO8MZjvJCW0O8Q0nCMJJZDZBAzBxq+RGAXZDxssNzsXuUUqFaYR10vuXe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793839; c=relaxed/simple;
	bh=ocPZHL8ZAxM7LG7KK5BNC9hAqfsGEBJgN3soPmgkQO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7n6z0G46dBwA+XdESA2YYHEA+LikfQbe5NbSSpxm0MjVwZOXgjVwjFCCEn8kXeClUtiug3LLR0RIPIqkzteCxOoZ9lUQfvoCtK1ZemO1EovPCGLztUE+ZvAL42jITL8QlRv/eNAnTtUxE5Y70gpjMXkAhaHP8Um2WGRxcCRCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5sasHGy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5sasHGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718793837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TnMScOhz4qYvTS4cE6Nk+vX82f/lNwXsV11kV+iWbPI=;
	b=Y5sasHGyjBE5biJCczjhscuMMTzEklHaVuPilhQv3l2lQ6/wC5ejNTJSyobRnEPkWxlv5W
	yrVYraAbQBTp+Xa3kmcyE2AMLoiL+L9MrLJgMCzikEyOjj+KZ/HL2MhAI73sbo4Y1TVppt
	WTc7sk95tgxVyLs6zFhMU94O2CQz37Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-YrKfxy2YMoeC5-3QasaCBw-1; Wed,
 19 Jun 2024 06:43:53 -0400
X-MC-Unique: YrKfxy2YMoeC5-3QasaCBw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04CC519560AF;
	Wed, 19 Jun 2024 10:43:53 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.185])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08BDE3000218;
	Wed, 19 Jun 2024 10:43:51 +0000 (UTC)
Date: Wed, 19 Jun 2024 12:43:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v3 0/2] unshare: manage binfmt_misc mounts
Message-ID: <20240619104348.rp4v7ljkadt343ng@ws.net.home>
References: <20240619081951.656640-1-laurent@vivier.eu>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619081951.656640-1-laurent@vivier.eu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Jun 19, 2024 at 10:19:49AM +0200, Laurent Vivier wrote:
>  include/pathnames.h      |  1 +
>  sys-utils/unshare.1.adoc | 21 ++++++++++++
>  sys-utils/unshare.c      | 71 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 92 insertions(+), 1 deletion(-)

Looks good, thank you. I will merge it once the changes in
https://github.com/util-linux/util-linux/pull/3094 pass our CI.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

