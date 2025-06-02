Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1AA22652D
	for <util-linux@vger.kernel.org>; Mon,  2 Jun 2025 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873712; cv=none; b=YYGdDYpcqYsnK8+iR4qZxTlpFubkEwd0t91R2TzNPXqexl7JnYljG2Blwx77zSXzLXdD53SSErG8oJnTRO7kBxo3sJwz/QlZeH0wF+fI6nNjKrnVVPOzQwBqaD5GKFDsPv7+3ZrBFpCCfq2EcH50YuxYVKYWsg2Ket6BFCTuGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873712; c=relaxed/simple;
	bh=GEhYqagQYM7ZM4V02KV62JQa0BQH0pHB9tyVO6T318s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5P6FfLlVOYxneXBfkpBLE9eBbdwnamVf98TM4C409g1CAMo32vq7EeYuGVvYXyc2EFLt85VcLMbStLV/Y9AvR29JiolLpswkvnhabjJBqsRrFBDcN+pLHCTNLvftQpYOfx71Wk9f3fNlLmPv0Rfhrvh2ivfb0/4916K4szliCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=pkUUjWTf; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="pkUUjWTf"
X-KPN-MessageId: 20862769-3fbc-11f0-b9a1-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 20862769-3fbc-11f0-b9a1-005056abbe64;
	Mon, 02 Jun 2025 16:16:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=aOjIhcfcf5jLdTKgXGMjEhUcLTDckzOUMmszzt6K9aE=;
	b=pkUUjWTfxi0N5+t8NpB1l4VmlDVS6px7zEt+H2+kBp+7IqT79Hul9TMLRTKc46Rb917l4/IOn45P1
	 dgPRdPW6+t92mOPNqFhxn2worAISW9RzsHESsgov1rDSdJB06tQ0cmwihdcz3zjEPnEsP/fS3ugUu2
	 Blozbj+uC9j7aVcw=
X-KPN-MID: 33|qZwQXGtslUi8tYmfBUpX/D9+gfOLsMCO/MWt74+pd5083tikuYT6dcllBCu8ZEw
 9eXE0+Y0AmswscFIOEhgVP/DvwrhTy/4LBlAD9UHIOUA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0KisUAoxe+g2XJ2rjO7VhH9xwsS3FD+XwzjbOuP81jY17Es9J2LPq8yiJ/iU5aM
 0iGQAl610+OvJLPLc0PjLiA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f97c75f0-3fbb-11f0-9bf3-005056ab1411;
	Mon, 02 Jun 2025 16:15:02 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/6] docs: make the "po4a:" line the first line, like in all other .adoc files
Date: Mon,  2 Jun 2025 16:14:34 +0200
Message-ID: <20250602141436.11156-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250602141436.11156-1-bensberg@telfort.nl>
References: <20250602141436.11156-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, there should be no space before "po4a:" for the line to be valid.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 login-utils/newgrp.1.adoc | 2 +-
 misc-utils/rename.1.adoc  | 2 +-
 sys-utils/setpgid.1.adoc  | 2 +-
 text-utils/line.1.adoc    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/login-utils/newgrp.1.adoc b/login-utils/newgrp.1.adoc
index 521b73559..0df01a3f7 100644
--- a/login-utils/newgrp.1.adoc
+++ b/login-utils/newgrp.1.adoc
@@ -1,8 +1,8 @@
+//po4a: entry man manual
 //
 // No copyright is claimed.  This code is in the public domain; do with
 // it what you wish.
 //
-// po4a: entry man manual
 // Original author unknown.  This man page is in the public domain.
 // Modified Sat Oct  9 17:46:48 1993 by faith@cs.unc.edu
 = newgrp(1)
diff --git a/misc-utils/rename.1.adoc b/misc-utils/rename.1.adoc
index 692f4b54f..39b1496d5 100644
--- a/misc-utils/rename.1.adoc
+++ b/misc-utils/rename.1.adoc
@@ -1,8 +1,8 @@
+//po4a: entry man manual
 //
 // No copyright is claimed.  This code is in the public domain; do with
 // it what you wish.
 //
-// po4a: entry man manual
 // Written by Andries E. Brouwer (aeb@cwi.nl)
 // Placed in the public domain
 = rename(1)
diff --git a/sys-utils/setpgid.1.adoc b/sys-utils/setpgid.1.adoc
index 0d43723e4..493038d55 100644
--- a/sys-utils/setpgid.1.adoc
+++ b/sys-utils/setpgid.1.adoc
@@ -1,8 +1,8 @@
+//po4a: entry man manual
 //
 // No copyright is claimed.  This code is in the public domain; do with
 // it what you wish.
 //
-//po4a: entry man manual
 // Daan De Meyer <daan.j.demeyer@gmail.com>
 // In the public domain.
 = setpgid(1)
diff --git a/text-utils/line.1.adoc b/text-utils/line.1.adoc
index 5ad85812d..ecbc08817 100644
--- a/text-utils/line.1.adoc
+++ b/text-utils/line.1.adoc
@@ -1,8 +1,8 @@
+//po4a: entry man manual
 //
 // No copyright is claimed.  This code is in the public domain; do with
 // it what you wish.
 //
-// po4a: entry man manual
 // This page is in the public domain
 = line(1)
 :doctype: manpage
-- 
2.48.1

