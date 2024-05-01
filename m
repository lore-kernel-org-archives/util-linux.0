Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89BF12FB1A
	for <util-linux@vger.kernel.org>; Wed,  1 May 2024 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591839; cv=none; b=nJ5xzMj0yCkTao2F/nw+FZQSBxCf3UyoaD3B4UXQKu0OLSh9lwKnNnCHOlYPUHvw/k3vUHrbdrlctAdpHBnvUFGg0RJgF9IZZB6X/UpSHDsVJyhQBV2y4JNpS3irvRIOsd2jljsIFWk+mTeaKjbshZEsebkb00qmLGQFRXkJ/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591839; c=relaxed/simple;
	bh=cXeBgu9tt3lmrwI3s1dmt9Yl6OGHn0yIWPno8OdNSXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG2zb9kMIGg137vZvXSkzaISBbnRo0XXX2fe+eKiqhyNWVqin5t0tMPzVtWTXyz60H1ollHW+OEp72m8mixlUTvwFhHzOf8onWb+MQxuK43fddBnPMxaP1sw9W99pjApNwoT4Qk/X/3//0O8F5tpdBvCitmUQP9Y4NAGIjTFV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdx/QmU2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdx/QmU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714591836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4Iqmqtn+/bDxq3poRjwellsjU4wCV7V3DBUzI7myZA=;
	b=bdx/QmU2VCvbUpC1yD/crBj6eyNv8hjxfKtH9ap8Ppb2nQtyanNnzvehso2ojfEuu7n5+Z
	9asADB4+i+quyrnPOb9Ad6HCvocM82kCwznNe8P+YkQCJsWfO/k/1SpwQarJkfBn9na91w
	b75ahp2stzouvQsbZcxl+Xkqd75EOT8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-UqEHgX0RNxCrdQt8CYPzKw-1; Wed, 01 May 2024 15:30:35 -0400
X-MC-Unique: UqEHgX0RNxCrdQt8CYPzKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED6461005055;
	Wed,  1 May 2024 19:30:34 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 766686958;
	Wed,  1 May 2024 19:30:34 +0000 (UTC)
Date: Wed, 1 May 2024 21:30:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: util-linux@vger.kernel.org
Subject: Re: umount -r broken due to "mountinfo unnecessary"
Message-ID: <20240501193032.ysusjmcmlfv6rp47@ws.net.home>
References: <315f1f43-013f-48c9-9016-474dc9d53a04@ans.pl>
 <20240423083358.2k532xl557meewws@ws.net.home>
 <1350349b-8465-4ce6-8dc9-55a32b84dc39@ans.pl>
 <20240424101535.4tvyms63egfwlw46@ws.net.home>
 <fa4da8a2-010c-4bed-9d62-a0fee7646bf3@ans.pl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa4da8a2-010c-4bed-9d62-a0fee7646bf3@ans.pl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, Apr 30, 2024 at 09:31:54PM -0700, Krzysztof Olędzki wrote:
> On 24.04.2024 at 03:15, Karel Zak wrote:
> > On Tue, Apr 23, 2024 at 07:35:18AM -0700, Krzysztof Olędzki wrote:
> >> When is the next release planned?
> > 
> > I plan to release v2.40.1 next week.
> 
> Thanks you! However, the patch is still missing in the stable/v2.40
> branch. Sorry for the noise if this WAI, just don't want it to be
> accidentally missed.

Cherry-picked to the branch now.

> BTW: v2.39.4 tag seems to be missing? https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tag/?h=v2.39.4

Ah, fixed now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

