Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423771624E8
	for <util-linux@vger.kernel.org>; Sat, 15 Feb 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636379; cv=none; b=MfEo4EKNzevZT/JUHEyDsYKSlSfMheAFQSVz1OJ0ZAN9rEeQ/kVDvnq4RL00qKrLChLEeLbT3ORIlEwrpZXBAwPAEwi5N2pFbBYW+FKKYGx+iziDW1NYv38lnqEQEs1z+ob9xVTFjZXYiSVGwi4/Qstyi657HBFVX76uermTFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636379; c=relaxed/simple;
	bh=Jqk/Kj4QgYPL6V3L6Od23QNEspudPrBZmOLv2efyLVU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF5iysNQPrNDKj6qspHb6jf/6jFmHWY+cDlOi2vnrmz/lnBCYZYv0xTdut/3YYlSWOgs4UL5p8jym/ZmjCEGZDCciyf/apdMQGWWdwmN6ltFHObLDbOikAmCCQa8ff8XpJJQyer/BZ2UIEFejPiLd2i0NkYS3t3XesepT/T/nWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=P89ZGGKQ; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="P89ZGGKQ"
X-KPN-MessageId: a3ccb182-ebb8-11ef-8f0e-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a3ccb182-ebb8-11ef-8f0e-005056aba152;
	Sat, 15 Feb 2025 17:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=GYGPqXmSKcQolXy6rZuRN+FXuIMFnzfaVsxZ/sDXrRA=;
	b=P89ZGGKQPB+ZISQkk/2pD6GjifJRvNrX87gZMSPMQMWyjTITi3PlfypUOnTZXLoFgDH6wBztIqgtU
	 eGCo0hObk6orT0LlQQEBLkd23XCEJKOKdl9ydtrv14p30GSZ7kfvM3V31UWMaOY2lKngPqzF9j8OZk
	 +hsli1BRm6ci3sbY=
X-KPN-MID: 33|8Kt/VIXtQ2615r4X33DtIEx3p9ARLYLmlzYPzFWRioAqrWkCSIuwd0GIIBUN6dn
 jfvFUIABU4TOFLerhrOSGLNI69TLC53AFwcEahrJGfOk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|IYgCOscOXV1WPzaVpr5P4q3iSIWhEgz0wvqSa1fD6xesS7WjEVahlaca34Izzv1
 8A35nvppleRru2VgKE1GmEA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id a24b7ada-ebb8-11ef-be91-005056ab7584;
	Sat, 15 Feb 2025 17:19:30 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/10] textual: fix three misspellings of "unsupported"
Date: Sat, 15 Feb 2025 17:18:37 +0100
Message-ID: <20250215161843.12053-4-bensberg@telfort.nl>
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

One misspelling was fixed five years ago (in commit 760ecc3613),
but the others remained.

Fix another spello too, found with `codespell`.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/mount.c       | 2 +-
 sys-utils/wdctl.c       | 2 +-
 term-utils/script.c     | 2 +-
 term-utils/scriptlive.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 7bce9038e..8d0e9ab17 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -378,7 +378,7 @@ static size_t libmount_mesgs(struct libmnt_context *cxt, char type)
 			break;
 	}
 
-	/* messgaes */
+	/* Messages */
 	STRV_FOREACH(s, mesgs) {
 		switch (type) {
 		case 'e':
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 4818c6ce4..ba013a3b4 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -545,7 +545,7 @@ static int read_watchdog_from_device(struct wd_device *wd)
 }
 
 
-/* Returns: <0 error, 0 success, 1 unssuported */
+/* Returns: <0 on error, 0 on success, 1 for unsupported */
 static int read_watchdog_from_sysfs(struct wd_device *wd)
 {
 	struct path_cxt *sys;
diff --git a/term-utils/script.c b/term-utils/script.c
index 59b640256..78ab3f4ca 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -829,7 +829,7 @@ int main(int argc, char **argv)
 			else if (strcmp(optarg, "always") == 0)
 				echo = 1;
 			else
-				errx(EXIT_FAILURE, _("unssuported echo mode: '%s'"), optarg);
+				errx(EXIT_FAILURE, _("unsupported echo mode: '%s'"), optarg);
 			break;
 		case 'e':
 			ctl.rc_wanted = 1;
diff --git a/term-utils/scriptlive.c b/term-utils/scriptlive.c
index af946a08d..1b0bf96cb 100644
--- a/term-utils/scriptlive.c
+++ b/term-utils/scriptlive.c
@@ -218,7 +218,7 @@ main(int argc, char *argv[])
 			else if (strcmp(optarg, "always") == 0)
 				echo = 1;
 			else
-				errx(EXIT_FAILURE, _("unssuported echo mode: '%s'"), optarg);
+				errx(EXIT_FAILURE, _("unsupported echo mode: '%s'"), optarg);
 			break;
 		case 't':
 		case 'T':
-- 
2.48.1

