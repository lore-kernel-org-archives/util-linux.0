Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E0220680
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489302; cv=none; b=VM0wTbK8QPmTcB3iGKNmC5BoceWj2DZn58Gib4U8Ihy7IMmKcbLv+Fg5Mokcz+jGlbZiILCGTeiP2w46vkLmsjYM3eCxHal1AIu9OpvpikxpQtyAp9OmSGfFkwPK/oN2ny/1mB06RuHCoPipHM377kr7hopdv7RVqnlDp5zhUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489302; c=relaxed/simple;
	bh=2v0ZTZ/ylOmUT98iYmEEGIQGDIfgbrW2y/BV9WF02ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgLURjJyE6u/Pu65vf7wlnIrqTaHu5zAWtgee7Hjs2wtI+W14b3fC6KG3orgxO+LXyvlKDoQEVzHcMlNG4Tub9uAqNSkgDwEoI2cebWbuTJjqItoGRn5CHPIVVhS+h3X6/HIZwGkrge5vUM9VXfWlp5apPdw/vD4eJ/26IkoANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVGKN8cS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVGKN8cS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745489300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LG8OeDapTpnUPjc6LTgLgaZIeWHKqr3jzmULRqXPUk=;
	b=OVGKN8cSm486D1Z+AB6N7GletXorwZaP1MU6rQrXoLAcmXMo37QONAAGgFuN4QR8JPqrOJ
	ZVbv8HBK5VijFWzco3DpJLxary6KekuJ3gkHxgbSi83VvAECuLqJ9E+9T7OnT6MggiIbpi
	7D88C+sy84x4gjd0hmOa6VsyWHrqYa8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-eIP4Qu6fNjShjLdGbBWF_Q-1; Thu,
 24 Apr 2025 06:08:16 -0400
X-MC-Unique: eIP4Qu6fNjShjLdGbBWF_Q-1
X-Mimecast-MFC-AGG-ID: eIP4Qu6fNjShjLdGbBWF_Q_1745489295
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD9491800446;
	Thu, 24 Apr 2025 10:08:15 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.130])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96C77180045C;
	Thu, 24 Apr 2025 10:08:14 +0000 (UTC)
Date: Thu, 24 Apr 2025 12:08:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/7] docs,usage: harmonize description of --hyperlink,
 and add 2 missing ones
Message-ID: <6sucmcn7scrug4shj2lebkrfdz3yyayoj37b3akusib6mxtyjw@kapl5f3xlvzq>
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <20250424093237.6432-4-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424093237.6432-4-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Apr 24, 2025 at 11:32:34AM +0200, Benno Schulenberg wrote:
> -*--hyperlink*[=_mode_]::
> -Print paths as terminal hyperlinks. The _mode_ can be set to "always", "never", or "auto". The optional argument _when_ can be set to "auto", "never", or "always". If the _when_ argument is omitted, it will default to "auto". The "auto" setting means that hyperlinks will only be used if the output is on a terminal.
> +*--hyperlink*[**=**_when_]::
> +Print paths as terminal hyperlinks. The optional _when_ argument can be
> +*always*, *never*, or *auto*. If the argument is omitted, it defaults to *auto*,
> +which means that hyperlinks will only be used when the output goes to a terminal.

How about adding man-common/hyperlink and including it in the man pages?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

