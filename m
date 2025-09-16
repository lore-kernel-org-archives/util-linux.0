Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A928488D
	for <util-linux@vger.kernel.org>; Tue, 16 Sep 2025 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030301; cv=none; b=TqE/ZtYZNI0hHKiLxjlArROOx6DbmLkrKIo9yCuWIiRaoLa+s3frAN6tf1Xu9RmKUp6mzixLVvIEBjHkVun3P4vCdg3R37Zhd5Lca+cLZGyKZXvbjXQSvRwqHIb8QO+m2udfcwoTC04fCf3i8QtfgSphLGxr4Ucx0OKQGOBookE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030301; c=relaxed/simple;
	bh=VdQ2BE6zdoq68rIatTQwa5RAl912CYmt/8JzvLQcp7o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rv1WgfcCcVx9m+TWj3RNT2NZRvsWJmJmOkbu62DgsczHCCwHz7V55/mbT/Xq4df1T4LDHwggJJqqhEdELo/DSLJ/Ez1NCtYSqSv0y7cPDnABNzebKnpN30sqrPliUpIOREwdJj6WieZEdWC3qq5aFcITvIqcdi9tmd+zC3ziGuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=I/OPA3dg; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="I/OPA3dg"
X-KPN-MessageId: bf3422ce-9303-11f0-b7a7-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bf3422ce-9303-11f0-b7a7-005056abbe64;
	Tue, 16 Sep 2025 15:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=HtaLuujhJP0oRjz5Ji2CSl21v5YsG4n/zATzMMARsGA=;
	b=I/OPA3dg8lyorNoXpZ9uRG0efrWCyjVlFxikpXGoEiJjB7p3I8gyIAr5KgS20P/AnDOxJ54aOiRZ+
	 2GVuwvUYqdVSePcjX/7Z/EFdk4Y8a8tFrAcYlx5e0+KjOCHViD2wZFc6uZl6cMzCns4p8xr+IiRsgO
	 YZYA7jc3e9eRA+t0=
X-KPN-MID: 33|rFkIeDWRG3pyyhvhKCMtDxJV9Hab3o8aEKyIqJrLTpXo8o50fHgxzxxiM+5cmL6
 JcmhP/R+iGIdI4VzwEPQhYOLhC7J2OhMPxO6hPi/N7b0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|bZiHdinFncwwe5OBMfM1w5CUrtaVYwFxwGs6511egavO/XcIePxf33g1KwrMQS3
 fhGwpxzv2YQ8XSUk/2Xq3tg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 51209425-9303-11f0-abc8-005056abf0db;
	Tue, 16 Sep 2025 15:44:50 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] blkid: correct an erroneous error message
Date: Tue, 16 Sep 2025 15:44:41 +0200
Message-ID: <20250916134441.51685-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running `blkid -p -n no /dev/sda2` would report:

  blkid: error: -u <list> argument is empty

(Mentioning -u instead of -n, and falsely claiming emptiness.)

Now the above command will report:

  blkid: invalid argument: no

(I don't think option -n needs to be mentioned, as it will be obvious
when inspecting the command line.  Not mentioning the option allows
reusing an existing error message, avoiding needless ballooning and
allowing the patch to be applied to the stable branch.)

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/blkid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 3960b0d97..a8580e538 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -651,7 +651,7 @@ static char **list_to_types(const char *list, int *flag)
 		p += 2;
 	}
 	if (!p || !*p) {
-		warnx(_("error: -u <list> argument is empty"));
+		warnx(_("invalid argument: %s"), list);
 		goto err;
 	}
 	for (i = 1; p && (p = strchr(p, ',')); i++, p++);
-- 
2.51.0

