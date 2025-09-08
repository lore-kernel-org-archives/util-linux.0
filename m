Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AE2EA752
	for <util-linux@vger.kernel.org>; Mon,  8 Sep 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325781; cv=none; b=oYS+T+77BWIJSxc/fCuISIDwEFWbZmyA9RYTse2dZItYpLYiVrHqLN0pyyY4dAaq0kR9fyC4OfY7Er/An5rPLjfHSc9Wa2vfJxMoKwSL3umMjaaH/QegRmD3eKt0Gbu5wxOZJ7o3e4oygJGRYjgCMjxVLMKhmgnL1VXnAml4g5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325781; c=relaxed/simple;
	bh=X9kJu+naBJn8WmvVJZedzfTEPV7phdUX2ajsi1rRcBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp9HPO511Ck+CrOIbjXlHTeh46yjtpNCTNKaTjJ3JW/KgDzszDCjjYGQKJKg0UrjJAuKrY10cq/jT2CjNbBnLmqAuA3KLQA43MRpg0l1wNVZueKTtWSPZ6QpLiQQ1Me33jGHh9OQJyf8m8EDwtd426vpGZYQlQK9reZ0plnTuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUnaX3gq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUnaX3gq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757325778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R1A+jYR9/8Ae/4zdRcJjFLjQQiZ/HYzmQE6+kc7JXg0=;
	b=UUnaX3gq6Aj2N29je47YgqP6yQw3APSMZgB6o03J7fz7ETKR5QYJARflav5R3vW2fR8cyB
	84qBwCzUVzx6kMvf/KGt9qN7tXKKftFSNIn/9TuEeYrD6ONV+Vpa0XvBTP4yAEzHl52ei2
	XRDYlnhllSJFRrvnrA8JoNCesC4E9eo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-lQLX6JazO8ixNxf5ziykyg-1; Mon,
 08 Sep 2025 06:02:57 -0400
X-MC-Unique: lQLX6JazO8ixNxf5ziykyg-1
X-Mimecast-MFC-AGG-ID: lQLX6JazO8ixNxf5ziykyg_1757325776
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B448180035C;
	Mon,  8 Sep 2025 10:02:56 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73DEC180044F;
	Mon,  8 Sep 2025 10:02:54 +0000 (UTC)
Date: Mon, 8 Sep 2025 12:02:51 +0200
From: Karel Zak <kzak@redhat.com>
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: Add NVIDIA Olympus arm64 core
Message-ID: <lsqansz552oop75zrk4lbam5hasbe6pvbgdgaspalvzht7plxf@oezumjmjiwz3>
References: <20250902202837.831543-1-mochs@nvidia.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902202837.831543-1-mochs@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Sep 02, 2025 at 01:28:36PM -0700, Matthew R. Ochs wrote:
>  sys-utils/lscpu-arm.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

