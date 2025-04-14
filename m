Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0E1F1506
	for <util-linux@vger.kernel.org>; Mon, 14 Apr 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624039; cv=none; b=GUxXQHKm93U+CsAKRyroFheexQYVPn/THb4aaJS0H9gm2FqNyzBWeqNRpqaLRqAtPqqKCE03kW2YDsDUa39eDuXqA7MTLzBwu7TFgaS553sCzy0tHHOAuID68F3pQmEo9SU25/2GuXbu+2siPm8P7qSCOIX2nppi8oSLxTdPV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624039; c=relaxed/simple;
	bh=KWMh7EbHho51DNlkqXKRXxaYALH9DmOJhbJ0bK8ISr4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTs4ZEYUSUfgfGqOyoZ5WKbw2aXnMj5c9VFFbIIk6sfaEWMbyawHetRohp2RvYKewrjBqYPiB5XvIuBBebv+cooDBE1FkaWs/8LbI1jbQSFnAuoLqxeSSlUnxS/OVMOmAWV7Tih4FZ6D3uppwyiNRAS1EYEYK+QoXqedYEQwhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=HZ8PpMfC; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="HZ8PpMfC"
X-KPN-MessageId: 5ca49f10-1915-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5ca49f10-1915-11f0-86cb-005056aba152;
	Mon, 14 Apr 2025 11:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=SoUljukgH8t8YCPFbLDtphHuLAIvVTtHgznL0MrxhmA=;
	b=HZ8PpMfCa2pZzXwCSNLtw1T4x4clQQnocQQvyXgy4Z0Rmy5T4T2opi5NGLSek2EKOuLjM0svyaRRZ
	 ABAxVb4TJWg9PSj+i2uzQ0i+ijeL4u8j2DrTf6FEZcC3BxtMSlIJCKuXdieINadxNt9vJk6y9gtuxB
	 N1ct59wbRi+R6ZD8=
X-KPN-MID: 33|7qrBIGzcwpaIIxj5Kg2t/+heouSwLKiInfwNNZnLHXzN+yJh9bJBrqqcQ087lfM
 QfxsNFH9N+ydUuvWyNKrG92tq5hhrQj7dUMP8KZCOvBo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Y6rnZettsaLxdakVlXIKOsOtAtwEUxHXBTrw20hjkG9zc6Ny+5aAEKL6gFvQ6KW
 LqbG44Cam/eeGs1fwo16dFw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 4a74aab6-1915-11f0-9bf3-005056ab7447;
	Mon, 14 Apr 2025 11:46:08 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/8] agetty,setterm: (man) remove the mistakenly added -h and -V short options
Date: Mon, 14 Apr 2025 11:45:30 +0200
Message-ID: <20250414094534.9504-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250414094534.9504-1-bensberg@telfort.nl>
References: <20250414094534.9504-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three years ago, commit 2b2d317242 was a little overzealous and replaced
also occurrences of --help and --version that were *not* paired with -h
and -V: `agetty` does not know -V and uses -h for something else, and
`setterm` does not know any short options at all.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/agetty.8.adoc  | 6 +++++-
 term-utils/setterm.1.adoc | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/term-utils/agetty.8.adoc b/term-utils/agetty.8.adoc
index d34bd746c..988915865 100644
--- a/term-utils/agetty.8.adoc
+++ b/term-utils/agetty.8.adoc
@@ -180,7 +180,11 @@ Run login with this priority.
 *--reload*::
 Ask all running *agetty* instances to reload and update their displayed prompts, if the user has not yet commenced logging in. After doing so the command will exit. This feature might be unsupported on systems without Linux *inotify*(7).
 
-include::man-common/help-version.adoc[]
+*--help*::
+Display help text and exit.
+
+*--version*::
+Display version and exit.
 
 == CONFIG FILE ITEMS
 *agetty* reads the _/etc/login.defs_ configuration file (see *login.defs*(5)).
diff --git a/term-utils/setterm.1.adoc b/term-utils/setterm.1.adoc
index 1e6c2f5e1..89e21532e 100644
--- a/term-utils/setterm.1.adoc
+++ b/term-utils/setterm.1.adoc
@@ -160,7 +160,11 @@ Sets the color for underlined characters. Virtual consoles only.
 *--underline* **on**|**off**::
 Turns underline mode on or off.
 
-include::man-common/help-version.adoc[]
+*--help*::
+Display help text and exit.
+
+*--version*::
+Display version and exit.
 
 == WARNING
 
-- 
2.48.1

