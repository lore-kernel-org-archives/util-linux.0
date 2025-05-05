Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC51A2C25
	for <util-linux@vger.kernel.org>; Mon,  5 May 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451361; cv=none; b=E2fOPW0kcXYiXUqT4OsxLE/wnoq/4b670Cr0Zwy1udlL21IsIl/v+LxfbK3OnNNFf+Gkm1V7nUyhjkX1V6cH/ua9mTGFSi8OslSWRvQ5ySOJvueYMKHctpHvk4JbfVH9hu1BJIL5m9PFas4tATSINUoQzlRi8kDtNnEDNcR7rJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451361; c=relaxed/simple;
	bh=mlCtd9WyotRxllEJMrgZfNx9rGJ+GFdqPUyaPI6wVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaE800wdbNITnXM61X9sV1MqRroWwezL0rHHAj/0NojaqxwAISUKkaPGK1jMmgWMQ2annJoL3nYar/mRgW+nVvCDJw/naeiFSJ4UKqqhYal1OCJtDnOTbMAynaXrvEBAvtmbOO0uKh4EeQxZ3h+uVgF2t4qdkWxyl79qFG1QdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyZukdq2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyZukdq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746451358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0s4mxWt253CF7dYV/7Yw2pd0Gcf/aXZrk32uN2molE=;
	b=YyZukdq20xvUjkorB4/4A9HiJl3Q9YkUlO7JoCXGMbFSGBjtY9aOQbcInZ48agF5tOobhV
	ud37SH0PNg0gZt95IDAJK7RDMUKxuy4qw4uZKtTlj9ma6dpH0+U3TeK2xsJFx7uE8Xu5DC
	Mmo6K7cEyM6VfoLgPTp4m/tq0sygBD0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-0yvxuaJBPmiEj8DyvyUWnw-1; Mon,
 05 May 2025 09:22:35 -0400
X-MC-Unique: 0yvxuaJBPmiEj8DyvyUWnw-1
X-Mimecast-MFC-AGG-ID: 0yvxuaJBPmiEj8DyvyUWnw_1746451354
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35F1719560AE;
	Mon,  5 May 2025 13:22:34 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30FDE1800365;
	Mon,  5 May 2025 13:22:32 +0000 (UTC)
Date: Mon, 5 May 2025 15:22:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] bits: only build when cpu_set_t is available
Message-ID: <kysateoru5o2oxcfpql5zcqnx3jokdjdz4farjlwwzukeyjd7k@3zsnw3e2jhw3>
References: <20250501075806.88759-1-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501075806.88759-1-hi@alyssa.is>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, May 01, 2025 at 09:58:06AM +0200, Alyssa Ross wrote:
>  configure.ac | 6 +++++-
>  meson.build  | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

