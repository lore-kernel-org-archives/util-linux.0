Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3034D923
	for <util-linux@vger.kernel.org>; Sat,  7 Mar 2026 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772883807; cv=none; b=TNprC7Bg0pqhSOt+P6sSwluiowJUFhFL/kfrsaulvMJLkO4utR8TJODwDCfxTFsuFx0xy+QJfcTpTI0bkOwf7Q4LPlgdWGq3rdF80/i6s4S2Ll5OVb4Ob3NUXd5Zt/lWxd6DENbaTBWjNOnFuGc60SQrVcTa4ZVvB+ftk3W6SIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772883807; c=relaxed/simple;
	bh=rW2CXvKCktEOiAx6gkCzs2U23y7qB7wuFyEOEWEy2wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PK9wRXFE1UCaXFy9ol/3PUMf4/BZvaDF5j60e7p20sfO6GHSHGUmFN0kaHlMf68qWx1We660d9ZJDgGsn1odmKJRjqTNrVphdXUQvJeXwaCXll8Rd584iHyrrM/vutBj5ij5zxgN2xSFQ3O1TUBKgeYTD2q7eHtADYqx+5mgVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=QMiUT7vU; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="QMiUT7vU"
X-KPN-MessageId: d7ec8630-1a1a-11f1-8a98-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d7ec8630-1a1a-11f1-8a98-005056ab378f;
	Sat, 07 Mar 2026 12:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=xKuKn2y67vSbetmiit0mrcw6MMzvzkRhghaGovBSXNo=;
	b=QMiUT7vUcC70FtF6odKa16LfFCmRK4JbRUK+z6tLHKe0xaVLmKmirsj/XsVRbfIjo/hjvmvNalOMe
	 len+JyzPPwsWPhG0wzIT/Yq6cYiwwlTi/ZA3xSRaNV4jXWO5urFo5F6YOqLC3VHLxFg2AL4q6H79Kf
	 Ac3qQG/pZKnQcDlI=
X-KPN-MID: 33|BO3wuF+F7O105YRdD7ZmB7naD6qu0pKHRFGNpRzScPBxUeUIgv24iTkFEHGRI2r
 3t1kdswjHqvPuU3HnfDydk+y+O4ueX+woF85TY9PMiC0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xPGJPMSHwWdxzipKO458Wz4VZYloAC1kUZe0DZe8YhzWqxaZuhf+reBS5kbx+MT
 sgmjMgOA+5W0CIBgomjquvg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id d7cde4c7-1a1a-11f1-a6ca-005056abf0db;
	Sat, 07 Mar 2026 12:43:21 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 1/2] lsmem: correct the grammar of an error message
Date: Sat,  7 Mar 2026 12:43:07 +0100
Message-ID: <20260307114308.7517-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

That is: make the message identical to its twin nine lines back.

(The spello was introduced by commit 92d018a105 from five months ago.)

CC: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/lsmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index b74c95d43..aee68a171 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -819,7 +819,7 @@ int main(int argc, char **argv)
 	/* open /sys/firmware/memory handler (optional) */
 	lsmem->sysmemconfig = ul_new_path(_PATH_SYS_MEMCONFIG);
 	if (!lsmem->sysmemconfig)
-		err(EXIT_FAILURE, _("failed to initialized %s handler"), _PATH_SYS_MEMCONFIG);
+		err(EXIT_FAILURE, _("failed to initialize %s handler"), _PATH_SYS_MEMCONFIG);
 	if (prefix && ul_path_set_prefix(lsmem->sysmemconfig, prefix) != 0)
 		err(EXIT_FAILURE, _("invalid argument to --sysroot"));
 
-- 
2.53.0

