Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4752C327E
	for <util-linux@vger.kernel.org>; Mon,  2 Jun 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873694; cv=none; b=ORhAELRmky+HMRVsQgUyvSJ4VWjc+cMfwHTq8mIkcmcm4hNBk3o4aZCMUca1wEWn4krIk9lVP61tSxG1vXZnBX4Tm3Czi9j+vT9L0qT+5ZhCFe+6MeQZkW6YftbrlrwpibEAjt6g+K0cIctVjO7i/uEgZmMlmgvSrtBbMiXSYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873694; c=relaxed/simple;
	bh=DTMItEhJu0TaLlJDHJKsSF6x3LJiDxBZD7Betl3kAs4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BULvPF8VYffF+QjE04eUxIrOh+tyGkxIKZ10af+KOYGZcgjdUV5WQH4LXwY6sC766CwDsskkgn7jV91hdRDDYNw01go8eNBNRjY2OBt2K8pF0vxlYN4myarRbk4o8DmHnQvd5gHmlv7xoJZ9wEuWyXWCtzQDEoiSC+yNEw3IQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=DQeowBCM; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="DQeowBCM"
X-KPN-MessageId: 0e656f5b-3fbc-11f0-a830-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0e656f5b-3fbc-11f0-a830-005056abad63;
	Mon, 02 Jun 2025 16:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ghWRcUlBX/WwSvwdil8zjHTS02mw3Rn0BgPDfntJDx4=;
	b=DQeowBCMxX/eQPGIDCNv2Sh2utj1vJYtBzQe4EuK4bFdq3Dg/MFEiuJNlyFEzFq+SbiziaqMag/WH
	 4TaMddI/YaOFHjMyqCdmfBJV9NY9B/yYTaWQZ0fipXQgBz5VHlnpe82bTjazGHDAQAwotsm/Y4sOc1
	 oX7QasDCt0mcq8TE=
X-KPN-MID: 33|oN0aqQrBUOIg8bi6G+PPYp76bNMEABlbk3uoAgrRD+c8pDY9W2gRYSk/zxOhO4m
 A/EESwnTtEsN77ju1sgsgQ2lEByrCirf+Q789ntgDZ9A=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jXw6f5zaJyem5AqAyb3f+uNKAcwW/zFr05h5axBOgkdKYg0ptv1CNP/6YRIpGnS
 HNOLK3Y54pjMd/UsebAm2rg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id edf50c1a-3fbb-11f0-859e-005056ab7584;
	Mon, 02 Jun 2025 16:14:43 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/6] remove two leftover license lines from colors.{c,h}
Date: Mon,  2 Jun 2025 16:14:31 +0200
Message-ID: <20250602141436.11156-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last March, commit 549a517857 replaced the SPDX line in three files
with a "No copyright is claimed" phrase, but forgot to remove from
two of those files the text lines that correspond to the SPDX.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 include/colors.h | 3 ---
 lib/colors.c     | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/include/colors.h b/include/colors.h
index c02f61a57..d77e0a3c2 100644
--- a/include/colors.h
+++ b/include/colors.h
@@ -4,9 +4,6 @@
  *
  * Authors: 2012 Ondrej Oprala <ooprala@redhat.com>
  *          2012-2025 Karel Zak <kzak@redhat.com>
- *
- * This file may be distributed under the terms of the
- * GNU Lesser General Public License.
  */
 #ifndef UTIL_LINUX_COLORS_H
 #define UTIL_LINUX_COLORS_H
diff --git a/lib/colors.c b/lib/colors.c
index 47d69cabc..92afc9b96 100644
--- a/lib/colors.c
+++ b/lib/colors.c
@@ -4,9 +4,6 @@
  *
  * Authors: 2012 Ondrej Oprala <ooprala@redhat.com>
  *          2012-2025 Karel Zak <kzak@redhat.com>
- *
- * This file may be distributed under the terms of the
- * GNU Lesser General Public License.
  */
 #include <assert.h>
 #include <sys/stat.h>
-- 
2.48.1

