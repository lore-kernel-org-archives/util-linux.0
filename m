Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB719F40B
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487191; cv=none; b=mvaXGOMbVXgmZm9pVoUWrdfnuMnpERKJwgRDmKEeXKBB+j9LJ5mfwJAQ6y9KjWu6fcw8+ItNS8qZerl/8OvuhC/yWou+9gyupSWvriJX8yuMYc3CJz6+JIBLoCZms0VsGy2wcTSSlTVyuU3i+dDy99mUeI1JWFIilpP2c8oYc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487191; c=relaxed/simple;
	bh=vyrONDnmpkN8llgiDWNqo8ChBdSNRFGLzg5LsYkNNxg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izBnrP1nXCkQNToR58CjuKXUsrT1VenYU3na6EeduaVBblj6XaP69OTYvBBFVpo3pu23yPuEThbCyZRmQ1ud/EHJ2a0osF9sV3FdyhfUwWUqG2NldI6yYVsNg1mcRapMVWVeR1C1DdzT2d2nOwnaCb1F5X/Ml6CusgjNUvzqD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=C+qG3fqo; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="C+qG3fqo"
X-KPN-MessageId: 394aef52-20ef-11f0-bc2a-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 394aef52-20ef-11f0-bc2a-005056ab378f;
	Thu, 24 Apr 2025 11:33:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=u4Shi05I+ssoGgeWqZ1qbgxLt2DLqdmY/vdb4ZY21I4=;
	b=C+qG3fqobkiXs+gEEhbadnvUXRNOb0JQ49BWhtieBLWmHfgAYn99kvyuSqW9mhAY1MZSokWHkBb3H
	 55q/kKWxRcohaEkj7ah0hRNKA9cD5ln4Fbyk1E/c0TUZ55a/wQ4f7+hY4JrXsVQpTFVWJzI9EC8dth
	 RMSLB4tiBUP8BTQ8=
X-KPN-MID: 33|pnPWy3dXQDI/lM4rrjelSxVcJSuaQwRhMIzqsaLFxqJb8FgY9EFy+DQ4e8HqJsV
 C1eeGM2tWaV5h86XtUGQZek2Yqa1imd0iYkCm2/YblxU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|o0T6HgZSXh094d87PPOpdvIgRtkgDBZIjuqWBhEdNoP70p+J29sAcY5IrQruhLK
 Kmzbc8gGL92LjnFUxy8JWqA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1faf24e2-20ef-11f0-855b-005056ab7584;
	Thu, 24 Apr 2025 11:33:05 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/7] lsfd: improve grammar, and use angular brackets around placeholder word
Date: Thu, 24 Apr 2025 11:32:33 +0200
Message-ID: <20250424093237.6432-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424093237.6432-1-bensberg@telfort.nl>
References: <20250424093237.6432-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, use dots instead of "(s)" to indicate possible multiple arguments,
and don't use "<when>" when the possible arguments differ from "always",
"never", "auto".

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 lsfd-cmd/lsfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lsfd-cmd/lsfd.c b/lsfd-cmd/lsfd.c
index 2eb53935c..3610de8dd 100644
--- a/lsfd-cmd/lsfd.c
+++ b/lsfd-cmd/lsfd.c
@@ -2190,14 +2190,14 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -o, --output <list>          output columns (see --list-columns)\n"), out);
 	fputs(_(" -r, --raw                    use raw output format\n"), out);
 	fputs(_(" -u, --notruncate             don't truncate text in columns\n"), out);
-	fputs(_(" -p, --pid  <pid(s)>          collect information only specified processes\n"), out);
+	fputs(_(" -p, --pid <pid>...           collect information only for specified processes\n"), out);
 	fputs(_(" -i[4|6], --inet[=4|=6]       list only IPv4 and/or IPv6 sockets\n"), out);
 	fputs(_(" -Q, --filter <expr>          apply display filter\n"), out);
 	fputs(_("     --debug-filter           dump the internal data structure of filter and exit\n"), out);
 	fputs(_(" -C, --counter <name>:<expr>  define custom counter for --summary output\n"), out);
 	fputs(_("     --dump-counters          dump counter definitions\n"), out);
-	fputs(_("     --hyperlink[=mode]       print paths as terminal hyperlinks (always, never, or auto)\n"), out);
-	fputs(_("     --summary[=<when>]       print summary information (only, append, or never)\n"), out);
+	fputs(_("     --hyperlink[=<when>]     print paths as terminal hyperlinks (always|never|auto)\n"), out);
+	fputs(_("     --summary[=<mode>]       print summary information (append|only|never)\n"), out);
 	fputs(_("     --_drop-privilege        (testing purpose) do setuid(1) just after starting\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
-- 
2.48.1

