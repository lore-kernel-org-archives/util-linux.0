Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D62036ED
	for <util-linux@vger.kernel.org>; Fri, 23 May 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001944; cv=none; b=HzZJ8oHfS5wExXbTIdFkHwkV4CzKDM/TkSoqwhiDliLIQBhem1tKhDxrnw2UG+2Fi3OaksCvtjrnS+HLjKCoZo5NDPxsLwGbfIeUlWkMhSUFQJ2tUGD/qNOM5eDTJA1imFe7mHVOmpq2kDFpUJLmmQlwF/xe+4YxPrhqhyenANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001944; c=relaxed/simple;
	bh=Oxu/hb7+psNVGi5H0kPO0pOPMVedRzdBLRJR1cOQCBk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEXFizg0ByoZVxlzF6RvQRJVFI1ncabvBpL7GJiDnp5E57fQyP3QG+uvgigKvzxyIDsQM9kgpb/f362d/wrDEaV0bcVEQyFJbYre3wEHbIe+7OZQKFcG33HrATgP1XY4NUfvbhHtmXBI8az5sovZKlir7SSmVL/tx8ulzMmHSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Y3+BaaZP; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Y3+BaaZP"
X-KPN-MessageId: 38db6039-37ce-11f0-bc2b-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 38db6039-37ce-11f0-bc2b-005056ab378f;
	Fri, 23 May 2025 14:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=yiHfyxdLJen0jPBdWdwxtS5s7vBwVtFLs2PHptfisug=;
	b=Y3+BaaZPxR94NB4Ao8+TLvDKuKfL9WqVPJYIr+YmVhwxfpHBiTfmrnxvSaEN0/H/8K/8P5BoIP1mj
	 LvNd7DiTT06/voARaEbA6BwWquY6vjCTI8ydRfSQNjUHsbMQ1yocYyrWwkqYxBVzUttLTMjZWIDtLL
	 yqnp/SFhpCaZK2Eo=
X-KPN-MID: 33|/u7nEU7hGblyPhsCIsgXTFhXCrmCKfXi8E8ksfMBbolDPEbxAYQRg0O2cU0Nk4w
 tc1NszQtWWz4lvHUPCtSR0CjD+Y5ktsZiAsJ9hgkZdq8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Mj+/v0uzQX9bjb2bbFTvcZMfqSrqyzlA11lryW90A+2VukoXW+s5qjdVNmSBiLF
 AEDbaAgtqclqwrIc1cjoywg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 166ce1c7-37ce-11f0-8584-005056ab7584;
	Fri, 23 May 2025 14:04:32 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] hardlink: (usage) improve the descriptions of three options
Date: Fri, 23 May 2025 14:04:06 +0200
Message-ID: <20250523120407.75188-3-bensberg@telfort.nl>
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

The first description was too wordy for a --help text, the second
was vague and seemed to imply that it should be combined with the
preceding option, and the third failed to mention that it doesn't
actually link anything.

(Note: the choice for -m for --maximize and -M for --minimize is
unfortunate, as most people would guess the opposite, especially
since -s is used for --minimum-size and -S for --maximum-size.)

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/hardlink.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index 7f2ff8046..5365e5370 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -1195,11 +1195,10 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -d, --respect-dir          directory names have to be identical\n"), out);
 	fputs(_(" -f, --respect-name         filenames have to be identical\n"), out);
 	fputs(_(" -i, --include <regex>      regular expression to include files/dirs\n"), out);
-	fputs(_(" -m, --maximize             maximize the hardlink count, remove the file with\n"
-	        "                              lowest hardlink count\n"), out);
-	fputs(_(" -M, --minimize             reverse the meaning of -m\n"), out);
+	fputs(_(" -m, --maximize             keep the file with the most links\n"), out);
+	fputs(_(" -M, --minimize             keep the file with the fewest links\n"), out);
 	fputs(_(" -n, --dry-run              don't actually link anything\n"), out);
-	fputs(_(" -l, --list-duplicates      print every group of duplicate files\n"), out);
+	fputs(_(" -l, --list-duplicates      just list paths of duplicates, don't link them\n"), out);
 	fputs(_(" -z, --zero                 delimit output with NULs instead of newlines\n"), out);
 	fputs(_(" -o, --ignore-owner         ignore owner changes\n"), out);
 	fputs(_(" -F, --prioritize-trees     files found in the earliest specified top-level\n"
-- 
2.48.1

