Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D528688C
	for <util-linux@vger.kernel.org>; Wed, 26 Nov 2025 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157874; cv=none; b=Ye9DxgTrP8T9GUj2tyKbSl4jjcRtd6tHs/eBLhzLkcsZPDX3Zn9gWk8dtdSwDpuGFQyGF03Bl5ih7nAOBBvPwMc6uVPD1gBYXc/PpnvJVoFlnaQDMn1UJi7g7uGhbAcYq4HTHXb/6CiV3/d5JoXKCF1C86ljJ+o7vrUg3ju4iRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157874; c=relaxed/simple;
	bh=H9JhKAf+Xa3YkeVdEV+YWIRs14afXrDNFK7+XG0RrME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9sy9TNd+N7nGXeR5rQkGoDKtEQqT2a1jLG7VPTyVg+nzeNpGEnN8LMrDr1Upk5TM8h9I1u9dXijIsJoJL8odu1kEL3463a7EpIM+iWrasYL+FwzdZTGdEfz8B0l2Fa3+Z16/SU5/3ppcL2yEHdalt2f1eZHRAqiLQ6NquWVLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiJMfx2M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiJMfx2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764157871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WObJCRYRxmRllAipZbpj4jKrLWsJrNR5s3kf6oMb0zM=;
	b=TiJMfx2MUL/fWQkyfMpNEO5os2Ic0QqQ3as9XfaREHDQYSFE9ohAiVIFgNkNqeDKbyrAnr
	C54Sn6mr3EyxGc3L6PrGI+egHPRitftEuXgizEwgNqLqoDpVgpabo5k4/bKVudl4/+G+HM
	9CiCFiFeTFF8hlVkduVPc/Pw0qUI9q4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-tms0DkJ5PZ6OLRjE4p0dUQ-1; Wed,
 26 Nov 2025 06:51:07 -0500
X-MC-Unique: tms0DkJ5PZ6OLRjE4p0dUQ-1
X-Mimecast-MFC-AGG-ID: tms0DkJ5PZ6OLRjE4p0dUQ_1764157867
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0E7E1954B0C;
	Wed, 26 Nov 2025 11:51:06 +0000 (UTC)
Received: from ws (unknown [10.45.242.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 903DF180049F;
	Wed, 26 Nov 2025 11:51:05 +0000 (UTC)
Date: Wed, 26 Nov 2025 12:51:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: util-linux@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH 0/3] Consistent shell resolution across util-linux
Message-ID: <wrmeywniicltshcczypjo7or6hnds7wkkgaaiizbsvvzkwaab6@minsmj74e6wm>
References: <20251123153246.1056874-1-alessandro@0x65c.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123153246.1056874-1-alessandro@0x65c.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


 Hi Alessandro,

 thanks!

On Sun, Nov 23, 2025 at 04:32:43PM +0100, Alessandro Ratti wrote:
> This patch series addresses inconsistent default shell handling across
> util-linux tools, which caused user-reported data loss when script(1)
> defaulted to /bin/sh without respecting the user's configured shell.
> 
> The series:
> 1. Introduces ul_default_shell() for consistent shell resolution
> 2. Updates interactive tools to use the new function
> 3. Standardizes _PATH_BSHELL usage in security-sensitive tools
> 
> This implements the solution discussed in:
> https://github.com/util-linux/util-linux/issues/3865

How about creating a pull request on GitHub? It will help us with the
review, etc.

(I can do it if, for some reason, you don't want to use GitHub, but
it's always better if the author does it themselves.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

