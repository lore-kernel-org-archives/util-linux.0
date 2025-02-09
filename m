Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308646FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089557; cv=none; b=bJ67o8FsgiKGxW8iS2jTC9q+qXlDGGdKz/a9qAYVvW4QcIKHHUEF1888+YphrUNMOrpyjvY96iedT1hERCNvSYkDE4n+U4l4FKtvMLR3n9Kvucl1dHKds37QVR1vrZXL2kktR+1q/GPmklsTT5zkhGPLMVe0whLjYGPk+8HLAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089557; c=relaxed/simple;
	bh=8NBMcTJDaAH2BuG1Zls4rZSUZ8fmhDhDjW5Jp2jO0tA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrjg/iCt9wdRW5lCPNV+lR8rdUsDHK7aPEFIzXazuyI5IFG9aw5+wRYLyblKekeJ40v/5bcgEzfTtGEjUuMc5fSObpDzbVIYkf2LKB/GEt54Aw72EVtzCkcE+CFgUX3nTWgxQngwsPZSaqTGZ1YyIOjyN9hq3sb3rK9SemHv7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=FHzjq+YI; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="FHzjq+YI"
X-KPN-MessageId: a7d24bf9-e6bf-11ef-8d8a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a7d24bf9-e6bf-11ef-8d8a-005056aba152;
	Sun, 09 Feb 2025 09:27:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=g0Gg+3AIHQYcaKA+9fquEpwpLH2um/XvEAw6u3h9wd8=;
	b=FHzjq+YIaQigJpt1SdqSYr9lrBpgQXDIUAF3SijJCACap1G74e/wvucMFzVmHreDB5N+zSGrfUvsO
	 SSEqSWy/nICAIrjvDNONdLkvQNPHIYpXHcvRMVmG4BgCywcJ+PxECSm7g4a3iIZfmWVdTyHjlb2fYb
	 RwvqfN6yuCvr3NK4=
X-KPN-MID: 33|fdYM18r4a2C/B884MOaypxAPsL+hjX7BWewh2QZYdKOQlXkye+k/OjRlfH7BR8G
 Rn30Xn+JiI/07J3qNvjfnzLA+LNdBd3Mbz0DjO+zE7Z8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|M0HFtbAeU5cGduIXLsyqcMNQ6GQxc3+a34hsk+nrOLpNuhOe64Nuhos34BmiDZ1
 p0cq+AIREeHk7fhdZASQ+PA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 7772bb1e-e6bf-11ef-99a4-005056ab7447;
	Sun, 09 Feb 2025 09:25:49 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 11/14] renice: put text that belongs together into a single translatable message
Date: Sun,  9 Feb 2025 09:23:27 +0100
Message-ID: <20250209082330.4235-11-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
References: <20250209082330.4235-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, use semicolons and no periods in an option description.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/renice.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index 419cef46d..eac104db3 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -70,10 +70,10 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Alter the priority of running processes.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -n <num>               specify the nice value\n"), out);
-	fputs(_("                          If POSIXLY_CORRECT flag is set in environment\n"), out);
-	fputs(_("                          then the priority is 'relative' to current\n"), out);
-	fputs(_("                          process priority. Otherwise it is 'absolute'.\n"), out);
+	fputs(_(" -n <num>               specify the nice value;\n"
+		"                          if POSIXLY_CORRECT flag is set in environment,\n"
+		"                          then the priority is 'relative' to current\n"
+		"                          process priority; otherwise it is 'absolute'\n"), out);
 	fputs(_(" --priority <num>       specify the 'absolute' nice value\n"), out);
 	fputs(_(" --relative <num>       specify the 'relative' nice value\n"), out);
 	fputs(_(" -p, --pid              interpret arguments as process ID (default)\n"), out);
-- 
2.48.1

