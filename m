Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213536FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089495; cv=none; b=hXPPnhSviFfsyCjZl4kNA0mPZh8/FACwjbhSHwBv0bymEikdVlPYRX1AtNAEy2VHsnAcz1FuZZ5Pta4qFQ1qwXim4ayE7KYlOxtT3Vxbw/iSgHSQlXxYB0ftCsEVJwY7bTHRxi1sepmTgL0Vo7SCg3iRHU4nyXIq2EbrXsSYzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089495; c=relaxed/simple;
	bh=5jFOB1Rikrr4EhRsQc06SK1T683INSCjWC2QdonxCjw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c3A0DEgXWxnM49bOlB8Z9juNP4+njZrXwnu93W041wNZS7/tF/HHauyRn6xLWSJJ70nliLJDtdG3CKLHvV2GHIwrZttlFHImByPtpSwcyakXJgGiZHI3VAzVjF16EXm7i8RbWTlJyHBWrjjXSGarXVvcsZWGjp5I0gvkUUFXQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=whLGLfCh; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="whLGLfCh"
X-KPN-MessageId: 7a7e9665-e6bf-11ef-87ce-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7a7e9665-e6bf-11ef-87ce-005056abbe64;
	Sun, 09 Feb 2025 09:25:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=4HdB6goi526Gq1HkUkGc45EZyDQXDeaUd6pJImqw4mk=;
	b=whLGLfChFnLX8MN80GQLg6LMtCBFUJk69Z9+6cSlDxLS6RYSh+tY/M3oHHcf56mLYTjfIQ11w3xge
	 njrGQmFtlSvfwfMhtw9LUTt6kK61XLCciXoCH8RNJ/y/nlXfPjBq1Pot/2q9zfD2VlpNx0pB+n8aPp
	 JC1yF1HSUFBT4r6A=
X-KPN-MID: 33|lk5+oTczgxvzShTQMz/3WA2vBmzr1laOfECtHHMKztPSvA0y8DyWJbJNhP6g0cb
 EehA+u6pCjK49Zp5WyklAA0apwIOikOWE69jcYsSGQdQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|O2TvT6rgJFoTP4OfTj6ObQpGXSCkwF+JCtf+MdFb4+wIQjHpKtrwXtuS2MMmUJs
 kGF0SMfJ6nLMoQKC44ruFvg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2d10d4a4-e6bf-11ef-99a4-005056ab7447;
	Sun, 09 Feb 2025 09:23:44 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/14] setpriv: make message for failing PR_GET_PDEATHSIG the same as the other
Date: Sun,  9 Feb 2025 09:23:17 +0100
Message-ID: <20250209082330.4235-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/setpriv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 43d72f64c..daa3ab366 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -329,7 +329,7 @@ static void dump_pdeathsig(void)
 	int pdeathsig;
 
 	if (prctl(PR_GET_PDEATHSIG, &pdeathsig) != 0) {
-		warn(_("get pdeathsig failed"));
+		warn(_("failed to get parent death signal"));
 		return;
 	}
 
-- 
2.48.1

