Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC251C84D7
	for <util-linux@vger.kernel.org>; Mon,  8 Dec 2025 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765202424; cv=none; b=JKETcqCecsFJsG1oBx1AfErAkwo7YDhUkdIWXSvyEroBwFRNSIgldAmoRKIElT0nrWWeVPGH+pkHtxWTjGgAZx427YDfoEORsGVivealy8Y2wjrSYwwKr4M4Cjm1GxjNnouKFASYljZyLFGGJzMHUo3wUNHXRw/Y6scg1QMSM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765202424; c=relaxed/simple;
	bh=VBYCVIecd3ADq+iy+ZDP4OhwDTEDEWTXf29uvZlCImI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N+l/mFbdbQPqkebAD1JhBedg8ShBXi9jDLnQE5SsnUVLmNvcXUUw1iW1Lmf7mfqS9OUvg6SrqhHVC+reEGKNEXQn49ihdkPbFeAQfAQxlgX5bhCack3Ue8qUVSIXmpenKwvxttoiByc3HZyLvy6xQD9+oxu9EtJWjf6djfOPw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsP3XvDV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsP3XvDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765202420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=t7q+QL+bmvFgdK75Q/SyWnmxjC0rgijqp4lQiLHR0Ek=;
	b=BsP3XvDVDAMcjNWu/tcpCOD5J7esdtGh7ZYKIra6B3Zpt7/zWzJxOivTmdauJANiByopYE
	LiVq8xk3AWlH7o/GR+vBYh1yEL6uVj9OKgnMk5G51yFPTwndHgxCCG8VaF/ENOsLR5bonz
	8DN2lvv3Sh8uUy0c7voAn9sMwb0w/cM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-QvkaHjzwNm2YJhR-o0E_oQ-1; Mon,
 08 Dec 2025 09:00:18 -0500
X-MC-Unique: QvkaHjzwNm2YJhR-o0E_oQ-1
X-Mimecast-MFC-AGG-ID: QvkaHjzwNm2YJhR-o0E_oQ_1765202414
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E8A81800378
	for <util-linux@vger.kernel.org>; Mon,  8 Dec 2025 14:00:14 +0000 (UTC)
Received: from ws (unknown [10.45.242.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 764A21800346
	for <util-linux@vger.kernel.org>; Mon,  8 Dec 2025 14:00:12 +0000 (UTC)
Date: Mon, 8 Dec 2025 15:00:09 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.41.3 planning
Message-ID: <ajxw7xn6mh3puhs44cmj5mxxe7stxqwqi3vzzzueqa4srn2zgx@iukpxdgp4dkk>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



Hi all,

I'd like to release the stable update v2.41.3, primarily to provide an
upstream tarball with the fixed CVE-2025-14104 and to fix compilation
with gcc-15, along with some other minor fixes.

Do you see anything in the master branch that we need to include in
this stable maintenance update?

For the current state, see the stable/2.41 branch.

    Karel
    
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

