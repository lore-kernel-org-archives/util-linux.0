Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B3242D8B
	for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272882; cv=none; b=Sbuz5JVVmuznt0u6m1yzu/lITtuIRuRN987Xf2qdYy5x0nYcjUegIxBrdIGR6ku2/aGz/GBCIfE/87WmrLwlYFlE/2rMdS3Q+C9hOKtZtZRzgGnu4yczlIV6aKio6wG6FDnge2GGOjbfjuvt4Oecf792BoQlTvt4tFnjMeS86Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272882; c=relaxed/simple;
	bh=lecXalJrJMtU2vTELf6spD/fhJHl76VKe+V2oAXmBpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lh4X/UMscB6PJsLmb+ZRPvpk8WU+jmlS0MV9oIblqzgdcwR/7qFNCL4e2RmnHlgFXny/TcjldXUInCAyDlyY2sYKv51FIr7KrW3QURHCJX+puQ4RWroT9oJVF7i92JqQaydOFNJWdKQT3Y4GQjFq/wbP0aiIPgbVdQ9hBPtctfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=S3zikCYf; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="S3zikCYf"
X-KPN-MessageId: 11b40304-558e-11f0-a833-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 11b40304-558e-11f0-a833-005056abad63;
	Mon, 30 Jun 2025 10:41:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=z1iGOd27Ko+C5P7NffGPgYyPlWD2UfU2rkvsMczXP5Q=;
	b=S3zikCYf3Drw/0NOzq8TiDNE7tvnXYEFtL54Ki12lY1RvU+ybSu9bHOSFs3KVGzftPTxnkrvCaHaf
	 WV9VbrKbb+0SuJq/DZ9I5NkFdEZF3flOGOX/o4hvxFE17MzhH1Zpr3XtjEZbltoDGH2P72SIONotR4
	 fb47bya/qMRKQiwo=
X-KPN-MID: 33|OiKYdH84oIFjNxuUWB8FPYBbSK9Y7C6FlAUV5VAnAYvqOC1In+J5aep4axZXO8V
 ztAh1Z3NkGjAHf2GAUoa4EIRFwVMsHY7oekzveQuHWeI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cMEJzdRGVl8kEyEv8OboJpETr21h3+tXXQi2b14o98zXg36eT6QisgbLu+hW7kE
 tP0lmW6XZBZ1gFoNBsy0xaw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f8b710fd-558d-11f0-95b7-005056abf0db;
	Mon, 30 Jun 2025 10:41:10 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 1/4] chrt: with more than one argument, interpret first argument as priority
Date: Mon, 30 Jun 2025 10:40:47 +0200
Message-ID: <20250630084052.11041-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first argument is a priority not only for `chrt --pid <prio> <pid>`
but also for `chrt <prio> <command> [<argument>...]`.

This fixes an oversight in recent commit e7a2d62434.

CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 0bcdd1a1e..4c45eae80 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -530,7 +530,7 @@ int main(int argc, char **argv)
 
 	errno = 0;
 
-	if (need_prio || argc - optind == 2)
+	if (need_prio || argc - optind > 1)
 		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
 	else
 		ctl->priority = 0;
-- 

Dobjátok a Dunába a kis diktátort.

2.48.1

