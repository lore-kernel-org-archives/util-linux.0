Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D71AAA1B
	for <util-linux@vger.kernel.org>; Sat, 15 Feb 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636402; cv=none; b=nnu8mC1e3hmygkbvXwQNnnyKMzIYcy8T/xfafz2i+ET4LM8SB7i5MQ8uj8K8q9VEMgnxQmi6QR4IibAXJj/IzlumUzeAJDCvseLm2EqovuM2evf1rKzZ3STLD86vhkp2KjkXfWfKjxTzfF5ovqthQLCeTRdH6RoVvCDbstlQNVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636402; c=relaxed/simple;
	bh=5fZw1e5MKjke22LiglO4eUbLzHbFdmeO9fWror3MCKQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9VdmjTOLDmX1NSVTMyeniWo1tpv2FA00qgYqNoKJvZ0KnsWNf4yKugfoR7FbnlBQBy+7F1e3tiFi8kY+clHYvzL3q0ttjRQbOEKoLcXb4w9GQ2Zwo7lCQ2qxFx17kWfjzRHutCFUTTLQAB3yUIRBtyvsn6l2vwsgDL0+ZvMz0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=s3e6bpBP; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="s3e6bpBP"
X-KPN-MessageId: b3432556-ebb8-11ef-99cf-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b3432556-ebb8-11ef-99cf-005056abbe64;
	Sat, 15 Feb 2025 17:19:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=FAhYO8Ep6g110RpT6tYrfTbWjrAr497ygUqmnIhJBfU=;
	b=s3e6bpBP5YLymDjVVRpXk/VL/pH/DT3btZ8XqE5Ti8Em/TG9I4h78MQK5v7J6b/L8u5TyQeLVmIKp
	 SZKtP3CP2pdhoWePKW1vK95rk2YgQSFlLSUcGT9yPQY5vQSwHNN7gASGMZ0WtUPSzVki/MVuuZM0b/
	 9TVqKknzF91t06IU=
X-KPN-MID: 33|DhauJCF1diaOLEEZ5sZDnDmJGI8lq4ODM/ztaF0S8okOUX9A8uJxLWjRvK879AA
 oXuxaHzeLgeNe6RPNzJ53WhYqmAQDQMEx1YkZdOft4m0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|5lUgKk82ZRXWaO9063SXcH6jKG1ZqPPYUPu8v+z480KSHfaJNsm98tM7WhxKJ5C
 NX69KxLt4kcn/wZ916FGNug==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id b3460dc8-ebb8-11ef-92ee-005056ab7447;
	Sat, 15 Feb 2025 17:19:58 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/10] textual: make two incorrect synopses identical to a better one
Date: Sat, 15 Feb 2025 17:18:39 +0100
Message-ID: <20250215161843.12053-6-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215161843.12053-1-bensberg@telfort.nl>
References: <20250215161843.12053-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/setpgid.c | 2 +-
 sys-utils/setsid.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/setpgid.c b/sys-utils/setpgid.c
index 4bcaefad2..a1708d62d 100644
--- a/sys-utils/setpgid.c
+++ b/sys-utils/setpgid.c
@@ -17,7 +17,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(
-		" %s [options] <program> [arguments ...]\n"),
+		" %s [options] <program> [<argument>...]\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index 5ccfd0ff1..0a7fdbed0 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -32,7 +32,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(
-		" %s [options] <program> [arguments ...]\n"),
+		" %s [options] <program> [<argument>...]\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
-- 
2.48.1

