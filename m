Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAE22094
	for <util-linux@vger.kernel.org>; Sun,  6 Apr 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743952929; cv=none; b=Qtum+fQpvdMDPxX2BT5SRl+wDscnoey3VMx7n0amHF1FOVRlrjgO1xMNZwoyaCKhfFgIdoiwvIBqQmx8JJ6fSRtw4aWnxb/RDH14mCpcMzQUNpMjh/iz1K+T0psU6V0p6pm3Zind6OutsbVjFH09f4WxlJK9J0nU2aCpGc48/BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743952929; c=relaxed/simple;
	bh=PUgD8lOujAUurAHhhRJotl3jTl2jvztvvV+R+hvgaMU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TQhVB4c0kjBc+ChjAxiXss3Nm+lRKr0xQsDlhxZz9HN+6O2+5vr3WNsfODjr1uem+ewMH8opcUxy6I1vsXoNnhBWc3K+8zNd78e+PQkur/1T65CFDTT1rcT/gx6wQ6vWpfdUyVYRuOf95ZFxQV1mQPMFoKtM6VxB66TTQQY0eZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=JIMRHJ1h; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="JIMRHJ1h"
X-KPN-MessageId: f63fe034-12fa-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f63fe034-12fa-11f0-86cb-005056aba152;
	Sun, 06 Apr 2025 17:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=vBVct+Hw74+zKOBlsF5gchyz1D0/AZuUDB3VquNf1Vs=;
	b=JIMRHJ1hoz6FBUhQ2gPmrTVqyGIBf53o18EPxl5cJavS6xn4bundF+AJQmRifazldHL4QFWmI3oTg
	 fkHGWdaNCFW73vYLXKyJR9I7ayi7frD4VcAt72wEMwiRsGD4lfQwOWPnZ9PJ42hGliat3UYd/D+mWp
	 tfu4qJJ++JtBKfyQ=
X-KPN-MID: 33|5yaUdhI3J2/DhL+bHamE4T3kDCH7tT4ajllEjxrc/Zo3ukx/W+xCNto5JUFAvWV
 3FTtBh59agy6HvvdpnZoj0g==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|wjtYsXbzyb0rQV22/E6oOE6ftWibYmjncgtZGkH+ixVgCIpBZqQW2ijCX5rPjm3
 UHRS1OSYMfnfVcTe85rP01w==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id e0e68fc9-12fa-11f0-9599-005056abf0db;
	Sun, 06 Apr 2025 17:21:57 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] hwclock: remove two comments about parameters that no longer exist
Date: Sun,  6 Apr 2025 17:21:44 +0200
Message-ID: <20250406152147.9225-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 336f7c5f68 from nine years ago removed the 'universal' and
'testing' parameters of do_adjustment() but forgot to update the
leading comment.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/hwclock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 9977e0600..7ae7fca11 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -943,11 +943,6 @@ done:
  * Hardware clock set time is subtracted from read_time to 'refer back', or
  * delay, the trigger point.  Fractional parts must be accounted for in this
  * way, because the Hardware Clock can only be set to a whole second.
- *
- * <universal>: the Hardware Clock is kept in UTC.
- *
- * <testing>:  We are running in test mode (no updating of clock).
- *
  */
 static void
 do_adjustment(const struct hwclock_control *ctl, struct adjtime *adjtime_p,
-- 
2.48.1

