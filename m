Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F64183CC3
	for <util-linux@vger.kernel.org>; Wed, 29 Oct 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735867; cv=none; b=A0sJbWziKcsoApieEYzwv41tsmITcVFI4CCPx0lhTqeJfXIrZlts60ANtRqG8vxlXlNZfurrbCyzcyvJkqcPkZQMZ0FgbERwLXUJWSsJAW8MzPhc9UAsox8cl5PSltqFPvH8qIdpLmiZJjB/R2Q8pw4UWYVaibqQN9gnMyOzOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735867; c=relaxed/simple;
	bh=rUBGebk0N3w4ZWtr3jBKSlQn3DsnKgUirjWwd7VicsE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IG1lu0PPgm6OSkh3GgI3o5NTLRFfxxUQw/g5CaRMFIs6K4DeIhRM83oihLDWJnArj0FoK7a76H8UgKMmvQRebKHLwIxO82jrT2wSzbrx5MVvIXsWsSNRODzFkSNchCH/C2/zP47s3ytSrjlR7tEgJ1M4QTRtQ74M89ioIL3PuWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=svcbq/Ti; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="svcbq/Ti"
X-KPN-MessageId: 4f6b020f-b4b7-11f0-a27d-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4f6b020f-b4b7-11f0-a27d-005056abbe64;
	Wed, 29 Oct 2025 12:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ncJW1/vDNVy6nBvhpvX/8mVVg9SW8QA/+ji6ks41bb0=;
	b=svcbq/TiqXnmKD7sIWNASsN//9A7VoUTsuOT6b1Qew5UmvLSQo1yWIhNfKadJWEDBb2C0G8A/lWp8
	 PUIHpJkR6NlA0B5yKRjf/ymGSC9cAzdTbu9wXmpYzCcH/IvVPPusSTOXOrIUu3czsr9V/+jOxMgeYG
	 A3KMYG5Fp22Imcl8=
X-KPN-MID: 33|HCQWe/Ds1879fvN2DL3WhWf6CDPIFeTLEgw/WkYR/EiLphcz9/8Vfnz7AszdHmh
 DWvaWwWNvUIIUHv2bJgLoesrxPCEqajhYnUyqHCmCWDc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nDKY1Sda7nWJAC69ogXdbei5zMFxAxmqxlYq0FJqoCwoc6to6a0FWgrexeMM/q9
 9KNmQwWdouw9gKU+GuvoDwA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 06980554-b4b7-11f0-a6c9-005056abf0db;
	Wed, 29 Oct 2025 12:04:23 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] losetup: (man) put the synopses in a better order, the name-giver first
Date: Wed, 29 Oct 2025 12:03:58 +0100
Message-ID: <20251029110358.18170-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029110358.18170-1-bensberg@telfort.nl>
References: <20251029110358.18170-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, condense the synopsis for setting up a loop device to just the
essentials -- it had become so long that it was incomprehensible.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/losetup.8.adoc | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/sys-utils/losetup.8.adoc b/sys-utils/losetup.8.adoc
index 131ebfa56..cecc09618 100644
--- a/sys-utils/losetup.8.adoc
+++ b/sys-utils/losetup.8.adoc
@@ -12,31 +12,27 @@ losetup - set up and control loop devices
 
 == SYNOPSIS
 
+Set up a loop device:
+
+*losetup* [options] *-f*|_loopdev file_
+
 Get info:
 
-*losetup* [_loopdev_]
-
-*losetup* *-l* [*-a*]
+*losetup* [*-l*] [*-a*|_loopdev_]
 
 *losetup* *-j* _file_ [*-o* _offset_]
 
-Detach a loop device:
-
-*losetup* *-d* _loopdev_ ...
-
-Detach all associated loop devices:
-
-*losetup* *-D*
-
-Set up a loop device:
-
-*losetup* [*-o* _offset_] [*--sizelimit* _size_] [*--sector-size* _size_] [*--loop-ref* _name_] [*-Pr*] [*--show*] *-f*|_loopdev file_
-
-Resize a loop device:
+Recalibrate the size of a loop device:
 
 *losetup* *-c* _loopdev_
 
-Remove a loop device:
+Detach loop devices:
+
+*losetup* *-d* _loopdev_ ...
+
+*losetup* *-D*
+
+Prevent loop devices from getting listed:
 
 *losetup* *--remove* _loopdev_ ...
 
-- 
2.51.2

