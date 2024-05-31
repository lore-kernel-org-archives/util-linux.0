Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD016133993
	for <util-linux@vger.kernel.org>; Fri, 31 May 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148493; cv=none; b=F0zmS0C+ahwkzIr5jxITiHBEox4lx9wzaQ83jtv2SgREi8hHQ7/6cF76nxelJ8hPmHvJODrHu+kU/UdX/J0JnPtlytSTj1qH28DaalPU51k67sunj4hMrCXf+bAf7ReSQn5xUhhHpDcyZVTOBSS8ehe400UbF0Agg0YOBUuJxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148493; c=relaxed/simple;
	bh=i+FXuAjVVemoFPwl4jZBIUPhiWWaCMiC0mR2I1+rxQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwt9Ev5UuRtV6BHAWt+jgoJv7ItUvyB8JCc/r5Ciw9k0RuM0S4Nue+Ft14xz86J3q4OTZRz2BpMfif1v4ywAIgL1pK1V7jxEfG1M3k2MPYZxMFlDllwpdL9KN5pM7Ico1Yo42jVyoPjt2Q31LwGtabDDRUC76PcSHzViT02slYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hodmq2JK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hodmq2JK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717148490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEMrUhtRKVSfM8A9Pscy+eB64fzRtNYHpdV1cpYf5As=;
	b=Hodmq2JKPJd2miyPNHw46PoCwe4XBJFxn0IFG0C0E+519CKpECvNBvIe3jquZfwI00uHtH
	sbUSsKvTouxUxqWndSdvfSKzas/ZzEgfGXu4Fm4sEQkQFx31j+SphUUNQz+JoXTWx7gCg7
	EUJSGjKLqdwBuGB67bewLtQTyy1dM6Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-Fo6zqGvfMzSf2rbHFkXClg-1; Fri,
 31 May 2024 05:41:28 -0400
X-MC-Unique: Fo6zqGvfMzSf2rbHFkXClg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 042641C0512B;
	Fri, 31 May 2024 09:41:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.37])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 80C8B3C27;
	Fri, 31 May 2024 09:41:27 +0000 (UTC)
Date: Fri, 31 May 2024 11:41:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Linus Heckemann <git@sphalerite.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: provide tree fd even when a mount helper is
 used
Message-ID: <20240531094125.r2nvmio47itrtzep@ws.net.home>
References: <20240530180041.3447273-1-git@sphalerite.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530180041.3447273-1-git@sphalerite.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, May 30, 2024 at 08:00:34PM +0200, Linus Heckemann wrote:
> Previously, the X-mount.subdir option would fail (mount exited with
> code 0, but the target was not mounted) when a helper was used.

Do you have any examples that can easily reproduce it?

> In addition to fixing X-mount.subdir, this allows dropping the
> fallback behaviour previously implemented specifically by the
> set_vfsflags and set_propagation hooks.
> 
> I realise this patch is not acceptable as is, since I just exported
> the previously private open_mount_tree symbol from hook_mount.c

Perhaps it is unnecessary to only keep the API file descriptors in
hook_mount.c. It is a generic feature and we may see more use
cases where it would make sense to use it in other places.

I can imagine having the file descriptors in the libmnt_context
structure and initializing them through functions in context.c (which
would involve renaming open_mount_tree() to something more
appropriate). It could potentially be a public library function so
that libmount applications can also utilize it.

I will think about it :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

