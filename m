Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B88254869
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899414; cv=none; b=WOar5CeWIKzZi7nYh4sWqcB+fHx51ek8O5lrnXqttlAJqeLHXNphLaxoRmtEk9BcLhOSCPBHu7BjQ3RIaGM9+pASvdFKnyAskDNEDD2rsJRYB2PdJ7VyObJzq74TUj2f+TzNIno5feW9hhw4BqhCIBW2rXdSZ6bMMF8WibaF95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899414; c=relaxed/simple;
	bh=6GASSVf0WdHcTkzYd1EN3lmSlSEsFDkabIxCTbrBbYo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0KCkRuu8wQ2ckTFvX0/KeOyNq4A/FDwzXW/+HpzUc6fbSi3wyu+gb7xAxbaA/gv07+6Ts/dM48WjCg73yckbKOXJ+RXO9wthEOgOyinADtqgkLW1jqZYe0cUqsmNXtUMT7x9MjPqYWVcAheHSCqnk1rGFy6MuJK2sisv7i70Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=rsRgf7tY; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="rsRgf7tY"
X-KPN-MessageId: 053771ff-0966-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 053771ff-0966-11f0-bc28-005056ab378f;
	Tue, 25 Mar 2025 11:43:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=1EWnFgm1mCMzLKaCrS9UrDDsEItV0b13V0cyitTog3o=;
	b=rsRgf7tYr1w8Oqapo5vZkNOBqe2TGYu8sf6Ubj7cXIjG2fclpXRbN6lk4+2TYDiuGoM0hTwolvIkW
	 Ba3+GXD0PssVfxKa6j+nptYzi9NcswckgW+/92k4REWi8efmRQZOc600qdXCG8BSGq9K6yYa2kXzsz
	 Sd1TxE/1BS8EVmi4=
X-KPN-MID: 33|jVnYq7Pmlpw2a8C4BnkxhcKJIRpoOdrF2kUSynP5Opdva0pjpkNF6wg2CfwyHxZ
 3TppxU/l3JQMyAj4zHmMgpvJMNb5WMTAhlKD4gTE7jao=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|8iNU185UjVbDuWdMyUSoYvD17ZgHu6EgiPTAjHOGHOlknqdipg8z4S3jPNwGsxK
 SKMczVY9rJp5sXzYCivoQIA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f93f86b8-0965-11f0-8503-005056ab7584;
	Tue, 25 Mar 2025 11:43:22 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/11] ipcrm: in usage text, use two lines when option+arguments is very long
Date: Tue, 25 Mar 2025 11:42:56 +0100
Message-ID: <20250325104305.23980-2-bensberg@telfort.nl>
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

Also, do not use tabs in the usage text, and keep it within 80 columns.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/ipcrm.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index ceb101187..8ddb104f4 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -56,17 +56,18 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Remove certain IPC resources.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -m, --shmem-id <id>        				remove shared memory segment by id\n"), out);
-	fputs(_(" -M, --shmem-key <key>      				remove shared memory segment by key\n"), out);
-	fputs(_("     --posix-shmem <name>   				remove POSIX shared memory segment by name\n"), out);
-	fputs(_(" -q, --queue-id <id>        				remove message queue by id\n"), out);
-	fputs(_(" -Q, --queue-key <key>      				remove message queue by key\n"), out);
-	fputs(_("     --posix-mqueue <name>  				remove POSIX message queue by name\n"), out);
-	fputs(_(" -s, --semaphore-id <id>    				remove semaphore by id\n"), out);
-	fputs(_(" -S, --semaphore-key <key>  				remove semaphore by key\n"), out);
-	fputs(_("     --posix-semaphore <name> 				remove POSIX semaphore by name\n"), out);
-	fputs(_(" -a, --all[=shm|pshm|msg|pmsg|sem|psem]	remove all (in the specified category)\n"), out);
-	fputs(_(" -v, --verbose              				explain what is being done\n"), out);
+	fputs(_(" -m, --shmem-id <id>           remove shared memory segment by id\n"), out);
+	fputs(_(" -M, --shmem-key <key>         remove shared memory segment by key\n"), out);
+	fputs(_("     --posix-shmem <name>      remove POSIX shared memory segment by name\n"), out);
+	fputs(_(" -q, --queue-id <id>           remove message queue by id\n"), out);
+	fputs(_(" -Q, --queue-key <key>         remove message queue by key\n"), out);
+	fputs(_("     --posix-mqueue <name>     remove POSIX message queue by name\n"), out);
+	fputs(_(" -s, --semaphore-id <id>       remove semaphore by id\n"), out);
+	fputs(_(" -S, --semaphore-key <key>     remove semaphore by key\n"), out);
+	fputs(_("     --posix-semaphore <name>  remove POSIX semaphore by name\n"), out);
+	fputs(_(" -a, --all[=shm|pshm|msg|pmsg|sem|psem]\n"
+	        "                               remove all (in the specified category)\n"), out);
+	fputs(_(" -v, --verbose                 explain what is being done\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(28));
-- 
2.48.1

