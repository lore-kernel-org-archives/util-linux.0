Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DE1DE884
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414310; cv=none; b=cqBOTuSUU4nuVk+pYbf5BhERJaapqQ5reIO3vc7jC1qH8iXcNgGwat3cKPhSnTroHxFkkh8fZvYhwHDySdI8fE7nS1KULZ5VMYMLYmFPoBiA94E+wB+TbToKC/34lRxQJuKmaVS1yeq163SWDCOKcFyMI8859Y0Mt3Z3plywxZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414310; c=relaxed/simple;
	bh=oTnPMaVlLlloGqtY1FhD0UcA9tyMwzSr7JKWogtHDAg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGzhdP5ZJ+enn/siji5hWaaWPnrHctNNDH9a0FM2wyUsi37Vr1NkXrfjzWqU+Hr/KBINN2WckvPEz1nKV93tBzQwAJqfbQ5wCV5rmwcfQumP/VkNbpGX1fGivQ4nJG613ypCjpWAXwEHX+o2+Zl21v9Cdb+zd6L65L0hhsDHGEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Crj2V9go; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Crj2V9go"
X-KPN-MessageId: e477171f-0e14-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e477171f-0e14-11f0-86cb-005056aba152;
	Mon, 31 Mar 2025 11:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=jIwDhls1a5oaccJ2g0d3RVuSrr0xKVBYtHaQLh7OheI=;
	b=Crj2V9gos52cjtvQVFDXkU1tG4qC++9uKKgtFawRZ/eZ4JTB6Zd5Bf1EuwZK9EheHXHeJYOkkkxUs
	 cFkH6THYgyaEzvv75jEZNQFgrP4D+lbByRUDX/XeJoQLR+08jAWpKybZ5LGyh4qUum22c2K4p0nH/o
	 r5UdiHfWl2IsPkjI=
X-KPN-MID: 33|z4gcQ9zilk59UFobC32Ztxsj1PnxllsocBI62UoqLVt/46A8N8/xgPWQ67Dvhn2
 wSOPoZeRf9uow+2+GHr/HNOzEHrnn6RFp48UyyHJNZPY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kwMVObjykELpDyxd1YZjcmqx2+JOMvOUoCWTA5XQc7qU9PwRw9vgnKBTkngW02U
 GFWMYzr28tp6kiLxTakNJZA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id d322625d-0e14-11f0-9b49-005056ab1411;
	Mon, 31 Mar 2025 11:45:05 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/10] last: don't use a tab character in the --help usage text
Date: Mon, 31 Mar 2025 11:44:36 +0200
Message-ID: <20250331094443.9619-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331094443.9619-1-bensberg@telfort.nl>
References: <20250331094443.9619-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, sort options -p and --time-format alphabetically,
like in the man page.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 login-utils/last.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index bdd375063..b7dff30c6 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -598,15 +598,15 @@ static void __attribute__((__noreturn__)) usage(const struct last_control *ctl)
 	fputs(_(" -F, --fulltimes      print full login and logout times and dates\n"), out);
 	fputs(_(" -i, --ip             display IP numbers in numbers-and-dots notation\n"), out);
 	fputs(_(" -n, --limit <number> how many lines to show\n"), out);
+	fputs(_(" -p, --present <time> display who were present at the specified time\n"), out);
 	fputs(_(" -R, --nohostname     don't display the hostname field\n"), out);
 	fputs(_(" -s, --since <time>   display the lines since the specified time\n"), out);
 	fputs(_(" -t, --until <time>   display the lines until the specified time\n"), out);
-	fputs(_(" -T, --tab-separated	use tabs as delimiters\n"), out);
-	fputs(_(" -p, --present <time> display who were present at the specified time\n"), out);
-	fputs(_(" -w, --fullnames      display full user and domain names\n"), out);
-	fputs(_(" -x, --system         display system shutdown entries and run level changes\n"), out);
+	fputs(_(" -T, --tab-separated  use tabs as delimiters\n"), out);
 	fputs(_("     --time-format <format>  show timestamps in the specified <format>:\n"
 		"                               notime|short|full|iso\n"), out);
+	fputs(_(" -w, --fullnames      display full user and domain names\n"), out);
+	fputs(_(" -x, --system         display system shutdown entries and run level changes\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(22));
-- 
2.48.1

