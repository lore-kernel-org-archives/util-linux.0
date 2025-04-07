Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388B1F4E49
	for <util-linux@vger.kernel.org>; Mon,  7 Apr 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038988; cv=none; b=EIf/IaU3l/ZvTYYiGxrAmOcGxk7XvBJlFfjbvCRSPMfZNvr7fdtqHfprlacQ68919kjyMUH97wLhJ/WjXoz4H2ICbQnKWunuvrN2yQh6RPtGErNuB3+HEaL4QlAJQfRj+9WuNJdo++y82qKCcACyHbLOMvuEj2RdpNOim1BtsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038988; c=relaxed/simple;
	bh=CxC1qbuxlJD3PLPwDBex1lHyjwC/u5s0ua8xTHa3mhc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvpTzn4cTwYCV4/0lF7Gst75WMyD7OxdIyZXpgJ7sx5bcZxwn3egp4w17F7aZflOnsfzzzfNnQ2K/lfsESGCUB0n8Ea+DdvctcGmpTAFS09kLtApLCibMkj6cu0ylGFZZwQqVCp7+DnpH8LzvpD5pirW8B97cknCRUz4BzygQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ejmt4n9/; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ejmt4n9/"
X-KPN-MessageId: 3d32ff8c-13c3-11f0-b9a0-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3d32ff8c-13c3-11f0-b9a0-005056abbe64;
	Mon, 07 Apr 2025 17:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Rmy3x6hab2z3EkQvD+Q525tnaala0mjcsemN27yvkuc=;
	b=ejmt4n9/t0Ji6wGrPRAEkAZE6LFKHQGZhqamXzSbKaTd2dA/zYxFi9hb1SzbzUhQP0ZI3HAXsYNKk
	 GjC+WBUcvZyyd2UdY/byojAEVm9rU1rkEGXBVuG/0s1Klb3xtRn+UeNMDcAhLTong+LwFHjFJjbTJt
	 4Meisao713GRoLPA=
X-KPN-MID: 33|4Yo5PTS+qlbWxbITDa4FRMv12FSU4iKMcfq53WCAPVuZL66QSvywdxyQ/08LB3t
 LFXr/S1uX9galTF+cV5sKLPe47Dyz+jWxBw7OEklbtn4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|aaGoX/Crtf/Fn53c8+3XHhf4/iQFBsVcO+19A128lRWsZ3XambU2FnmzX4pK5Ba
 gjclNEDObguD8x9/ElxlHVQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1d42c227-13c3-11f0-852c-005056ab7584;
	Mon, 07 Apr 2025 17:15:18 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/8] choom: (man) add the missing SYNOPSIS section header, and improve wording
Date: Mon,  7 Apr 2025 17:14:33 +0200
Message-ID: <20250407151503.23394-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407151503.23394-1-bensberg@telfort.nl>
References: <20250407151503.23394-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/choom.1.adoc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sys-utils/choom.1.adoc b/sys-utils/choom.1.adoc
index 51d43e7b9..b699e967d 100644
--- a/sys-utils/choom.1.adoc
+++ b/sys-utils/choom.1.adoc
@@ -8,7 +8,9 @@
 
 == NAME
 
-choom - display and adjust OOM-killer score.
+choom - display or adjust OOM-killer score
+
+== SYNOPSIS
 
 *choom* *-p* _PID_
 
@@ -18,7 +20,7 @@ choom - display and adjust OOM-killer score.
 
 == DESCRIPTION
 
-The *choom* command displays and adjusts Out-Of-Memory killer score setting.
+The *choom* command displays or adjusts the Out-Of-Memory killer score setting.
 
 == OPTIONS
 
-- 
2.48.1

