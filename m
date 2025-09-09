Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D023C4FD
	for <util-linux@vger.kernel.org>; Tue,  9 Sep 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430815; cv=none; b=n+4ND/nQTuM4mmfepQ4KB204dM2iR/jZTUyRAPasObdNM2uBpFcFbtqbmPjUu5xN4uFnremJf+Qj8ZzGFJhu1e6+3OnKO7AzplN0dqXj68jc5SeHlIZYZ0khiaysJf2rv46AbqmClGAefPOz01LxkvipV03AipdXCFdJeTxK6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430815; c=relaxed/simple;
	bh=kynGoDBIu/+eaxPUvF6Lzi8Vh5BvS5MZIGDmZ+7jazQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQ74uXWbATCgkhNw/hAuoVKSrBNjID6ZJVmjY9LP+Xi6HgnpOJUe87GTajrElHoJr+wBOJStAZHMjR3zMBZBunL7I0ulIVPVicfsnHq9A+3AB0VxFfH9FgJD8nSYDewis0o8prNVEKg/B0Y5mCFWmnX9/m9Hk1eN5+nESVz7Ggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=b1LnCCb7; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="b1LnCCb7"
X-KPN-MessageId: 8ed9f5f8-8d8f-11f0-80eb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8ed9f5f8-8d8f-11f0-80eb-005056aba152;
	Tue, 09 Sep 2025 17:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=9yCSTwEfcwNYdkLv22D383MBfSKmEiNmCGdYefUmdOg=;
	b=b1LnCCb76xIR+RJxIbg5/pTe1nb1pUUgekptrvu0+523ydWjI7Gk+ju22eLnqgVTz9FuSp3gAA+eT
	 rELrRUiqtXMqtmKnvQa19iZtIyaZ3pOpT022ezEDx5+4gXYVsUVtgtJ0RAUQP1TCKeFsfVuWnlKDPM
	 pHrD2l43SdlYoSvk=
X-KPN-MID: 33|wHDUhCX/oKTR2dYPA/VeWsfn4qis3h6Y1+urKLR3jeHzQ8XB7hFayEsOh1p5/8F
 kamDmsOojLOakhYa/gWXhzB4n6QHILyW/i5wnZ78TNhg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|FLb0sRBqhO+5OkbMUfv0BmGVZaKjw6XdEr87e0MQCAAEUlCPrr0UcyRAiU7Ln/W
 8Yj23qBAlNWYO+ruFD9j/1Q==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 62d9f286-8d8f-11f0-abc8-005056abf0db;
	Tue, 09 Sep 2025 17:12:22 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Mario=20Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: [PATCH V2] sfdisk: (man) do not use the common 'include' for --help and --version
Date: Tue,  9 Sep 2025 17:12:08 +0200
Message-ID: <20250909151208.81179-1-bensberg@telfort.nl>
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

This effectively reverts commit 82d0bfe59a from last week, and
adds a comment to try and prevent the mistake in the future.

CC: Mario Blättermann <mario.blaettermann@gmail.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/sfdisk.8.adoc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/disk-utils/sfdisk.8.adoc b/disk-utils/sfdisk.8.adoc
index 01bcfbfff..7d5db422e 100644
--- a/disk-utils/sfdisk.8.adoc
+++ b/disk-utils/sfdisk.8.adoc
@@ -239,7 +239,13 @@ Wipe filesystem, RAID and partition-table signatures from the device, in order t
 *-W*, *--wipe-partitions* _when_::
 Wipe filesystem, RAID and partition-table signatures from a newly created partition, in order to avoid possible collisions. The argument _when_ can be *auto*, *never* or *always*. When this option is not given, the default is *auto*, in which case signatures are wiped only when in interactive mode and after confirmation by user. In all cases detected signatures are reported by warning messages after a new partition is created. See also *wipefs*(8) command.
 
-include::man-common/help-version.adoc[]
+*-h*, *--help*::
+Display help text and exit.
+
+*-v*, *--version*::
+Display version and exit.
+
+// Do not include::man-common/help-version.adoc[], as -V is not --version.
 
 == INPUT FORMATS
 
-- 
2.51.0

