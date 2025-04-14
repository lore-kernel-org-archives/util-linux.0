Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D36F9FE
	for <util-linux@vger.kernel.org>; Mon, 14 Apr 2025 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624019; cv=none; b=Mbix1UjOZo++nUYEwP9Fh1V5V82LDdPGVhI//+FmZSokoEurWdGwJlesHvEpdB3u329uu/zykNvbS7XmlQHXkLKF01Ldoj8lwhfTZwphxyMLx6RP10+03ooW0jBFiCkJUeaoRcOFkPBo8dOHe+pjHYH5+riCOL+T5yCnsCioHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624019; c=relaxed/simple;
	bh=nPC4IZDKffOAelr9puR5j0xqVu+VF96gji5DOvANrk0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Yh3NgtpKTNnBh3zwiwiXAjwrybWx90zDEonWgyxEE9troKbXeSayPFwA2PhYBiPz3coCj9iD3276FaYEktJcXgA0Ly352FCIbvG9+DMR3+zuYKesagf2tgyWmcWsS/hsbsE+BWbPvLlRqR+vhay9+CWEbmlH4MUGdnOBFo9NbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=r7adWY67; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="r7adWY67"
X-KPN-MessageId: 579b3cb3-1915-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 579b3cb3-1915-11f0-bc28-005056ab378f;
	Mon, 14 Apr 2025 11:46:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=YcWRG+zjhPhgBN1E6abU91PjctO53QR2EiU1rXsd3Is=;
	b=r7adWY67mp0V0RAfhKhU1YyiQ4Y8CoUeSPXSyIuCb/FZBns3Kk/Y+XJbbWyOW23kfCDzabgQILOSR
	 GZNKQ88O7fLOMQ0gAyZpC41FonuLGzKRXjOPeTcwDYXe3wkV+Z7MilClkdFtKCi8SaxYI9DfahLcMG
	 mx1wKkLagomQP8Tk=
X-KPN-MID: 33|w7CcZmAQZvYxogF2B/p8jZkzK4seMnhJ05FjeCwrlOq3jgZ/MGvzMz0zngpYmaj
 H1pDTNH4JFF+L7tYsw7D/LPqZaho3SfeoofyX8EtnBCI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|hrL8MZjd0z0YOwJiufuulGiSKxX4puU5thZ/TjJyKqK3r9mUJO3+y8vJ7KjNrtt
 /ugakT1Hzov8k68LgcgS5bg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 3d3df62d-1915-11f0-959e-005056abf0db;
	Mon, 14 Apr 2025 11:45:46 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/8] docs: rewrite the description of --bytes, to be clearer
Date: Mon, 14 Apr 2025 11:45:27 +0200
Message-ID: <20250414094534.9504-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original looked like a plate of spaghetti to me.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 man-common/in-bytes.adoc | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/man-common/in-bytes.adoc b/man-common/in-bytes.adoc
index 3a69c6e40..0c4a4d651 100644
--- a/man-common/in-bytes.adoc
+++ b/man-common/in-bytes.adoc
@@ -1,7 +1,5 @@
-Print the sizes in bytes rather than in a human-readable format. 
+Print sizes in bytes rather than in human-readable form.
 +
-By default, the unit, sizes are expressed in, is byte, and unit prefixes are in
-power of 2^10 (1024). Abbreviations of symbols are exhibited truncated in order
-to reach a better readability, by exhibiting alone the first letter of them;
-examples: "1 KiB" and "1 MiB" are respectively exhibited as "1 K" and "1 M",
-then omitting on purpose the mention "iB", which is part of these abbreviations.
+By default, sizes are shown in units that are powers of 1024 bytes.
+The formal abbreviations for these units (KiB, MiB, GiB, ...) are
+further shortened to just their first letter: K, M, G, ....
-- 
2.48.1

