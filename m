Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37105189B8C
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883323; cv=none; b=bVJu97W9XTaR0sWbUJqkujc6inGl3wNs5F2UEoHkr59iZjtVx9CN43KbT8XwRcrsC8mhqzgfINNdsatDx1ZqGvM3mhup0lD7Pu9DSbXt3SlCZdsuadJ68OjEcrlbWGvBuRHN/MFR6YFhCk6tIerTiVM01/VaWwT8g7xDHUV582E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883323; c=relaxed/simple;
	bh=Zlf2CCJRikOkQhhIYtQ/hOkUdt3JghAHUik19eWHfJU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zuph7r4Snx9okwhD8ooRunNXILURRDjXYAsuA7XAOvSHxbo9EV4EraA4Q7dpYUBTIZW9mAQ2H067XZuqIJdayYD9MB8PoJYH8DYjXBuk/dbNMf7NdPBKniqvF18Ct5Va3f+3EORTOr6oEV4l5P10jXtkh0qYc7F1h1YKXHYrlqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=PzbtFBSd; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="PzbtFBSd"
X-KPN-MessageId: 43fd7c7d-1b71-11f0-b8e8-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 43fd7c7d-1b71-11f0-b8e8-005056999439;
	Thu, 17 Apr 2025 11:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=HhdvPcyRgGZkzCzw7InbOuFKxq8NW6DSfBIkWF7BMvw=;
	b=PzbtFBSdfBp7YcjBvjo3bF/luNx/EFJ7gK4uh3w5KmSUi7EIcJTZKLUXhu9f/VaBtTVoT4qKo6/OO
	 djf1S+3AeqL3mUJgl+DZ0MfQFQfGCNbcAJHrmxyZyGqCjKU5F0sxBoAaHB4RbX0WY4c2D+1W5BTofb
	 Ixac/IxGyIJjWjts=
X-KPN-MID: 33|QVw4zRk3AnfkqAEQXD5jXQ5yEQobizj+oR8dRGOCWovMS72hWMNmdOR6fXJBmQB
 5zeKKRHzdRhD+MVhcrWuTj5XXkHDQ7qSxgzJl5JJEvsE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|19sZ26Uy/v2QgQWFmndA92Jrzk30AqPa0xAFVWgcoXb6wFwjc+BKKJ2/nFItnQV
 CJGfOpFOVU/EYTWBzjGoW6Q==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 229d964f-1b71-11f0-99e7-00505699772e;
	Thu, 17 Apr 2025 11:48:37 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/10] last: (man) correct the descriptions of --present and --since
Date: Thu, 17 Apr 2025 11:48:16 +0200
Message-ID: <20250417094825.20870-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250417094825.20870-1-bensberg@telfort.nl>
References: <20250417094825.20870-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Doing `last --present -24h` will show who was logged in around this time
yesterday.  But when doing (what according to the man page is equivalent)
`last --since -24h --until -24h` nothing will be shown -- unless someone
logged in exactly 24 hours ago to the second.

So, correct the descriptions of --present and --since.

This fixes #1896 (https://github.com/util-linux/util-linux/issues/1896).
Reported-by: Finn Krein-Schuch

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 login-utils/last.1.adoc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/login-utils/last.1.adoc b/login-utils/last.1.adoc
index 099b281cc..8da52c766 100644
--- a/login-utils/last.1.adoc
+++ b/login-utils/last.1.adoc
@@ -64,13 +64,14 @@ Like *--dns ,* but displays the host's IP number instead of the name.
 Tell *last* how many lines to show.
 
 *-p*, *--present* _time_::
-Display the users who were present at the specified time. This is like using the options *--since* and *--until* together with the same _time_.
+Display the users who were present at the specified time.
 
 *-R*, *--nohostname*::
 Suppresses the display of the hostname field.
 
 *-s*, *--since* _time_::
-Display the state of logins since the specified _time_. This is useful, e.g., to easily determine who was logged in at a particular time. The option is often combined with *--until*.
+Display the state of logins since the specified _time_.
+The option is often combined with *-t*/*--until* to cover a period.
 
 *-t*, *--until* _time_::
 Display the state of logins until the specified _time_.
-- 
2.48.1

