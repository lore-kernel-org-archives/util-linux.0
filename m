Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34787839FD
	for <util-linux@vger.kernel.org>; Mon, 29 Apr 2024 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419493; cv=none; b=T2yF9EcFHlN+SyGs83ktinB8sld0pC+qwLp1UmsS83cDvpfSTEd1oHgBryVkaT0JG5HHnx47boXvrSRupW1gXeL/nLdnQ0kBF1OYHWIUgU9MnkK97W9rPlxpZChdfwdnVMsyWBbS1B0Rfc1kU2pXk2avln2NoZur30+STGPhPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419493; c=relaxed/simple;
	bh=/cewaeYDU+mrCJm9dS0ph5f1+hWdpFP8AOXEr80BiJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8H9JilanhEjd7l6SE7jF9W0FUmUndV5mNab/SAkIapOlOK492MQE13hl5cXa0TIGVoK32+NOd/MSWdfT50wylB66zZ2TFgPyqHhK75Oov6a72Jux4jlQ0HRUV57f4+CWiF33pTj8AemqZGC90wHwkthpZuLn0lsIgzRxkVd6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXPHHuTr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXPHHuTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714419489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J/MXxw+Mg79NEE1eQDuXwcCNUMbncN6l8Q9uxgJnvmo=;
	b=aXPHHuTrAwQ6d4qf27eKOf2pvmQDWg7ikitADrpMlzTVwm9KzgdvS72EH9wZXaksmhYHWf
	jXDITn1VKa3/Ue00XBs/m2FFLt78OBFF4bbWX5Gr5MQCj3cAoel3N3Hu6zcIPhbdJTNJG6
	2mgQ8hDQVKke8p7+dFEfoRkdTAxPbuo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-iW--nqy_MA2-QCkryw-yXw-1; Mon, 29 Apr 2024 15:38:05 -0400
X-MC-Unique: iW--nqy_MA2-QCkryw-yXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3743C104B503;
	Mon, 29 Apr 2024 19:38:05 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7989D1121306;
	Mon, 29 Apr 2024 19:38:04 +0000 (UTC)
Date: Mon, 29 Apr 2024 21:38:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Petr Pisar <petr.pisar@atlas.cz>
Subject: Re: [PATCH 1/2] textual: fix some typos and inconsistencies in usage
 and error messages
Message-ID: <20240429193802.cflzk47hgjrlsq5f@ws.net.home>
References: <20240429123542.zbiieh6dpux6xoza@ws.net.home>
 <4582ffa0-e5fb-42ca-9b4f-a6a0bc67bed2@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4582ffa0-e5fb-42ca-9b4f-a6a0bc67bed2@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Mon, Apr 29, 2024 at 04:58:35PM +0200, Benno Schulenberg wrote:
> 
> Op 29-04-2024 om 14:35 schreef Karel Zak:
> >   Applied (to master and stable/v2.40), thanks!
> 
> Hmm...  I don't think it's a good idea to apply it to the stable/v2.40
> branch, as it invalidates any translations that were made for these
> strings.  It would be okay if you first offer a new POT file to the
> TP before making the next stable dot release.

Good point. I believe we can begin implementing rc1 for stable
releases, with a short period of time for translators to make any
necessary changes. For instance, we could release rc1 on Wednesday and
the final version on Monday.

Since the stable/ branch is now being more actively maintained, it
would be beneficial to involve TP in the process too.

Does it make sense?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

