Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F58236457
	for <util-linux@vger.kernel.org>; Thu, 26 Jun 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750937282; cv=none; b=iRG7/u7IyXpIt0r83dbQ8ivgUyqQloYbKWKVQV3tYytAjuiAEAlo7/9poZRVHrKjq74xg68H9FeabBk2+GTQd2CYwFoURBa5rwB7WGKCPlm2BokPe0tZQw5WB1hhDznPSXVgWhk9OdlZn+NkOcOtKfrW618lQWys62RGucKoxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750937282; c=relaxed/simple;
	bh=jsMiJBM1z5MKHyrSLHyZxE9UjmC3cp0Lwww7hBCORA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEfKAjN7qTbin0lWEtn7IPn+h+uQqpiBey9QKEiV65oka9lSSwH4o9kFBC4Ui+ylZ+DVLOGdphViHDw9a+sZ/EjM6bpszPq8EUmiRDYkuAaRdxQ4UxjH5qZnI02YHUNMY7SQSzYgEv4SuBCxEJoZB69UR4oG7ycvXcrFL5q2h6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=QYGUewRu; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="QYGUewRu"
X-KPN-MessageId: bb0b6ce9-5280-11f0-bc2d-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bb0b6ce9-5280-11f0-bc2d-005056ab378f;
	Thu, 26 Jun 2025 13:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Z+Y6eSiHjPM4B7AVln0n1CpmCk0Bc5LCaH8AAmY3dIg=;
	b=QYGUewRuK+EayojRhr6TQE4VYDzP8zqWxjftFptxB16SfEZbyNtG283lCHPfvpnyQROjfcO0RF91J
	 nyFCBA+Uv25ImsCjm9fGemsFkhRMnYJNuQYJ/U/0Q+HJl6FDlXVy+8/D5K2Ry9kiafjQ5Uh9L4WQxt
	 dyLA+yyKcyIsjCQU=
X-KPN-MID: 33|ABwO3VITxxTQdPFY+aAFCKIazJWdBMugXy+MV0EOTz6N/QGP/cYNIkBgDpUw/40
 jyYUuDw6f/2b6sWMedq4Od7bowP9CvISrf03wiOYKIjU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|M5yWm8w1KxM7nROiipCheg+Ld3peqI0cHC7DQXKApuMLsM6vEGNPPWlvAyIkoeS
 36qcu1GW0Wk7PLy3MXSU29A==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 9674f13c-5280-11f0-9c21-005056ab1411;
	Thu, 26 Jun 2025 13:27:48 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH] chrt: when more than one argument, interpret first argument as priority
Date: Thu, 26 Jun 2025 13:27:43 +0200
Message-ID: <20250626112743.9862-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first argument is a priority not only for `chrt --pid <prio> <pid>`
but also for `chrt <prio> <command> [<argument>...]`.

This fixes an oversight in recent commit e7a2d62434.

CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 0bcdd1a1e..4c45eae80 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -530,7 +530,7 @@ int main(int argc, char **argv)
 
 	errno = 0;
 
-	if (need_prio || argc - optind == 2)
+	if (need_prio || argc - optind > 1)
 		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
 	else
 		ctl->priority = 0;
-- 
2.48.1

