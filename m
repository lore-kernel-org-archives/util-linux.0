Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688C2FE58C
	for <util-linux@vger.kernel.org>; Thu, 18 Sep 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185847; cv=none; b=O9A9ct3L5ul5MNik70Go+17v9dzD+lO/JRLQjGzTR0p3fl9q9JE4J3KiDujyFDDWxZqdRPTee7QMmo7E442t6AC/6RZ/76GtzWf+FkiH4k+E7NdQyEG7qJx8WnNftALD1r5GNuYf4G+/fV5WZotARV0MjNTeG7AqAxtE7stw7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185847; c=relaxed/simple;
	bh=P6poXlhav7RNKA4CJXVdZcMHxht91HPHcJ5ybnuuCR0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FkcTRSn8RlG79+u8t1Z//tE2MZ2sQjI7O4KUsboHlfu2ClY/kvoLCFn5s7bqey/TMBANq+8K56Nf6xp1qXY7+0uHWTydNcN5wcXaTOs2eFdEnXM4h/uoTTpoC4ehxsHMAZ7Rlvsff4pUbmPvljkF7CX2aVFL3ytEwImr7vO9fVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=EBDJM5E0; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="EBDJM5E0"
X-KPN-MessageId: a19ea46a-946d-11f0-80ed-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a19ea46a-946d-11f0-80ed-005056aba152;
	Thu, 18 Sep 2025 10:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=na4RNl62DZfVHDKgNFVpDGOvblWfk0u603mPvQVoJoE=;
	b=EBDJM5E0p+3ezau522/iY9R2c6VG+xh7KS001Aa/hSKyFp3Rf7g/E9NdmW9FiVUQhlDctGdq03rFQ
	 Bn6nDoeXGeSU/A/xEpdLD69wdXwPVz/Vld6Ssn93IxwecaZn916ZqDBTn87hbgNx82i0BtlMr8B7ss
	 puEX8hATdHNjqNyw=
X-KPN-MID: 33|kO2L5+tUO8ociDEbrQcCcydcLHangxSUzIiOw/nIraNPDXifv7pM6u2eOFnBNDg
 b5l7UGA4eHUywfEaRxacektm2ipqx/x9vT/I7vvkw59c=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|5d3vz6toyDQFluJKO2U70B/JHrTjD1V/IgFJdk6rx8J1JSUnfu8ckesVKHNtJkZ
 Z4IiwN9EVmCMrDzIqwAc8iA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 7863b4bd-946d-11f0-807c-005056ab7447;
	Thu, 18 Sep 2025 10:57:14 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/6] getopt: (usage) make the description of -U fit within 80 columns
Date: Thu, 18 Sep 2025 10:57:02 +0200
Message-ID: <20250918085707.41785-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(It is good practice to keep --help output from causing ugly
wrapped text when printed to a standard 80-column terminal.)

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/getopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 180313cb4..68dba4597 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -372,7 +372,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -s, --shell <shell>           set quoting conventions to those of <shell>\n"), stdout);
 	fputs(_(" -T, --test                    test for getopt(1) version\n"), stdout);
 	fputs(_(" -u, --unquoted                do not quote the output\n"), stdout);
-	fputs(_(" -U, --unknown                 leave unknown options as they are and disable getopt(3) error messages\n"), stdout);
+	fputs(_(" -U, --unknown                 leave unknown options as they are (implies -q)\n"), stdout);
 	fputs(USAGE_SEPARATOR, stdout);
 	fprintf(stdout, USAGE_HELP_OPTIONS(31));
 	fprintf(stdout, USAGE_MAN_TAIL("getopt(1)"));
-- 
2.51.0

