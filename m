Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547A2AE66
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.3.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726907444; cv=none; b=FjTqoGnlLUrJFhrwRGp1qtb2nTytIfhI6rK9flnBtbCjK2EbFYoR8MMJZzehZBoTK/LT7Yql/jDXujMvCXMNHw0prQqufizkVwvWDj6mj43ilcJivCdqWMxtqnL7vwujtO7tLKJVwQqgVELxlnRcZJqL2FJCy08hr1xyh0VeSzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726907444; c=relaxed/simple;
	bh=YnohaPSR/QC9u56pL4y9fTGbzmJLX6fNWK9Q7hy3Cxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pp1xIyptagkeGiWtaxSbq6ix4qxfKaYen8a0L5RaJJ7+ExPJLVUer0tqssawJd3LFau1xW3mtynX0WAVO+/wDzQ2cia6xoUqJQ7PGnHrhA3rzjAxmaxwptOwD7Dz3GF4u5CBwHFdLolxFUak7vEMbVjI3GMX3V7OjWIJt+3188I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se; spf=pass smtp.mailfrom=lxm.se; dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b=sKM8awBa; arc=none smtp.client-ip=93.188.3.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lxm.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b="sKM8awBa"
Received: from s807.loopia.se (localhost [127.0.0.1])
	by s807.loopia.se (Postfix) with ESMTP id 746ED8CB22
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
Received: from s981.loopia.se (unknown [172.22.191.6])
	by s807.loopia.se (Postfix) with ESMTP id 65E6288F2D
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
Received: from s471.loopia.se (unknown [172.22.191.6])
	by s981.loopia.se (Postfix) with ESMTP id 6443722B1736
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1.2
X-Spam-Level:
Authentication-Results: s471.loopia.se (amavisd-new); dkim=pass (2048-bit key)
 header.d=lxm.se
Received: from s980.loopia.se ([172.22.191.5])
 by s471.loopia.se (s471.loopia.se [172.22.190.35]) (amavisd-new, port 10024)
 with LMTP id J8_rRARhgVK3; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: henrik@lxm.se
X-Loopia-Originating-IP: 92.35.23.126
Received: from pc.arpa.home (c-7e17235c.012-196-6c6b701.bbcust.telenor.se [92.35.23.126])
	(Authenticated sender: henrik@lxm.se)
	by s980.loopia.se (Postfix) with ESMTPSA id 0C84F22015B7;
	Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxm.se;
	s=loopiadkim1708025221; t=1726907082;
	bh=eZbLfjwCuYHMk2uxZIqJTlsmBYYsFxQXAcL0EhhnL14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sKM8awBarD/sLPJwDOj6JrJacTXi4R6rtl1yncq4720Liijoyc0MJpMZiMC1W1drG
	 jtc/tA/emyLWkvWYMpkc6QSp1gTQrsZi6svkVTJ9kydoHYRoNksXLo1zzMumei8rke
	 o4fSj9QkKjMexDO+kbzo+Q5mwlzpC8oH4X2zOQX2sKutF3jpkuHDcCCub1I3kBNT02
	 ak7ai/PseLELg9furKdl8IISshLRV4H9hc3cCSu03cdr69uoCzKr8xyERn8xxzItcM
	 h20W5unKDGxBCS/2woevEGmnGXYiZnTX83MQ/OI/e+//r1tmGNrij3MgC6TYkhsR5f
	 0UWS6hA9A5+fA==
From: =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
Subject: [PATCH 2/2] dmesg: allow enabling with --disable-all-programs
Date: Sat, 21 Sep 2024 10:23:10 +0200
Message-Id: <20240921082310.232867-3-henrik@lxm.se>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240921082310.232867-1-henrik@lxm.se>
References: <20240921082310.232867-1-henrik@lxm.se>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Henrik Lindström <henrik@lxm.se>
---
 configure.ac | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 838047720..8a788179d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2165,7 +2165,11 @@ UL_BUILD_INIT([readprofile], [check])
 UL_REQUIRES_LINUX([readprofile])
 AM_CONDITIONAL([BUILD_READPROFILE], [test "x$build_readprofile" = xyes])
 
-UL_BUILD_INIT([dmesg], [check])
+AC_ARG_ENABLE([dmesg],
+  AS_HELP_STRING([--disable-dmesg], [do not build dmesg]),
+  [], [UL_DEFAULT_ENABLE([dmesg], [check])]
+)
+UL_BUILD_INIT([dmesg])
 UL_REQUIRES_LINUX([dmesg])
 AM_CONDITIONAL([BUILD_DMESG], [test "x$build_dmesg" = xyes])
 
-- 
2.39.5

