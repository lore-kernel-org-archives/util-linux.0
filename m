Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A938E8B0
	for <util-linux@vger.kernel.org>; Wed, 13 May 2026 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666186; cv=none; b=p/GJfX9+wA2q6rgOfMqxlm27iaZpLAVZyFsqeakrNxJwWpEfZfAaHlT22cujUm2vTp9mqFjckPaBXrxdZaz5hcBTRN54+9RFm2VBB7j75g+pIS1DLgWfqyYWrOHsnlwwGh/gPHI/03CoCJGxtrTJySSQMwNZ5rDEkZ2mDJfuOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666186; c=relaxed/simple;
	bh=h5WzKsyK58tANBTNlIfI1Vylo9pxX6ZvntcGNEv/b/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsFnzmvlrvW6YhzRI0rGgzGMPv/9xmT0Xn8g39MDD1dTwz0ZpmfuVgKt1mxau2Dn771Ey+yrhTTvskDIVqQJpr8hytIZ6hcJhhZlyDpfu9MVaixJCYuPjLgyrC0HIrW3fHC1Al4EAQvszDnCSDpkedQ4lrnAbz7/oKlSvxNztCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KC74vuSn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KC74vuSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778666181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWlI7yMtu55aEd4U0654HR85evg7lR2sAxWlSWgzfgY=;
	b=KC74vuSnIU78ZhJYDVxQYueLNEcMsccPPch3Q/07nywIGD19VckKnF3Bj9p01DQDGWsZpY
	2AAjlzYaubZY+QQpNKJMh+sJHi42kFyNOrhbXU5kg5/4EntyVKMpFFXB6REvp6mKbi+G8q
	r6kR+8/vyAtPANCBEtP5RIUwxgZA7a8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-i8widn54NmO2GIb6RgdhHg-1; Wed,
 13 May 2026 05:56:19 -0400
X-MC-Unique: i8widn54NmO2GIb6RgdhHg-1
X-Mimecast-MFC-AGG-ID: i8widn54NmO2GIb6RgdhHg_1778666178
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5AD51956062;
	Wed, 13 May 2026 09:56:18 +0000 (UTC)
Received: from ws (unknown [10.44.32.176])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A729D1800347;
	Wed, 13 May 2026 09:56:17 +0000 (UTC)
Date: Wed, 13 May 2026 11:56:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Furkan Caliskan <frn1furkan10@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] chrt: Add support for (GRUB) bandwidth reclaim
Message-ID: <qxdlckjn62cuprljhq5ykcvays6vjt5s35h2qvqougme7a6xdw@tjeqjxswupdz>
References: <qa5c2sqdvxiclkfszc7wdfdd3naa7e2w42mip3abj4auisqw6r@o2jtcbaibyep>
 <20260511141030.16291-1-frn1furkan10@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511141030.16291-1-frn1furkan10@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, May 11, 2026 at 05:10:30PM +0300, Furkan Caliskan wrote:
>  bash-completion/chrt   |  1 +
>  schedutils/chrt.1.adoc |  3 +++
>  schedutils/chrt.c      | 17 ++++++++++++++++-
>  3 files changed, 20 insertions(+), 1 deletion(-)

Applied, thanks.
https://github.com/util-linux/util-linux/commit/81c2eb29486281367b81baaa8ddf0f27f60877d3

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

