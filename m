Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBC23AB86
	for <util-linux@vger.kernel.org>; Thu,  3 Jul 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554113; cv=none; b=RH05JcQFOZA4u6xE+2nJk2cbxxgqui2tT3J9nl3kAJPI/iRadOVB3dXDOj1MQiaWC6YqBL9SkSpkeBjnxnOQyKEx9ltVHI5/TDmZIa2FpGLn59xipM4E43B0Fq71zj4ODj6tLbu4bWhOA9lqh7P8YJ2eZaRj+kVnjc3fNq2oWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554113; c=relaxed/simple;
	bh=oFQzIkqivTEMFwWKw8RUHySQZNybV6s6KuEM9SG4F7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjNhvTyOr/tGiw3LK6dwX2VqGG4aVXAR/jBX0X1zzZHyjwlV/3Sof2wdUPaBR2KAb614Vh0ITF0x6yiN/+2XuPwrG4RHTkr0opsqiu+jfIZNmhcxokfph6z15hNY/lej1JAF+Unx9QIw4hrEzhksfMdvJ3WSp8n3FbXEJFu4pV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=xPRH4NpY; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="xPRH4NpY"
X-KPN-MessageId: f590d15e-581c-11f0-86d2-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f590d15e-581c-11f0-86d2-005056aba152;
	Thu, 03 Jul 2025 16:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=RbvJeydUeRO66NBuxofTLI+PmNwmm5n+p1MWHVc2WnA=;
	b=xPRH4NpY+BMJCOp2uL94XQkGPsOIdJnNbSDQ48LN5gw/dSRE+KOCD/KZ/1asoek6jkQK+bz4aoVMA
	 xEJqLIvnvRpGfiOEPP6zVYTdEjMa84Mv7ZE2R1c8CaSZPuHoylOzsScLTzaXnMS53VvBRWazsFnmdE
	 U4RuMZy++BCmPaIM=
X-KPN-MID: 33|XlPAFWfR6wVznHStKKPZ48Z2+VfRaLb5Kmu25HRWYaoIWU2YsU49jV208btNH1Q
 621/qSOUDXceHbBhwhFsLGbPfVnXyi6oFxcm3XjzP2mg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|dYIZwGlUP5oWQ59+bJktxKXKpf8PmXSLGOGoJm2DGKtcMOkrOJRAx29BdAwmO1X
 qJzLQJIA0D/bqRRnMZ0jSSA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id c554d36f-581c-11f0-95bb-005056abf0db;
	Thu, 03 Jul 2025 16:48:24 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 3/4 V2] chrt: simplify the other check for too few arguments
Date: Thu,  3 Jul 2025 16:47:51 +0200
Message-ID: <20250703144752.29971-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703144752.29971-1-bensberg@telfort.nl>
References: <20250703144752.29971-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without option --pid, always at least two arguments are needed:
the <priority> value and a <command>.  (The 'need_prio' variable
is relevant only for the --pid case.)

Also, make the error message more informative.

CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---

V2: left in the call errtryhelp()

 schedutils/chrt.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index a72c0de26..731f995bb 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -507,9 +507,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (((ctl->pid > -1) && argc - optind < (need_prio ? 1 : 0)) ||
-	    ((ctl->pid == -1) && argc - optind < (need_prio ? 2 : 1))) {
-		warnx(_("bad usage"));
+	if (argc - optind < (ctl->pid > -1 ? 1 : 2)) {
+		warnx(_("too few arguments"));
 		errtryhelp(EXIT_FAILURE);
 	}
 
@@ -530,11 +529,10 @@ int main(int argc, char **argv)
 	if (ctl->verbose)
 		show_sched_info(ctl);
 
-	errno = 0;
-
-	if (need_prio || argc - optind > 1)
+	if (argc - optind > 1) {
+		errno = 0;
 		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
-	else
+	} else
 		ctl->priority = 0;
 
 	if (ctl->runtime && !supports_runtime_param(ctl->policy))
-- 
2.48.1

