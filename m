Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD019C558
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899423; cv=none; b=cuj9uOyNi8D7C/DdDJ1U74Z80KcgV68SAxxiBD9UWxtwR/IXiqGOuBZDqPCAsGNbCC824HHpbczAzeV9oztHRDSCO9QJyvSnBX3Li97HMhTBRMpOCKGwMJGeRtiJJcIWUEaN2q6yzb4sIvbToeYwiIuhlQTJ95eyQOq//+u+hPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899423; c=relaxed/simple;
	bh=XxuH669ctYIeqb2F9rV0fhwd1PeYKiFqai+psCUd+Aw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsgiz8tgKnFezpd6UYrWoTeBemjl3Wf62iDmuURA1x+zCXnlISHcGbMKZQoRoLpERNOv0HZlkneICpMG6By4WBniodJQN1KSUTWJiYtmj4Zb48MZtpaqRp7lmx49yrDsGVJah4/QLnt0aIhhIJLrrPaUTMsadFjb5rHF/d4lvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=H/NK1IDl; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="H/NK1IDl"
X-KPN-MessageId: 0de87790-0966-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0de87790-0966-11f0-86cb-005056aba152;
	Tue, 25 Mar 2025 11:43:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=kIScmsO2aBTLy5G4pPW7ILye7rALRJ7MsB9PJWuLeWk=;
	b=H/NK1IDlGyKiUETOKUB5S02oWqGryEmvT66fYb3C8U3pBjD6WMMGXuC9Q6g9xKcFhsvJQ6DHz2tgF
	 c6qfHMUVrv4A3o7J7jcijejXTGrm+7hGzI0vWp1zrVTfamnt2Lo0Hqe3Tl6YfONAtw24z2UrVw056B
	 4/m8x2ORPVrs8mA0=
X-KPN-MID: 33|Hbkmd5oRecRNO16mQptaHrWVoBNfeXa12Lr0+Ae442esk6y8TZOmzTaGBKLJXNY
 jNkjue6r8TXg3q+5NAWhxaQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|yw9ghhxhIsm5rnx7o2mnUnRUei7kxfIeE9JQ68UhJG1GiaPNQFiSsaxIo/lPeFb
 M47YD6KUfP8gUXFL7W3retA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id fea2d618-0965-11f0-8503-005056ab7584;
	Tue, 25 Mar 2025 11:43:31 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/11] ipcutils, lsipc: unabbreviate two words in some error messages
Date: Tue, 25 Mar 2025 11:42:57 +0100
Message-ID: <20250325104305.23980-3-bensberg@telfort.nl>
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

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/ipcutils.c | 2 +-
 sys-utils/lsipc.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/ipcutils.c b/sys-utils/ipcutils.c
index a755849fb..e3da523b7 100644
--- a/sys-utils/ipcutils.c
+++ b/sys-utils/ipcutils.c
@@ -677,7 +677,7 @@ int posix_ipc_msg_get_info(const char *name, struct posix_msg_data **msgds)
 	}
 
 	if (name && name[0] != '/') {
-		warnx(_("mqueue name must start with '/': %s"), name);
+		warnx(_("message queue name must start with '/': %s"), name);
 		return -1;
 	}
 
diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index 133957ea9..074dc4520 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -784,7 +784,7 @@ static void do_posix_sem(const char *name, struct lsipc_control *ctl,
 
 	if (retval < 1) {
 		if (name != NULL)
-			warnx(_("mqueue %s not found"), name);
+			warnx(_("message queue %s not found"), name);
 		return;
 	}
 
@@ -1010,7 +1010,7 @@ static void do_posix_msg(const char *name, struct lsipc_control *ctl,
 
 	if (retval < 1) {
 		if (name != NULL)
-			warnx(_("mqueue %s not found"), name);
+			warnx(_("message queue %s not found"), name);
 		return;
 	}
 
@@ -1326,7 +1326,7 @@ static void do_posix_shm(const char *name, struct lsipc_control *ctl, struct lib
 
 	if (retval < 1) {
 		if (name != NULL)
-			warnx(_("shm %s not found"), name);
+			warnx(_("shared memory segment %s not found"), name);
 		return;
 	}
 
-- 
2.48.1

