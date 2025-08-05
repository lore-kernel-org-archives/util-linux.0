Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA826057C
	for <util-linux@vger.kernel.org>; Tue,  5 Aug 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385977; cv=none; b=oyUVckwLORU5qPu/I/a2GLVLnYT6jiptpfF7j2kkcR5FPk42RaksERKqyVDqEy0yvoS+uvQpEZysHSpgNDIhFyOu2VdHPTC5O77g+aA3C6gG8pP9R0ODWrBAxedGZ6od7w3jDAHlZl7qJLE9V4zDoTpAPVzaslL3khTPxrP+bG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385977; c=relaxed/simple;
	bh=Qa+QD9G8dKAEFbOh+/s2WAaF3+TGVG52bAW6Y3W5WJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmwF5ul47NgZpyzOr05OzvuVgqYuvJx05tk2i+OprPNatVULHg6kBuW7b2ob/lgfbeBDXiVWHH5W5gRE6wpVe2GFrUV1L+XgcEcwW/qSeSkTMX1b/abbFIbbpH945m4NWnlnWIAakOB54ZJTbSthc550tm+c5UkuW/ZXEQaoaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=qoCXO9si; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="qoCXO9si"
X-KPN-MessageId: 3b790660-71de-11f0-a4bf-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3b790660-71de-11f0-a4bf-005056abad63;
	Tue, 05 Aug 2025 11:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=HcAUPRR+M80+6bDd5WIDlk6z8+QEd8he/wwdrxbM6fY=;
	b=qoCXO9siq/njIv70RWXOwMsYDL8JQeEbUzCvpoTWxpRAfOfsD0lRhUA6FuFhE3KJOKqkZlcDbEOK1
	 3oxgO21PnwGzhMM9KVMBmanJl3UToc9C/LNz666IWpsyT19VspOW9+scAxtZClqEAN8g4KJBYqeE94
	 lYpWgaxfojNYltSA=
X-KPN-MID: 33|V4qn7psMWemuXwY0f+vC2UY4XIK80FUwb3TSEcrHbu9L7VjW9yR8QPrHTftE2mc
 D+rRPTHDxusJoNUARqTiTnJ1idrX+ZjAUZMBvavaUB6g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|4tseRi6nNxCrOfayczaaOigFF1r+BmBGGP91ba7qVS0zfw4K8/rbJ2Mct/GMEOk
 4fjfhx71bFGiHhlQmJksrtw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 128b9a33-71de-11f0-a796-005056ab1411;
	Tue, 05 Aug 2025 11:25:05 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 3/4] chrt: (man) improve wording and markup of some examples
Date: Tue,  5 Aug 2025 11:24:42 +0200
Message-ID: <20250805092443.5847-3-bensberg@telfort.nl>
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

CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.1.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index c8278463a..7ed676a9a 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -122,17 +122,17 @@ ____
 //TRANSLATORS: Keep {colon} untranslated
 Or set them{colon}::
 ____
-*chrt -r --pid* _priority PID_
+*chrt* _policy-option_ *--pid* _priority PID_
 ____
-This, for example, sets real-time scheduling to priority _30_ for the process _PID_ with the *SCHED_RR* (round-robin) class{colon}::
+For example, to set the scheduling policy to *SCHED_RR* (round-robin) and the priority to *30* for process *1234*{colon}::
 ____
-*chrt -r --pid 30* _PID_
+*chrt -r --pid 30 1234*
 ____
 Reset priorities to default for a process{colon}::
 ____
 *chrt -o --pid 0* _PID_
 ____
-Set a custom slice of 1 ms for a SCHED_OTHER task (priority is optional for policies other than SCHED_FIFO and SCHED_RR){colon}::
+Set a custom slice of 1 ms for a *SCHED_OTHER* task (priority is optional for policies other than *SCHED_FIFO* and *SCHED_RR*){colon}::
 ____
 *chrt -o -T 1000000 --pid* _PID_
 ____
-- 
2.48.2

