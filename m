Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F425EFB6
	for <util-linux@vger.kernel.org>; Tue,  5 Aug 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385972; cv=none; b=Hkax02JyubXu9Txww34mvGKctYx9aC2WAixXPAURKN4X66I3kyDFUGVYo+9dqYKTnIOa7gPTEX8wAKPdxuYesenYD0vit4h9J+ZOBaz/2wGVHhAkrmbnSrqnLOiSC9VDtI9s96MhZky7WuToqKqbInunnZb7RXT1nU0P4L12tTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385972; c=relaxed/simple;
	bh=L4V1X7xWZ74eoqGTAasdSg+gFzYD2w9HCMJlfuDYwmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGQuv+TxIHoAXnAqdZ+PVWn8Ya9krY40Azt0IyztXSsTVGgETv0pYuVXq5j2c5cK/60pJ0qgBmI1rlv/ivPUihWOv5i/r7B3dyf/sC7VPsEuvwHLegUobZiOmMGvNzx9OeQtdD+Zyb6mZO1cxfSL2h89SO2IIpLSNxKAecHcxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=v0qmTcvb; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="v0qmTcvb"
X-KPN-MessageId: 280a1892-71de-11f0-80e7-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 280a1892-71de-11f0-80e7-005056aba152;
	Tue, 05 Aug 2025 11:25:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=4C7Ljt8eMRtiyyKG9QbKBzQhEc2FMBUi81WCOIeoBT8=;
	b=v0qmTcvbJkroNS6lJ3U2rdSoCzc0CegNhJj51w9oVMQVzIAGCzemP4yi3P8U+g0AkAmW08rMAuIaF
	 UPoNUsdKeOzo5Hoi9Nt5raqVi33Neu7Cwd1wcwh77XzVmTIne4CiePP6BLRAoOoSqcuJewROywhaPJ
	 zbfrCkp55Ze8U49Y=
X-KPN-MID: 33|8KYtpFXwZk9wwG8LJ4nB9FyDC1XeI+4Wgv4dBDTh88YYaROwMrnoAamRagJlol/
 gkPRofv6JI4mkIrGRaLCiunTrJ5YzpATuQC7EBL+fP40=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|F4GGgJDBzPlqLJQewppXdESVVKinm0nTBDist22rAS15XyGtPmvxWqZ1P1Ylh8L
 4LVUOOau5ISPU/J+7iv0kQA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0ecfa92e-71de-11f0-abc8-005056abf0db;
	Tue, 05 Aug 2025 11:24:59 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 2/4] chrt: (man,usage) mark the priority value as optional in the synopses
Date: Tue,  5 Aug 2025 11:24:41 +0200
Message-ID: <20250805092443.5847-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.2
In-Reply-To: <20250805092443.5847-1-bensberg@telfort.nl>
References: <20250805092443.5847-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The priority value is optional in some cases, so it cannot be listed
as required.

CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.1.adoc | 2 +-
 schedutils/chrt.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index 3f67b13bb..c8278463a 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -38,7 +38,7 @@ chrt - manipulate the real-time attributes of a process
 
 == SYNOPSIS
 
-*chrt* [options] _priority command_ [_argument_...]
+*chrt* [options] [_priority_] _command_ [_argument_...]
 
 *chrt* [options] *--pid* [_priority_] _PID_
 
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index e07284e41..de1898160 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -60,8 +60,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Show or change the real-time scheduling attributes of a process.\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Set policy:\n"
-		" chrt [options] <priority> <command> [<argument>...]\n"
-		" chrt [options] --pid <priority> <PID>\n"), out);
+		" chrt [options] [<priority>] <command> [<argument>...]\n"
+		" chrt [options] --pid [<priority>] <PID>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Get policy:\n"
 		" chrt --pid <PID>\n"), out);
-- 
2.48.2

