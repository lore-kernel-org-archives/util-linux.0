Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29467200A6
	for <util-linux@vger.kernel.org>; Mon, 29 Apr 2024 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394152; cv=none; b=iYQAFGbWewynusZWdUKcN1VPefTpCyMw1PsHRAaZ9K2YDzvJRgtqVtAxmRK06eSRURqw1MNT82S6HN+Fvk9ZiYAZnsy8BP4c80aa0JHVeghhk9AnUZCLBEn3ePlkurGXOxp3Q6ZNUgSkKapyr4wyx1CpNUnylioGbBVmwIbiU/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394152; c=relaxed/simple;
	bh=4RRAtjwfMe2fJZUp+KruAc9l32Sh+E2vsur4Wy8js0o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T316llWzTvuC512IGG6KK0XC77AXhlPyf2/7MoA/k9m17rGTC4UkALenUR3H2b8ODNnJ3y5Ne2KSMQLBbP7OiXCV455kKawtK0dLPZUZ3dwQrDVSfhGgXnt+e4/vVPkSIMddEbzKfWPulpdq0/3SJ/7sMVJ6UuUWu69Nln73No0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1kYb494; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1kYb494"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714394149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=5jHLRGY/y2asilwNPw/CybDhiK/wrkKs9lSEBNIA0g0=;
	b=A1kYb4949/ttWT1yX8w81J63Or6wnsQWzxqIM7CweiJcsBpPg2naZ+FnhZeZJq051Ijqbm
	SUQ8j/BaVLL2JBdJYRmJ+Pr+EsWcpfZr/ivnLvGQ1COczhXjiNeL2Tn7ffVf6i7x9kNcG8
	DJcqWVbKC/LjqwE5H5YtaJgl+bMNe04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-KheY0QGyPDKFaWw06MbSmw-1; Mon, 29 Apr 2024 08:35:46 -0400
X-MC-Unique: KheY0QGyPDKFaWw06MbSmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4AF5803505;
	Mon, 29 Apr 2024 12:35:45 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E4900EC687;
	Mon, 29 Apr 2024 12:35:44 +0000 (UTC)
Date: Mon, 29 Apr 2024 14:35:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Petr Pisar <petr.pisar@atlas.cz>
Subject: Re: [PATCH 1/2] textual: fix some typos and inconsistencies in usage
 and error messages
Message-ID: <20240429123542.zbiieh6dpux6xoza@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326154822.8959-1-bensberg@telfort.nl>
 <20240326154822.8959-2-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Tue, Mar 26, 2024 at 04:48:21PM +0100, Benno Schulenberg wrote:
>  login-utils/lslogins.c | 2 +-
>  misc-utils/lastlog2.c  | 2 +-
>  misc-utils/lsfd.c      | 2 +-
>  misc-utils/lslocks.c   | 2 +-
>  misc-utils/waitpid.c   | 2 +-
>  sys-utils/irqtop.c     | 4 ++--
>  sys-utils/setpriv.c    | 2 +-
>  term-utils/agetty.c    | 4 ++--
>  8 files changed, 10 insertions(+), 10 deletions(-)

On Tue, Mar 26, 2024 at 04:48:22PM +0100, Benno Schulenberg wrote:
>  misc-utils/lastlog2.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

 Applied (to master and stable/v2.40), thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

