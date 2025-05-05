Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DCC204840
	for <util-linux@vger.kernel.org>; Mon,  5 May 2025 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451414; cv=none; b=fHkcx5oU28s/96icIotHKbpAko47bDHCW15L2EbJg6TjyvQTD14X6IfkutSTORLa+lCJVWMKJwnm8ididefyjiXif5mN09+NQ2glCOtjMN63gleaX8lhUcr0t+nRbgi4DjhItLaEALN+3frCa86MZGVSCRDVGHHy61WWuv8LiEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451414; c=relaxed/simple;
	bh=gRXjFnmGwvYaNeFHcvK0puFFbXRkz8n+AKSwu7QpQm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opA4vipZ4ot0DyZRAlZ+/lp5ke0qctbBIZuAinmSpKLOKHdB4LMnPG2qCaTuX/D9xzF15wfUcR5+pn3Z/vkujxcJ1LxnqygSi8j47bwlK3DDCUIAsAG8f561CxzM2HKoNanoq7r5riOO+GAYYf4QcwdQoUOClEXLo+CTHne5E5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SceF3xYJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SceF3xYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746451411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsNxzLWJLsrrHnM032zQJLpk2tVRP56YUA9WD9eefzQ=;
	b=SceF3xYJtwLlMuP/FDNdiyNst715QinScq9MxxZCnvuCz2iCpPbhp+8F4ixVeFJ6nveLu5
	GvxXDoog4kjW8BFDg4IkMaRO2rNI7+XXJnHum54zwaXeFTpS0Cps5Z/JBH8tOElEiVNiPx
	51aohf4EI3XoGfCouMIb81VFwMG9V+g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-UnmshmUWNIuZIqI__0Krpw-1; Mon,
 05 May 2025 09:23:24 -0400
X-MC-Unique: UnmshmUWNIuZIqI__0Krpw-1
X-Mimecast-MFC-AGG-ID: UnmshmUWNIuZIqI__0Krpw_1746451403
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F2D919560A0;
	Mon,  5 May 2025 13:23:23 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA5061800368;
	Mon,  5 May 2025 13:23:21 +0000 (UTC)
Date: Mon, 5 May 2025 15:23:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Zhenwei Pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 1/2] irqtop: use standard 'always/never' arguments
 instead of 'enable/disable'
Message-ID: <nhjeou3uainmyj7skhbnoini5ypida4djcejm7mofixh4pp5la@qhudth3j4yi3>
References: <20250502122242.72961-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502122242.72961-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, May 02, 2025 at 02:22:41PM +0200, Benno Schulenberg wrote:
>  bash-completion/irqtop  |  2 +-
>  sys-utils/irqtop.1.adoc |  6 ++++--
>  sys-utils/irqtop.c      | 11 +++++------
>  3 files changed, 10 insertions(+), 9 deletions(-)

Both patches have been applied. Thank you.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

