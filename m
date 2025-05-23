Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B672036ED
	for <util-linux@vger.kernel.org>; Fri, 23 May 2025 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001870; cv=none; b=F7bvbUPnjicEDLWJOHU4B+rszZc4B6tjT6pup/VGZ6DCURtoruG9hCxaNxuhmdKobJA8oyXlHSPOigN5iDDgD2wfHk1ztkjdOpwpNTX2Wvtq+eReJR3cQ/4rGBPjDFVuBlNK6Sam1vDOoPZ0RgQb0RUzvjcFl7p9P/3e/pHs95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001870; c=relaxed/simple;
	bh=QNtovGrLjp8xQQYzH82S3r9c3liR2ewduteQGyJhWdA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIPL8rI44gcD3SjkixDFrXwIMyNYEYGWSiHVQ84M9Sr0C7j1HeGXvkDTlv8q1neR/RhPOV25BtWjJligXlyvjWtmEzhOGUaQXmwnSPdGe66rboXxIYSQM/ClfXt9NCXq4f63RmyLTUHvm2+/lJoyG3H9NsD6LCDTgh7tch7h+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=pKg014F2; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="pKg014F2"
X-KPN-MessageId: 32e64091-37ce-11f0-86ce-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 32e64091-37ce-11f0-86ce-005056aba152;
	Fri, 23 May 2025 14:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=tNdQEhnLhTMM4Mzmv9qRr+WdTbBkBlgkfilozySuBus=;
	b=pKg014F2f7G321eYWhPfTCPGH4fC6UNLSrzmZHkxPwGb4xer1Qo0LGqTEGD1lTCyqWXzwL1qtrrmx
	 aYw6aqY1rhdkt5qZphLi8/inko+jwu8TDAai0QMfpxclggPuubrRfHQXVTQEuuTsYP4eZA1hxupcbT
	 ehE6hiK6eSJX9Wgo=
X-KPN-MID: 33|RqZrt4vIUYKcIMkhdSy0a7v6Hdymh0UwEDEzNBjq8YWxgjt1G5vxquxbb13RgMe
 AyYC7d18fvuIrJ8R3m2AOt0dvnbC3/T4Hs2ZpHUuzR2o=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HlVvBGceGWyGEYWQUf3S4KzFkXaSutd1E88n0YqBHzeWkb9BEH9sNjR/ZQwpB00
 dz1xUyNiMlRyYE3ZtEZhgaw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1134adf2-37ce-11f0-8584-005056ab7584;
	Fri, 23 May 2025 14:04:24 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] hardlink: (usage) remove mistaken period from two option descriptions
Date: Fri, 23 May 2025 14:04:05 +0200
Message-ID: <20250523120407.75188-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523120407.75188-1-bensberg@telfort.nl>
References: <20250523120407.75188-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/hardlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index 85d25ca22..7f2ff8046 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -1210,8 +1210,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -p, --ignore-mode          ignore changes of file mode\n"), out);
 	fputs(_(" -q, --quiet                quiet mode - don't print anything\n"), out);
 	fputs(_(" -r, --cache-size <size>    memory limit for cached file content data\n"), out);
-	fputs(_(" -s, --minimum-size <size>  minimum size for files.\n"), out);
-	fputs(_(" -S, --maximum-size <size>  maximum size for files.\n"), out);
+	fputs(_(" -s, --minimum-size <size>  minimum size for files\n"), out);
+	fputs(_(" -S, --maximum-size <size>  maximum size for files\n"), out);
 	fputs(_(" -t, --ignore-time          ignore timestamps (when testing for equality)\n"), out);
 	fputs(_(" -v, --verbose              verbose output (repeat for more verbosity)\n"), out);
 	fputs(_(" -x, --exclude <regex>      regular expression to exclude files\n"), out);
-- 
2.48.1

