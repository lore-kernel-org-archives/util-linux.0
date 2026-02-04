Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0AD3ED108
	for <util-linux@vger.kernel.org>; Wed,  4 Feb 2026 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209318; cv=none; b=fjtReGW5kpqGENBXU3MG9ICNdMKKFixsr3BDVk15b/QPMl3Nl2TP+Za2QbmY2JrymtVl3DptK7/lSXlX0mareqL33V9jOZcr+A8lwY+NoK6WYKNrC2jXSKWjXYuK8KSVIpwrSPGwXagD1+bVGpHHN4f5WY6OuJf0z2+DWeTFIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209318; c=relaxed/simple;
	bh=3cPPmX4kovBdLTX2tVhAo1REBlmk7NQ4aiqTR7jbF9Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sCGZNogLNi6M+4kfBtPp1YaV8Dv5QglcRDnZBACUQQB6NP7/4axLNXERLRdmWE35rbw231ce1ZfKzBafF4z7BfCaw6wE2LTQcrwnCcZROWNmE55jkomPduDasBBl2qMeRZc6NKZnoIS8sJNS7z7ULi/pyxCl9Q8iLaON0TQ902U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5kOPm/6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5kOPm/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770209317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=cs0FV2yKpWrsiA+g42GHhk8NRGIVSfpMRWKiNp1+kQQ=;
	b=D5kOPm/6dTWeDgfBL+Eh55t03OGwffhChb+++dsqnhzq9GAWubqYlOjzkWdHtbga2ytDtF
	4LiPo5IqyLnC3DxDl6vRbJH1elZYukpKj8ARWtrwRt2hiCNYUiReuIsKyCx6TAoplILn7e
	4qOUPYp9EUm5tsEjMmQHzUfjthRF830=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-ZN7nU_guO8a51G2a-FyC2Q-1; Wed,
 04 Feb 2026 07:48:35 -0500
X-MC-Unique: ZN7nU_guO8a51G2a-FyC2Q-1
X-Mimecast-MFC-AGG-ID: ZN7nU_guO8a51G2a-FyC2Q_1770209314
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B99CE195609F
	for <util-linux@vger.kernel.org>; Wed,  4 Feb 2026 12:48:34 +0000 (UTC)
Received: from ws (unknown [10.45.224.201])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D738A18003F6
	for <util-linux@vger.kernel.org>; Wed,  4 Feb 2026 12:48:32 +0000 (UTC)
Date: Wed, 4 Feb 2026 13:48:29 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.42 branch
Message-ID: <qxlfjr5j6kklyrmamigayaxnh5coolqdxpes5rnmhr7b4qw36h@leuvwc5m52mj>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


Hi all,

I'm going on vacation next week (starting tomorrow), so please be
patient with reviews and merges on GitHub :-)

After that, I'd like to create the stable/v2.42 branch and start
working on code stabilization and translations. If there's something
we really need in the next release, please send a PR.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

