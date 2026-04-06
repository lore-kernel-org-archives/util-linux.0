Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029735893
	for <util-linux@vger.kernel.org>; Mon,  6 Apr 2026 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775438364; cv=pass; b=WOo7pAgTmLqQjGEQ93gbwrLrmtDbDaEhQEFaB71HuwhfvK1TUQQtEPXF4tVc9KuDDFct7ZUVcbJ46xTUJi+NyBaFxi7HydDVPBE7gbHaTdWe/1uG7wklbm9IVncdV+EnVBXIxIqcSrrBltlq1sC67Lx5IGAkihpOaCok7frjsoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775438364; c=relaxed/simple;
	bh=iV6awCLhdOy2Xa4sGsD2NjX6XGXUrnRDHeI9t6MZvs0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dWb6/u1dDYKyuiRxl9l9kwLx3cWYhCvKukNTsfQExvUAO9UhUSR1yG42e9LzpQDNX8MME83757Lf9uBdjMBtviYqIFpds5+2hJuUIdKTudiPHh6PIcFzkGLFXEmVWUrnsF86ld1firz15rtw5k14aKc8yUOxRwQHjXBtG0/EPkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=numin.it; spf=none smtp.mailfrom=numin.it; dkim=pass (2048-bit key) header.d=numin-it.20251104.gappssmtp.com header.i=@numin-it.20251104.gappssmtp.com header.b=JCq2txIG; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=numin.it
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=numin.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=numin-it.20251104.gappssmtp.com header.i=@numin-it.20251104.gappssmtp.com header.b="JCq2txIG"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c0b72daf7so1401084c88.0
        for <util-linux@vger.kernel.org>; Sun, 05 Apr 2026 18:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775438361; cv=none;
        d=google.com; s=arc-20240605;
        b=fbfD+/0hqY2ZCvno+7oyrckm29nXwWkxjct2rKLkdnmWfMvP6w05vG5MHUz5mA0aBF
         VFHlU2TopMxBjfnfjfBypGh/FufC4v/yoxpEUjIyryfNccaJ+u2sUn6hAweK5QnwzFtS
         Z3bX2ZowcP3hxhJe8G+ndzTykSmDgOklByQRmr8I0B/abAniqDW8FzzmQgADjfrkIH7L
         Cr9PsPdVRnJqJVD8vjVGjqMFmiScHo+dp6sqi4uY30iVSuUY5Wv2bxZJZTUv9DTWLn4R
         GboffHcU6hCGglPTR88GnaJ+6fq3Z5sTkIom1GjHvm5XBW1csLCltTBwxJyspYznXjxI
         X/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7NATwbc3c9yTSBmyR9rrG5gOLsCYIvBd/KAf9xL/puo=;
        fh=wGiqS6fCIXmTY01ukAaQ0f8K0pJvn/8Cx9cBD0x5bgc=;
        b=V3haOtZmNYzCoNCq5JRtsgb7XiCISnM9ai+yAiAuheViNMKTyacW75xjjblY5UrRA3
         NzX6axZmh2rmfFBgeboXbgi15/sbQsVrb3jjxREolDmO+qJWuJY2rELxzq0D99EG/TaG
         LNicTK6eYvxzAkC9hQbLYrDKPPlHVIMZuZGSVC49uKg2a7UC1fS2TwYBJxg+EvKD8dwd
         E2zS/cnjlPEjp3vCUxM58hByrtNMSaDwnP46+JIrycTqJuqIgitw0Hd7JLR/mtnMpmeE
         TCY0wFfs8D52vZJ37nGQYv8/3WYhbAV6XBvAVV+e1NGUpOtbhJuItV4o9eNpxOHYt1WX
         +QTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=numin-it.20251104.gappssmtp.com; s=20251104; t=1775438361; x=1776043161; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7NATwbc3c9yTSBmyR9rrG5gOLsCYIvBd/KAf9xL/puo=;
        b=JCq2txIGGYePhgytJJmONdVLM+mhG1WByXMNomXzG2kgcN08Mh+1JUPpjk5IcWmyv3
         jCA/s1YWD5uvXMzsHNEWaDokSfdkjZuSuxTLs/4/cS9589ZQAkxj4uukr/X7kepVU9+u
         kGQ//vARLJvNEH61paV7SO5+GDoLq307mMeiKgWqIWVQrTVYzvHqaIkVVgX08GO3sa+b
         1KJFMnV0Z+IsCBrf1NKZh8CjxeDozmAuB9ryoxW5cY8m76yh/A6RA77Gy9yW6ZyF1DT2
         xy4SWnExqdQaI+lvnab/FGkn6I4psLLVZ99sXxpranECoUyE/GGZ4VAhF3UagqP8ITh+
         ptDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775438361; x=1776043161;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NATwbc3c9yTSBmyR9rrG5gOLsCYIvBd/KAf9xL/puo=;
        b=jVu4m4x6qXhdEr/OJIRiM+YEiwnywUX4wUBZ7o7Pubm5X3qL3bwlPLWoxBtBPtWCoA
         dZWKrt6GHQIJD+Rz7XadAQUCCdfCdY+Qvk0LLRG9sUuZcqB1z0WDU/j7Hvl4qldN62bM
         9EaXoI47lN78x7vor11Xy7E8dURt3DCYQqf4pelfEooJl48vvs6CNAvHqWH5ve+oRnZJ
         akwbKcF3MRIWOdoC/hpm3IOjnJ/eSwu4hZZL5Nlr8+F78xKKfuhq3jz6tnEbhQh9c8Z1
         bVV8DeC5EgRRZ0IRe4yxtjrcGX4KHGEGr+X6JdutrF7M7zIPZTQFUOEOP9bIvVVck3JO
         GVGg==
X-Gm-Message-State: AOJu0YxWS0d8Xiim68bm60ft0dlnqrAQDUPTzxXZ3WW3qP8/k1WUmA3B
	pOYqcJgL22flzIsJ+YLXUE4MqHSJDU4l2a7wlXdh8YErH2jM+/ALT2w1Pc2q7kC5S1cy/v77B1s
	bsJAdWIwFqsw9d9G9OdnyVAAVXv+zVN50kZN7KQSsIA+4B7ieArc606M=
X-Gm-Gg: AeBDietacTdu1kXa8lz2omQh+p4kVS15m+3uRDMhja31LshQ/8hleQb5mR2C6gDLYiF
	ZPbpbY9vphoNgy98ZlToOjv6dQlS2bLITIR69Nm+ZKrBJ+mxFS04WiilZwtE6AxWVt0pVgSCRhV
	6p7VqAvc2N83KCHNQRA+OShv3r+/2wHhShcgihdTgKOQwz3fofE9OIMeWAmIvBeJ3oTC/klGXAO
	0ItdR5tYj+nJnaDjM3snDIli3FZT+DoXbh78+FjeUjKuo5kiRcXEcz1lUIxdxCUUTe96vmTJUKQ
	WP2kAmA2PTSueYdfjY7r2J4WSIcP4Mdn9Tt3QyB2wAh1bK1pwqnit/Pk4roTmYCC1GhBBxjpYah
	JRTc=
X-Received: by 2002:a05:7300:3252:b0:2c5:b23e:48a5 with SMTP id
 5a478bee46e88-2cbf99ecbebmr5230926eec.1.1775438361272; Sun, 05 Apr 2026
 18:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Morgan <me@numin.it>
Date: Sun, 5 Apr 2026 18:18:29 -0700
X-Gm-Features: AQROBzC8KmvNJA5-QBbZQtKlb0G0Y5qM5tUaZikLt-z9cijR-OQtgL_FcY5uKnc
Message-ID: <CAEUYr6ZjVX1bd-xcBGtFN_ZYwQnXDYsw7d1-7sTpF2BbgfrR+g@mail.gmail.com>
Subject: [PATCH] pidfd-utils: include correct struct statfs header for darwin
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 145b6a66dcc725de3c3161db62db7047eb407214 Mon Sep 17 00:00:00 2001
From: Morgan Jones <me@numin.it>
Date: Sun, 5 Apr 2026 18:03:54 -0700
Subject: [PATCH] pidfd-utils: include correct struct statfs header for darwin

Fixes the build on Darwin since struct statfs is in sys/mount.h
and sys/vfs.h doesn't even exist. Just conditionally include all the
headers.
---
include/statfs_magic.h | 16 ++++++++++++++++
lib/pidfd-utils.c      |  3 ---
2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/statfs_magic.h b/include/statfs_magic.h
index 6921abaa4..28977f392 100644
--- a/include/statfs_magic.h
+++ b/include/statfs_magic.h
@@ -5,10 +5,26 @@
#ifndef UTIL_LINUX_STATFS_MAGIC_H
#define UTIL_LINUX_STATFS_MAGIC_H

+#ifdef HAVE_SYS_TYPES_H
+# include <sys/types.h>
+#endif
+
+#ifdef HAVE_SYS_STAT_H
+# include <sys/stat.h>
+#endif
+
#ifdef HAVE_SYS_STATFS_H
# include <sys/statfs.h>
#endif

+#ifdef HAVE_SYS_VFS_H
+# include <sys/vfs.h>
+#endif
+
+#ifdef HAVE_SYS_MOUNT_H
+# include <sys/mount.h>
+#endif
+
/*
 * If possible then don't depend on internal libc __SWORD_TYPE type.
 */
diff --git a/lib/pidfd-utils.c b/lib/pidfd-utils.c
index a83735920..f7c649144 100644
--- a/lib/pidfd-utils.c
+++ b/lib/pidfd-utils.c
@@ -5,9 +5,6 @@
 * Authors: Christian Goeschel Ndjomouo <cgoesc2@wgu.edu> [2025]
 */
#include <stdlib.h>
-#include <sys/stat.h>
-#include <sys/vfs.h>
-#include <sys/types.h>
#include <errno.h>
#include <err.h>

--
2.50.1
