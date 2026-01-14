Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDA311C2A
	for <util-linux@vger.kernel.org>; Wed, 14 Jan 2026 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383064; cv=none; b=EOMkf8SoUygbw1+eSlf6i9SL9IYFyvuBrPgY217Mcc8KSqUJka4ypmMTKeyVtA2+UtbfaVe+Ab1GL7onaZGKw22Vh9kOZMcgnfhxaHVKLGn8xMfyvvYMs6O+GH1DMY51qahOsdtM5sxW5KNyFJtwBwZVFeotqPdqQgeIVbrY4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383064; c=relaxed/simple;
	bh=aCA+MlbuvZwy4duyoYX4mT8GLHBc6TMiA4aa+4f4VsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzlhkys9xdMT4CX3HMJ6llMCE0ma7ci+wj5B8/HiD7CEYYCuyzrQukuaOJw3zHKNV8EIghyVqq7JqEykzxWzsL8We83hN1/xt3rRSzK/jfzL8udtgPdQbu1vAGTgOHUrpu9Y7BhLZaRz48m9T3uCZ8z9FyX7km6QTzckTz/Nk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgGgdfo0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgGgdfo0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768383061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=teVAgHYQ+q7nLyVjBRS8UUeVtBSm4NiA9qVyxyXCaVg=;
	b=TgGgdfo0UZcbGnMcPJLIzzsc9rN+AaA3Sn++sGSa0LrS/ASpffIDWFS2YLwGsPr3VSwrTs
	50MdgS4eW+abY93vW/gRMMaWk5X/h9ZXEkWzsDMwndTlFAaqsacM3WWR56kvyH5Vg7tSja
	vo0f6yONTGt7af1aLzfpdLc3lPckt1Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-b6cmozdWNxieQfwkWtzhVw-1; Wed,
 14 Jan 2026 04:31:00 -0500
X-MC-Unique: b6cmozdWNxieQfwkWtzhVw-1
X-Mimecast-MFC-AGG-ID: b6cmozdWNxieQfwkWtzhVw_1768383059
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81CE31956088;
	Wed, 14 Jan 2026 09:30:59 +0000 (UTC)
Received: from ws (unknown [10.44.33.173])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00D8D1800665;
	Wed, 14 Jan 2026 09:30:57 +0000 (UTC)
Date: Wed, 14 Jan 2026 10:30:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: util-linux@vger.kernel.org, kwolf@redhat.com, hare@suse.de, 
	pizhenwei@bytedance.com
Subject: Re: [PATCH v2 0/3] blkpr: add read-keys and read-reservations
 commands
Message-ID: <36rzq4in4oozqyahq3g7ux53jjnsjkvnlrso4auyoitrf6vuj6@4hejyeatmif7>
References: <20251217182607.179232-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217182607.179232-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Dec 17, 2025 at 01:26:04PM -0500, Stefan Hajnoczi wrote:
>  sys-utils/blkpr.c      | 106 ++++++++++++++++++++++++++++++++++++++---
>  sys-utils/blkpr.8.adoc |   3 +-
>  2 files changed, 101 insertions(+), 8 deletions(-)

Applied, thanks.
https://github.com/util-linux/util-linux/pull/3965

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

