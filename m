Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EAA42A8B
	for <util-linux@vger.kernel.org>; Sun, 16 Mar 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742138530; cv=none; b=rXSvvWoQskESK5zZObXHdigc5ad4MR+FeR3HI6ncZmp3xOgrwiISi17ofQ9CBhC+a5L1zK4rk76zNYcZiHxI7+AtdQ8s4/Aq/BYQpC57FJh1tsD6bvjon3cuoW4MTLG8E1ywtjRRplFVmRbDzMNSM1JUDWsLsIXGuTz3S/QSII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742138530; c=relaxed/simple;
	bh=wX9ZF1SCjUer9BQvGttGyr81DW7Dy6KxZL2GtLFROKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aR7aKe1kLO8AtTV5cAYN2tcF+sg7pbC46m3GPOuoh0U0kgQOvu5vlA/VThgZpXDC6TblZQ9ICXawg828dwyH3zck+4l+6xG/CmxhjkuTmwhmlI6NgpO+EIlYiOZrR+yHp/pKlbbBts7C7BLAIPxu4MID2hmDTiWNRzedUReo608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=YirlBIVJ; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="YirlBIVJ"
X-KPN-MessageId: 50f8f6ab-027a-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 50f8f6ab-027a-11f0-bc28-005056ab378f;
	Sun, 16 Mar 2025 16:21:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=/10X1GuZebdacXR4w3D4YYljk9H8dLAOC+gs/Tai5bU=;
	b=YirlBIVJhv/INf9oOd9SU4BUyD7Sx8SXpR4lLK78l1fo3UGImZLa3EHC4ZsI66RJB5UtJ43j9LV4b
	 18otr0L6z7B+p34XU0WJfZPo3pGVmEljPqze+01E9LBJG7w8SZ6YdVdQYv5X6uFXJBNaaFTANWaPMn
	 s8aQ0bIFQoViULcM=
X-KPN-MID: 33|I1CliPuZhOB7coSHNHHkuiFMBFGPyNScHs4wqcpJF+Lrtwx4OTFLjkHsIj2yWAj
 cmJf9pnicWH6SX7o5BM/wh1cKknyami/MMzXiEPdxZ3c=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0o93kaud8HCchW/Eg3WOALkkOlCxCpeT0IFNeaxnBiliN1LyfahhljAf+YFLX7x
 h9A/6jQOcrtAbsb3jlrTwRQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 43858503-027a-11f0-9be3-005056ab7447;
	Sun, 16 Mar 2025 16:20:59 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] irqtop,lsirq: set up locale path, so messages get actually translated
Date: Sun, 16 Mar 2025 16:20:37 +0100
Message-ID: <20250316152040.44163-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/irqtop.c | 3 +++
 sys-utils/lsirq.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 6d001cb10..99f2f6041 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -456,6 +456,9 @@ int main(int argc, char **argv)
 	};
 
 	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
 
 	parse_args(&ctl, &out, argc, argv);
 
diff --git a/sys-utils/lsirq.c b/sys-utils/lsirq.c
index fa2dcaaf3..0b3e4c241 100644
--- a/sys-utils/lsirq.c
+++ b/sys-utils/lsirq.c
@@ -109,6 +109,9 @@ int main(int argc, char **argv)
 	char *input_file = NULL;
 
 	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
 
 	while ((c = getopt_long(argc, argv, "i:no:s:t:C:ShJPV", longopts, NULL)) != -1) {
 		err_exclusive_options(c, longopts, excl, excl_st);
-- 
2.48.1

