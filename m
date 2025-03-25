Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D607433A8
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899465; cv=none; b=bEJg/+jhG0SNFrKiRyieA2+YU6OEgmRcPewEIevt3ldttQ9wTe01F2HSBaGTtaNVLGuB7OcNU9RckmrbNssFQXPO0oPVlL470oME6/dEQXtZaLpz3/HejywrinIWaW3O7/TqLUQfrcK1GJyopINq0b8zU2au2X+jW29zN1bUJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899465; c=relaxed/simple;
	bh=+/GPmL4AogkcRgmvFYPtjGH5h26n28y69q0WyZM1Mwo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OUv04eo3B62uVLTY88mPxhvzxlU71RcPoteV+1hbOqSHeFDNrmv2n/VjIzSo64IeTG/lNpyZPmDWD6tiaZ/Bl/cjGfYCOkDNcGIcSyq4Iy8kSIQSViLyy0OjcdU2pY7muFqqWYKywOQaWXB1G1C9hlvjAViVtkVLz+mtsYVtUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=cz4dpuVl; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="cz4dpuVl"
X-KPN-MessageId: 0fcb9fac-0966-11f0-b99f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0fcb9fac-0966-11f0-b99f-005056abbe64;
	Tue, 25 Mar 2025 11:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=IbgcxHy/GVWWSDiGib8CWo4rgp2iD0OLAVWOKt4RwT8=;
	b=cz4dpuVln+I98u96GDZ3TBOWWNOmnY1BIs9+V9haoVGLgpr3I2h7Kky4ATowuMcnc/bnNv29cdpwm
	 QrEru6sCBicwIp0wG43R8erOWJ+1dx/uq0yqcV4o1Nfek6R/APd7EHIY1aRvwnTBKJBjolPPFFd/iI
	 MDXF9Xc6yX/ZV7Z4=
X-KPN-MID: 33|rmZ/fEtzEHBJc/oXGBnbIbyaLRW1zDSd8d6eiSa6K7mEiDx/4Q1OSVI7S65Qi+b
 jB4brKmyMpGnoF2nXzNz/BRmlB/QVIwXDt9xs7pbcfho=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XqhIQaSFst5QFfsMf6AkZhMZ4rmsSYBfywkyL5Wh2GDbjZChc4SppmcRMy/E01r
 ksEvDlKz3AJ9tZ1p1PYZ54A==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f4cfa0a1-0965-11f0-9bed-005056ab7447;
	Tue, 25 Mar 2025 11:43:15 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/11] ipcrm: move a constant argument in order to gettextize the message
Date: Tue, 25 Mar 2025 11:42:55 +0100
Message-ID: <20250325104305.23980-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/ipcrm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 11adf2f80..ceb101187 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -173,7 +173,7 @@ static int deprecated_main(int argc, char **argv)
 	return 1;
 }
 
-static unsigned long strtokey(const char *str, const char *errmesg)
+static unsigned long strtokey(const char *str)
 {
 	unsigned long num;
 	char *end = NULL;
@@ -190,9 +190,9 @@ static unsigned long strtokey(const char *str, const char *errmesg)
 	return num;
  err:
 	if (errno)
-		err(EXIT_FAILURE, "%s: '%s'", errmesg, str);
+		err(EXIT_FAILURE, _("failed to parse argument: '%s'"), str);
 	else
-		errx(EXIT_FAILURE, "%s: '%s'", errmesg, str);
+		errx(EXIT_FAILURE, _("failed to parse argument: '%s'"), str);
 	return 0;
 }
 
@@ -200,7 +200,7 @@ static int key_to_id(type_id type, char *s)
 {
 	int id;
 	/* keys are in hex or decimal */
-	key_t key = strtokey(s, "failed to parse argument");
+	key_t key = strtokey(s);
 	if (key == IPC_PRIVATE) {
 		warnx(_("illegal key (%s)"), s);
 		return -1;
-- 
2.48.1

