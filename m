Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26981FF1D9
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2025 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085895; cv=none; b=vDQ4BKkYXgutE30UdtCje0QRRP4fA5cSJKU538jucqF/2mrBJfCJnnlopCPsD/e3bweK+xEvb7nZWBpEURDxO5wBT7IyK7zcXWx0/nnLKBg0FIJOqZpFwAPbhbJYFmIaaNVM9qfISgl1+xGjMmxAVZ0Q92AJx3NI5ZtjINiAMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085895; c=relaxed/simple;
	bh=sjdlpCHQwz2jyxIC8p25V/EM3Ro4quaNdOVD+2jZO2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRwryZtZFWJzXicss9C2L/1Tn74Q97P/gdupvf3rGeqK2rs95OJ0vbzZdli/tdTECbAQqisq2Dwrys+tzuaRxRIWhPtop+poymi3FTm0W6tY8IBItRNXi0+mfNRTWmXRDnM/kTgoHQ7naHYZIRceZtHPfCJ3nKwyt5Tc4PI5gSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOc/36+y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOc/36+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741085892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljTW7/LoyMrs2hWdGLiOyOw9jk0AW09FncWByeMtJxc=;
	b=AOc/36+yWtJRNwPfDMSC0G4b97pfO46g16AjJUvnuNCR7GKQO+IbDLXdgyxfRA9DjoaaAL
	SwzVpfJWE4mZeFHOpOEtB0jqG78zFPewDXNJ2Lx4KjWfSpJXu+xU03fRjmVQ3XRWpBhV+K
	J57R/LVBfaYr4ydugI2iD4bOFgWZ6TY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-PJiBKIUbOR-Vh_eauTWiWw-1; Tue,
 04 Mar 2025 05:58:07 -0500
X-MC-Unique: PJiBKIUbOR-Vh_eauTWiWw-1
X-Mimecast-MFC-AGG-ID: PJiBKIUbOR-Vh_eauTWiWw_1741085886
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E94E41800268;
	Tue,  4 Mar 2025 10:58:05 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33FAF1800361;
	Tue,  4 Mar 2025 10:58:03 +0000 (UTC)
Date: Tue, 4 Mar 2025 11:58:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>, 
	util-linux@vger.kernel.org
Subject: Re: [PATCH V2 0/4] irqtop,lsirq: Miscellaneous enhancements
Message-ID: <slmym5tvcnf5evhcbgydkhnfhexmoqrv5wsmzrpg2uafdicxcw@2akbzvezgsam>
References: <20250228161334.82987-1-joe.jin@oracle.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228161334.82987-1-joe.jin@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Feb 28, 2025 at 08:13:30AM GMT, Joe Jin wrote:
> v2:
>   - Removed macro irqtop_batch_mode.
>   - Replaced macro irqtop_printf() to inline function
>   - Changed option '--number' to '--iter'
>   - Replace strdup() to xstrdup()
>   - Added json output format for irqtop.
>   - Remove irqtop input file support.
> 
> Joe Jin (4):
>   irqtop: add batch mode support
>   irqtop: add max iteration support
>   irqtop: support json output format
>   lsirq: add support for reading data from given file
> 
>  bash-completion/irqtop  |  12 +++-
>  bash-completion/lsirq   |   4 ++
>  sys-utils/irq-common.c  |  19 +++---
>  sys-utils/irq-common.h  |   3 +-
>  sys-utils/irqtop.1.adoc |   9 +++
>  sys-utils/irqtop.c      | 124 +++++++++++++++++++++++++++++++---------
>  sys-utils/lsirq.1.adoc  |   3 +
>  sys-utils/lsirq.c       |  24 ++++++--
>  8 files changed, 155 insertions(+), 43 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

