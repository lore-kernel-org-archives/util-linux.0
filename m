Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44A1C84AD
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883348; cv=none; b=ljniyYluLSmYqgNaMovRdHKA8vz5fdbPivGpquvR6z2DTFERLMDPcEOXEzVhOm6CazIgFVyYkp0FC+c5Zh57p63kx3yTGq8MuYu67EeFBKh0FqTFD/P6+mjXbGbHL1H0pXuhPhqFqv4z7dvgB5L8RD9cDowdzhrQ+qzYRmRlEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883348; c=relaxed/simple;
	bh=jvhqKokg5y+oEpCvaecYO50uzYlp0HTJyjCqyLak74w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcyhcr/mCPE0t7oVaeMY/yNR29gfvaKmQTRTM5NYcglVSI95Amz0GFoL18+CApLhrotpa4TVo44sxeFH4QLnQ117cGwPU4R9L3YYElo+3YgPW4S63INECh+tBdelK1dsmdbVzSOSme5JkEv0KK5wAIijpYFvguvu/29dwUM1yps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=FI/pCAnV; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="FI/pCAnV"
X-KPN-MessageId: 51bfd0e5-1b71-11f0-8ec8-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 51bfd0e5-1b71-11f0-8ec8-005056994fde;
	Thu, 17 Apr 2025 11:49:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ZflFkfB13chnHqGDTd1Qpt+uTTHTUgaTEMjBfeNOVQU=;
	b=FI/pCAnVrQ7rqxFTs/jZlfw4keZ/7+Vw4ml5V7G2mOnpxgwhZOyQd9c24nVc3LHUGiGN/caiAe0Sb
	 1QPexJaXcyWXt8wJOiluKMfOA4VIfaHaH9avbkxRHovkz5tC+cLuIvioIheBtrS3mn9Wcj6+z4QVzg
	 FDUu8t/xgQft8nyA=
X-KPN-MID: 33|UXI2S5G5vJS29YXMwUvZpadw4QI+06y95sR9snZXkHtyX4VpW/6QfNwGN9z97z7
 c65RV6BnUbXaAuo33RCbtmN64dVyqodfTA8ifuoKiaMY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|OKaa1cuaVdg7a9Ls60Ku/+FrEWctk4RY4rf3MtlCFYYGy1AXksl1nUwUJHrx1/L
 wj10x05o1x/npODCGXQS4CQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 3271b7ee-1b71-11f0-9da2-00505699b758;
	Thu, 17 Apr 2025 11:49:04 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: David Anes <david.anes@suse.com>
Subject: [PATCH 06/10] renice: in usage text, condense the oververbose description of option -n
Date: Thu, 17 Apr 2025 11:48:20 +0200
Message-ID: <20250417094825.20870-6-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250417094825.20870-1-bensberg@telfort.nl>
References: <20250417094825.20870-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --help text should be concise: it serves only as a reminder of how
things work.  When a more wordy explanation is needed, there is always
the man page (as every --help text says at the end).

CC: David Anes <david.anes@suse.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/renice.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index eac104db3..7872e8fbb 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -70,10 +70,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Alter the priority of running processes.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -n <num>               specify the nice value;\n"
-		"                          if POSIXLY_CORRECT flag is set in environment,\n"
-		"                          then the priority is 'relative' to current\n"
-		"                          process priority; otherwise it is 'absolute'\n"), out);
+	fputs(_(" -n <num>               specify the 'absolute' nice value,\n"
+		"                          but 'relative' when POSIXLY_CORRECT is set\n"), out);
 	fputs(_(" --priority <num>       specify the 'absolute' nice value\n"), out);
 	fputs(_(" --relative <num>       specify the 'relative' nice value\n"), out);
 	fputs(_(" -p, --pid              interpret arguments as process ID (default)\n"), out);
-- 
2.48.1

