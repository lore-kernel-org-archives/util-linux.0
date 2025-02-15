Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B581AAA1B
	for <util-linux@vger.kernel.org>; Sat, 15 Feb 2025 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636346; cv=none; b=Y8DERyjY5Rwtdp28PQS2XNh8q6jFMEKbkPhgyrMsqwo0idzYld3FY28eBqfNgxHCK18nqIbc2wtLGjTrL4uz8duBHsJo2PJBCvt2dHC4iY/YrjaRm3C1yq60hLCqOUwegcSisMFiiJYCWugi3ZBSJbmPVsSit7sNe7H9MYcrP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636346; c=relaxed/simple;
	bh=x4+T8sIapt/8VcKRCdWTOZLS7IQvtfXF2loJKknrU7Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b+Pnq/DzVLFsUILY/vi6LCko7y/ewmXwUwMzbhteMHqcUYyRWqxY6U2/Zm3EAzpai6FZ/6XuGkqKeLTatLq6nRGvVHvI0QCxaYLdN/d6pfD1rYxfAAvXvTSUdMhtLYN6zvDDsYRJm9rOWDkNldChBgVSoDomgNiCG+YNWlqb/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=RZZ4J+4x; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="RZZ4J+4x"
X-KPN-MessageId: 8e8dbbaa-ebb8-11ef-b876-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8e8dbbaa-ebb8-11ef-b876-005056ab378f;
	Sat, 15 Feb 2025 17:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=iHBo7IKo+pTbV9ODhF0bfS5ZKU/Ru4t0vH5+R6h6V4s=;
	b=RZZ4J+4xAMzzuMExAZnT93X0R2m54QM6J/Gv1W2PJB+3MryPomRh1QPBFLbRnqRj4+7Zwh3te1Ug6
	 agQZXUJuPcJidd4a0iUg5NP7I9jcDriRWGb5hRb0c+DJ01oUsXcQH8YB6F+vV1hi93/SktrJ3u0SYM
	 XuGJP/B7KUiPUgJQ=
X-KPN-MID: 33|vqPG1IcYGYOh6rQfths128p0Nt6iPBI1I8jPde68kqnbSmiQlxjvfFPDMDQAKKF
 t4HtJf9ONpSUWfdaLL1Ixf/4n1Nzd8e6wstiT5Ed1lbk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6g0agqn/cBnfM09DGe5Bq+0ZTqCcV3AtI2EeHING1W8Pcwx4c1Doa6rK+FAlN3v
 ByM6IauUg3GiIfKbLAaBN9Q==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8d79b187-ebb8-11ef-bc7e-005056abf0db;
	Sat, 15 Feb 2025 17:18:55 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/10] colrm: make the wording of the doc string analogous to that of `col`
Date: Sat, 15 Feb 2025 17:18:34 +0100
Message-ID: <20250215161843.12053-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Which allows removing an awkwardly placed and rather redundant sentence.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/colrm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index 363d732b6..b1370ac81 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -63,12 +63,10 @@ static void __attribute__((__noreturn__)) usage(void)
 		       program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_("Filter out the specified columns.\n"), out);
+	fputs(_("Filter out the specified columns from standard input.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
 	fprintf(out, USAGE_HELP_OPTIONS(16));
-	fprintf(out, _("%s reads from standard input and writes to standard output\n\n"),
-		       program_invocation_short_name);
 	fprintf(out, USAGE_MAN_TAIL("colrm(1)"));
 	exit(EXIT_SUCCESS);
 }
-- 
2.48.1

