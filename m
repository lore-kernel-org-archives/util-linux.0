Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A50241CB7
	for <util-linux@vger.kernel.org>; Mon, 14 Jul 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494151; cv=none; b=kzydMwqaXiRiSo4th+WgxAr/4AEmRk/VtpLdzLoUEbJLq4jLRox23vmFLs962w51U/7KCOf1qmuEYbVLyAQdEwcWeWI2Hl591MZwQiF+ScNgEfU/GFEbcRhh6P2pe2GWthYa4D4u6rgA+1+vXzAZBEW9vKlHqWLvX5Pj5TGkcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494151; c=relaxed/simple;
	bh=K0SdCtSUjnOoI3Ffk5WshKRV1EroEithORjOE+aDIhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIXrwrgwqQmItrB3v1ohjasCzP3eaR7ERvt82N4M47I8pmztA6aqWjK7+O4g2kjbwzf1jsLsgYFNCuxYd1nA/X6En0XLrWfrp+RC8Esy00M8xitjZzQKQqy9c+xmfU/R80ucQp4oXFpOu4YE3whW4J0RlPCiKr6bgyKXmVUfS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XO3uJPKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XO3uJPKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752494146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIz0tz8U2ch8gBGN4BVSUHQKfsRndFdE53TraQAifkQ=;
	b=XO3uJPKCHznJYRHBUmnkTG3vK0tkRaxGynzkiqAQDYu5wceE9+9RgmD7vBHoPwCOhshx/w
	znJ0qK+zNB/ffYwoUicy8eI2tOIlTutwJCox3sz5oOdL6VbRXeooE+3bq1mZgu4CCwBRr+
	YgVfq/1zRxV3pI/Mv9Dj8Eq9NiRvGBY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-XjmgH_s-PM2Zk0evAD2SPA-1; Mon,
 14 Jul 2025 07:55:40 -0400
X-MC-Unique: XjmgH_s-PM2Zk0evAD2SPA-1
X-Mimecast-MFC-AGG-ID: XjmgH_s-PM2Zk0evAD2SPA_1752494138
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD6651809C88;
	Mon, 14 Jul 2025 11:55:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.225])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA85618002B2;
	Mon, 14 Jul 2025 11:55:37 +0000 (UTC)
Date: Mon, 14 Jul 2025 13:55:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Jesse Rosenstock <jmr@google.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] cpuset: Use stride in cpulist_create
Message-ID: <3sobgmoc6phs3jwr44qttauwmx5fwqs47tlfmle4s6mgpq6qvj@6vdwkjxomvtp>
References: <CAMZQ0rLE-6_Nowk5N+YCt35AM4L3XgvxtBQudr59Je73s2kffA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZQ0rLE-6_Nowk5N+YCt35AM4L3XgvxtBQudr59Je73s2kffA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Jul 08, 2025 at 02:20:14PM +0200, Jesse Rosenstock wrote:
> Format cpu lists for `taskset -c`, `lscpu`, etc. using stride.  This
> usually produces shorter output.

Thanks! It had been missing for years.

> The patch below uses spaces because gmail hates tabs. Tabs are used in the PR.
> 
> https://github.com/util-linux/util-linux/pull/3646

Merged from GitHub.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

