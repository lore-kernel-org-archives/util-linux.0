Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740D126BFF
	for <util-linux@vger.kernel.org>; Thu,  3 Jul 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554102; cv=none; b=P0RpTP8lAHfDXH8DDbJqYtkkopl1Q1VCAwJoIhv1u5LDh2Ed90iNEldiY4K+x4QPHLUjx7bbH9asy8xtVRQCqGQK+//bYLO43lmBhS3tTwkixN/J0TEIH23o/JJvzLB0ikWra13DE6hV5JY0+qIpAbgeMKvvwVf3bQeNENGMRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554102; c=relaxed/simple;
	bh=z/dvIWx/YvE0IjoVUgOaxuxN94DgJHk+9dwcwpnjnvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onwbhh/gfSGwxuiUOmLTRBSLv9E2AFLdJ37CIYgh1xg5MmaAFwoJ4sWt/13+TB+bDBZ0S29fvxt1MwxtJtOoU2P09AdipxLUCQiVcH80sLMRglb3Q+kk6zS+OX0R78w7nraR1MlFoPrzm3e0Vxs/PpzZf+6Iea1LR1LKJ6KCA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=lX+utnpG; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="lX+utnpG"
X-KPN-MessageId: d58d2116-581c-11f0-a833-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d58d2116-581c-11f0-a833-005056abad63;
	Thu, 03 Jul 2025 16:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=F1eR5ZQRjhVuRf5b1fP2qklHg40nIS9DEkRljPbeZUU=;
	b=lX+utnpGoCb9/X5xvYEMvrmzYQxeVcZJlVy9OPfWhh4b4gjJBZNQZU8fRUZHQUoRWvgQQAripVzGc
	 F7g4KRt+/vOF/X38qGlNIPI+BfAyfq+etykndRNpt//nckpddf9wu1axpyHs5KQcH6KL5gBTfVg/OB
	 CWSX12dD6t/TaAGI=
X-KPN-MID: 33|vH+Be9cIuXZZ53PhDLBG1lCsy5FLhI0FSGNBXkj2ZRcQMtd8ZOYXbJKzfpIxKZq
 fECBynrSQlZfzAQTdKfNqa3rODJudnWTQCtCmRst9BR0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|1djU84e9ADdH8kJg/eRNkiOUsrL8soH4m0qm9d/u5uMQNBuSWt17Qc2sKEfp+zh
 +8ipuluiRQXwszfYH0uCBIQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id bdc1e1cf-581c-11f0-9c45-005056ab1411;
	Thu, 03 Jul 2025 16:48:11 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 1/4 V2] chrt: with more than one argument, interpret first argument as priority
Date: Thu,  3 Jul 2025 16:47:49 +0200
Message-ID: <20250703144752.29971-1-bensberg@telfort.nl>
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

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 550cefe4d..415a9aa77 100644
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

