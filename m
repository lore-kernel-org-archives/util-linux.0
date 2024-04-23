Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8785579F
	for <util-linux@vger.kernel.org>; Tue, 23 Apr 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864434; cv=none; b=GF03j05/TE2dysNtkMv/ktqY5KbqOEpYqo/xmAoL93MGeTgSTypSO5MzHUkVHeel789hmgvyc6IjPYDNozVak/Ba8yEWf3GuMpUyV2AWY4smZXdoB9jtjAy1zlTHxcrpPVYlRFOpCfi9lMy3u0HcpbNLT/JnLol6gmP8skUUuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864434; c=relaxed/simple;
	bh=OQ4/pXWu4emOgnrQTum9ErSFrlG8AsYxhUrSACNQWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5FomwBmbcxtKYk6ggag7LIUds1khczp0vWgu2HAbsSb8LfHA6DmhLjkX7ZTAzi2QVHyFP0nAe/k7noP1tnsrVFbscpkk99oLeQtCZVeIRbdPEHHk3G096VKkY53kaEXjqOUQXSKN0iQaulZCx2kXCEK1RJup2WoT9iadTfLSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKkI9LKX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKkI9LKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713864431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yoz8MJfkaNMGh1esk2VNyUTDi40TD6pB6MK6pE2PwU0=;
	b=KKkI9LKXB0NS3cvK5myqniHeTWuip81kfSbKDPaIZt9EptYehXg46gIetPG9V16U9lmdB8
	Iuu6/tR5P1IQnmIVlBXhYzycvkGzh6/Q+mSB56YTikJ2yZp+3SeoAAnEYHZmDXGXeL1cy9
	ladfpbIiS8xSRrNwhvcjOsmWLZNIjnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-WsyW34LWN1Oi1i3wVYlVAg-1; Tue, 23 Apr 2024 05:27:08 -0400
X-MC-Unique: WsyW34LWN1Oi1i3wVYlVAg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE1D880D678;
	Tue, 23 Apr 2024 09:27:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D718C492BC6;
	Tue, 23 Apr 2024 09:27:06 +0000 (UTC)
Date: Tue, 23 Apr 2024 11:27:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Thijs Raymakers <thijs@raymakers.nl>
Cc: thomas@t-8ch.de, util-linux@vger.kernel.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v9] coresched: Manage core scheduling cookies for tasks
Message-ID: <20240423092704.p6ylmc4a3armdccp@ws.net.home>
References: <20240417103138.g3bk5zamemhx6xm2@ws.net.home>
 <20240417113932.14237-1-thijs@raymakers.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417113932.14237-1-thijs@raymakers.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Wed, Apr 17, 2024 at 01:39:32PM +0200, Thijs Raymakers wrote:
>  .gitignore                                    |   1 +
>  bash-completion/coresched                     |   0
>  configure.ac                                  |  12 +-
>  meson.build                                   |  16 +-
>  meson_options.txt                             |   2 +-
>  schedutils/Makemodule.am                      |   8 +
>  schedutils/coresched.1.adoc                   | 139 +++++++
>  schedutils/coresched.c                        | 358 ++++++++++++++++++
>  tests/commands.sh                             |   1 +
>  .../coresched-copy-from-child-to-parent       |   1 +
>  ...coresched-copy-from-parent-to-nested-child |   1 +
>  .../schedutils/coresched-get-cookie-own-pid   |   1 +
>  .../coresched-get-cookie-parent-pid           |   1 +
>  .../coresched-new-child-with-new-cookie       |   1 +
>  .../coresched-set-cookie-parent-pid.err       |   1 +
>  .../expected/schedutils/set-cookie-parent-pid |   1 +
>  tests/ts/schedutils/coresched                 |  83 ++++
>  17 files changed, 621 insertions(+), 6 deletions(-)


I have created pull-request with the patch to verify it pass all tests.

    https://github.com/util-linux/util-linux/pull/2990

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

