Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7CB2D4B66
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995978; cv=none; b=c5G/PAyQk2CTcy/WueEWJemfjfDxA132ywbse71TvYdZRhsjgfq2o1EaaDplgHyCC65AAMs3plh1ZX2mvojm62WbPE6jBg57yRf2UxSQvdfc5b+b6mdlK89cTB+V50WTVePLwcnQw3FRjK7IM+yCMmNcWAU7WRFvgS2UsUP3gU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995978; c=relaxed/simple;
	bh=dIR4iZerqeTu2G0vU+Lg8B3M7a5gAXXJQNLU9XNfQek=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HweprIH/SrFwHNVjDDWN+TjR1+gMFnrej2t1zBebH14gOfB7vGABmQIOGfKIVSLFUDCdUKnOxjck/rLnXfz06VjNmEk2X3nbWadOGwde+GGtsR4zn1hI5trDoiTVP/Bn/mKsphpUAujxqJTW0GxKvWmBjQEbamRBvC1wmRBVtc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPIkOONe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPIkOONe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765995974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=83j8u1KonoQRR7wyQpbYWcaewbnBk8zhkqDePkdrQWU=;
	b=iPIkOONefRguJa3hKqxtpyRbUVZhDDLSllgTEgl94sxiuOhDXHeYyrvgiBoGeqYnULJqhM
	IjkmOqDgfjzsqHq0MBeEWqEW0WhSp/Rpm3x/xtVnBpKq2B6LAxeG3LiMGPZGwvczhJov7U
	nZK1S5GuYhAZHmdE9CwOZaqJUGvRF14=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362--s8sfFJLNeS48aLukOZ6xQ-1; Wed,
 17 Dec 2025 13:26:10 -0500
X-MC-Unique: -s8sfFJLNeS48aLukOZ6xQ-1
X-Mimecast-MFC-AGG-ID: -s8sfFJLNeS48aLukOZ6xQ_1765995969
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FDC018002C9;
	Wed, 17 Dec 2025 18:26:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02DEE30001A2;
	Wed, 17 Dec 2025 18:26:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: util-linux@vger.kernel.org
Cc: kwolf@redhat.com,
	hare@suse.de,
	Karel Zak <kzak@redhat.com>,
	pizhenwei@bytedance.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/3] blkpr: add read-keys and read-reservations commands
Date: Wed, 17 Dec 2025 13:26:04 -0500
Message-ID: <20251217182607.179232-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

v2:
- Use #ifdef IOC_PR_... instead of autoconf/meson because it's simpler [Karel]

New <linux/pr.h> ioctls make it possible to fetch the list of registered keys
and the details of the current reservation from a block device. The relevant
Linux commits are:

3e2cb9ee76c27 block: add IOC_PR_READ_RESERVATION ioctl
22a1ffea5f805 block: add IOC_PR_READ_KEYS ioctl

Add the appropriate commands to blkpr. Users can use these for troubleshooting
and cluster management tools may use them to query the state of persistent
reservations during recovery.

Stefan Hajnoczi (3):
  blkpr: prepare for _IOR() ioctls
  blkpr: add read-keys command
  blkpr: add read-reservation command

 sys-utils/blkpr.c      | 106 ++++++++++++++++++++++++++++++++++++++---
 sys-utils/blkpr.8.adoc |   3 +-
 2 files changed, 101 insertions(+), 8 deletions(-)

-- 
2.52.0

