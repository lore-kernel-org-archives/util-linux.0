Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AAF1624E8
	for <util-linux@vger.kernel.org>; Sat, 15 Feb 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636416; cv=none; b=nMCKjlwUjp2l0qnTSmu9Dveji/9lpHj1ITLMRzP6uZKLU2bGSeb4ubJY0U43setE+Q7BvHE1zosORFMPtlEG+6A8873hiV0m6wM9hGhF6A7Tve6FDkNp3fhXno+Y9hcwfmk6DIYmfgIyYho11B9AkF+DKMpt8rAVuoxJEFuA110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636416; c=relaxed/simple;
	bh=ioaU8uAz3fRh+pFvJzZQ79GS20br8EypqutwP0UqLUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwjfJhEayvsiFVvuJOAqvbAoBahXVybtE8jhTVKmfg0NCq+ksGeFjpIWs+98H39vZzrpEQnFdZM6E5q6Pct7lgjzz3CT3CIYKJT4io2mzcOKnpmLq+afUZNDRTC6aSyou/maihMewqRPm2OFAJlIUGsjqlJ+xh9oBp9y51EOgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=KlGmD7P3; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="KlGmD7P3"
X-KPN-MessageId: bd0024e7-ebb8-11ef-8f0e-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bd0024e7-ebb8-11ef-8f0e-005056aba152;
	Sat, 15 Feb 2025 17:20:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=BLqW++YIF9T75dHA+DEgWXYlIqGa3YqepMMd7Fza6IM=;
	b=KlGmD7P35JGDEOEMhFcb9sSgeIr9xUZ/lIKRtlQ8CqKk/yxveKQwm5FQLkJePQBNf87XPmfCzMKkJ
	 4F9Z2YUKaXA/tM18qEFsMOwVpbRsJWGnVq7KWopsvmCaGodcMPc1N5lfJrkvs+Rq2S/eWJHD1D1AtU
	 Kjhzn2OYGmEce9S0=
X-KPN-MID: 33|1Jl3h7BlLo3mWbYvQS4NwskAzcYplmOH5Zo8LcWJMi7iRPdPZdH/tS7oDcdIkUa
 B+zmU9oPkmWgdI1MViZwBlsWQmG1CJPj4tHfV+DH6kuM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0tBxxVI6PxVvKaJvcvSCvIHuyrYBoOYaXT/Sb6X5hdc+FDMEA5UMc/JR6c5NBOL
 PFbwLfZUqqMaS+l9ycYrCvA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id bb7e9ae5-ebb8-11ef-92ee-005056ab7447;
	Sat, 15 Feb 2025 17:20:12 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/10] rev: standardize the usage header, making the synopsis equal to another
Date: Sat, 15 Feb 2025 17:18:40 +0100
Message-ID: <20250215161843.12053-7-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215161843.12053-1-bensberg@telfort.nl>
References: <20250215161843.12053-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/rev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/text-utils/rev.c b/text-utils/rev.c
index fc7ac6203..4c2357a7e 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -73,8 +73,8 @@ static void sig_handler(int signo __attribute__ ((__unused__)))
 static void __attribute__((__noreturn__)) usage(void)
 {
 	FILE *out = stdout;
-	fprintf(out, _("Usage: %s [options] [file ...]\n"),
-		program_invocation_short_name);
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] [<file> ...]\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Reverse lines characterwise.\n"), out);
-- 
2.48.1

