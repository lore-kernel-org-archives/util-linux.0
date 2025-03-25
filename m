Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3111946AA
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899439; cv=none; b=Edt5e/wNHBG+2LINI8Hw9ITOXI3Yvyon8Edqv3nJqcl9bx7cLjNhbpnnJDKQDtPOdSAFw/WH/X9EOhIBwZ0UG88cgwi4m5vM2aoPyzLNRLQ/gTEhnSF2E89nl6CPcFWpODOcOTuXU+DMxIbx4e2SwpBYOCrpNUmc0CsLKIoRdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899439; c=relaxed/simple;
	bh=eqETylMPo0la7dVOuSQeL1EihdUFzZXnEEJ/vHj5f2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XM9/J3/L2KC3+YlcLkXwf8Q3JeOML8UbXH4JQAhIjgMOyV4KM/HUVSjjD7ziLNH3hEjY7m/QoEd7sE+9ShgjxMAJZBaukMXgLmqGSgQ9gBBnETAf8ZWU40uVKotbVC//SbBlWWr/GfiLy+zJnV/T/SaCM1dMLW2ZBQw3NgDW9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=SCAyLTN0; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="SCAyLTN0"
X-KPN-MessageId: 17032f80-0966-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 17032f80-0966-11f0-a82d-005056abad63;
	Tue, 25 Mar 2025 11:44:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=7vNqqQ0b4Rc7CuPhxO5Y3uasUEUPBCCnCN+uZCFjQxY=;
	b=SCAyLTN0l5X2+TM8eY4w7hWmYNNQCldC6lNMU7A6zxBLOf05ysAFpFCaNBvzhnkY6bD/cxDAVtuzM
	 XQlN2Jp+1EM04/jF5UpJ24TEhR2FNrhepW8RthyM1Hip+zTJbfyZBmzLhaS1H+sUg2PZabMgT6hu3x
	 32TTFAnzCZOyM2a8=
X-KPN-MID: 33|DUdFX8a2V0KS4IOUMwFyybRw/pY0d4sbIlhnvNfSFSsGy+0rPWWQtUdnoURLGPo
 hW1LpDlK2TYn5BbPXge40dw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|szKDS+b2U9vBD34ulg7TIwPraDGnPJcCfACo9qTWfSXSo4sn5OEuKy08/TwvJyE
 2HaNGkt3NDBL4k4VOU3CrhA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0d3a2560-0966-11f0-8503-005056ab7584;
	Tue, 25 Mar 2025 11:43:56 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/11] fstrim: mark only the mountpoint as placeholder, not options -A and -a
Date: Tue, 25 Mar 2025 11:43:00 +0100
Message-ID: <20250325104305.23980-6-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325104305.23980-1-bensberg@telfort.nl>
References: <20250325104305.23980-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, write "mountpoint" as one word here, because it's clearer.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/fstrim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index 2ae3480b8..4d43c7957 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -451,7 +451,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-	      _(" %s [options] <-A|-a|mount point>\n"), program_invocation_short_name);
+	      _(" %s [options] -A|-a|<mountpoint>\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Discard unused blocks on a mounted filesystem.\n"), out);
-- 
2.48.1

