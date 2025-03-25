Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3B1946AA
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899431; cv=none; b=ui+Vu7e+7q0IHa2TyG3e7PiLko8RRvmeRgcv/B1KEp8hQrzbKZ7EJ9gHJAsgyxo225R0EVLbUNtAWaDrm+ooKVZhXVN/CiSPqf/v2vVZz0HT1yfq6X9+M5yulQ6flydwMbIT/Lzg2913vHGJCZeGDPpsE6UItbCYTgZte+N6W7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899431; c=relaxed/simple;
	bh=cvjWHuYgykUH7y8KC8TrT+a1JXHeeSV1jCy2BdLjWLA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuZ7S9+mw1feiJU3n15QX8Z38z6d/WSMmT0sL2a0bMjzrn9a9kRq7uYGccEuKahN2hNcMPRoyHsVbNeu7qGl+zZE7AQj0kewVSsc2muSCiO+rMdGorBca3k3XGZ7hOsEsWD9zrWXPPYTH6i8LDDj0HNTlaI6HSyDvYbBV9IqrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=TOVmmHNR; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="TOVmmHNR"
X-KPN-MessageId: 2350ba4b-0966-11f0-b99f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2350ba4b-0966-11f0-b99f-005056abbe64;
	Tue, 25 Mar 2025 11:44:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ZRVGIfbpHqakdS8HIU9FRM2c5aINW50Yg78qBhJCMWk=;
	b=TOVmmHNRHCpdAHR981GMWkhzqSW3JaUk8zN7xxS4rDGINO+mBdk6k4tWXwna1vxv0pUhJkSo0szZI
	 5KC/lRxIvnsLQ8uQOFcUK1/Eu1dkTFXYYMwGPJ3MeN4/9OEeEmkoldDoC8w+JSFV6a0oB9vrO0jRvF
	 W3LNvZ1pHNSw/9VM=
X-KPN-MID: 33|rN+bgNfAK4OmTB1Bq/CpXEXd0wCVL2o48PTYBcw972bmJ6dcmTCvuMGdtSlHQBm
 0nNGFbqMb1JZQhTl1OsOcBBxd08uDWq0gJJnXHWLmeUg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|RtGMsnMXAME36bGLKX04YQMMXt9zmRmh5ZU2U4CKZ7pSOAD7h0x4XtP8EHXbIDe
 BvNtfWHi4bPMhUoKf3FiOUQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0854f5c2-0966-11f0-9bed-005056ab7447;
	Tue, 25 Mar 2025 11:43:48 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/11] chmem: (man) add missing end-of-bold marker, and add missing OR bar
Date: Tue, 25 Mar 2025 11:42:59 +0100
Message-ID: <20250325104305.23980-5-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325104305.23980-1-bensberg@telfort.nl>
References: <20250325104305.23980-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, use "EXAMPLES", in the plural, as there are four examples.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/chmem.8.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/chmem.8.adoc b/sys-utils/chmem.8.adoc
index 029bc0832..f30f3a369 100644
--- a/sys-utils/chmem.8.adoc
+++ b/sys-utils/chmem.8.adoc
@@ -12,7 +12,7 @@ chmem - configure memory
 
 == SYNOPSIS
 
-*chmem* [*-h] [*-V*] [*-v*] [*-e*|*-d*] [_SIZE_|_RANGE_ *-b* _BLOCKRANGE_] [*-z* _ZONE_]
+*chmem* [*-h*] [*-V*] [*-v*] [*-e*|*-d*] [_SIZE_|_RANGE_|*-b* _BLOCKRANGE_] [*-z* _ZONE_]
 
 == DESCRIPTION
 
@@ -64,7 +64,7 @@ failure
 *64*::
 partial success
 
-== EXAMPLE
+== EXAMPLES
 
 *chmem --enable 1024*::
 This command requests 1024 MiB of memory to be set online.
-- 
2.48.1

