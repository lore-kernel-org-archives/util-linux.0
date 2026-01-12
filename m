Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86271EB9FA
	for <util-linux@vger.kernel.org>; Mon, 12 Jan 2026 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226756; cv=none; b=tdEQ85lobxFi9dFaVONj/mvWhLVq4ny0H75GDTNwolOJs6lDWfM/A0k5oFX1cWVPFH3VTVaSEWkdr0/dH0rxCmpyuRXgFcXKhYGLl3DTuvbtbLBBsxifeEDCoK1vLuPRn5IQdbqef/t0l/hZKZ46Q4ATADN8H/e5QBVOPCu+cDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226756; c=relaxed/simple;
	bh=vBZU6kyyR182cFvWTpHuUQw6e70ThTydKg09Y9rBw2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKxZ92jTzbWK15FuqzMn4Cm1/KkdyV1pOmz4NDTaTGU6qoZEd9zrvkNBMaswqQ6jMZMVJTvt1sV9RDYH9CpENIHnmtfFYuZGLh7o6ezRaKgcb1/L15o1MX2Sjl8T2EmsW326mKOauSbIpAJF3zZ+SpAC7JhxYXr/KK3pKzH1p3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9p2jOR1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9p2jOR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768226753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50Ha5OGyJjMNCBFc4GapZls/AhZspTGyW2Ebu0FHMWA=;
	b=d9p2jOR1lKlGZ29j2oyTogINz7fTtOdP99/+HF4VXM4mL1q5c8VRfyjiXfbytlDgOWSvbu
	NcY9C2vwnI98JlP0AkxsBSACSJFZK0e6U9zwxcJJ5Ciss6kbT8myaaYPrKpIKa2VwV/okd
	EQ2mhP4+611xXcH7lIVnq1YtK3I9D2M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-PRWHz5xtNNa7GPicifWxqg-1; Mon,
 12 Jan 2026 09:05:50 -0500
X-MC-Unique: PRWHz5xtNNa7GPicifWxqg-1
X-Mimecast-MFC-AGG-ID: PRWHz5xtNNa7GPicifWxqg_1768226749
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEBDE19560AF;
	Mon, 12 Jan 2026 14:05:49 +0000 (UTC)
Received: from ws (unknown [10.45.225.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C29B919560AB;
	Mon, 12 Jan 2026 14:05:48 +0000 (UTC)
Date: Mon, 12 Jan 2026 15:05:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Kiran Rangoon <kiranrangoon0@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] unshare: fix signal forwarding to child processes
Message-ID: <3tysdpabjulwlmr3hkm4pr7romwtf6cofhghth7buyuxnmwr5r@pliehv2xicmy>
References: <20260108183134.23980-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108183134.23980-1-kiranrangoon0@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jan 08, 2026 at 01:31:29PM -0500, Kiran Rangoon wrote:
> This series fixes a bug where unshare with --fork was not properly
> forwarding SIGTERM and SIGINT to child processes, causing premature
> termination during system shutdown.

Thanks. 

Created PR https://github.com/util-linux/util-linux/pull/3961 to test
by CI on github.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

