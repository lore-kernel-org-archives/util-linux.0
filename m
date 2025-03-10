Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CD1AA1F4
	for <util-linux@vger.kernel.org>; Mon, 10 Mar 2025 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608881; cv=none; b=r1YxWqZ7xFERAg0sU6/n2V58kvl9HYkPdiXrscApLTLRgUZhR+ETKx6x8A5EhAcOU7C2sZloJvvVevBgCZ5lL4KY+FqLvkQfgU7nomHIrvAHXYjiGanYz3ocFlUwrsdSa96j6igs4qISqgV2fVrOK5FUsZ+JwcP8Y7KI5cMZq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608881; c=relaxed/simple;
	bh=J0IQV8FQ6bodjuAHqvu26/Srn+1XVdSkvp0usnt1ZRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN33LHu2Cj+ffpWOCFr+qQsCNHkzVzRfmFVt5O0KaTkvfdEVtc6pJJ9ggnYETARtYGDLcwlTlXjec0d/9bpOcNdMjymvxIo+CcALXzUIzQnHNfhCc5Sl5Wd3Iu153PD53ZMFazvRxxR/cWU2Val+rv2CFgi3nlcl1ZuZnxNKtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dU9/y0eX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dU9/y0eX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741608879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VL2OhIG5WS1LwPEPp4tZlEXLxqQoOlYF8FCyVqxKKa4=;
	b=dU9/y0eX3uF0vv8m7Q9euNS7CiAFp4+1jQ1GBZUlZ2ihZB6JWp7F4YDxCuorpbuvO7hhkz
	3a5YlFSrQNlY5LDRvIbLMzSUd8d2uZFjGkFq839ETi3NhGOztS64DlhrLbjWfAVI+Ukz1v
	iKp+6qafhPupwqnTrX7Paz/WFTb1TEQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-oJzKP29APFecSprniy-W3A-1; Mon,
 10 Mar 2025 08:14:35 -0400
X-MC-Unique: oJzKP29APFecSprniy-W3A-1
X-Mimecast-MFC-AGG-ID: oJzKP29APFecSprniy-W3A_1741608874
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53F461955BC6;
	Mon, 10 Mar 2025 12:14:34 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44A2F3001D0E;
	Mon, 10 Mar 2025 12:14:31 +0000 (UTC)
Date: Mon, 10 Mar 2025 13:14:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>, 
	util-linux@vger.kernel.org
Subject: Re: [RFC PATCH 0/2]lsirq,irqtop: Add filter support
Message-ID: <qdiia2fmgfxwgr75qjdgxuiitaoo66tsthajqxs6mrtca6oqh4@irpn3e44w4sw>
References: <20250307025201.92541-1-joe.jin@oracle.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307025201.92541-1-joe.jin@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Mar 06, 2025 at 06:51:59PM GMT, Joe Jin wrote:
> Sometimes people may only be interested in a specific IRQ, adding regular
> expression support can help engineers find/monitor IRQs easily.

Ah, the libsmartcols provides a filter. See, for example, misc-utils/lsblk.c and
the "-Q" command line option, and also "man scols-filter".

scols_new_filter()
scols_line_apply_filter()
scols_line_is_filled()
... etc.

https://www.kernel.org/pub/linux/utils/util-linux/v2.41/libsmartcols-docs/libsmartcols-Filters-and-counters.html

The filter allows the creation of complex queries, so if we integrate
it into lsirq and irqtop, it will be possible to use things like:

    irqtop -Q 'NAME ~= "PCI\-.*" && TOTAL > 100'


  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

