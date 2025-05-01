Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7691A3179
	for <util-linux@vger.kernel.org>; Thu,  1 May 2025 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746086327; cv=none; b=KC+6gSdvTufeajvtSGNTxGQDyEzKZTkrdXCfWAk/7Ka4x6/Dql56gsLInMVIeOhZhEqRqU50OC7xRVzTh0LxNB9w/R+6Wp3IjwPCMamYrU0RbmESmna7Dxj6AaZ7ah5Yui5tLbNbHMi/YlCgB2kNLQkzCi5Ks1P1n3GKQNEyTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746086327; c=relaxed/simple;
	bh=j3rUntPj5sMkYvslrT2HnVIXLnWPv+KtqgvsPNfyLjA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YE2qSlVarxSGcqgbV5kGORvLHNBN9UAvIp2OyVASjPREiAkWLuPTI5NeI8IZkWqP2diivhMyJQsaKRRtuV6ROyKQ6qvgFfmKq1h8ng3MvCDz13NH2LnWd6K0dV8Gvtm/hSckjYBiRi5aSbIwO83MpW7aonYJg6CypjwNBicj2GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=mNlNmHFy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9SrIubz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="mNlNmHFy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9SrIubz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 178E7114016C
	for <util-linux@vger.kernel.org>; Thu,  1 May 2025 03:58:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 01 May 2025 03:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1746086322; x=1746172722; bh=Rnw3fgvQNHSJUSKVtVgyd
	5axY2/yyxCQRpc+pFH3Bm8=; b=mNlNmHFyuBN7q8yG+2Zl2vurYzCoNVyzm3pXt
	1rbFVDNCFdiD7RTF0R7vQ8iNRvODhHUf2nbTD2TWVT7nRTvlmH9QujRnhI4uDo1Q
	bvlhju5zoJfH2t9uHCsgE+NDk12GMI6zXzb9IOhyPXaWdJ+jFoxXItOkbuqPYxxn
	3q48hRCgKgc2NO6U9tP8QF/tbxt5/kE8qNdz2NNKnh70AMfoiabythfcVQV65d/N
	T1JC1MDlId4QNw8hmml7U9saxHuc2TmaS4yaj2gB/IcX7I6TGuiXzUUEDhAh91iO
	yieWpJxS+lWsCrenHbOZGs5tBBt8sOWH3Akr1n4zlNNu1ylGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746086322; x=1746172722; bh=Rnw3fgvQNHSJUSKVtVgyd5axY2/yyxCQRpc
	+pFH3Bm8=; b=g9SrIubz/98pHJAthRu9UozFqtGxRQafa+kHuVBPVFwe50Jsskc
	RaD9YM3FL2aEJFewS6SDPqCLij8ZvpiBIz2hyf7l4SKeWdGKyWgU9Dgv7I4FX/bu
	zHENdQOCT4XGyRTzIu5mtqukKFUd/UfYxAdoEtFbnuOTcHmZzmk6uaqFPWLdu7SX
	Gy1TBLNEoUocIpSTFCd8FJ2x2H8+erJaigKSjZ+l/MlI+lLxx7QV27sp9Xx0H5Lm
	nbCZjSwYRpdDLdy2Z7jGJ7udj9qCDAHGU9oA2R9u1QxVnK1UFxbKeZfUSjzPjn3x
	PBEfv0STqVvlr0iyhrFw2bpGqGG1wVGyPJQ==
X-ME-Sender: <xms:sSkTaHhfJeM-f2KuCMKhLoQbkyYysBeZ93a4eDOg9b2P9cBp4oOr7Q>
    <xme:sSkTaECSRaUAgiIyE6PadO2IyxYgvmGV_6G8Z4hd2bNBUD8isZke0IG_v__edmVWB
    L53lHutr66HIOIovQ>
X-ME-Received: <xmr:sSkTaHEdZSol1xfWLgqaEJ1cUgve7d4ymhea0_QI-cXVaISDKQ8U5Q5AUwy38udx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgrucftohhsshcuoehh
    ihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhephedvfffghfetieejgfetfe
    dtgffhvdehueehvdejudfggefgleejgfelfeevgfefnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhspdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehuthhilhdqlhhi
    nhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sSkTaER7kEyyW10vOAQ1vui5G7_D0GifliYeMLQz4JLNa4iZ080L4g>
    <xmx:sSkTaExYNz-p85jteQ0H_ZdOnMBHHOBw1SWAfHjbsvgAoh2frm4WDw>
    <xmx:sSkTaK5823IqxISExUdhL3R-uUXRNdNzVYC1UTJq_WdFgkjIGg3J6A>
    <xmx:sSkTaJz7fWBQWiLK91l4YKB-yK9BqQ1_OGFj9sfWfirayzCZpvZAxw>
    <xmx:sikTaAf1iglYzSo8hd9L0hoHaKUrAOU5zfTby77wB17InHIakt2GmKkJ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <util-linux@vger.kernel.org>; Thu, 1 May 2025 03:58:41 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 4863811F83; Thu, 01 May 2025 09:58:35 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] bits: only build when cpu_set_t is available
Date: Thu,  1 May 2025 09:58:06 +0200
Message-ID: <20250501075806.88759-1-hi@alyssa.is>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Doesn't build on macOS.

Fixes: 6e1301d59 ("text-utils: add bits command")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 configure.ac | 6 +++++-
 meson.build  | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index a5d910204..ac043d856 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2309,7 +2309,11 @@ UL_REQUIRES_HAVE([scriptlive], [pty], [openpty function (libutil)])
 AM_CONDITIONAL([BUILD_SCRIPTLIVE], [test "x$build_scriptlive" = xyes])
 
 
-UL_BUILD_INIT([bits], [yes])
+AC_ARG_ENABLE([bits],
+  AS_HELP_STRING([--disable-bits], [do not build bits]),
+  [], [UL_DEFAULT_ENABLE([bits], [check])])
+UL_BUILD_INIT([bits])
+UL_REQUIRES_HAVE([bits], [cpu_set_t], [cpu_set_t type])
 AM_CONDITIONAL([BUILD_BITS], [test "x$build_bits" = xyes])
 
 UL_BUILD_INIT([col], [check])
diff --git a/meson.build b/meson.build
index 1537f5e61..6e0381646 100644
--- a/meson.build
+++ b/meson.build
@@ -1248,7 +1248,7 @@ endif
 
 ############################################################
 
-opt = not get_option('build-bits').disabled()
+opt = not get_option('build-bits').require(have_cpu_set_t).disabled()
 exe = executable(
   'bits',
   bits_sources,

base-commit: caa26876bc75041833c9644491cc2670d623f750
-- 
2.47.2

