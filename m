Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E32522A8
	for <util-linux@vger.kernel.org>; Tue,  9 Sep 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408255; cv=none; b=RzYHBJFnlUb8A68WPJO63ESrKl1Ud9iT4aMYvall0hMEqnJPzD8l3IVNWHCFYjfT7KHUpxumqMbodl5B0QWAl3DlTpNXmUnl0X3bzMmiQAaLMuXgDsD0IyryJILkxuhkJDwbQiibm2BYwN5O2TM6IbJjeci41yYQ808fVNmyK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408255; c=relaxed/simple;
	bh=ERJLNsVEvJhwj67iF1FUvgGxJJLgp0x77XgfM5rMm/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bl4rkt7JIWtFk2c85uAc114J2jzs7desMOVWj4oDrOc5QAfYmrOAeM2gAc6k5Qg4lFVKv8wmWE2+CK/gLYxlMOHORyGHNSiAtJ7NW1lf4ig+2hh1SoIQgaREHNbHAuYa5LiDG3vRFV9pN3OkqHy0OF4c9Kh72gFqqybZU26qmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=msmpRVwK; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="msmpRVwK"
X-KPN-MessageId: 372c9ac6-8d5b-11f0-b7a7-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 372c9ac6-8d5b-11f0-b7a7-005056abbe64;
	Tue, 09 Sep 2025 10:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=ABaNhTfjm9ufwf+oo9InMrhjyumkThBkkFuu9Ebtr0I=;
	b=msmpRVwKb8q1bH7zARLy0wnfqBOCUnupegqvG2rNUEuueNxYD9k8GdnWp+PIFuSwZns8OpLjLn6pv
	 YRb6lcW3LqZ5W+g2tH2KhQ41Tv5oYCB0XwIAhWcVeMUvRxsHqLNClz7tauENTcSpUZLv1EmcolYk5O
	 4P0gYlgkqJzmAlsM=
X-KPN-MID: 33|VphiFOXlTipkT0JoWJGLjYu5XpWg6m4Gz1g5mNFUe5YN2dsmEDHu8TgqD89feXd
 eDL5eswbPVrzDlLW9+aT3Ncg4XJKos/Ubev+NpPNXwOI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|JHdCORXGfB/M8j5nFTiFBT5xx+TjX7QPvqr3Ynebu/CeifWlzHNocsoAGi275bj
 wJIocKD9sh33taQch+R4T8g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id db80ffb3-8d5a-11f0-b448-005056ab7584;
	Tue, 09 Sep 2025 10:56:21 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Mario=20Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: [PATCH] sfdisk: (man) do not use the common 'include' for --help and --version
Date: Tue,  9 Sep 2025 10:56:09 +0200
Message-ID: <20250909085609.5049-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Anomalously, `sfdisk` uses -v for --version instead of the standard
uppercase -V.  In `sfdisk` -V means --verify.

This reverts commit 82d0bfe59a from last week.

CC: Mario Blättermann <mario.blaettermann@gmail.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/sfdisk.8.adoc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/disk-utils/sfdisk.8.adoc b/disk-utils/sfdisk.8.adoc
index 01bcfbfff..99849a638 100644
--- a/disk-utils/sfdisk.8.adoc
+++ b/disk-utils/sfdisk.8.adoc
@@ -239,7 +239,11 @@ Wipe filesystem, RAID and partition-table signatures from the device, in order t
 *-W*, *--wipe-partitions* _when_::
 Wipe filesystem, RAID and partition-table signatures from a newly created partition, in order to avoid possible collisions. The argument _when_ can be *auto*, *never* or *always*. When this option is not given, the default is *auto*, in which case signatures are wiped only when in interactive mode and after confirmation by user. In all cases detected signatures are reported by warning messages after a new partition is created. See also *wipefs*(8) command.
 
-include::man-common/help-version.adoc[]
+*-h*, *--help*::
+Display help text and exit.
+
+*-v*, *--version*::
+Display version and exit.
 
 == INPUT FORMATS
 
-- 
2.51.0

