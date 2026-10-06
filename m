Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECE3812E9
	for <util-linux@vger.kernel.org>; Tue,  6 Oct 2026 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277414; cv=none; b=pA4Z92ZUkQLLjV8EgRG2aF1nmzUiInOt6sU1jwQJs4arb/It8/fLwhASoC2PbRc3+kMtjnGjCq1b5xncXrA3TdWnoabrJaNtkTNXwwanpgmUDxYf6h6FIDNfIVeftuezCcrvITu8rDPjjeRCeP+yAkMdjQ+WjZzwh9G4XTaytO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277414; c=relaxed/simple;
	bh=H0dCFKfhayZNi1PL36C+bzJfLTS5auydkEGepXxvuMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3Nwo3JpEbaR0OZm4vpvk7Xq80CKUsZDeeSwaPyII1o8m+5Yxudqxvfgt+ryx4wowsCjPJMb0v+aPfh/vwY6/ULpOKWsImpIgHIWlzUrs2lwxLi/776nTj7DsAu+GRGbOjTtjSmfZiaH4/NhO3+LX3K+eCW+N3C/z0fjufZxGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLLkeXMn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLLkeXMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791277409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VtCKPOJ4vaRTVhau5TxaoNhAGQz4HCQL5FqFrOgZmFw=;
	b=YLLkeXMnQJnGNluvahRKCxkRi4jRnMyXyJZYVE3iksdbmDJnU642P++q7yXjuanal7GLaz
	I9zhINo4P8iKANe3b28ldYyRXoF8MjWqvgMCgAEdQ+LLwiTJGEPq7qS/CW93wBBJeNP7b6
	SBCRufjEkmxCx4yzRfYdct6ezpxe0GQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-hPfbsbnrNMyYL7KWrhG8Kg-1; Tue,
 06 Oct 2026 05:03:28 -0400
X-MC-Unique: hPfbsbnrNMyYL7KWrhG8Kg-1
X-Mimecast-MFC-AGG-ID: hPfbsbnrNMyYL7KWrhG8Kg_1791277407
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2025A1955DE8;
	Tue,  6 Oct 2026 09:03:27 +0000 (UTC)
Received: from kzak-thinkpadx1nanogen2.rmtcz.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 490343001D31;
	Tue,  6 Oct 2026 09:03:26 +0000 (UTC)
Date: Tue, 6 Oct 2026 11:03:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Tianyi Chen <hi@tychen.cc>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFC] libmount: explicit loop direct I/O requests
Message-ID: <asS45_Tw3-gPmMLF@kzak-thinkpadx1nanogen2.rmtcz.csb>
References: <178981850377.1262776.17938790502420524863@tychen.cc>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178981850377.1262776.17938790502420524863@tychen.cc>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Sep 19, 2026 at 07:48:23PM +0800, Tianyi Chen wrote:
> Following https://github.com/util-linux/util-linux/issues/3464, I'd like
> to implement X-loopdev.direct-io=on|off with these semantics:

Sorry for delay, I did some review, see:
https://github.com/util-linux/util-linux/pull/4646

	Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

