Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173071E522
	for <util-linux@vger.kernel.org>; Thu, 30 Jan 2025 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247258; cv=none; b=UoK90k1pSi8Qr6/ZWydRn7jIThDj/fSkzsoRICayHY7cxuGJUC/IrZRgKAKJ5mMyKsHJ7CeK10ogk5L1K2ZXqzh8yz8SwjN/xTruV5SwdIHX1+NDqvnIYDyJ+cLQWxvQxIfK7zT2ZSJfCCss3DMHeBNwxsu1HYbko4F6C7AJ8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247258; c=relaxed/simple;
	bh=K/yzVsXGHeF9uRWxLr8lxMqdtu8eKAwEA0FMluD57ws=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z1TaCFSqTfxrLuktKqzvk99BZsvNGtLH4M8IviwoVwVNXjayMJlSW/RHVF6QasC/OrVC/YAL9kvdHe7h/LpBQYNn+N2os71k8Y1RhLrqcg1uNADkNo/n10MeTwAlufbJzvTt1VLEQNwEo+BjzNo2wqYpezob8wFFzEnrOk0F1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=XIpTY6vY; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="XIpTY6vY"
X-KPN-MessageId: 883d33d5-df16-11ef-8d8a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 883d33d5-df16-11ef-8d8a-005056aba152;
	Thu, 30 Jan 2025 15:28:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=xcIzdTN9jd5bO/BxofeBuiHLG6Erzxdot7CZeozGpuI=;
	b=XIpTY6vYRrb2k0/Q3u92vrtBXdb92Ga4eQKdBnYLTVpMsUIizrbciHqEHMa3/GmeeRPalvdW9mtfq
	 xQoVVfF1vsQZYO+3W+4oIgKcOHJlxauCRfs+B6t2B2SZWsrK9/l9EFz11DNDqtt9Ncthi3uYQyzOkL
	 voIDvLri4yW3JjjM=
X-KPN-MID: 33|60zcmk0hNTtWixl6efvC6MNx6Zda/ntxSiOq/eGRdpbMXuqGiEUD7FLVI7m8J4j
 49/c71xhplVmps3GOwB4GHD/tTQlj0MdQatCtHZDsctg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3+Ti5vMUCaXWwfhOo2bjaiB9W59xs5/DKxBVXaSRKSsi/o6YLQsf9vSnfdHzICY
 25pQCmcsRUmmnS5JrEr1GFg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 58346222-df16-11ef-9975-005056ab7447;
	Thu, 30 Jan 2025 15:27:33 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] lsmem: make an error message identical to one used in seven other places
Date: Thu, 30 Jan 2025 15:27:27 +0100
Message-ID: <20250130142727.29744-1-bensberg@telfort.nl>
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
 sys-utils/lsmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index c9851e98c..94150e49d 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -713,7 +713,7 @@ int main(int argc, char **argv)
 
 		cl = scols_table_new_column(lsmem->table, ci->name, ci->whint, ci->flags);
 		if (!cl)
-			err(EXIT_FAILURE, _("Failed to initialize output column"));
+			err(EXIT_FAILURE, _("failed to initialize output column"));
 
 		if (lsmem->json) {
 			int id = get_column_id(i);
-- 
2.48.1

