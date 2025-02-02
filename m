Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83410E0
	for <util-linux@vger.kernel.org>; Sun,  2 Feb 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738514323; cv=none; b=ZllQFaQv71e0u9ib6urunheSPLD+kLKJd9S2S1MZ7YDb6a20yTXGg1StNAYJOmAuanTar95oGdAcrwGr98XQBmEU2E29d+ai2t5RWo/5Z66KF9jRpJpG1H/He09PkA0NuoLdCHSAXENE9qwQlj8g4bla8E6tj88CtEeo5Sjjd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738514323; c=relaxed/simple;
	bh=k5DkbVgG6HqtNCxd5PWm/gh51xDh/6JlVM/83ykRdC4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YoKXNEpgJKvRFUUiGv76Py651+Lq7J/2OOGKhBgykxdZNuELXOxkEdjcySoWteukNkN+gLSF0vkQTMoJUNMpySXbikWA0pe5DjSr7fRqJmw8680u4hcyjmJfzszbswVPIFwY2uIULNDYzCE0t9+Y7u/Ud1o78SzZYzLJTEwzRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=xmmj5X0e; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="xmmj5X0e"
X-KPN-MessageId: 601262a5-e184-11ef-aff5-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 601262a5-e184-11ef-aff5-005056abad63;
	Sun, 02 Feb 2025 17:40:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Op4gokpMusjSueuxxNSiTLy8FMtOt2Zb0eDkrIUWIGg=;
	b=xmmj5X0egr5pBZcp8jCxaiaRE/GLsBYctRCa2xCgtHEbe5d9MHKUxccSDfDuQAGDDTLdVx5Q7f3mZ
	 Z3oVVn9jNN5ZvHnmJSj9u+43q88O9GLCZpu3vVVJUNkAU4uubLK33i77TItb8bivEL5WnGUNu5fkg0
	 gJsdJMWXc+vLCVn4=
X-KPN-MID: 33|JnXCudoohagIdf+K8tHuTlutHwoFTxWwcqeImNkFcTfHcgqS/1nm1m3Z+P7k3Du
 FaY2IkxMg5iGtEeaYFHQ80+Zp511Ta+9gqNRGE86PUlM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|GqCXZdpqC9r38EwHuKg7RMUqXc7q77BC3Uu0WV5cLO0WS6qb2NQMzEb1ndAzH6b
 +oK/5RkABEC1QeYfcRZSuwg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 23eae301-e184-11ef-a315-005056abf0db;
	Sun, 02 Feb 2025 17:38:32 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] setpriv: describe --groups more correctly in the usage text
Date: Sun,  2 Feb 2025 17:38:09 +0100
Message-ID: <20250202163810.15911-1-bensberg@telfort.nl>
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
index f68e6c48a..43d72f64c 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -146,7 +146,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --clear-groups              clear supplementary groups\n"), out);
 	fputs(_(" --keep-groups               keep supplementary groups\n"), out);
 	fputs(_(" --init-groups               initialize supplementary groups\n"), out);
-	fputs(_(" --groups <group,...>        set supplementary groups by UID or name\n"), out);
+	fputs(_(" --groups <group>[,...]      set supplementary group(s) by GID or name\n"), out);
 	fputs(_(" --securebits <bits>         set securebits\n"), out);
 	fputs(_(" --pdeathsig keep|clear|<signame>\n"
 	        "                             set or clear parent death signal\n"), out);
-- 
2.48.1

