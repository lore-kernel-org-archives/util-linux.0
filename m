Received: from out-2z4y-a134.jellyfish.systems (out-2z4y-a134.jellyfish.systems [198.54.127.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E34B0E49
	for <util-linux@vger.kernel.org>; Wed, 16 Sep 2026 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578681; cv=none; b=pkf1GmEkDGfaGEq/1cXLX5DMtAjHq15FQyGwpQKA1Tsan+ANfpyhoyHUlIyM0BD91/yP9GBCxjasMfohix+B+6wGLXfUXlYSFlAIv5RB5YJnHFnXZ0hA04NkKLIwuHaHdyDVSEvsA9BfyxY0NfL2fQZGmPEeudFBlvhZHIqusFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578681; c=relaxed/simple;
	bh=ySj9cEhmh5t5cdifFqOdN6pj6rHtCxQf/+Vc/+6jLlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQPba5IMP5CjweZlsoRL7BFOZX5b5TjbtRCMeTbEfwNG0YwrYeF+hJHjaCVrCEFcor3SSgN4ryMVt1XEOcj1dvMsg/hzAAnX0LlfjqxlJJN6/mSNGCrECkETYIo2vj0umQtawH6BL3MTXqx68mEDKd7jo8WvkIJH4rtJcYNihaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=pkEtIBxi; arc=none smtp.client-ip=198.54.127.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="pkEtIBxi"
Received: from fedora (unknown [117.147.120.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hlQHm0yPLz2x99;
	Wed, 16 Sep 2026 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789578325;
	bh=bK4k9QZ+nJXIL1+56HrwLUFH41g9NRiBbWE8ard0yE8=;
	h=From:To:Cc:Subject:Date:From;
	b=pkEtIBxi6ICiEemrzXFZENdwW824fNaye4x8ZTo1gjEgP/6rT1wF53dr2NP2DWMh3
	 NZ/mH+K97EaQNfDPdFjzYNhJRKuDxaL6KeSatSvvDo8ub16jOaO2e5Sau12jr063+u
	 nl+WywJ2KMdORo8s3HB4+Gj7gTSN+TagTpOxk1FxPULja4FMzxrqfqLMGToBIIXnPH
	 aSnniOIjFyeBsAkhCMri5GkU/P/j8GXWbRTjD+0bYJG6OidDae2MrHumYKyHc0FqUc
	 O0xNgUGPtYUQP3r24HouNx98ZAEML2ijxsKY47i0sC2twyBXBbU/xVVFDctal6JGoR
	 7Oo3kYwd99xSg==
From: Tianyi Chen <hi@tychen.cc>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH 0/3] sfdisk: incremental kernel updates for -N and --append
Date: Thu, 17 Sep 2026 01:05:11 +0800
Message-ID: <20260916170514.2595842-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Hi Karel,

This implements #4634: -N and --append update only changed kernel
partitions. Two preparatory libfdisk fixes cover error returns and DOS
extended-partition sizes.

In an isolated x86_64 VM, all 111 sfdisk/libfdisk subtests passed. The new
regression fails on the baseline and passes with GCC and Clang
ASan/UBSan. I also checked 4096-byte sectors and appending alongside an
active swap partition.

Thanks,
Tianyi

Tianyi Chen (3):
  libfdisk: propagate errors from fdisk_reread_changes()
  libfdisk: limit resized DOS extended partitions to two sectors
  sfdisk: update only changed partitions with -N and --append

 44 files changed, 146 insertions(+), 45 deletions(-)
 create mode 100644 tests/expected/sfdisk/reread-dos
 create mode 100644 tests/expected/sfdisk/reread-gpt
 create mode 100755 tests/ts/sfdisk/reread

-- 
2.55.0

