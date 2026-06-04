Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4174380FEC
	for <util-linux@vger.kernel.org>; Thu,  4 Jun 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566807; cv=none; b=ghd+aFBRvZiRBFNUtAHrSOszYfBIHt8rOsgFc+X4DMle2ZW+cg4RaKtZ1p5BbmaM18sz8ng6OrXd4M+WCvWY1P58crXcKo45DebOKosT6s+rxrFOoZxbWEjr/wVbW5MfVHKby41DljLByWb+MHpGUqAGrXD4ere9WqOi6rHRCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566807; c=relaxed/simple;
	bh=dPUMZq9sTS+F9OWlxGIXxqGb4CqdjCtUlGWycPKsc/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om5LdSoOwNTodlazzp3T+WsnNzf1FtJsYhigj0748fmQ4T2YZ235pAJaN89HhboXC7kT5pA/gznM5WTQz1PgkE7LZBJ5vBpqviMgYfTADbEU2p8VmrmuQmUNRMYGMoBEEZlgcDcVfuBmZyhHko6ohfzBUYC7NeEiLEnyWuKGRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ZmxRbTkl; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ZmxRbTkl"
X-KPN-MessageId: 3651fbc9-5ffb-11f1-8aa5-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3651fbc9-5ffb-11f1-8aa5-005056ab378f;
	Thu, 04 Jun 2026 11:53:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=FHBhRmRaxqALS5uvo/2J05VJYarBGYy5DI46Z8NGAEc=;
	b=ZmxRbTklZaNWP4WgIuYhd6odHkPGqiNlHMO7cz/KujnnBqPGO+xgMPP5uPknvhYGn6JJtmVTHtXe9
	 2Uzpsl5IglROaROTiSLTAUI6bJ7BKMRH6cxJiO7izqPUqBudNX+Sr2UC+5PL8V9I9Nr8xP+hwZZnmY
	 avbEYE4K5ESVr7Ls=
X-KPN-MID: 33|/keuQay6Itcpbfj11x/rMyZz/HJ4v+4KbYZCnowZOmNjMGKAwCodFGDYwL5CkMP
 34KQWGLAl7i6375O67aByGrMCkaOrf9ST8wpTCHZO8RE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nE0qsttrHcMIAJOE005OrBs9hNYb0Q/HpXrdwI0bWEG6Dl8E6mSzn/jCUl8Cftz
 mPFf6flij3FnWmO4PYowbAg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 36388e82-5ffb-11f1-bdb3-005056ab1411;
	Thu, 04 Jun 2026 11:53:17 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] lastlog2: correct the grammar of an error message, and drop two periods
Date: Thu,  4 Jun 2026 11:52:52 +0200
Message-ID: <20260604095252.162210-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604095252.162210-1-bensberg@telfort.nl>
References: <20260604095252.162210-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The grammar of a similar message forty lines down is correct.

And a period at the end of an error message is inconsistent.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/lastlog2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc-utils/lastlog2.c b/misc-utils/lastlog2.c
index c5e518c3b..838f27db8 100644
--- a/misc-utils/lastlog2.c
+++ b/misc-utils/lastlog2.c
@@ -236,7 +236,7 @@ int main(int argc, char **argv)
 	}
 
 	if ((Cflg + Sflg + iflg + jflg) > 1)
-		errx(EXIT_FAILURE, _("Option -C, -i, -j and -S cannot be used together"));
+		errx(EXIT_FAILURE, _("Options -C, -i, -j and -S cannot be used together"));
 
 	db_context = ll2_new_context(lastlog2_path);
 	if (!db_context)
@@ -281,7 +281,7 @@ int main(int argc, char **argv)
 		}
 
 		if ((Cflg || Sflg) && !has_user(user)) {
-			warnx(_("User '%s' does not exist."), user);
+			warnx(_("User '%s' does not exist"), user);
 			goto err;
 		}
 
@@ -324,7 +324,7 @@ int main(int argc, char **argv)
 		char *service = NULL;
 
 		if (!has_user(user)) {
-			warnx(_("User '%s' does not exist."), user);
+			warnx(_("User '%s' does not exist"), user);
 			goto err;
 		}
 
-- 
2.54.0

