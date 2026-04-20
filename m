Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333B39A045
	for <util-linux@vger.kernel.org>; Mon, 20 Apr 2026 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.76.87.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708734; cv=none; b=BXyes7PPwidSxWYmyt7VGx4vKfnilOIxpRm1vXoaBwRKYoFtnz6I0+wl0wi8BWGda5xjl3u0CPbTjBjn0m0dBaurCOwRyhhl2W5BBgrhH6F1LTfddBT9xBiH4Hl/X3tPce3ZPtJUolOCG50EbOI5CdiZGPRFv3olROkvKcCfqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708734; c=relaxed/simple;
	bh=4cAmCcPno2q7oIe+mk40sIrG3bg6ILcbYUtNUsJGEdw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qxe3XTywDsibA3tBsyHMpscBfG0cb2XNmo5C3K+hkhD/LTAUXxlpox+tV29pX+Iv1FwQf++X4Lm9yghENsrh4mmUcpI93+GHLxyIA0QBatGjTvvKP8M0vOc93u9OzOp/qSY/BmVaXrhiELeY6hrSj48NR9fUp5pO/pmGxEIle08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net; spf=pass smtp.mailfrom=smrk.net; dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b=BRFCWxHx; arc=none smtp.client-ip=45.76.87.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smrk.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b="BRFCWxHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
	t=1776708328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D11vt6qkTCbqD2wXbrPO8utQDKciFBsmITu4MUc/E9Q=;
	b=BRFCWxHx7AKY6dH2y0fgL3i7hd8rAUHjb/DuCFf+QeSr+hHJ49WnXp2xjLVQkKA4/Dlf69
	8zjgCAmscXZtZylT8GCEx6cTsNvZqYHHFi/BEJmyOQXipWjLey74+m+QWVdUWmyqXk+crD
	RS+/UFDvr9fVozivIWyfWGcJuqTmrPO82l/2McOOGMpk1l+p++GcR7ahNoI2+Oi1IUaM13
	JbA9CwErEhsPud03K/+jwX9IfiFh4fXNii8pmemAF+DhqwgiMy2wfW869dlZDqoeyPQIqb
	ybtoSd0AwP5z62HMLlCA0HvIYmvOb5iqvJ7kYuR/Tyi9wESmkQjKDUxwWPLXAA==
Received: from localhost (<unknown> [192.168.5.2])
	by smrk (OpenSMTPD) with ESMTPSA id 9e7a79ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 20:05:28 +0200 (CEST)
From: =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] copyfilerange(man): fix swapped offsets in command example
Date: Mon, 20 Apr 2026 20:05:28 +0200
Message-ID: <20260420180528.943663-1-stepnem@smrk.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
 misc-utils/copyfilerange.1.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/copyfilerange.1.adoc b/misc-utils/copyfilerange.1.adoc
index 303a1a7b25e2..89b95e9516fa 100644
--- a/misc-utils/copyfilerange.1.adoc
+++ b/misc-utils/copyfilerange.1.adoc
@@ -71,7 +71,7 @@
 
 copyfilerange split-first-mb join ::
 
-copyfilerange split-remainder join 1M::
+copyfilerange split-remainder join :1M:
 ....
 
 == SEE ALSO

base-commit: 2f0a4512ea813b050172207c88ddfa9ace12d830
-- 
2.53.0

