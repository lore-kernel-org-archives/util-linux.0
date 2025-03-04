Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7D25F99E
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2025 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104584; cv=none; b=MuKvByCZX1tXnoziTDBs3vgAz4b70Wfu0lNGMZ8LLv2YfzGwnCufZMOxskvFSsYehqIWy2Cfz1MZWOhcqtH7lWQLukL+OQclFrGXkH4M69uUnSdcCvTJzQ/s8J2az5MZOvZeCix/kd8t4zwubVuVNQBBsibtWFVYdymiFWbOM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104584; c=relaxed/simple;
	bh=WYq0t3efQX+fRbZXO0v7NDlkWXso1a0ggeNqAKiZePc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzITK2nmfDTw1hExdVvNGlhTkyumapY435C9waQ1Fepu27GwubxJ3NhdhdfWKoWVH/xAxr7V5jqNZeKGspNJa5CnONXFSD/Hlye+JK705AgZP0CKgXNqcR3XYrOlA2Mnihkk7E6T6atcPNNjaXGaTo4RpuO0xd1YGF6/LR3BNJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=hU9Db0YQ; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="hU9Db0YQ"
X-KPN-MessageId: f69fe426-f912-11ef-86c8-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f69fe426-f912-11ef-86c8-005056aba152;
	Tue, 04 Mar 2025 17:08:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Xry+Bk7JXEeUHEbAxKgbleS1Ku6SxYpzJgbIf23MWNg=;
	b=hU9Db0YQ8ohWJ4Vt+eGSrhy00mUmTlzlt2oLSCNmHH7QiYAZd8040tlG2o4BeM/S+hSxCYu7ekhSL
	 Op6fYBz0CwrCl3NVbZClrnSwHGpkR7AVHhK+An1bvM/umMgRbuElbvJC/2JNEKcacWmg6BDFm4xm1R
	 5B4FmvveAbqUHkRs=
X-KPN-MID: 33|riqVRNEIo3jKn7QWpo/jgZJuf0q0Nl+maL6a5p8Pf/aDiwMje0n0opC0qSv+6NG
 hDlMqqwbpDofra6FiA61c8A==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|iJv6NEtbidsKqOrtgkkxZkicXlgOfRT1yaK0Loixr1jvDZN7KV0EAcMZZJk8FAf
 HfwlMkGjW4JYuIZVH2EUPNg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id eb033ed2-f912-11ef-9587-005056abf0db;
	Tue, 04 Mar 2025 17:08:32 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] hardlink: replace a strange word in an error message
Date: Tue,  4 Mar 2025 17:08:06 +0100
Message-ID: <20250304160806.10374-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304160806.10374-1-bensberg@telfort.nl>
References: <20250304160806.10374-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/hardlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index 6ac4a3306..ae8215901 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -1484,7 +1484,7 @@ int main(int argc, char *argv[])
 		rc = ul_fileeq_init(&fileeq, opts.method);
 	}
 	if (rc < 0)
-		err(EXIT_FAILURE, _("failed to initialize files comparior"));
+		err(EXIT_FAILURE, _("failed to initialize files comparer"));
 
 	/* default I/O size */
 	if (!opts.io_size) {
-- 
2.48.1

