Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF0422DC43
	for <util-linux@vger.kernel.org>; Tue, 14 Jan 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847186; cv=none; b=Bv8chv3b51hmS4OZiXHI9cQR5S2Zs/T8oWakh3OH/XdUNeUsISxIANALHJojfmUIrxoT6JQHFLqmEQVV1iYyG3MENQcw8evEhJu5LGZGJ7ZLKqvN7r6NhhFx/MalvAiXN5iPD2Ss4aUZtMSI9CtIwhbpYUya9MyV7bfeGsZu7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847186; c=relaxed/simple;
	bh=tQe4Ih4pDOsI/l4ht9Q598tgl+ks1OjXPnY8ELfTN+Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvPjXUrM4F2yy9k/Dv1cqVNbjZebl7wandrw2TjQhH4n6wwxCMywdRMtHC1G5oUDsO/sMbynsNtAcqaRBQCYAtRXglizPISxxvjnPuqGmqwkCWv1HYT9bJxqE/4dCvGd8nIQcjGq9m0qjIw6tJL/Qx1Wo2y6yJEsSYjdj4OOdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=URK/fHNf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URK/fHNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736847183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v3on4nhc43NVY7uYwCyypzo5AhiM4fkSSKBPBZuWjJM=;
	b=URK/fHNfEcq6Qj3NZND5XaLqdCbT5zCkM8a1kpwPfbiS2ySvLBu16nO3LeKoyKsZQ1HI4C
	iBGyvdMF7j13cNpuBUbQNvPIoZNGGIgemum6JsOy0akIqYKhB7JGfqm9FNlxKjENLfrQXg
	apJgIrskctBAeCwSCDdgLrDu1tye9dc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-1iYMMhtbNUiUq4LxdYsllA-1; Tue,
 14 Jan 2025 04:33:01 -0500
X-MC-Unique: 1iYMMhtbNUiUq4LxdYsllA-1
X-Mimecast-MFC-AGG-ID: 1iYMMhtbNUiUq4LxdYsllA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3CD819560BB;
	Tue, 14 Jan 2025 09:33:00 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.208])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6EA219560A7;
	Tue, 14 Jan 2025 09:32:59 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:32:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Samuel Thibault <samuel.thibault@gnu.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix non-Linux build
Message-ID: <22d3kilpbkuhwsk7lac2f6nscbtet5j56urjyrzarifymwqgh5@d5nu7qwd75nx>
References: <Z4PiQCAhViwlpqnG@begin>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4PiQCAhViwlpqnG@begin>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Jan 12, 2025 at 04:39:44PM GMT, Samuel Thibault wrote:
> This fixes non-Linux builds, by:
> 
> - making sfdisk discard option conditioned by availability of BLKDISCARD
> - defining and using blkid_probe_get_buffer only if O_DIRECT is
>   available
> - always building src/fs_statmount.c and src/tab_listmount.c, they
>   already contain proper conditions to make them void if support is not
>   available.

 Applied, thanks!

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

