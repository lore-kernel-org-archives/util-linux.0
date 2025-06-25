Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD53074AD
	for <util-linux@vger.kernel.org>; Wed, 25 Jun 2025 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839007; cv=none; b=t/RYVJ/IDGf0Trghs7+gZLiZbPP8htNx771XrI+xkZkp59Vw6KLmH60Y0VC5enBQYA3Ya9ihzQUMcBkcThJ7/QkeswJJtgCrMWjqcG2N4KhidXi9vZ4pGXvJHXhZFTZATY64udJeSlHG1ACzddkgVyZ40VJuhb8XgkB669a9AGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839007; c=relaxed/simple;
	bh=7tlhzolyCdAknOOTjuyJogCRpd+G1003saNVqZpF8gc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u584wAmMYZIFII/beKoKRYh5RpGU8z2yN3cfjfyDwutTtqLH9DNoQ1+JGFnJ7dozqezVxshVJKDvZCFvE0C5pTzzlvySNNaH8bZn0swF4c5Kz/rhQ22MR1iX0SjVMf9Yntld7tMKkM8tMEa7J/udqoltci3xs6f7TjfhSpZijKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=d8a2KPYV; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="d8a2KPYV"
X-KPN-MessageId: ebe29f05-519b-11f0-bc2d-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ebe29f05-519b-11f0-bc2d-005056ab378f;
	Wed, 25 Jun 2025 10:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=xnaAKYaVte2tjfvT3h45L4lxqJ4zOx8nevLPUthunkE=;
	b=d8a2KPYVkReCnuYINg6gH0FmBWJIvuslewi6zHVMSADgD/sq2fEnmPqKdhPRmJMqjnVbJH2GOiEFv
	 4SHf0RkZ+hvElRcF30OjxhRYhPd4iG04Cci4IiLpwmf54j+UYrg//HFY8qXLPA/1Vr/XzQ7Mz3l3Cb
	 7UZDoc/7WLVz7BP4=
X-KPN-MID: 33|K+jG2BD+6U4YkgL/IJUETQqO/LBDHyBOVFezSdHPyUpKiu9EUVs2bPSK6zsn30N
 pJ4fZWCIshMYiet0FFrfpbzdyGniKJyk9qrO3UxpC1lE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YnI8KMgTvVkyaoKbiUIWmi3IbEK9WI8A0Z8KvotuHM6PFK+Y/xwY2mHQwUhO2PK
 9L5X2oPhH9yK6CqZeiWacog==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id c6e6ad38-519b-11f0-9c7a-005056ab7447;
	Wed, 25 Jun 2025 10:09:54 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] chrt: (man) correct the short form of --ext, from -d to -e
Date: Wed, 25 Jun 2025 10:09:47 +0200
Message-ID: <20250625080948.6064-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes 3e667cf7ed from last month.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.1.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index 5b8d7e832..17d683ba7 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -66,7 +66,7 @@ Set scheduling policy to *SCHED_IDLE* (scheduling very low priority jobs). Linux
 *-d*, *--deadline*::
 Set scheduling policy to *SCHED_DEADLINE* (sporadic task model deadline scheduling). Linux-specific, supported since 3.14. Since util-linux v2.42, the priority argument is optional; if specified, it must be set to zero. See also *--sched-runtime*, *--sched-deadline* and *--sched-period*. The relation between the options required by the kernel is runtime <= deadline <= period. *chrt* copies _period_ to _deadline_ if *--sched-deadline* is not specified and _deadline_ to _runtime_ if *--sched-runtime* is not specified. It means that at least *--sched-period* has to be specified. See *sched*(7) for more details.
 
-*-d*, *--ext*::
+*-e*, *--ext*::
 Set scheduling policy to *SCHED_EXT* (BPF program-defined scheduling). Linux-specific, supported since 6.12. Since util-linux v2.42, the priority argument is optional; if specified, it must be set to zero.
 
 == SCHEDULING OPTIONS
-- 
2.48.1

