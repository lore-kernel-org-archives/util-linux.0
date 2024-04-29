Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA4EAE5
	for <util-linux@vger.kernel.org>; Mon, 29 Apr 2024 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379377; cv=none; b=uaNsQMfC1z1/mZFRj2bhrER84oDQSC1nogs33NMSO2ndroTPdzUFqUGoJkeg2WX7H7rqyDaPZ6Z7JaBTxBIcOQF4d0c1SxQe8h5IVYAjuasgGjJToSRupk/Z3aCUWzMtf31m4RlDNaxtqWMEjV9hol8EGtJAdH8Ixk9KnO6QAWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379377; c=relaxed/simple;
	bh=Z7uxUyCz4QZepjMfLHPWaT0rNyuYtlaPlLcnPLbzMeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEbecms6m+mZc1n3UNhr1b8YXNNiOMOW/QFnS88cPXFzKWhCaWimdr0/AW79wGYIDgpcSzdtMMsFz1LdW/mYBd4ohuuDeMJ7XOhKQECevQfj4QfxBirbBNQyXIAKorzvopmaHGZKg2U3XbCQrzy7nDNRXXZmZEVUsqtE5wb8l5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5htzfTm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5htzfTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714379375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtGR1xXdW3Uq9R6A9LuelvXWkfny/rZ+IAieBhuNsTE=;
	b=W5htzfTmJFGPCvOekkWLjLskZ7XKSTWleDyRQ1Mg2xqWVF1TE5ClOS+kyvs/vUqVvCdu63
	687Wji5B+afM/1yYKp7FgUfv53eyPuFp7oO/5+yG6BAWl6XoxXkeFX+I2PmeFj4TxetN7E
	wQ8kVkwdHHDaL1zITLCOrT9gs25c3yQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-wh7vSMk7Np2z3vRWn5m0Ow-1; Mon, 29 Apr 2024 04:29:31 -0400
X-MC-Unique: wh7vSMk7Np2z3vRWn5m0Ow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0991F80021A;
	Mon, 29 Apr 2024 08:29:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 11A6D492BC7;
	Mon, 29 Apr 2024 08:29:29 +0000 (UTC)
Date: Mon, 29 Apr 2024 10:29:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	util-linux@vger.kernel.org, Masatake YAMATO <yamato@redhat.com>
Subject: Re: [PATCH v3] flock: add support for using fcntl() with open file
 description locks
Message-ID: <20240429082928.cuodskfd5kqljf7l@ws.net.home>
References: <20240425094417.1174162-1-rasmus.villemoes@prevas.dk>
 <a0de91f6-2eb0-4526-a50a-b89db9fe140f@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0de91f6-2eb0-4526-a50a-b89db9fe140f@t-8ch.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Sun, Apr 28, 2024 at 11:07:56PM +0200, Thomas Weißschuh wrote:
> > 
> >  sys-utils/flock.c | 78 +++++++++++++++++++++++++++++++++++++++++++++--
> 
> Some testcases in tests/ts/misc/flock would be nice.

 +1

Merged, for tests use another PR.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

