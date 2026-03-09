Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0039B4A5
	for <util-linux@vger.kernel.org>; Mon,  9 Mar 2026 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054951; cv=none; b=CGRD+TENaW5RByP89jBHqNS94tX2M5FRH3QVhU8MY1Lzl6P7ZlwjlLKreAyHh1Aw5dL0R3Jc0o2G+7Gw6XztYXpzMQPMWHYbaCBIIR8Ce52tXHNrIldVu7wqPKDLKXSODo+GDQL3FTUNLr91wQwwopISo1OCuTC6tip5w2AjOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054951; c=relaxed/simple;
	bh=n/tPttTdNILOfxlQU63S33kjjwm1hdtPhNAdxueHVbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2PR1SR8Mk5G9wWS0AU1kkQrjd0pZZDnprWy2KaEyIxRP7KC+Dzra+wXmzR5+dO4GVvxdui7mICCrPefdJz88gG5IyZVE2klNwE8MDUybD6XhQhd1zAsXqawWJXHvAfz1DlvYmyoymDOmzH/KkwbAl3qMHm2mP4SjFC03oG99sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=wmHjfiCU; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="wmHjfiCU"
X-KPN-MessageId: 51eb7408-1ba9-11f1-8a98-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 51eb7408-1ba9-11f1-8a98-005056ab378f;
	Mon, 09 Mar 2026 12:15:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=P+iYTgPDOYxiDFJbQgjMOOi113jmsxifE0pKf0cBV6M=;
	b=wmHjfiCUeb1S36Hwus4tS8uL4QhXRh0lEbm4CY5JqfQnosxc//HJiad7z+FbwXbxHDLg2xlf6L1iG
	 efGDlQ68cCFU1u44HM2OUXedUZwlpEupgCHmw2Htl7+Zus+52HcdWQEXgHpVUmzTNSZZIL4tXhvxif
	 91TLwv/HB2DoGHgI=
X-KPN-MID: 33|lsZWQXLwrpgW5ZaUFbZZOJR36EMx7ymzEVZifY0tB5bp7dpseucSz+Bu9MomZx4
 DaS9PhOtKw8VjNQcVdmFmVptgOGh8SSxtjvw19kKhXO8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|hWq7rVVZYD8qLr/SHFurrZCsZMjfEdqb73c8ezFX9W0JpVt8kjMN76vG3DCvWxw
 0BU3D3I8RrQqwKw5SKHGygg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 51d10791-1ba9-11f1-a6cb-005056abf0db;
	Mon, 09 Mar 2026 12:15:46 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>
Subject: [PATCH] waitpid: consistently write the abbreviation "PID" in all-uppercase
Date: Mon,  9 Mar 2026 12:15:44 +0100
Message-ID: <20260309111544.4952-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, use %d instead of %u, as all other comparable messages use %d.

CC: Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/waitpid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/waitpid.c b/misc-utils/waitpid.c
index 865b537e9..d77a41c5e 100644
--- a/misc-utils/waitpid.c
+++ b/misc-utils/waitpid.c
@@ -74,7 +74,7 @@ static inline int get_pidfd(const struct waitpid_control *ctl, struct process_in
 	if (pi->pidfd_ino) {
 		fd = ul_get_valid_pidfd(pi->pid, pi->pidfd_ino);
 		if (fd < 0 && ctl->verbose)
-			warnx(_("pidfd inode %"PRIu64" not found for pid %d"),
+			warnx(_("pidfd inode %"PRIu64" not found for PID %d"),
 					pi->pidfd_ino, pi->pid);
 	} else {
 		fd = pidfd_open(pi->pid, 0);
@@ -94,7 +94,7 @@ static void open_pidfds_or_err(const struct waitpid_control *ctl, struct process
 					warnx(_("PID %d has exited, skipping"), pi->pid);
 				continue;
 			}
-			err_nosys(EXIT_FAILURE, _("could not open pid %u"), pi->pid);
+			err_nosys(EXIT_FAILURE, _("could not open PID %d"), pi->pid);
 		}
 	}
 }
-- 
2.53.0

