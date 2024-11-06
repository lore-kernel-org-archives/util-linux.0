Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E411D2B1A
	for <util-linux@vger.kernel.org>; Wed,  6 Nov 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886704; cv=none; b=h6Fy6dfLvv4IKuHYheM9XKmUZmNBcWM88LxSmwpXmKyHz5o71+Ri3E+nKc0Qqitn9BwcCkIxYnp2X8z1s5z1wnLYDuKof+F4E/qcbbCFd11AtMwHlzbGYjrRhZeU4i5ohqmci2bzW1WMzBwpnBubZYZvcMyp+YAgBL+RNQ98xBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886704; c=relaxed/simple;
	bh=DRo55AvHSYn6r40nul7GJnPq0/zY2CzI8KikWOV4yq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnwMcZoY0gZB5ha1e5oTVnde1YfFk1V0IpknrfPjmfJ8C8Zq0UiZENM9vy90it8g5H2+IKF9vndyrnQA1WyCv+6/zXKyd7M9d3Oy/NWCxu3XjfAXpbO7NaQ/brFI5p6/AgQBTcgqXOtwhkhSJGlHwIR/JYQKLnpQiSktJMjXOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cq1eaRul; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cq1eaRul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730886702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pGzF+DBbMgrXRmV3NcFcih82Jeaqia89XTYNRQvFMJQ=;
	b=cq1eaRulFYef23HPDTGa4E4862eSxgneJ9MYfOtq+Qgm8n6jnR9/E1i7Ik/nXxjkywet4o
	bCs3rnNEE2W+zUKwURNspXlNjWFuwrspjD4L520pJzOlBhsetPjQyOGx6xxfJZsIfln5oG
	S8YtHt1voxDHNTYJtzh3G8D9Lul65FE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-XgmaRCUcP8SYr2odXVpRdQ-1; Wed,
 06 Nov 2024 04:51:40 -0500
X-MC-Unique: XgmaRCUcP8SYr2odXVpRdQ-1
X-Mimecast-MFC-AGG-ID: XgmaRCUcP8SYr2odXVpRdQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1F9319560B5;
	Wed,  6 Nov 2024 09:51:39 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7E2819541A5;
	Wed,  6 Nov 2024 09:51:38 +0000 (UTC)
Date: Wed, 6 Nov 2024 10:51:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Anjali K <anjalik@linux.ibm.com>
Cc: util-linux@vger.kernel.org, anushree.mathur@linux.ibm.com
Subject: Re: [PATCH v2] lscpu: fix incorrect number of sockets during hotplug
Message-ID: <sqtt43fwcdsvrxcl4kibzeqa2e5iacvqd5vnlcdsxgymef5s3z@cmc5mfsygzc4>
References: <20241104063226.172077-1-anjalik@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104063226.172077-1-anjalik@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Nov 04, 2024 at 12:02:26PM GMT, Anjali K wrote:
>  sys-utils/lscpu-topology.c | 71 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 7 deletions(-)

Applied, thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

