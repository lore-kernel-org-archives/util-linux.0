Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2AE3502B5
	for <util-linux@vger.kernel.org>; Tue, 28 Oct 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681291; cv=none; b=D90r5pFdkVlMTSEaa0tUxK4Oh4G5JZpi4fH65d2oTYrhLhNXG9wzKNn6gZhE9TZHJ3EaxKMKoYXNU+a/gpqgAqqowlKjtyPf6KUMyPP8MfwqHPQ077S2WcCQIHM5pVrYP1QD+rDQ13umnI94u3pCoP8ZlYwd36r1Azyd+8+KdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681291; c=relaxed/simple;
	bh=niqyAXEmjMPgSMg4gNQ5siOSqlu6FggtSaBdFGfULTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JUkO701CDkTWWMWOjpRsKsO74dJo7hqJi+fIKkPgADGP3DH+FK+V1eXzGznNzQn7ffFaPgFLJwfi1++ety6eBYPmnsyCqP4oYCPr2UKJvokKdE0CF48GazN3BkRr0yvH+ZBgmJxVhs9Y7zjGw03LfkYznDtV4l0W/7ATTnkeqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vi9a06kb; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vi9a06kb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761681290; x=1793217290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ekXTKVPDcTjJPJUPaD1eG2214RDjP+ePtK+vkx9WJgI=;
  b=Vi9a06kb6n8llJywGPfY6Kv/kmCEUMEwoseqRU5rolF/eWFDTFWccPOw
   TittB8Seb5OXp9I0Fs4oIrN9VJh24WELSBU9eaN+nDxTXzaar5dZ0oZ6I
   4sVC5o9iAa9FXk2ROD+16ndzRNQ7zhfLau07+LF+tA2KE/fX58JB8+kil
   5d1f4zizYA+lGt3unnwVxt+q5ldlvIvQib9GORwGO0BHKdyZ+yKLFcvuJ
   yxuhBzwrhS5pYfx/Jv83SJE7zdM8Ew6StGDbOX0uevc5aExHJsdrKyILJ
   XX1jTnBtqXKb4MXA/HQrFKFmIZ5tfyd0+Z/xaIbLpu99gU6R6xaB8sQ3y
   Q==;
X-CSE-ConnectionGUID: sS7l06QoRaqKtY3/VBIhnQ==
X-CSE-MsgGUID: 1FTowNPBSsy03n2pdXcllQ==
X-IronPort-AV: E=Sophos;i="6.19,261,1754956800"; 
   d="scan'208";a="5900751"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 19:54:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:15331]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.51:2525] with esmtp (Farcaster)
 id 3edef0e6-29ae-4ad5-94cd-f60990cb79b1; Tue, 28 Oct 2025 19:54:49 +0000 (UTC)
X-Farcaster-Flow-ID: 3edef0e6-29ae-4ad5-94cd-f60990cb79b1
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 28 Oct 2025 19:54:49 +0000
Received: from u14c311f44f1758.ant.amazon.com.com (10.187.170.41) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 28 Oct 2025 19:54:48 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <util-linux@vger.kernel.org>
CC: <adanaila@amazon.com>, Munehisa Kamata <kamatam@amazon.com>
Subject: [PATCH] wdctl: remove -d option leftover
Date: Tue, 28 Oct 2025 12:54:17 -0700
Message-ID: <20251028195417.3569126-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

-d option was removed in commit f56338b43973 ("wdctl: allow to specify more
than one device"), but the optstring wasn't updated at that time and wdctl
can still accept the option halfway as below:

 $ wdctl -d
 wdctl: option requires an argument -- 'd'

whereas it should say:

 wdctl: invalid option -- 'd'

So update the optstring.

Fixes: f56338b43973 ("wdctl: allow to specify more than one device")
Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
---
 sys-utils/wdctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index f3ae0e3f8..0cf8ee7a4 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -779,7 +779,7 @@ int main(int argc, char *argv[])
 	close_stdout_atexit();
 
 	while ((c = getopt_long(argc, argv,
-				"d:f:g:hFnITp:o:s:OrVx", long_opts, NULL)) != -1) {
+				"f:g:hFnITp:o:s:OrVx", long_opts, NULL)) != -1) {
 
 		err_exclusive_options(c, long_opts, excl, excl_st);
 
-- 
2.43.0

