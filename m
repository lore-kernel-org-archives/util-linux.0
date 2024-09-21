Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054FE13D51C
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.3.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726907445; cv=none; b=g6fgmv2kAo8wHsJxxsJ+nglxs+AacUFdW5IoCxR8uQHx7VWk/TBnTm2u8CSssIxGmxn6GgmQgwlwbubO1GHFyLG7Njb3upO7djjKGn1+UyIGq2QhSzrWxT4copd9pTiUbTWM6kBVlkNQdBwVoRdNjhiF5y/xMDyvLOWXV+ju8bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726907445; c=relaxed/simple;
	bh=gIM9ffkzcM1A0EmylM6JIwzm8PM0948aNwkhOvPygEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fb3LrXbYJi5Ed+BwWOQdy+LbXevvZ0FRl5f/AlFGJiRaLeZbD0tLBX5jm4KBIEb/Sm2vZhQi0peymBk9dW8JDrtLfb+gLV6hUiaLw/F+E47SfxRDVSUhz95KDDNHR47utkTNHJ2eaKchXcQA8OLX5Vo5oKZdtfmleC4UhYx3jSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se; spf=pass smtp.mailfrom=lxm.se; dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b=ZFuDsLug; arc=none smtp.client-ip=93.188.3.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lxm.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b="ZFuDsLug"
Received: from s807.loopia.se (localhost [127.0.0.1])
	by s807.loopia.se (Postfix) with ESMTP id 6C20B88F2F
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
Received: from s979.loopia.se (unknown [172.22.191.6])
	by s807.loopia.se (Postfix) with ESMTP id 589D688F23
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
Received: from s470.loopia.se (unknown [172.22.191.5])
	by s979.loopia.se (Postfix) with ESMTP id 5785D10BC43F
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1.2
X-Spam-Level:
Authentication-Results: s470.loopia.se (amavisd-new); dkim=pass (2048-bit key)
 header.d=lxm.se
Received: from s980.loopia.se ([172.22.191.6])
 by s470.loopia.se (s470.loopia.se [172.22.190.34]) (amavisd-new, port 10024)
 with LMTP id unvBAb-Eslcm; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: henrik@lxm.se
X-Loopia-Originating-IP: 92.35.23.126
Received: from pc.arpa.home (c-7e17235c.012-196-6c6b701.bbcust.telenor.se [92.35.23.126])
	(Authenticated sender: henrik@lxm.se)
	by s980.loopia.se (Postfix) with ESMTPSA id D5EE522015B0;
	Sat, 21 Sep 2024 10:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxm.se;
	s=loopiadkim1708025221; t=1726907081;
	bh=blPXyuHuKCC9uHryOHE/B+sPw2OAWL1NaUQh2VzjAxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZFuDsLugCSWZGrngIMX+szfPYEoT/wX0W5lj/jQRuWum1CUl6n8u5Ot39WX+Yp+5U
	 6MhyJ8w/svReO8atqXMvmyqC2NxC84sdczBz+FQOY12vD3ASVnQCso6JAd6a/5SPRq
	 09LO0/w7ZYOGGnP5WL5Ev6/3fpW0Ha04JKL1dqG64uapyjcTICPwsM+S6JYBOEVCyh
	 J/k7R4o0d9QPIIjc2OjEy5HL0sRcR1Eatlkm8/3xyf/407NvF/YdY3X6LFdTKtt+hl
	 qEfAIFGv2rThUzKJbqAABY0LgPAov/cN0XTZ7tecK/WXKcoDax9Ue8ZDWAI14y1nGL
	 lAcj38wDZLsUA==
From: =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
Subject: [PATCH 1/2] lsblk: allow enabling with --disable-all-programs
Date: Sat, 21 Sep 2024 10:23:09 +0200
Message-Id: <20240921082310.232867-2-henrik@lxm.se>
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
index 0ca2ebcf7..838047720 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1835,7 +1835,11 @@ AC_CHECK_FUNCS([swapon])
 AC_CHECK_FUNCS([swapoff])
 
 
-UL_BUILD_INIT([lsblk], [check])
+AC_ARG_ENABLE([lsblk],
+  AS_HELP_STRING([--disable-lsblk], [do not build lsblk]),
+  [], [UL_DEFAULT_ENABLE([lsblk], [check])]
+)
+UL_BUILD_INIT([lsblk])
 UL_REQUIRES_LINUX([lsblk])
 UL_REQUIRES_BUILD([lsblk], [libblkid])
 UL_REQUIRES_BUILD([lsblk], [libmount])
-- 
2.39.5

