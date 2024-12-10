Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19978F4E
	for <util-linux@vger.kernel.org>; Tue, 10 Dec 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831098; cv=none; b=Xv/STjvtamoZFjE1QoFYZ4TgXdLV4b/bMZfPk9r5iebjwpaXGnsZt9FnR2YFlvcCF9KRMq00uAUq2vyX6MLodlwFlTH0whKpLQSHe18/C9ZJ546ijZIsUp0q0pTJ2V5iNN4GczHnJ3aV9wExx/29QyQ9mJqqWXAQzky2R3cWp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831098; c=relaxed/simple;
	bh=Gg16wRm1qgajrK0Jr8Iz07l9geA+jLrciDFhIJZhLJg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bCq3xf41+nM493h9Xpchq6VApEtSRMjFShdP03X86Io+t5/LMcGK8mIRc0PAZnWXPzErrbyRPZ9gHwHeh1INLomXLNIzpepBF6c0lezIm6/LFSu4vAXxHpbxK56Fv2t5sxl1GddemzjOGuD4zPLK9uEKhPkJUOWU+8T/DAlm+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoLOUU/N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoLOUU/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733831096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=M6QgBk4uK26nBhzaKRmyCRBVc9Up2N5sWj995gxeXPA=;
	b=hoLOUU/NAnM7YZoYp32X3uWv/m9p6mp6KLHaN1ufoTWR4Zj0Q1SctGIl7ahfTYSKnomGZw
	tlaNsZ6nKZNMcLFvxpUoxDKJkzhF6gteI/m4FUvn1NbVrFZi3uHemOEzIAg4V/egleZHN2
	hjfl9wSWgNV4ul1IH9evX2db5qybgR8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-8Z0q1qKfNmOIVpox2axpeQ-1; Tue,
 10 Dec 2024 06:44:54 -0500
X-MC-Unique: 8Z0q1qKfNmOIVpox2axpeQ-1
X-Mimecast-MFC-AGG-ID: 8Z0q1qKfNmOIVpox2axpeQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD819195608E
	for <util-linux@vger.kernel.org>; Tue, 10 Dec 2024 11:44:53 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F2761956089
	for <util-linux@vger.kernel.org>; Tue, 10 Dec 2024 11:44:51 +0000 (UTC)
Date: Tue, 10 Dec 2024 12:44:48 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.40.3 plan
Message-ID: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


Hi everyone,

I would like to announce the upcoming release of stable maintenance
v2.40.3 from the stable/v2.40 branch in the next few days. 

Please refer to the following link for the current patches in the
branch: https://github.com/util-linux/util-linux/commits/stable/v2.40/

If there is anything missing or if you would like to add something to
the release, please let me know.


The next release, v2.41-rc1, is expected to be released at the end of
December or in January.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

