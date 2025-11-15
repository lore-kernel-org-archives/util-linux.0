Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6021C1865FA
	for <util-linux@vger.kernel.org>; Sat, 15 Nov 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763202980; cv=none; b=ENQkjh/W9nEjLDKGEOa49cTSjmwL7SJg2QDdIVFGdtuZRwbbxvH9w53bhYRWIHk1SU8YzCh/iYSVAPDcOtKCiWamGp26sv1iqR1/MnKsKLCZOoKlr0dsT+yo16BJnFTpAdN+3IjDXi05KCn7LS7GVRxKVztNEZwiviHewa88zWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763202980; c=relaxed/simple;
	bh=+KH9/ZIXDyzzq9hiWA1O3mnqry6WZrxGcp6VHq5fHvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pzSt/d8rPQ/aM/OVEJo/EkvQp8KLdPDiCV5Q4rPIb9oUZkf9y1U7PSc6rhUcJFi1gr1u/ujJ7ywgT+J6TKEsZ1VT+2jBAyu1Z8s2H4FglFxObCOx8jXinJj0fQhumnKQ4l56/TI8w1xYOf9+yiX1f2HqB/lFp89UU0CtnPgwviw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=hNS0vvOz; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="hNS0vvOz"
X-KPN-MessageId: 0aa25d97-c20f-11f0-bd6b-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0aa25d97-c20f-11f0-bd6b-005056aba152;
	Sat, 15 Nov 2025 11:37:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=HvQrzUh9MqnZ60ogJWo7NTNBuvFshromdI5hLfzE+18=;
	b=hNS0vvOzwv83+g1uWMVCNWL1W0nEGxNcbQv0jC4rq27KUnSJcrjEAwm6uilGOT/zq+N7B/uuZbw18
	 N/P96aIvk1IdPqwpDOvKLe8LoS4q59v4+EwWheKgx7fGuydRsLKf1K3TQkiSJC8h3kgcXJHGBdRQH4
	 tZHl0an3CI7LvJRI=
X-KPN-MID: 33|Yk4pePklEG7rSQXhAhpfuverh6oQFh//eRJYqVHPE9SdFwyiQu9WhMn6aPqndbS
 Wk2RfYBwm0yRk0H7vZAZLM7Y1ygZBsm3iariTc3v6S3s=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|2/bHmJroCNthqOXbu16vgNk/E9GQ2Bngm6URQM+LiIO96/3am9mUmHE6uvxYcDJ
 zWv8WCYsjSqQrgAfbHXyuHQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id c1d458e9-c20e-11f0-bda2-005056ab1411;
	Sat, 15 Nov 2025 11:35:08 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] losetup: snip --verbose from bash-completion, and 'v' from options string
Date: Sat, 15 Nov 2025 11:35:03 +0100
Message-ID: <20251115103504.6360-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should have been part of commit 7e27c81597 from two weeks ago.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 bash-completion/losetup | 1 -
 sys-utils/losetup.c     | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/bash-completion/losetup b/bash-completion/losetup
index 2d314c111..bf1591fbf 100644
--- a/bash-completion/losetup
+++ b/bash-completion/losetup
@@ -59,7 +59,6 @@ _losetup_module()
 				--read-only
 				--remove
 				--show
-				--verbose
 				--direct-io
 				--loop-ref
 				--sector-size
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 7da0ebbd0..fe30d70da 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -751,7 +751,7 @@ int main(int argc, char **argv)
 	if (loopcxt_init(&lc, 0))
 		err(EXIT_FAILURE, _("failed to initialize loopcxt"));
 
-	while ((c = getopt_long(argc, argv, "ab:cdDfhj:JlLno:O:PrvV",
+	while ((c = getopt_long(argc, argv, "ab:cdDfhj:JlLno:O:PrV",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
-- 
2.51.2

