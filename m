Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5D393DCD
	for <util-linux@vger.kernel.org>; Thu,  3 Sep 2026 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431133; cv=none; b=P8rRKvFzj0Zr7hoQSxGmN27xcILIbniY0ZNjGNq+rIc2kzmUDCPvGWAmAkP50FAYHGE+VlgF/ZxPQsQnqVfcyzWHVjIoAAgtqDx6f/Lx/MuSYbyqd9NMvSQ72me+sr8gD2oB8qx13gZUijkVRnfScOMZkfq8w7dEqqcItguNd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431133; c=relaxed/simple;
	bh=PiBTqTsNVdnmfysZZxMfnlSGEHRLKdkxbHQRDZd9tHA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=loGZ0shUJr1EXAltXfz8hsDwokMEcktrbLkVUleZbuoBVJQt7zMPtiuteqBSnVX8ciJ49oZ9rLZq2Q9o3pejoywr/fRXUVJ5CEXsy8fTSAiD4jbFAa9pyUyOzuoOXJfcPpKjDpjWp3e+6yxzSzSIVHyqPZ3Kb51OPJIGV7FfAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXCLsbAN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXCLsbAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788431121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o4vJz60RdDZVBMwJKwp3Y3+BiU/hn0zcDCzcU2Q7ZqM=;
	b=eXCLsbANHtUDh2SzntLGJfvWFKBk0xI2jAgH5Zc3yOraEAtGH584QO8NPB0IdCamYtIlPq
	mMWgjs3mA2ggpJB479VeHTfXJyEaqFr7inaQZ1B6hkXDvWXH185oHMMczGGsLesbf95scb
	7EohjfBYUOC+SKBFxgRzDVJ72ReDYKs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-WKEs4io1O3SC4k-WqUSfJA-1; Thu,
 03 Sep 2026 06:25:15 -0400
X-MC-Unique: WKEs4io1O3SC4k-WqUSfJA-1
X-Mimecast-MFC-AGG-ID: WKEs4io1O3SC4k-WqUSfJA_1788431115
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D7F41926B66
	for <util-linux@vger.kernel.org>; Thu,  3 Sep 2026 10:25:15 +0000 (UTC)
Received: from ws (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4882518001CE
	for <util-linux@vger.kernel.org>; Thu,  3 Sep 2026 10:25:13 +0000 (UTC)
Date: Thu, 3 Sep 2026 12:25:10 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: CVE-2026-78408: nsenter cgroup.procs fd authority =?utf-8?Q?leak_?=
 =?utf-8?B?4oCU?= incomplete fix in v2.41.6 and v2.42.3
Message-ID: <aswqpdnp3yrc67y3iepuh3iu3z45yabjfxx6lomduippttm7qg@xvapsteqqpch>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


The fix for CVE-2026-78408 shipped in util-linux v2.41.6 and v2.42.3 was
insufficient due to a wrong cherry-pick — only the O_CLOEXEC defense-in-depth
changes were backported, but the actual fix that closes the cgroup.procs file
descriptor after use was not included.

Additionally, v2.41.6 and v2.42.3 contain build issues.

New releases v2.41.7 and v2.42.4 with the complete fix and build
corrections will follow shortly.

Affected versions: all util-linux with --join-cgroup support (v2.39+)

Upstream commit:
https://github.com/util-linux/util-linux/commit/afe067c97

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

