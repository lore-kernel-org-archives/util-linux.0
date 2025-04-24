Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32822FF55
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487241; cv=none; b=jcPvruoldOF8fg4wO/SollWroKWePB4zssbLJNISCnZaaDP3B4c1fPs7WVxVG3T4AEhqalzU62Nnu3I8YCKiajUZwOrLbKCIM433+vVX+sIznoNxCQ0UpgUiP/DjbaYCIVkbDkfp1HD6kY1xIk9ZDCGH7JMferxfzEptdwJ5Wo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487241; c=relaxed/simple;
	bh=S35Zdk08B0V0w5s90qhxHX8zidulfngPT8l/ielbJFI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SUHB2ugO4NN4a/YQi0TZIJl0jAbNnLN/cPyT4Ux/SSR20eUuZXMCDjhPj8nI91rVVXUTpQ1XFAJk/PUGxxk/i++cPJHz4w7W//MmYgLd/7d5ZxAkx/3LeAGZaNiNCSpNOaX6vD5Dq2KZs3jwp+zST4/AMdZALFiBNTmKHainGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=vr8IBQ4Y; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="vr8IBQ4Y"
X-KPN-MessageId: 3078bd7b-20ef-11f0-bc2a-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3078bd7b-20ef-11f0-bc2a-005056ab378f;
	Thu, 24 Apr 2025 11:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=dqea+P/FbL074CIVdQGFxKVGSao9a2c06dQSzOC9vmg=;
	b=vr8IBQ4YnhaHURg+Yyoh4s6OP9n2xb3fY7BcnlE+BHG6J56fKFB/J5KfZtcxL/gkE/fhA+woxkUKr
	 0qoROEF1wPJK7x1TR/EFBulErTYTZYMBXwzVsYHSSm+H7Oc/A4L7tLfHo+Z5kvF278yicp2EuWRwa/
	 lFPlBV02wMtNUM1I=
X-KPN-MID: 33|LtzOc29q0KWmBxalhje4LE8YqDWXZwpH4I//RYIEhdCEtkJSJM+f722AP11jKU6
 IMMx4r/omaVUFUzC6neZtPPgcN+3pqkQ86DKngjVdibc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|IZN8ORspS2QfAHrL2nm5fr9GAOuZH1DQpry3h6HhEJ96AhmXU4bdV3fCY0HhHS0
 j3kCeAvoXOzMR4VqFx3QC9g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 16d8f904-20ef-11f0-855b-005056ab7584;
	Thu, 24 Apr 2025 11:32:50 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/7] unshare: make the wording of a message identical to that of three others
Date: Thu, 24 Apr 2025 11:32:31 +0200
Message-ID: <20250424093237.6432-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

That is: spare translators having to translate different strings that
mean the exact same thing.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/unshare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 05db627be..fe140a0c7 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -1241,7 +1241,7 @@ int main(int argc, char *argv[])
 		newdir = newdir ?: "/";
 	}
 	if (newdir && chdir(newdir))
-		err(EXIT_FAILURE, _("cannot chdir to '%s'"), newdir);
+		err(EXIT_FAILURE, _("cannot change directory to %s"), newdir);
 
 	if (procmnt) {
 		/* When not changing root and using the default propagation flags
-- 
2.48.1

