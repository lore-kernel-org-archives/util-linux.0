Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB692080F1
	for <util-linux@vger.kernel.org>; Wed, 12 Feb 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354470; cv=none; b=GiIlyd05Fcj6IF13QnYv9DfKhp+W/hmnLsQwtwR1MsC/xaowFASLnILlRp+YOPgT0m9p19WjyZDd7abkxVX0MVAizInxN+0K+h7V+g2sFJX/Mvr+pbHRI4SaO3SXljSv0GHeyGayw5b82AGf9HuilpMQ4uzbpnKCB+Wd8v8KY50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354470; c=relaxed/simple;
	bh=+sHkFou03ZGaGDxOa4eSYvFqgQum/czljyX7UJivmZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgD/YW9tCiBTfF9TQjxX4J6BzMSvBMUp7VCgoEl37Jqbr6gGR37JCe6YWShgcnlWcU2z5A28WpGQci9dx74xP/WoNZ7nj6/cQ/NulLQfdmovASY4++YWQOrnaWT2MyG10q9WN6S+UY7241lsI4h/JwCOqQJKUJTiOXzA1fDzvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYa04ybv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYa04ybv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739354467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2MV5sorcCsMCx4qiyj4REpIGULDmvvniEBk6oNk4cVM=;
	b=PYa04ybvVqHWCgJ+qxUNHnpv9HbKkxIr6lmL5HATdkI6totTiDxWeDkV1UWA6kRAd2T0A3
	M9tUfQafZtzeEkVEG47lMqFY39OQmoJvUeal9eX8Ylpo0oQhrQ0CtbFkup5uJdkwtn4usP
	1KWS/b4ytIlQPXqHkRLp1NE5s3oc+tU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-m9SYnPTYN9mFPpuY48tUUQ-1; Wed,
 12 Feb 2025 05:01:05 -0500
X-MC-Unique: m9SYnPTYN9mFPpuY48tUUQ-1
X-Mimecast-MFC-AGG-ID: m9SYnPTYN9mFPpuY48tUUQ_1739354465
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0368180087C;
	Wed, 12 Feb 2025 10:01:04 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3A611800570;
	Wed, 12 Feb 2025 10:01:03 +0000 (UTC)
Date: Wed, 12 Feb 2025 11:01:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/14] setpriv: make message for failing PR_GET_PDEATHSIG
 the same as the other
Message-ID: <c4egpbl636rugo7gc2ituqtwf4ffztywjgece3sglfp6wctzfa@vqvxujtzjabz>
References: <20250209082330.4235-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Feb 09, 2025 at 09:23:17AM GMT, Benno Schulenberg wrote:
>  sys-utils/setpriv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied (all 14 patches), thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

