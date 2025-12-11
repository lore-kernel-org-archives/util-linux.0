Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8BB22068A
	for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469406; cv=none; b=k9NH0pLy1o/MauM2Nm/9PSeYGgaDkqamDf/Fa+9TFwqJWMjph7jKs0aiRBTwkOR5pTgxtdWznN8pKkqpIS+BON8dIzwWc8L/7eLkAWHK9fRjQucXniOHiTW0zJuW74cei3RhxsilmDXBDgnUmdyMsOtANHDGELswN8oQ2XChyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469406; c=relaxed/simple;
	bh=zGmVma6VmfRYX2U7DEGMhFFDl5KnzI19RRmQxQ5QbG4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YoXT7gbdXlJ/Ah5hhmN+FlojkOyoACvaa2LgxkcJwlMA26iQF2Gc7iB3cR7OPusKfzfufMXroI//1qmKj64YoM2RNtll3WA7uag+9YneHJDo4WtkD3U/EKgW8Xyp/SmrBg/FJ7y+cBbNJ8HX3k887gXzgWcYiJi0X0r7FaCpqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9Og55D+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9Og55D+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765469403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fWVWHw6jBQvWA+D7agtBGCjQUFTXtHM2pMOGVEV0tcA=;
	b=E9Og55D+0uE0SoQVw3eDEyQu0l0zPkUPVUlXCpn/wiSkYogh7otDPGJCWx0RWaIYYT3Jad
	wJ0Tuoj0/S9FQGcP4yCfqq71T4mft42J0yIy+Ay5Z0K8/Q7Wb5fMvOt1kMrhlhB8wKLfET
	XBDmqgwDsnl5I55lRUMbIk3ZUPY3OUs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-I7fEZyQVOW-25oMcCjFg9w-1; Thu,
 11 Dec 2025 11:09:59 -0500
X-MC-Unique: I7fEZyQVOW-25oMcCjFg9w-1
X-Mimecast-MFC-AGG-ID: I7fEZyQVOW-25oMcCjFg9w_1765469398
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C691F1956095;
	Thu, 11 Dec 2025 16:09:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.208])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29CA71956056;
	Thu, 11 Dec 2025 16:09:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: util-linux@vger.kernel.org
Cc: pizhenwei@bytedance.com,
	hare@suse.de,
	kwolf@redhat.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/3] blkpr: add read-keys and read-reservations commands
Date: Thu, 11 Dec 2025 11:09:53 -0500
Message-ID: <20251211160956.1540114-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

 meson.build            |   6 +++
 sys-utils/blkpr.c      | 106 ++++++++++++++++++++++++++++++++++++++---
 configure.ac           |   8 ++++
 sys-utils/blkpr.8.adoc |   3 +-
 4 files changed, 115 insertions(+), 8 deletions(-)

-- 
2.52.0

