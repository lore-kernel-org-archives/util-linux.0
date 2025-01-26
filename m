Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2B1362
	for <util-linux@vger.kernel.org>; Sun, 26 Jan 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737889845; cv=none; b=V6NbeDuw6wNW0UMJ1xvtz7eQvuqClVRBXwwtm1Tl/BQd8nQ9MhTO39gUQp3bfBP0JsKsF/QSMz2IFEpOrXvxkVvgqxoeuAK3kiLXZlxS2M+/pyuJY2LeZIyBIWcbXGub83OM5kfi86LSYsMOCblJtwRbHMkFsaALFVpYxr5DDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737889845; c=relaxed/simple;
	bh=mwTSbzr/coZk3/LkLmlsUFrB9hLnK8OU2IK3cGoi8mg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U45Zc7/tgDsZXS3i9O8b2y7cDtuTd+hW39fstuH/frFcPGlcrJIKPH5vzhn/MHZPaf15sye4/THqnsp2AJvLS29BCKsCuVFTkq7Kr5xtUThFrlnohCXkr3cW10LR8k3c6vvmaawe1u3+87RqWvZp57gOaQGur3nIscF80TMJhrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=fz0UKf8Y; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="fz0UKf8Y"
X-KPN-MessageId: 50f3344d-dbd6-11ef-a841-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 50f3344d-dbd6-11ef-a841-005056ab378f;
	Sun, 26 Jan 2025 12:11:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=QwBwr8KYY3FCIAvLl/WyLyl1xs1r9f3TyAxsRGI6tw4=;
	b=fz0UKf8YYIpjhn3nPRJcA1NWssV2/XsKbFDHCfhGp+kK8SzyIFCjNh/YmjqqiPJzjEVqKIeHSsyvx
	 QnRBAPnBVzUmvUp+qJnk9WQt7tG0xeFY+S4rv1JyfRW9GuCLFqZ/1J9SRkQD3XTXUYxS9VYCx2pxgP
	 y5jro3J3mH0R5S38=
X-KPN-MID: 33|8+wBuOMPpkW3ZAy9ttFzUtVnxwXp7rSXWrMgwyLskJIVdvvW9C5mo4BP7AahyNM
 wxrvUR0uBxMBrgfBePLdOU8rVNfB1/rGWlJjjycieb2c=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|eWlECPhjN32cGEUjCSqbG2Dagyni81Dpb7PYLhVzTejVh2szmk8SK9wXaqqHTIx
 EHdIw59HJKNbszpMOkpmceA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 05a1d462-dbd6-11ef-8e27-005056ab7584;
	Sun, 26 Jan 2025 12:09:33 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] lscpu: make three column descriptions more grammatical
Date: Sun, 26 Jan 2025 12:09:24 +0100
Message-ID: <20250126110924.5611-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change an adverb to an adjective, use the plural "lines",
and use the plural form of the verb "have".  Also, put a
clarification between parentheses, and reshuffle it a bit
for clarity.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/lscpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 21c5a99cf..9dd12a64f 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -146,7 +146,7 @@ static struct lscpu_coldesc coldescs_cpu[] =
 	[COL_CPU_ADDRESS]      = { "ADDRESS", N_("physical address of a CPU") },
 	[COL_CPU_CONFIGURED]   = { "CONFIGURED", N_("shows if the hypervisor has allocated the CPU"), 0, 0, SCOLS_JSON_BOOLEAN_OPTIONAL },
 	[COL_CPU_ONLINE]       = { "ONLINE", N_("shows if Linux currently makes use of the CPU"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_BOOLEAN_OPTIONAL },
-	[COL_CPU_MHZ]          = { "MHZ", N_("shows the currently MHz of the CPU"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_NUMBER },
+	[COL_CPU_MHZ]          = { "MHZ", N_("shows the current MHz of the CPU"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_NUMBER },
 	[COL_CPU_SCALMHZ]      = { "SCALMHZ%", N_("shows scaling percentage of the CPU frequency"), SCOLS_FL_RIGHT, SCOLS_JSON_NUMBER },
 	[COL_CPU_MAXMHZ]       = { "MAXMHZ", N_("shows the maximum MHz of the CPU"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_NUMBER },
 	[COL_CPU_MINMHZ]       = { "MINMHZ", N_("shows the minimum MHz of the CPU"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_NUMBER },
@@ -163,8 +163,8 @@ static struct lscpu_coldesc coldescs_cache[] =
 	[COL_CACHE_WAYS]       = { "WAYS", N_("ways of associativity"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_NUMBER },
 	[COL_CACHE_ALLOCPOL]   = { "ALLOC-POLICY", N_("allocation policy") },
 	[COL_CACHE_WRITEPOL]   = { "WRITE-POLICY", N_("write policy") },
-	[COL_CACHE_PHYLINE]    = { "PHY-LINE", N_("number of physical cache line per cache tag"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_NUMBER },
-	[COL_CACHE_SETS]       = { "SETS", N_("number of sets in the cache; set lines has the same cache index"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_NUMBER },
+	[COL_CACHE_PHYLINE]    = { "PHY-LINE", N_("number of physical cache lines per cache tag"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_NUMBER },
+	[COL_CACHE_SETS]       = { "SETS", N_("number of sets in the cache (lines in a set have the same cache index)"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_NUMBER },
 	[COL_CACHE_COHERENCYSIZE] = { "COHERENCY-SIZE", N_("minimum amount of data in bytes transferred from memory to cache"), SCOLS_FL_RIGHT, 0, SCOLS_JSON_NUMBER }
 };
 
-- 
2.48.1

