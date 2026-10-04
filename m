Received: from out-93wp-a34.jellyfish.systems (out-93wp-a34.jellyfish.systems [104.207.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E8244687
	for <util-linux@vger.kernel.org>; Sun,  4 Oct 2026 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791081709; cv=none; b=M7e10zJ8f9FyRrltb1f8UBTfKgQQ6T4G/jrBWMDfx6lCNGto4vejjKY6ihKz49X42GPeLi5oyt6n10dN6Nnr1Ddg2mESMP9za5ewG+xBydBBwhUvjdohAtOfqbs6qdi6SXJs1fmwl2usMiC4d9wA41huezQ5KTs/e0mZu8174i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791081709; c=relaxed/simple;
	bh=s291n73mDJypffBQ5azmJc8DR4CMRfGJWvSLwFi55CU=;
	h=Message-ID:From:Date:Subject:To:Cc; b=co5TJZ9tsGCnQ7BuPEB6H+23rcA7bCPuW1NZgkDUZFspL6dEjCY7eTtQdf074ZfVnXiIER13WdcQn6Cb5GTgpyfX4H5kRwHjJb3j9wMIPWkaYT9pvsZrpstmIDPJZey6SBUaJka1hnzBu+4vMr4QjeUe4Ne9MUH2I6ayZCRwd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=QeM0AVFF; arc=none smtp.client-ip=104.207.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="QeM0AVFF"
Received: from [10.18.116.108] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hy6Gp22Gzz8sWS;
	Sun, 04 Oct 2026 02:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1791081699;
	bh=ak0DeM4ssZWxvOt6lTaVHmdoZ13EZj7EwF+N4FJcOdU=;
	h=From:Date:Subject:To:Cc:From;
	b=QeM0AVFFTQIkPYu7iN/L7iTIfdFDhtWpCtxNtWWbcurKGsCifj6BQO10v2q+wVtSp
	 8s0Vg5cajldf5jLeSLxn4xzNWiOQoyYKE76ICKVpKxd0fWKn1W39OItp7kxHSxq+zW
	 Arl0ghXLtO+hsUYREo/Sq9hoebtCEkGg5WJz7s3OJfXeBLpsMJlFV7ovEhUz9fJyK5
	 ui6dvzSnvGSC+93op/Ii8QA/f0/3nqpQo2BTGj2syV9Zwn8s+Peil9n8kWJEO0SgdK
	 t3g2ysl+0ThepuQMESNSPiFzJPyLo0ouM3KTEG8Xfw1gEEoTk8jwUzPMIu6tPCZLtt
	 78Cwt6+6+g+kg==
X-Mailbox-Line: From 7c812fc97f090bbf42479c455fb65df6f5f2135e Mon Sep 17 00:00:00 2001
Message-ID: <cover.1791081687.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Sun, 4 Oct 2026 11:41:27 +0900
Subject: [PATCH v2 0/2] libmount: preserve reused loop devices and request direct I/O
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
X-Envelope-From: hi@tychen.cc
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

Hi Karel,

This revision addresses your review of PR #4646. The reused-device fix
is now separate from the direct-I/O option.

Changes in v2:
- Add a specific diagnostic for direct-I/O mode conflicts.
- Use ul_strtobool() and the test-suite cleanup helpers.
- Document buffered-I/O fallback and how to check the effective mode.
- Add the option comment header and reused-device debug message.
- Remove the AI attribution trailer as requested.

Built mount, umount, losetup and findmnt with Meson. As root in a private
mount namespace, loop-reuse, loop-direct-io, regfile and fstab-loop all
passed. The direct-I/O test also checks boolean aliases and the conflict
diagnostic.

Thanks,
Tianyi

Tianyi Chen (2):
  libmount: keep reused loop devices attached on mount failure
  libmount: support explicit loop direct I/O requests

 libmount/src/hook_loopdev.c         | 41 +++++++++++++-
 sys-utils/mount.8.adoc              | 13 ++++-
 tests/expected/mount/loop-direct-io |  6 +++
 tests/expected/mount/loop-reuse     |  1 +
 tests/ts/mount/loop-direct-io       | 84 +++++++++++++++++++++++++++++
 tests/ts/mount/loop-reuse           | 23 ++++++++
 6 files changed, 165 insertions(+), 3 deletions(-)
 create mode 100644 tests/expected/mount/loop-direct-io
 create mode 100644 tests/expected/mount/loop-reuse
 create mode 100755 tests/ts/mount/loop-direct-io
 create mode 100755 tests/ts/mount/loop-reuse


base-commit: 55e3c4dba6101a47ecaae71c91edbe10c59b8d56
-- 
2.55.0


