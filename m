Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9821767A
	for <util-linux@vger.kernel.org>; Sun,  6 Apr 2025 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743952936; cv=none; b=hpU5wSx88XM5Ps9GMVxR5/G0u4a9VnphDY9aiWpxsHi3wGlYNDRIm5dcnSj5pT5O4hxS7xgKeJoO57p+hMIjtkUmD4D6Ew/AydRtu5syNGcrsdcvZjruiugess2MmHpSC8olaoAR9h3iCSWX/D3M4HIAK4OPz8AV4cK/OdqaGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743952936; c=relaxed/simple;
	bh=E2XeF3cLm5vFMRXJl0AB7QabVJ6TjVrhtvMjPPJ/6f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeKAIHX5DZo3Aj+PpOzBxF7m1QGTChRyEnUAh7M46CC4FHg366aPr337zhvWqkB2eGaL8Mpq1T1iE93wDLawbs2SBduOWmsAkv+t69xL4m5rmsJIMY2vTDl/lt6Qdh5Hn6APamgkPwjHivWTWoewYwe65stzdGwUJm7vb7niYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=GykoMjTg; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="GykoMjTg"
X-KPN-MessageId: f4415dd3-12fa-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f4415dd3-12fa-11f0-a82d-005056abad63;
	Sun, 06 Apr 2025 17:22:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=DKgmROzBbLbt85D3T1elJryeEA6SmYHxwDo/ioC3Nh8=;
	b=GykoMjTgFwCVSGXzHgOlxZ20nwLlIDEsLUexjh10hsqrNm30TAykteQyzzOfu636Z3nDBYjE5SbRP
	 Wbqn1wAA2Yoh6SHXwsGyHoCbYH/ZsiroUXkg+TgU0PinDMy2+m6x0R7BvJTepKfQQxQbXnAe3tXjVr
	 6FwLgFfGbkSBmWm8=
X-KPN-MID: 33|llD1hQwlqsOz6LcCQjp/i5xRA1ivQ2bR6+GP4K/Rz4dGqQuAJFZr4BnJNOFbG/2
 O1DjKb61s3syrEGKZf8jmTacB6PkF1+DcvPPaMBFMHpc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|5ki3ZYfL3ei20pyBu9HMM7EeGQ1W+pVzKOXUj3a4/Rj1wesJjDdgMh2u588JfVB
 QkceSz8i6AB5EMCcwYLhJkQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id e5cb0ba6-12fa-11f0-9bef-005056ab7447;
	Sun, 06 Apr 2025 17:22:05 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Petr=20P=C3=ADsa=C5=99?= <petr.pisar@atlas.cz>
Subject: [PATCH 2/4] textual: fix a mistruncated message, and fix a typo
Date: Sun,  6 Apr 2025 17:21:45 +0200
Message-ID: <20250406152147.9225-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406152147.9225-1-bensberg@telfort.nl>
References: <20250406152147.9225-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The phrase "in human-readable form" was chosen rather than
"in human-readable format" because it's shorter and lets
the line fit *just* within 80 columns.

Reported-by: Petr Písař <petr.pisar@atlas.cz>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/lsipc.c   | 2 +-
 sys-utils/setpriv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index 7b041790b..d292ab96c 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -338,7 +338,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("     --noheadings         don't print headings\n"), out);
 	fputs(_("     --notruncate         don't truncate output\n"), out);
 	fputs(_("     --time-format=<type> display dates in short, full or iso format\n"), out);
-	fputs(_(" -b, --bytes              print SIZE in bytes rather\n"), out);
+	fputs(_(" -b, --bytes              print SIZE in bytes rather than in human-readable form\n"), out);
 	fputs(_(" -c, --creator            show creator and owner\n"), out);
 	fputs(_(" -e, --export             display in an export-able output format\n"), out);
 	fputs(_(" -J, --json               use the JSON output format\n"), out);
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index daa3ab366..433db6031 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -1025,7 +1025,7 @@ int main(int argc, char **argv)
 		case SECCOMP_FILTER:
 			if (opts.seccomp_filter)
 				errx(EXIT_FAILURE,
-				     _("duplicate --secccomp-filter option"));
+				     _("duplicate --seccomp-filter option"));
 			opts.seccomp_filter = optarg;
 			break;
 		case RESET_ENV:
-- 
2.48.1

