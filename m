Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33321 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbcAGDM6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Jan 2016 22:12:58 -0500
Received: by mail-pa0-f54.google.com with SMTP id cy9so246911971pac.0
        for <util-linux@vger.kernel.org>; Wed, 06 Jan 2016 19:12:58 -0800 (PST)
Received: from localhost (external.asc-asia.com. [118.201.41.218])
        by smtp.gmail.com with ESMTPSA id xr8sm145624698pab.26.2016.01.06.19.12.56
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2016 19:12:57 -0800 (PST)
Date: Thu, 7 Jan 2016 11:12:55 +0800
From: Peter Hoeg <peter@hoeg.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/1] timer units should be WantedBy=timers.target
Message-ID: <20160107031255.GD22389@mildred.internal.asc-asia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline


---
 sys-utils/fstrim.timer | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/fstrim.timer b/sys-utils/fstrim.timer
index c8d94d7..3a3762d 100644
--- a/sys-utils/fstrim.timer
+++ b/sys-utils/fstrim.timer
@@ -8,4 +8,4 @@ AccuracySec=1h
 Persistent=true

 [Install]
-WantedBy=multi-user.target
+WantedBy=timers.target
--
2.6.4


--
Regards,
Peter

--7JfCtLOvnd9MIVvH
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-timer-units-should-be-WantedBy-timers.target.patch"

>From 7968237c037308a52a5a50bb9ed5edc84de6bb2e Mon Sep 17 00:00:00 2001
From: Peter Hoeg <peter@speartail.com>
Date: Thu, 7 Jan 2016 10:16:02 +0800
Subject: [PATCH 1/1] timer units should be WantedBy=timers.target

---
 sys-utils/fstrim.timer | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/fstrim.timer b/sys-utils/fstrim.timer
index c8d94d7..3a3762d 100644
--- a/sys-utils/fstrim.timer
+++ b/sys-utils/fstrim.timer
@@ -8,4 +8,4 @@ AccuracySec=1h
 Persistent=true
 
 [Install]
-WantedBy=multi-user.target
+WantedBy=timers.target
-- 
2.6.4


--7JfCtLOvnd9MIVvH--
