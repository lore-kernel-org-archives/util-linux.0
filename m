Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C6242D98
	for <util-linux@vger.kernel.org>; Wed, 28 May 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425118; cv=none; b=p/lbGhXDqcQs0G7Q2BX+EBlWslcrxRvxq7MLSzkuTZU83q493Jb+3DeajnqQE/QpGsgS1NtqxkpTU9dP9Fu1Oq05vk70rW0PXfqcykUXmyD49uQ8Q2aKGSnQNJfP3cBA5varQ+2uZXKRrW7/qwvhp6Oga2iyu7rRwqAxD90feSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425118; c=relaxed/simple;
	bh=eQHg61nl5e2VN1QClEtGtf2XfDFY6jm2mtyBaSxmMhk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3p9ioF3uezOlGwbqGR7r47fTN3sXvqtri7FfxPklEktJYpIeCllWk4ZBbtlj3kGkvsxxej5wunnvMpSFCV9cRmojn//3zemWIGupmYeX88dAqK7PWFtSVvPe811JRM9AW+R/9UamEhfI4/M8ptbTJMRJzCEDyjqr+vFfyxI2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=KMrLqfWC; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="KMrLqfWC"
X-KPN-MessageId: 835b4d04-3ba7-11f0-b9a1-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 835b4d04-3ba7-11f0-b9a1-005056abbe64;
	Wed, 28 May 2025 11:38:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Lc8fzFGQpgKO9/Bp6V3W2nmQL+edYnBR7hRIPTgkDcM=;
	b=KMrLqfWC+QPBHq5AN/rg37N80oNdjc1f93s1cFy4kA7UTMJbROuHB4/tS6GWw+rNev+2o4leNWh3d
	 bMnbK4J/dYnhPnSYTWxRdZkWMjSy5Aa8+pC/REPju8hwgUu1rW/mAoBxt+15cPUfaflahYNHmrPceU
	 oP7PIBMnJ9JNClho=
X-KPN-MID: 33|2nfSsDJASm5cl+QTy4QS0eOSo1HBevgQmLPSrsqzLhvrIQJZ+pDnhxmJ7TSxlTU
 wY5e+4AKbU6jT7bv/MhBEQVxfq1xCr7g/qPf3ZX0clvw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|CR7FiwuRWVib+rzyfA0DgrYnL/4Y+Gn4B+i5rXChnb3vKGrT5wvJDPZLGROA4j+
 QKrmzyoH3ZcL4wlVrbcCZSw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 5d871eb7-3ba7-11f0-858f-005056ab7584;
	Wed, 28 May 2025 11:37:26 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] colrm: make two error messages actually say that something is wrong
Date: Wed, 28 May 2025 11:37:03 +0200
Message-ID: <20250528093704.8896-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528093704.8896-1-bensberg@telfort.nl>
References: <20250528093704.8896-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/colrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index b1370ac81..dd36d1827 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -180,9 +180,9 @@ int main(int argc, char **argv)
 		}
 
 	if (argc > 1)
-		first = strtoul_or_err(*++argv, _("first argument"));
+		first = strtoul_or_err(*++argv, _("invalid first argument"));
 	if (argc > 2)
-		last = strtoul_or_err(*++argv, _("second argument"));
+		last = strtoul_or_err(*++argv, _("invalid second argument"));
 
 	while (process_input(first, last))
 		;
-- 
2.48.1

