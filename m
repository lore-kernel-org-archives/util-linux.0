Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0961F03C5
	for <util-linux@vger.kernel.org>; Thu, 11 Sep 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598570; cv=none; b=oRjiEoLRgpXHEDXDb0WavEKS3oEOOkyHR1TH6sdoVkUolG/wl4qvuPnSz5BE8IbVjxlzk08CXd0Duwy7OmbhvVWNqGeaNfi599qn6QsYkC6swrI74Ue7hYnB/BSD62S9fWBxEe3sME7CDbzSma5FQ38ZybM5k1xfwLlg0YLKrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598570; c=relaxed/simple;
	bh=sO4UjLNrWNt5+Ia3ZENpruPl23P05/94Sck643nUNtM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SInByRj8SCNO4z3Zb7/ll6NTPR/Hf43VFBlUbsvICQ/GUsisAIRmlnuzuN7I3XUnRjWDxHLonjzDNToYbXXzt7UvsMqALBxYipswTCBmhUkBpdUQlFsRvGOLLXoiuU7sffnjAhvf22SnfZ83C/I9m6Cqfplm6kx9jA7nztyUsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=PTG8nMSy; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="PTG8nMSy"
X-KPN-MessageId: 81e71466-8f16-11f0-a4bf-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 81e71466-8f16-11f0-a4bf-005056abad63;
	Thu, 11 Sep 2025 15:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=k4iO+mdZTZlHR7givuTJPuvhcj3+4R8qXQrg1hn/VbE=;
	b=PTG8nMSyv2yHyaZ5P1hWD6z4Ck+xFYrRqtISvhLa1pnODUslrSl0FEZKITtUIa9CpXcEPeeKwAnQU
	 GxPceY1UHeAL4545hMlEmWwEeRROMZG7ukzAfkQ8Lc/KAu0zOz1V5NbL13U0HVRWec1ZDBbf/gexI/
	 JSWG61+l4erF/+CA=
X-KPN-MID: 33|OVprAYAj70eV+OQYZZOU8xMDieWq6m+Rg98PS3tqf3WN/jKXWuMLsaAXBuj6qIC
 ga23D1N1fH9XSB2SRK7IqcX7xHHgihB3LZXGFbGlTzAw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Rkq6YATbnZF3aPnVb4A6+WszFSgpDjj0B5MBmjulBFILiLvfwW/7CnYTu2nnvzc
 isGiSG5kjSh60I3ywpS1glw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f784b910-8f15-11f0-a7a0-005056ab1411;
	Thu, 11 Sep 2025 15:48:15 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] findmnt: (usage) add a needed equals sign before an optional argument
Date: Thu, 11 Sep 2025 15:48:07 +0200
Message-ID: <20250911134807.12903-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The argument of --kernel is optional, so an '=' is required when an
argument is specified.

Also tweak the wording, and add a semicolon between two phrases.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/findmnt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 463537e69..83989c10e 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1533,8 +1533,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -F, --tab-file <path>  alternative file for -s, -m or -k options\n"), out);
 	fputs(_(" -m, --mtab             search in table of mounted filesystems\n"
 		"                          (includes user space mount options)\n"), out);
-	fputs(_(" -k                     alias to '--kernel mountinfo'\n"), out);
-	fputs(_(" --kernel[=<method>]    search in kernel mount table (default)\n"
+	fputs(_(" -k                     an alias for '--kernel=mountinfo'\n"), out);
+	fputs(_(" --kernel[=<method>]    search in kernel mount table (default behavior);\n"
 		"                          <method> is mountinfo or listmount\n"), out);
 	fputs(_(" -N, --task <tid>       use alternative namespace (/proc/<tid>/mountinfo file)\n"), out);
 	fputs(_(" -p, --poll[=<list>]    monitor changes in table of mounted filesystems\n"), out);
-- 
2.51.0

