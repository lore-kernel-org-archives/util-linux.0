Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73620C46D
	for <util-linux@vger.kernel.org>; Wed, 25 Jun 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839015; cv=none; b=DyRcn1qDEhD8Ovx6NKbHbLRCn+5H4vzrVYbxlMVIve4LbvIlRmP0YSc4E5xph/DlWG5abqIwwhCFgJ6ad97jh5IGDOb/V6xWOi41yDUQ5qTI1tAGH0q+2u5nn0RbQ3vcDlRTovFV614mjc+sTKPVGERbxJN7bA60OFRUWS9RNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839015; c=relaxed/simple;
	bh=tPINR0GSerTh3O6WR8T0R8O5mChXTEb6QGrYB7s0zd8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR45TUuG7354Q0yZNcxMJ4L4lFKDhAOvIQIHhAsznKHEJ1sGkiECPnrFVTrUWoJ8QrleA+JVgIMsDtgqUrrbJRcE6/pbPQevQSg+yMqWYWtliOu9hZlQnp3ZCyKr7msQQHvNmzqLV9AQK1+DW0xMUW3rL8dmTfA8L25CI8dnekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ar/Gmo7Z; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ar/Gmo7Z"
X-KPN-MessageId: fb5c94c8-519b-11f0-b9a4-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fb5c94c8-519b-11f0-b9a4-005056abbe64;
	Wed, 25 Jun 2025 10:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=uFjxL1gHiBiYvmgpibgJcKXzLB3XijSqhWlUoCGDtbM=;
	b=ar/Gmo7Z2hRJJ1j3sf0m5lvTQ0MTdKTgXs4BkvpwW58V7wX52N7+HPJtwnix7acWx0b7pBdGDGaR8
	 OqTJ1sTh39eORE/S8p5OH3TPX/zhRJV5V88QeqcTpg9onTM/c4mYqTwQ/n6D6x1WfP0actpBx11LM1
	 W4WwWHjqgIEZjkSE=
X-KPN-MID: 33|w3IoravuYzd8BcLu/yCvm2HkysFUnKIEFt4VqsQAey4hXT0n+R2luFN3e/GO1d+
 /Lbu/Stk2HQshLBUKjjynaaJqHNmrnQvUjBdbGa9GC1Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|qpj6GFT/z416cNt0hI8LN4COWn8z3XowqRhoR4YJVeTfFklxgR1RFeYmFoVDAfl
 ddTk415wSs7BxV1ljz/uAeQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id cccad1c4-519b-11f0-95b5-005056abf0db;
	Wed, 25 Jun 2025 10:10:04 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] chrt: (man) mark "argument" as optional, and unabbreviate it in usage
Date: Wed, 25 Jun 2025 10:09:48 +0200
Message-ID: <20250625080948.6064-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250625080948.6064-1-bensberg@telfort.nl>
References: <20250625080948.6064-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, consistently uppercase "PID", to indicate it is an abbreviation,
and align the strings properly.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.1.adoc | 2 +-
 schedutils/chrt.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index 17d683ba7..3f67b13bb 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -38,7 +38,7 @@ chrt - manipulate the real-time attributes of a process
 
 == SYNOPSIS
 
-*chrt* [options] _priority command argument_ ...
+*chrt* [options] _priority command_ [_argument_...]
 
 *chrt* [options] *--pid* [_priority_] _PID_
 
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 0bcdd1a1e..550cefe4d 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -60,11 +60,11 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Show or change the real-time scheduling attributes of a process.\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Set policy:\n"
-	" chrt [options] <priority> <command> [<arg>...]\n"
-	" chrt [options] --pid <priority> <pid>\n"), out);
+		" chrt [options] <priority> <command> [<argument>...]\n"
+		" chrt [options] --pid <priority> <PID>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Get policy:\n"
-	" chrt --pid <pid>\n"), out);
+		" chrt --pid <PID>\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Policy options:\n"), out);
-- 
2.48.1

