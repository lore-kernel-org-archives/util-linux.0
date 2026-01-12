Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912B35BDA0
	for <util-linux@vger.kernel.org>; Mon, 12 Jan 2026 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226939; cv=none; b=Kpv0T562P86A74xPVFPijzGFpXGi3p7TDegJkcttCs8Jv6wqv3A2yblcUABCVZYl9/ExJ2D2Zd5juD3sQGInIo10aVhXhDjiZ4nwCN7PczE6duGO+lERbpH7Iekl4ul6YX588Jmw0qpxBOq1t5wuhZpUfGcGgwfGM9Nk5sWHUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226939; c=relaxed/simple;
	bh=KqdA5QNrBccVgs/Gt2WfPe1nlvIFNm/ULf5gvFxQzFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckPRMIMD94uinPR6zjHWGLQOFEvfS2xJJgPHqIu0WIwS0tCkyFS9qFtzhXs1ImUz4H254kh43Z/m6y+O+Q7ouNSmVzOyJDyw3JyJ6b0xWyl/RYz16Y2f1uWeVGnGAiwaHnsBBXvTYCrBqzZb1j/mB7XEfD1ljilHIdpFEy6M8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRHBBI4Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRHBBI4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768226923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4gDfvtRS+sby5PGV5zggp6ankpWzKNkEi4CSepV9H80=;
	b=NRHBBI4ZD0jZDQGIc6/6uUP7lmiF18hjfytTW134Fs7IatTm+2h7IebPvnLiLpwmdQB8pp
	OGHBC6/c9IVX1Ob4YDNvxsW93xKuN1/O6fy0vJCQct7Hpa1bf4GORokYAQKImmWvGMRzQt
	F2iiqyARjNKr5pvB1WShXORQQoqVhWE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-hil7BOcQMMC4qr1omubOOA-1; Mon,
 12 Jan 2026 09:08:40 -0500
X-MC-Unique: hil7BOcQMMC4qr1omubOOA-1
X-Mimecast-MFC-AGG-ID: hil7BOcQMMC4qr1omubOOA_1768226919
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D26818005B4;
	Mon, 12 Jan 2026 14:08:39 +0000 (UTC)
Received: from ws (unknown [10.45.225.101])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B923F1800577;
	Mon, 12 Jan 2026 14:08:38 +0000 (UTC)
Date: Mon, 12 Jan 2026 15:08:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] losetup: snip --verbose from bash-completion, and
 'v' from options string
Message-ID: <rcye4f5givltdznmz34oi5be7b6jly6vcy5bh2vy3ogbq7nkp5@7pguu423m6zn>
References: <20251209150222.50981-1-bensberg@telfort.nl>
 <6zqviy7rkkjvfubrunegtw5poeyq4tstg7wltnca36tnul3w2x@hs2oxaatxptl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6zqviy7rkkjvfubrunegtw5poeyq4tstg7wltnca36tnul3w2x@hs2oxaatxptl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Dec 17, 2025 at 12:00:48PM +0100, Karel Zak wrote:
> On Tue, Dec 09, 2025 at 04:02:20PM +0100, Benno Schulenberg wrote:
> >  bash-completion/losetup | 1 -
> >  sys-utils/losetup.c     | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> Submitted as a pull request to https://github.com/util-linux/util-linux/pull/3910
> for CI testing.

Merged a few days ago. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

