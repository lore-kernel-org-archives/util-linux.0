Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AA29CB52
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104511; cv=none; b=OXZjYxAQv/M89KzKl3qQiZpYKalRosq8YvNZ+b5hNNKIlD7ICLw8UWONk8DXgvUo9VLa9mQNE6FGO16oL/LgKmdaQGZe4qoXPPoem/fw7IPxSeN71iNNhKdvrylU2ZO29xSNrcNvFeuw0yRniHtH5VzbjoSaUbd5cAQH3hw3sLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104511; c=relaxed/simple;
	bh=0R0DM8iexVa0XsjYFNCrw7wUo7hFp6zmSDE445kJans=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oXkIftj08VPWeAOJiSwuJhI71zFEmq+WLovF59w2Qga4t8ND2WGDOQ2lR17EBQVjW3wZBSC9852FeuIHc+uC+sjVeqaQMPOyGVbAJzFqyB7WHozW1gSmtTZuwC/dZfkS1c+I+vL+QgLTEUhYeWgVTFJVlKrziG0b/SKy+jiW1hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=mjQ/W8ey; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="mjQ/W8ey"
X-KPN-MessageId: eb09f6ee-f912-11ef-b99f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id eb09f6ee-f912-11ef-b99f-005056abbe64;
	Tue, 04 Mar 2025 17:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=hUAeg3Cs+ZtXMrFAJBZbmOxHf11yEnRiH9dH+yaKw+I=;
	b=mjQ/W8eyRbEgGaqytHZo3xruNP1kSmVoiNdlEsNBnK99Ec3wZuFUUblA6MB3CoNIkVbdrpcgD2p17
	 JJtTUZNJVT5pU9gjMYjV9m9YQleBDPAef+p5kmfMoOiA0iK4XCtTnie1MzbhDqZAEnT0ElXebGdLlg
	 3luD1OTYfN/fbCHY=
X-KPN-MID: 33|ugIoWyR0IYSyxcNyIvFLU1bAl3zHiW9Nn5+umAVmMcQGg+kF46LEr1BFFKpIkXp
 sD35E2gNOG1S/3h0DfpKBpDZ6b9xvqoQuViJ5RJDJnqc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|TPXFpLMzNMNDgV+ZKcT+CCJrkbTcUcZgWi8RMnZjon6H0EUYC3JIKiv6V2lfWHT
 JfOYRAp1YHPSSgv+6NU10xA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id e3a918ca-f912-11ef-84c2-005056ab7584;
	Tue, 04 Mar 2025 17:08:19 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] lsmem: increase the available width for the summary text labels
Date: Tue,  4 Mar 2025 17:08:05 +0100
Message-ID: <20250304160806.10374-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the subsequent numbers to get vertically aligned for
most translations too.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/lsmem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index 94150e49d..9aa674581 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -306,22 +306,22 @@ static void fill_scols_table(struct lsmem *lsmem)
 static void print_summary(struct lsmem *lsmem)
 {
 	if (lsmem->bytes) {
-		printf("%-23s %15"PRId64"\n",_("Memory block size:"), lsmem->block_size);
-		printf("%-23s %15"PRId64"\n",_("Total online memory:"), lsmem->mem_online);
-		printf("%-23s %15"PRId64"\n",_("Total offline memory:"), lsmem->mem_offline);
+		printf("%-32s %15"PRId64"\n",_("Memory block size:"), lsmem->block_size);
+		printf("%-32s %15"PRId64"\n",_("Total online memory:"), lsmem->mem_online);
+		printf("%-32s %15"PRId64"\n",_("Total offline memory:"), lsmem->mem_offline);
 	} else {
 		char *p;
 
 		if ((p = size_to_human_string(SIZE_SUFFIX_1LETTER, lsmem->block_size)))
-			printf("%-23s %5s\n",_("Memory block size:"), p);
+			printf("%-32s %5s\n",_("Memory block size:"), p);
 		free(p);
 
 		if ((p = size_to_human_string(SIZE_SUFFIX_1LETTER, lsmem->mem_online)))
-			printf("%-23s %5s\n",_("Total online memory:"), p);
+			printf("%-32s %5s\n",_("Total online memory:"), p);
 		free(p);
 
 		if ((p = size_to_human_string(SIZE_SUFFIX_1LETTER, lsmem->mem_offline)))
-			printf("%-23s %5s\n",_("Total offline memory:"), p);
+			printf("%-32s %5s\n",_("Total offline memory:"), p);
 		free(p);
 	}
 }
-- 
2.48.1

