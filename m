Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62A2EB840
	for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335413; cv=none; b=leYvz8TRFtmJ1IilkqYY346gCdeK9bEcKFsWL3U5DY3wHxDa4FTne0rurYMzHSFUkLUUqc6dY15DcZ/danwhv+mgK6jARi1GUhuhXFwOMyW3X9WJ1qv/7FveTK0K0ji0ztGz53xZU33KOa0GNi7K1QrfCdHLVUwvvn2CIgebt7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335413; c=relaxed/simple;
	bh=i7Q0cppGHnXoJlzKDTPAA4Ox8F1xyo7tsBiGT/yZWUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmMkc7ghBL8IAri4ctkjmEnoqzOib107tO4+62/56h8e8HV8k4lLh1tpwxgKGo+d4BTjq5i2V/V/+uW6i1CwseSWPy6BDVV6ZCIQ4vu/ukOCb/bkA1jHJFofBhl4C0UHUym42Af8toZvMdJWsRu8sH8r6fnMWWQhulP+r0XNaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Hwam6yh+; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Hwam6yh+"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-644715aad1aso279100d50.0
        for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 12:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1768335410; x=1768940210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxakD1KmYQa92a3vZ7/OlBVuBUSn3nQs6Us3iV3sL6Y=;
        b=Hwam6yh+pF05hqzfKu0TuhGJGLYhBSjVPC6FWINo7k0J/IPSg3/lgBQEAPSnyMukeB
         sgFz0HM5E89y13JPankrblWGAWXyE9ycWQif9EIJEWLoevFfssnMcIFKQsvrp1CG++uK
         6Lry/CRqNthQR73KNRXeNLBgn+oA+dNgbMojghyqwIeNWN+1MgxFKpxCtnZ6LOAYwWvM
         mmMfv6wt96ebEGUGckz/7jrWz4s5G8EbkM9xPftCEfZWvR6aDy67Kl10vlG9kE4aosZw
         ehZkeUctbmwMU42oM2R1ANwpdBR525/2rAuKujlJJPJ8AefJ9bHNHurWTzJmZ5A6esKC
         2S2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768335410; x=1768940210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxakD1KmYQa92a3vZ7/OlBVuBUSn3nQs6Us3iV3sL6Y=;
        b=EgVhnup4WlhOWGLxUBdwmOYeq5e16vkGCGMopsLm8ZGDJBMy+o46UgKeGpJLNMXkeZ
         45SIBoEdW3XcK5Wkxb1/C5p5+JvwZG+sc4fdhv5Vie+b2RW9I951FOzCHxUk6XBIqloB
         6gJPnd2Vp55dUWtc9i1qj2pHzHUFekwr2aKPdTqKyZXKYNdFw/1dYw8A9APMi22lMaX6
         KbAS/hfCeleuGcykA4JvVbEZtTRCkvnwLfqv5BAY8H+N+9V5mvA0q16NigLS2oZYS4Ks
         pycRmQXM8qpYOnYJMYKO9EKCnFpE9otQyg07PkWvUdjXaBDlPaf2KceOsKN0NJtOFUv4
         Gx1Q==
X-Gm-Message-State: AOJu0YzywOCW11bTfIHD011nEVIfIutM6l44wyHbDRqAJfCDA2YQUJsP
	GrfjlCcL3nqxHL7meXct5thTYlfSluwDqhQ1B0dySCuXa6xwuMqSZZKpFnQ1HPtRcYFifxsRC3a
	MS7zr/yM=
X-Gm-Gg: AY/fxX7EmAQqLIUI/PzEJQEtVWKo/8ohWwIr8y3mIuUqxq2bJOhvfXjSioUWGqWgKoi
	xccDRnydi5kldsOfrtX3KBMLOZLgu51yWn/GJbhaBaVbDOAnmWoLGRsnuO6ROpJOkg7u4Uj7LHS
	g7u6an+u590xjLqnOe0Y9wvxa3nnqg4H/lZUCt16bEm7ssOWFDVLgeqr/dotukofXVUMiigjT4l
	2YZnhGFux9nkRubpapS8tZaALJea4H3KHfL88yGvR9rb6bdlYj5GJOfmYZI0C5nnhBCnnJmNRql
	AzmOKBOQbA4eR+jdX4B0vcLdlCreQyCUQZevwpgfZd3R8Nq/FGV2emIk0IqtIVgnUjp7QEp+OqL
	R+L9LAIOsGVWbv6HAGriSZUDDRGjFJjmznPC8aInUuyRp6qducbrNgMPLFLmffcHCcYfPVrWIhn
	nTKDxsCOGJ39DvD7wShaTMIxNxNK8CEtQTFnZK+wkykj7hGPeZynyUDqWcbVuqF4jq9A3XFPr6l
	SUYnBpLqyffex6A+hk=
X-Received: by 2002:a53:8543:0:b0:645:5297:3e5d with SMTP id 956f58d0204a3-648f638c88cmr2981073d50.46.1768335410350;
        Tue, 13 Jan 2026 12:16:50 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:cf4e:ea8f:19ac:63a0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d80be64sm9666151d50.6.2026.01.13.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:16:49 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: util-linux@vger.kernel.org,
	kzak@redhat.com
Cc: ceph-devel@vger.kernel.org,
	idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com,
	Pavan.Rallabhandi@ibm.com
Subject: [PATCH v2] mount: (manpage) add CephFS filesystem-specific manual page
Date: Tue, 13 Jan 2026 12:16:37 -0800
Message-ID: <20260113201636.993219-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Currently, manpage for generic mount tool doesn't contain
mentioning of CephFS kernel client filesystem-specific
manual page. This patch adds the mount.ceph(8) mentioning into
file system specific mount options section.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 sys-utils/mount.8.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 4571bd2bfd16..43d2ef9a58a4 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -853,6 +853,7 @@ This section lists options that are specific to particular filesystems. Where po
 |===
 |*Filesystem(s)* |*Manual page*
 |btrfs |*btrfs*(5)
+|cephfs |*mount.ceph*(8)
 |cifs |*mount.cifs*(8)
 |ext2, ext3, ext4 |*ext4*(5)
 |fuse |*fuse*(8)
-- 
2.52.0

