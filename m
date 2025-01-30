Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9EA1E1C22
	for <util-linux@vger.kernel.org>; Thu, 30 Jan 2025 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252266; cv=none; b=YJnGO6t/rDUhX6FYmRxf1VPI8deaMxJLK5r22GainkUN+TbhQ/5T/yqwSv4GltAjiWnDQOf4qBdND5ZtM8A1uRqEqzCRnWDyGSsCb/xLm37Zm2DpZovrrFpywnBaNmbHP2oWnZv4MyDINCADOe320VTVGggkcWpDslPHRA62XYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252266; c=relaxed/simple;
	bh=jZJBNWPQJp7aNNI8vdxL11BiaacpHSGCt/5V5rgngAI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XZwKtnYiwPjUkNqlvMl9a8oMmzgKQzQVxPU17pdDhxpVPmMQnDVCsh8Dd0yNEIXSTvNOWqixINE4LoDCfoeSI4sK/yYuc4wS/y2pkfJ3mwmJzIUQ05LO+HJMT/plUfOFoquMH0ULkh6tRJw6+WmdK6PYwmvrWuGqZdhN5AxaYnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=pI0z69bf; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="pI0z69bf"
X-KPN-MessageId: 53073ec5-df22-11ef-a841-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 53073ec5-df22-11ef-a841-005056ab378f;
	Thu, 30 Jan 2025 16:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=IeKKum6lLk6g58oTc3SXfRAMkKS8LrQh/+uXmcM4Lao=;
	b=pI0z69bf6bprIcPgXj0pjlUarvboIAp3/eAR/fzNJuhW2/vQOmEyc0FfUly0ukXuGu635zk9xuPxf
	 vU2OPiCM3O3c5fzF3GOAxq5pAvJQ4ihNWTOtpDp3cdn/HYvEoIjI+s2NzgnNqzcMnwO6ezNCMv8jbQ
	 FKDE8KF6vZNHE9qU=
X-KPN-MID: 33|FqaTlG9w+ZFkcOBHQS46Vvm0rOpcsTptZSrE8NmKchn+GGqzxyMZUUP+p+7aO/X
 l4FEojiMP2rPaQW5plza/1kB7pDFqJPFZgiEJL0rixqQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|sQiDjbe0Yhci8bXvy8prcctbvhpb/WH4J/giJroqoWuzAAkCYiudwEw/ln8iuOn
 xGacKDPKpoNtvUFAHqoc/uA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id fd91376a-df21-11ef-99e9-005056ab1411;
	Thu, 30 Jan 2025 16:50:55 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] readprofile: put two things that belong together into a single message
Date: Thu, 30 Jan 2025 16:50:48 +0100
Message-ID: <20250130155048.31061-1-bensberg@telfort.nl>
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
 sys-utils/readprofile.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sys-utils/readprofile.c b/sys-utils/readprofile.c
index 6e6a68b0c..3c200cf4d 100644
--- a/sys-utils/readprofile.c
+++ b/sys-utils/readprofile.c
@@ -99,9 +99,8 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_OPTIONS, out);
 	fprintf(out,
-	      _(" -m, --mapfile <mapfile>   (defaults: \"%s\" and\n"), defaultmap);
-	fprintf(out,
-	      _("                                      \"%s\")\n"), boot_uname_r_str());
+	      _(" -m, --mapfile <mapfile>   (defaults: \"%s\" and\n"
+	        "                                      \"%s\")\n"), defaultmap, boot_uname_r_str());
 	fprintf(out,
 	      _(" -p, --profile <pro-file>  (default:  \"%s\")\n"), defaultpro);
 	fputs(_(" -M, --multiplier <mult>   set the profiling multiplier to <mult>\n"), out);
-- 
2.48.1

