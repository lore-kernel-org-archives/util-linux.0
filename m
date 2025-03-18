Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC882054F4
	for <util-linux@vger.kernel.org>; Tue, 18 Mar 2025 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295688; cv=none; b=Zs+3BVKvpNHB9slt/764IJwPv+7hVPyRuU90vljn9P5SzOBIB8wpEOQewH7k5buKJJXaEjQ/xTf1WMbAHDvrVE+Dh+ouj+jUKA5mqesWs65HuETiV+UwW/DSXmsZDXPJzRFMVVUR6twl0IUbmGvknXNZSRi/D8aj3tbkrSkIg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295688; c=relaxed/simple;
	bh=RZWbB+Gy/ZucNTfJPH6pd4PNROsViNbXco4irNuLEhU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MT+9DjuFi7YkyjvZ/LrXuPPkpOuV/WM4QQW7nnUzCbEUI5CN72/ZR4mbioCY09wyH9RjpWGeKxzh9/xPkZFjrTTB98Gwt2jDKsg1DaSyluI+A9T96G1BujwUqD5Ta38wy/3jtdXjPZAxMbI5q2QlM20ON1CvBcNqI8h1mAktHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=kUCt+cXV; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="kUCt+cXV"
X-KPN-MessageId: 5b2be70e-03e8-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5b2be70e-03e8-11f0-86cb-005056aba152;
	Tue, 18 Mar 2025 12:01:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=TVFKyy0IqzwjN+ePCEvcJQy3IHKQFSS4l0Xim1zetlc=;
	b=kUCt+cXVM3AhnyDx7cv+ogfjsFSNMKwyrMJ/BnPn6mx+KUiSFuZkhyT9FFM4smNGOXhkQ9hp5Zk4t
	 JN/oWNhKuQy0Oatdqqtbv9uqYTVjYxlvMSeKOEUJ3N7NbEXS1nTp7wJmE5Awkgq8M+OZvIE17ShWwC
	 k2je1D/wmmj/8lKM=
X-KPN-MID: 33|bagEUYfhFOiwOTHWjH3JjmeGDsbcf+z01QKszhs7dZ1EtemDupAzTHmiVbdJPvq
 a598MNP4vNABcDu3s+gkJZ8OOovwIo7kwo8PiSxFRITY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|w9HNCPfFLu3vOX7Ww64wd7jK5DHp0lHiFz3gTLEeCg3RB9pqmlyv8uu1KkWozkq
 RGnXiXrrzJuZRN+j/MkRRtA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 51fc65eb-03e8-11f0-9bea-005056ab7447;
	Tue, 18 Mar 2025 12:01:19 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] more: ensure that on larger terminals 'h' shows only the in-app help text
Date: Tue, 18 Mar 2025 12:01:08 +0100
Message-ID: <20250318110108.5086-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a terminal has more than 24 rows, the rows above the help text
(shown by typing 'h' or '?') were still those of the displayed file.
That could make it hard to notice that the two lines above the first
row of dashes belonged to the help text, not to the displayed file.

Improve upon this by scrolling off any lines above the 23-line help
text.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/more.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/text-utils/more.c b/text-utils/more.c
index a035591af..d0fd6a48f 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1805,6 +1805,8 @@ static int more_key_command(struct more_control *ctl, char *filename)
 		case more_kc_help:
 			if (ctl->no_scroll)
 				more_clear_screen(ctl);
+			else for (int i = ctl->lines_per_page; i > 23; i--)
+				putchar('\n');
 			erase_to_col(ctl, 0);
 			runtime_usage();
 			output_prompt(ctl, filename);
-- 
2.48.1

