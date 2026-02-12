Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92B344DA9
	for <util-linux@vger.kernel.org>; Thu, 12 Feb 2026 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895493; cv=none; b=bav+AFGV2FCD4pSije7SIdE6Qgjuwp4wxa+KnGK6Ahh+iJfJzazrYodDMG6kvpJOAa5uCuCK5ZWZ9ojpZW9S4jI67nvIurEfu5Q9nN5dSNYrNV1+VRcKDZ20vMv3AEnOAxLUIBDPfJG+CYGfz3/4yZXBQdyLICN4P7wCp6SJ5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895493; c=relaxed/simple;
	bh=li0bYZXTHKT/E4DAP5yY2ImJWfM0YPCIE4tVNJCTDBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I1I3LabDI3tPk8xbG+qpPuGciptROq6mJoxbGaXyf6aZhfCA8hqV7w+Z/DsOS9BDpOAKENS7j3gK1vaMel3c0bq0a5PeivAqoel/CGbnXWCv+j9ljmeQIu5ufM+6plgzjlyAddc6y+JFGuZYOM/qDO8xWAf/MP62f/a/7u60WiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4lpVL4B; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4lpVL4B"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359228b7c6so4224088f8f.2
        for <util-linux@vger.kernel.org>; Thu, 12 Feb 2026 03:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770895490; x=1771500290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CDww0ghEPSt05W6KRsP8gszutx15YW8onzCHsM500TM=;
        b=V4lpVL4B3qORT6ib5P1vxda+u1zEVr8L/IWrg5C+un+e97TBx7Dul2zInZtdBx/Ws+
         7UKLix1tVEE5Ny+EB9fstJte45lsKD5+c01gCbd5wEvAHDTD1RKi8BGbGqTI7FMPLiP3
         1OFwsVMWugiuZwBqYtG+qiWY243P3lp9xI+FtrCWpLsPOsjr0iCk+cS92Fn0+LbtMgcP
         mgGDoEEa0agBt/+v3HJCRt2crJ+tDylvtQOZ5FnmLn3VjpWcjNeW7hor+09oMPtUPm1V
         LbBs1/51y53AaD02MS1Ts+B+Nm96ZrRJiCzAfPspNvBJEBitYHfaz86cFCxnP0922fLx
         5SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770895490; x=1771500290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDww0ghEPSt05W6KRsP8gszutx15YW8onzCHsM500TM=;
        b=E/ZriUZzOZlgylCyQ6mfUa7aaVVOyNyseV3eT1+YdVdWHSQqUH/GNfAmrTwXA1FwAv
         e9xqPdhRgfnc/kHKy95TITgB5+NAuCu52fVM0CkBvyB6hNDqh/FRSpit36PVo822tzKR
         idpOOxvyehme0z2ijQWG4CNNDg27zY4co0xQBi6lavLVqrPdmjDvmE/WFGFPik4APpD8
         PCe+SaGtf3Xpji8NNq00TpwRUG4nadIxYKd8T3WUrbEUg6Q5nnkE9nY2vtKihXbFgZI0
         7pb/9rV8HGTcRSioLZs6IcX/NzX8K7f6oU5L6EcOfFvVVgwbGNfB1pwDUpCaj/cIA7uF
         sPuQ==
X-Gm-Message-State: AOJu0YwDDGEaPjEbGoli5VZXjVSZ1PaSAtIgMbMI30pGsUMNkio9PQhD
	/fEKy9N4vLTOAawV0zAry8U9ZOMVmVB2jGHD+Gh2aqEY4ly9tqw39e2JOYIaHcio5HY=
X-Gm-Gg: AZuq6aKJr5tpF+j/a6iSaLE1zpPu2V82wwe5LIzYPggPGwT0wgmRwjMmgZW3nKyooJp
	ILReL1lWxrJNkv0DXCRmiD+7VG4MhNQWnAVet8Xo/6WtH3pzHRN92zUrKiBSTR5e5dGrSVKOz7x
	6ZA9IuHeeXSpTcPOnGSzzewvqrTInol8V6ZAgGDlEOeUVSWs0CH/4EUvH4N+1qzrmumbxvYT3bm
	h3xPFgQB9r7JwvGzbRFOlwTNJRIuPBQRAxd2JHZjq0Ezbc1lPpTeoDwuf68o8cAbk4TeLyBO5E3
	aWboBNyU33t78T5e+IVS9NNF9D2eEi0yQJL7muKsyKqAf7cFakmH6tSQQ5byLu/LhqoWt04aKuR
	zeE24joywrmqPmhW7lKsEvxFPdldOCCoc1T4etB+c3KK1K/RcSuC6liH6OcCi2Uby3Sejkm6lpQ
	QfpyNEhyyMUQUs0QNCNw1JpqXqX5IgtTtKl9E=
X-Received: by 2002:a5d:5f54:0:b0:435:b755:c67e with SMTP id ffacd0b85a97d-4378ad5f6c6mr3771320f8f.49.1770895490327;
        Thu, 12 Feb 2026 03:24:50 -0800 (PST)
Received: from system.. ([178.131.176.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e5c550sm12286040f8f.36.2026.02.12.03.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:24:50 -0800 (PST)
From: sina-abroshan <sina.abroshan@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	sina-abroshan <sina.abroshan@gmail.com>
Subject: [PATCH] lsblk: improve error reporting for invalid device paths
Date: Thu, 12 Feb 2026 14:54:23 +0330
Message-Id: <20260212112423.2400888-1-sina.abroshan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Differentiate stat() failures from non-block-device cases,
so users get accurate errno-based error messages.

Signed-off-by: sina-abroshan <sina.abroshan@gmail.com>
---
 misc-utils/lsblk.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 3d2bc21a6..4a0d7c70e 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1793,14 +1793,20 @@ static int __process_one_device(struct lsblk_devtree *tr, char *devname, dev_t d
 	int real_part = 0, rc = -EINVAL;
 
 	if (devno == 0 && devname) {
-		struct stat st;
+    	struct stat st;
 
-		DBG(DEV, ul_debug("%s: reading alone device", devname));
+    	DBG(DEV, ul_debug("%s: reading alone device", devname));
 
-		if (stat(devname, &st) || !S_ISBLK(st.st_mode)) {
+		if (stat(devname, &st) != 0) {
+			warn(_("%s"), devname);
+			goto leave;
+		}
+
+		if (!S_ISBLK(st.st_mode)) {
 			warnx(_("%s: not a block device"), devname);
 			goto leave;
 		}
+
 		devno = st.st_rdev;
 	} else if (devno) {
 		DBG(DEV, ul_debug("%d:%d: reading alone device", major(devno), minor(devno)));
-- 
2.34.1

