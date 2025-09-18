Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC382FCC1A
	for <util-linux@vger.kernel.org>; Thu, 18 Sep 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185854; cv=none; b=JAW4G3ZVuF3RKE2p5KKGRxVeXfH0qdaJ0qWnpPd9qlZNNQBgVxOC803TAmF6vAEBPIM7Svg9R47e274wwKfMTkhH+thV/zb0MMVnLODLtM4kp7XgLRQDz/mPjU+jgEZRD6WNKW+xq4/F6ZDR8R0dmT3GvLsi36H/OYA0qHaNNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185854; c=relaxed/simple;
	bh=+OTgWvzlzAm/rjCjyt8ZAjQD7ykuVQ6u/Zvgh0jAw6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWrKOxCXyDlXBGj8iGDn+ouzijlqufOqFi1yKA1Sbrz83bl+L+N6Hc26r8MODwrHY6qL6IylVt9GyR0m++kfuoi54zjGYQdIzxaNmyT8gX7/h9QLC6kbKPWCENwXYGzs+2ANX/7CqmSh1KqDzjI4BYXSxQSHUvRR08NjV+IUdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=v69pjHYB; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="v69pjHYB"
X-KPN-MessageId: aa659b60-946d-11f0-80ed-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id aa659b60-946d-11f0-80ed-005056aba152;
	Thu, 18 Sep 2025 10:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=0O41lhNckE6EOvYbyYs8iGhybwpJEDbNZIhrnTWPqms=;
	b=v69pjHYBPg5jBlOcgLqtvQx4eFQPLON4QJ+7sfz5mZoEeA2juquhywVGGOjyyryoVMfJaFrOGZ4Zj
	 gz8RXt4U/t+tx9noo2C7+KBY26z5538KXFrbXzv65GXLnkCaYe5urQdtdivKvjRreUisMre4p8aOqh
	 aIUd2lrk13qQOO8c=
X-KPN-MID: 33|kc1C3PB2YFg2vzmNSUfXY8aiVuSG6NApoVMnsypQSwGc4KLxIHH59T1WsCjV660
 YmzhX2qIIooyeO7ya6r/JR6en/yBq2BiHGGxnG7iNTXU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|S7MnqH3mUPpp8EPMFBaxdJmoGeUGtASKp/arBzU7iyOz+rURGH2pnMLlCYegXqg
 /Az9XrWiylE7728nyewqw1g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 812b5717-946d-11f0-807c-005056ab7447;
	Thu, 18 Sep 2025 10:57:28 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/6] column: (usage) wrap two descriptions, to make them fit within 80 columns
Date: Thu, 18 Sep 2025 10:57:04 +0200
Message-ID: <20250918085707.41785-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918085707.41785-1-bensberg@telfort.nl>
References: <20250918085707.41785-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/column.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 29ed25b2f..7a37cb886 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -999,7 +999,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -C, --table-column <properties>  define column\n"), out);
 	fputs(_(" -N, --table-columns <names>      comma separated columns names\n"), out);
 	fputs(_(" -l, --table-columns-limit <num>  maximal number of input columns\n"), out);
-	fputs(_(" -E, --table-noextreme <columns>  don't count long text from the columns to column width\n"), out);
+	fputs(_(" -E, --table-noextreme <columns>  don't count long text in these columns\n"
+		"                                    to the column's width\n"), out);
 	fputs(_(" -d, --table-noheadings           don't print header\n"), out);
 	fputs(_(" -m, --table-maxout               fill all available space\n"), out);
 	fputs(_(" -e, --table-header-repeat        repeat header for each page\n"), out);
@@ -1018,7 +1019,8 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" -c, --output-width <width>       width of output in number of characters\n"), out);
-	fputs(_(" -o, --output-separator <string>  columns separator for table output (default is two spaces)\n"), out);
+	fputs(_(" -o, --output-separator <string>  columns separator for table output\n"
+		"                                    (default is two spaces)\n"), out);
 	fputs(_(" -s, --separator <string>         possible table delimiters\n"), out);
 	fputs(_(" -x, --fillrows                   fill rows before columns\n"), out);
 	fputs(_(" -S, --use-spaces <number>        minimal whitespaces between columns (no tabs)\n"), out);
-- 
2.51.0

