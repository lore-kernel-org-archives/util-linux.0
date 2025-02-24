Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0723BCF3
	for <util-linux@vger.kernel.org>; Mon, 24 Feb 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402596; cv=none; b=gAG1fjMc4yF8O7d9ZdhUdut5bUafJ9ma2OZs3QUHjJcr6siTI7vw25JUrzXDlyHmyX8pRtnfN4Wy10UBuJ5+QXjQO1AB/SMP2+N6P7+6Ci2VgQwzHIzboKJgEWdTqq7xO6bWmKX4c9Ksnib+5ZWBhLlHB1HEFftuW0ikAxGWUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402596; c=relaxed/simple;
	bh=wRP4Tc3J013WB5Cuic8dZkRepYgCuttTQdyMAeQyg/k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dlcpoXsrG/x0Z+8iZ1VXomf5fePQroKMn+NKab0+4Y7KrL0PlQw524B/uxz7kuRvfvv0wNxwqlhx4r+f7UkA7N6VCFKCjJrE/n7ZsYpleZ0yVAJxBZYSahdEehVOkTIc6jtxo+JgxWQzs5nt1/DP62hrLHVOIO6f7eH5KppH4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=cXUTfhP0; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="cXUTfhP0"
X-KPN-MessageId: 7f58f26b-f2b0-11ef-b99e-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7f58f26b-f2b0-11ef-b99e-005056abbe64;
	Mon, 24 Feb 2025 14:08:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=fuJkKAHXmg+x20yIYQ5J3CYUTUeOtDtmspZZzcpMdGw=;
	b=cXUTfhP0PVFJQYQVRkNmJZZR+jew9GF890DjY6iJ31KEwljLUYKherB92rD2wqzRiwzpxEgzTxVMP
	 ijVLqE3zmKKlFdX++hkez3UikhisWW/I3zXNuvAUCKP6AgW10+5MmdvBOaBNqlE3FT1xCLT51u76gQ
	 aZJOLKmYHX26xs+4=
X-KPN-MID: 33|ntmjZkU7ZUyCewX4OC/3Pdc3ro7wiSo+04/IT3WpTldU9+4BsC1qVQLc9N7Ky/K
 +lrzFZtk64zAriPcx8JVDmrwKR4RpCQA4yT072MJ1pys=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|8cQzOL2Jn49/cmc+1x009dt/gRES/HCcRXULai5X2jR/mUJHto7utWUQlO2xAJo
 b8LCRiKNzlZGlQaIZ6jWUog==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 7a988cae-f2b0-11ef-849d-005056ab7584;
	Mon, 24 Feb 2025 14:08:45 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/6] scriptreplay: indicate that <divisor> is conditional on <typescript>
Date: Mon, 24 Feb 2025 14:08:35 +0100
Message-ID: <20250224130840.25770-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, use angle brackets to show that those words are placeholders,
not literals, and improve the descriptions of the key bindings.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/scriptreplay.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index c8a1ad0c4..0e1444ca1 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -50,7 +50,7 @@ usage(void)
 	      _(" %s [options]\n"),
 	      program_invocation_short_name);
 	fprintf(out,
-	      _(" %s [-t] timingfile [typescript] [divisor]\n"),
+	      _(" %s [-t] <timingfile> [<typescript> [<divisor>]]\n"),
 	      program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -75,9 +75,9 @@ usage(void)
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Key bindings:\n"), out);
-	fputs(_(" space        toggles pause and unpause\n"), out);
-	fputs(_(" up-arrow     increases the playback speed by 0.1 times\n"), out);
-	fputs(_(" down-arrow   decreases the playback speed by 0.1 times\n"), out);
+	fputs(_(" space        toggles between pause and play\n"), out);
+	fputs(_(" up-arrow     increases the time divisor with 0.1\n"), out);
+	fputs(_(" down-arrow   decreases the time divisor with 0.1\n"), out);
 
 	fprintf(out, USAGE_MAN_TAIL("scriptreplay(1)"));
 	exit(EXIT_SUCCESS);
-- 
2.48.1

