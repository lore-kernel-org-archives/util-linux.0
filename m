Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F5433A8
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899485; cv=none; b=iwevyRpp2vK/rLkNh9bKO5KNa+MvzMNjy2s5Ru57M2DopwUN/+dsNgymW+wTXECE3K/+a9ps++Zr0+gqgjmzI/W3OYmm+iZPYmvmUECgEqz5aB8vu1Eb7hA+Mp+/5UagH3yGVmfmt72ImRL5P4VYDxvBezA7bgSVswd5AJ7ZuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899485; c=relaxed/simple;
	bh=fahmYuJUATvl8ix6i5FyMugWcfYrO57UQ+VV7Zm1z+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNEnLMrrKwFIRmReL8PTg3RisIE0Nm2e0iFCWEwMVcv0i+2eKylh/whJZQcHBLYrJrWwbPtjXb0klw0q0t+DBSm63rQ05W41P46jxvrWT44nxtDPiiqePIiMGQbDQMe37Lzhw1x7wstJuDtwKEZUHjmASw0hLEY1Kwcjey62idM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=mekFkqMH; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="mekFkqMH"
X-KPN-MessageId: 30f8555b-0966-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 30f8555b-0966-11f0-a82d-005056abad63;
	Tue, 25 Mar 2025 11:44:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=4NjzTFv2PgZMlvtGuLgSF7Fb41zJ7b/sD7hBnP3IDEE=;
	b=mekFkqMHkPtELDXt+EMzuJ8UvTOa8VEkMcQNpdR+hDP8vZBmFm5AU5+pUUtMgK3ZZa2FGn3SlJU/+
	 DptIjwLlQA1iWZPmEIZFbg8QfEu2tY/klTtcw1/f24kUWgPVA1kjb1b9VnFtva4YIRF9sfniMsr9p0
	 Ypp4zlTYb8anK7zQ=
X-KPN-MID: 33|iLG//utvFR+VtgF9nD3eCZwaqKHXHpKB0Wm+eeXRcz3CQcOJ5QiXOYSKve8jIlb
 Vsk8xZnd41ggVT1qQbTB6dw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Hxgr2VzQGw7Ln1rh9KP4/CKcocS6bQvMa4pBIz7VdtKSbzpSDYSdh9aN/eukw6e
 pQBToxe//3RIKkS8DLXsLZQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 27201d4a-0966-11f0-9b42-005056ab1411;
	Tue, 25 Mar 2025 11:44:39 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 11/11] ipcs: align the first group of options with later ones in the usage text
Date: Tue, 25 Mar 2025 11:43:05 +0100
Message-ID: <20250325104305.23980-11-bensberg@telfort.nl>
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

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/ipcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index e77a657db..d30bc6ab6 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -75,8 +75,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Show information on IPC facilities.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -i, --id <id>  print details on resource identified by <id>\n"), out);
-	fprintf(out, USAGE_HELP_OPTIONS(16));
+	fputs(_(" -i, --id <id>     print details on resource identified by <id>\n"), out);
+	fprintf(out, USAGE_HELP_OPTIONS(19));
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Resource options:\n"), out);
-- 
2.48.1

