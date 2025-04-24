Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE3D231A32
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487248; cv=none; b=j+AaKvFSdZIrOVJMcAve9pPULc0XChTQl22fhncNZg7VmnT+P0nMXBJapWeXKxXyGiJHZ4c2BVO31p1ckSj2OAGrtBDRbzNdhAViyYcMa6pazwq7KgDdf49J5MYs6tTmsTSsovMfh1+NAd0cRkcw947UxxEO/DbxsJ31dnmSgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487248; c=relaxed/simple;
	bh=sOxsVRBpABUqknkFJl2fdnE1P3BlXGsAJJ88dQ3CV3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vo268Log/k6KbQpGCnYhgUJUmEip5BxJRYOxtHw3JU+fbYTXWfNgMXHj19E5Z/cf0jHX1dd4s47GK9QNDvrZl8RYxNo3gJ5ookI+ikJnBKHC4/F+I4Dg1EGU40Iz06mi1cXQfRTlnglsdBI+IswsFMqXU4fO7rRlUjFJ6FLC43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ZuX4TnJ5; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ZuX4TnJ5"
X-KPN-MessageId: 3498917a-20ef-11f0-86cc-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3498917a-20ef-11f0-86cc-005056aba152;
	Thu, 24 Apr 2025 11:33:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=+hrjj1Gi3tYJezf7y8BLxzGVjt+7hIqAWuEjvzpt2ZE=;
	b=ZuX4TnJ5jAfGFpxyizqFYKJxQLgOyz92CMX8wSmx3YvgPv1RzqKtQQB+x+UXRZZdQQBrGXcw7wrV9
	 7B9U3DfL/Uv7ef0K4dOe8J1W2U4/zYad/Igbba8dXDw5V6kSXIOj7HdQ16+1+YxNGUZEspCzsWZIZe
	 /wDwkiN1zX0UZdrw=
X-KPN-MID: 33|Xe/G/IFpyWzH1vZ8lvkU4BYMVhoLhlffkKnmg7D/qMf/SPkVjjMk/f3KdwT7gl2
 5zKf2sN9w5T/LugdlqepU3kQsj4jNP/QQTRPhC7pP+qg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|1fAwhKR5uzK4E+oOq+eB22AOFjzVFUs4BEYHw+FPdkUYOGrEMUoGoITBYGGelHd
 oKvnpk3qnpNM5t+NWY/Pisg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1b4a607e-20ef-11f0-95a4-005056abf0db;
	Thu, 24 Apr 2025 11:32:57 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/7] irqtop: make the wording of an error message identical to that of another
Date: Thu, 24 Apr 2025 11:32:32 +0200
Message-ID: <20250424093237.6432-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424093237.6432-1-bensberg@telfort.nl>
References: <20250424093237.6432-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Besides: the original looked like a statement, not like an error message.)

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/irqtop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 3dbd030e0..a42ece070 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -465,7 +465,7 @@ int main(int argc, char **argv)
 	if (!ctl.batch) {
 		is_tty = isatty(STDIN_FILENO);
 		if (is_tty && tcgetattr(STDIN_FILENO, &saved_tty) == -1)
-			fputs(_("terminal setting retrieval"), stdout);
+			fputs(_("failed to get terminal attributes"), stdout);
 
 		ctl.win = initscr();
 		get_terminal_dimension(&ctl.cols, &ctl.rows);
-- 
2.48.1

