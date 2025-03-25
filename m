Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626A149E13
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899431; cv=none; b=tkqbuxaYlBjqZt/LmE0UYeVHucpzvpIa4UpvofYm1piO6wokwfw8/8zUVlviGRrNbISAgtZRUmWT1XLVo3+Q5Q8JyMtHIreZOA3/eIC7JPcpsBg6OIAzHqwffnZ5T1iLU1P3zzUbMnf9vWrX4FR3ltg51gwnDRQYycnPBLX+Nt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899431; c=relaxed/simple;
	bh=YRRylg74fVbMJ9+IT0cFBAb7UJciSwO6pgx5Zky/5Lo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzcyrmABk2IGsVjNPnHMMlIGeqtsFye3Ql8S+FGG54owpw3GjvyvKxJpLnu7/c/9d+BcUAAzgZcODXmIph4CiC+/taPqXtwnhuaX059Uo5ZHtYdgW7pcKZ7Ti6bA/N34hVtHDi617ZsQXQ2tvlhIR1ptQ84Wai7yR4SYLPeyVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=k5sDHFL+; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="k5sDHFL+"
X-KPN-MessageId: 0d99e323-0966-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0d99e323-0966-11f0-a82d-005056abad63;
	Tue, 25 Mar 2025 11:43:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=XxqjxUaZc3BlLLh6wWsJ+chs0d+7yvdrwa4FUmXoWgA=;
	b=k5sDHFL+kr7Zkb5a6GhGKpvLHALwinMP5taR1L4YR8aEpfhgrAh9cTdfP0XmagIVic4W/c3+bbGnT
	 kd3cN/s6ealfJOnwAE3Trru3vpGb8LsKCCIuq3ijeGZlOlWxJ36opS8YS4KzlZwZmAUpRWShpYv7qF
	 z4ahh89gnMX+CVE8=
X-KPN-MID: 33|MPftSb4IL4/2AwnUQ6iNG53MuGkR4ja/ynCikWOlC+u5SLow9EWBJYAw8KfLPro
 jxvMm436dKydOIwzKo+Iu2zvD7JRWQCYmFzXRPfVmMyg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|rC4Hu/PlM9AJIONiPqEamNsWxLDhMDRB7ir2TL8CU3kSY+d6ywprHw1cBbUWwMJ
 wNZAxYUNnB6AuEIb47o1Tmg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 03cd77f4-0966-11f0-9bed-005056ab7447;
	Tue, 25 Mar 2025 11:43:40 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/11] chmem: print warnings about failures always (not only with --verbose)
Date: Tue, 25 Mar 2025 11:42:58 +0100
Message-ID: <20250325104305.23980-4-bensberg@telfort.nl>
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

This makes the handling of errors the same as some 90 lines down.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/chmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/chmem.c b/sys-utils/chmem.c
index 4105d1969..5ff344fd3 100644
--- a/sys-utils/chmem.c
+++ b/sys-utils/chmem.c
@@ -146,12 +146,12 @@ static int chmem_size(struct chmem_desc *desc, int enable, int zone_id)
 
 		idxtostr(desc, index, str, sizeof(str));
 		rc = ul_path_writef_string(desc->sysmem, onoff, "%s/state", name);
-		if (rc != 0 && desc->verbose) {
+		if (rc != 0) {
 			if (enable)
-				fprintf(stdout, _("%s enable failed\n"), str);
+				warn(_("%s enable failed"), str);
 			else
-				fprintf(stdout, _("%s disable failed\n"), str);
-		} else if (rc == 0 && desc->verbose) {
+				warn(_("%s disable failed"), str);
+		} else if (desc->verbose) {
 			if (enable)
 				fprintf(stdout, _("%s enabled\n"), str);
 			else
-- 
2.48.1

