Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE022576E
	for <util-linux@vger.kernel.org>; Mon,  2 Jun 2025 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873705; cv=none; b=o8UC+vMP4B9v/a/rr8SW8v3vg0Dn9ewQ3m+1SJx816Ticq8oWd/3ZdGBFprHfLRwZjp/LsW/Im3LKjx+MaUchNkO+Kc1QCKRWXlP340ccxdGL1OOqUcIRTQG9QRueFcBjbksYNXyM+Xx0SKgVB/aNF7BgWIjhMbhOwhErJFiZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873705; c=relaxed/simple;
	bh=QSUusF922L/7a9eu1wEeledVJtx6ubb6Hk/Ae2Qe1I4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Awbnxn/K+oxOwke//CNzQbyQABglgJ0H+ZiAnsxr29dsPzPQJO/HXPpfVOXgjiVi/dBgDJDyBLMUPN/E3b9/3FjHPGNvgd9QIC9ZUm3bWmDZD1YFHV8Ij8bI89JoxOS1tDe9kzzg7boR9euxKi7s6qhv7MG7xH/qWnc3p/Eo5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=FjYYhgyo; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="FjYYhgyo"
X-KPN-MessageId: 16025053-3fbc-11f0-bc2c-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 16025053-3fbc-11f0-bc2c-005056ab378f;
	Mon, 02 Jun 2025 16:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=bKDDsX9Ka0ijvT1wrGLZt3Zhnm5dOTRoU5P18vyve0w=;
	b=FjYYhgyonmq+WZlBzwGu5FFyIHSSShD8+yviuCYCLx236TWWux1ats35mSAsobin/2UkipeEDUZ39
	 AmODjRKGUDwR+5BWr3Cpz4AyqxmgRUI/nLfajv2wmTPQZQy3te2i1e2oKKgD5zxUxx+uvOjYMQ0SeV
	 MH60thJeODiL/3EI=
X-KPN-MID: 33|k0/YY+q/r49NrqlWq7Cl9tFYjAOc0P5oKjQusmf5aXg+S4g9F3Rvdp5Dj520xAA
 sUdPAGFODwxT2GgJlgmnna2n6aQ9Wf6YYbzZ0+b4Ejdg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7sccfrBq7z8VPFI6xetVZJHUPL8PQXfc91hXy6MRxTQk45+FZ07K8D3JR3TOlrT
 1NWdlykHbgwsAR0i+iOgIFg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f5c01e7d-3fbb-11f0-95af-005056abf0db;
	Mon, 02 Jun 2025 16:14:56 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/6] correct the full name of the GPL in various files
Date: Mon,  2 Jun 2025 16:14:33 +0200
Message-ID: <20250602141436.11156-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250602141436.11156-1-bensberg@telfort.nl>
References: <20250602141436.11156-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last year, commit f4cb44bd11 corrected the full name of the GPL in
a dozen files, but still left the mistaken name in eight places.

(Also, in the first file, just reshuffle the license line, to be
in the same position as in other files.)

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/swaplabel.c | 7 +++----
 include/ismounted.h    | 4 ++--
 include/pager.h        | 3 ++-
 lib/ismounted.c        | 4 ++--
 lib/pager.c            | 4 ++--
 misc-utils/findfs.c    | 4 ++--
 misc-utils/uuidd.c     | 4 ++--
 misc-utils/uuidgen.c   | 4 ++--
 sys-utils/eject.1.adoc | 2 +-
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/disk-utils/swaplabel.c b/disk-utils/swaplabel.c
index 2c56e1501..29484ffe5 100644
--- a/disk-utils/swaplabel.c
+++ b/disk-utils/swaplabel.c
@@ -1,16 +1,15 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
+ * This file may be redistributed under the terms of the
+ * GNU General Public License version 2 or later.
+ *
  * swaplabel.c - Print or change the label / UUID of a swap partition
  *
  * Copyright (C) 2010 Jason Borden <jborden@bluehost.com>
  * Copyright (C) 2010 Karel Zak <kzak@redhat.com>
  *
  * Usage: swaplabel [-L label] [-U UUID] device
- *
- * This file may be redistributed under the terms of the GNU General Public License
- * version 2 or later.
- *
  */
 #include <stdio.h>
 #include <stddef.h>
diff --git a/include/ismounted.h b/include/ismounted.h
index 62b1d26b5..c95cbde84 100644
--- a/include/ismounted.h
+++ b/include/ismounted.h
@@ -1,8 +1,8 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
- * This file may be redistributed under the terms of the GNU Public
- * License.
+ * This file may be redistributed under the terms of the
+ * GNU General Public License.
  */
 #ifndef IS_MOUNTED_H
 #define IS_MOUNTED_H
diff --git a/include/pager.h b/include/pager.h
index e5ba4d721..2172177ee 100644
--- a/include/pager.h
+++ b/include/pager.h
@@ -1,7 +1,8 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
- * This file may be redistributed under the terms of the GNU General Public License.
+ * This file may be redistributed under the terms of the
+ * GNU General Public License.
  */
 #ifndef UTIL_LINUX_PAGER
 #define UTIL_LINUX_PAGER
diff --git a/lib/ismounted.c b/lib/ismounted.c
index 31be71a43..ae5327c90 100644
--- a/lib/ismounted.c
+++ b/lib/ismounted.c
@@ -3,8 +3,8 @@
  *
  * Copyright (C) 1995,1996,1997,1998,1999,2000,2008 Theodore Ts'o.
  *
- * This file may be redistributed under the terms of the GNU Public
- * License.
+ * This file may be redistributed under the terms of the
+ * GNU General Public License.
  */
 #include <stdio.h>
 #include <unistd.h>
diff --git a/lib/pager.c b/lib/pager.c
index 20002acda..c3b42d19e 100644
--- a/lib/pager.c
+++ b/lib/pager.c
@@ -1,8 +1,8 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
- * This file may be redistributed under the terms of the GNU Public
- * License.
+ * This file may be redistributed under the terms of the
+ * GNU General Public License.
  *
  * Based on linux-perf/git scm
  *
diff --git a/misc-utils/findfs.c b/misc-utils/findfs.c
index 7b32dbda3..801a60c32 100644
--- a/misc-utils/findfs.c
+++ b/misc-utils/findfs.c
@@ -1,8 +1,8 @@
 /*
  * Copyright (C) 2009 Karel Zak <kzak@redhat.com>
  *
- * This file may be redistributed under the terms of the GNU Public
- * License.
+ * This file may be redistributed under the terms of the
+ * GNU General Public License.
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 74e950307..95cf1a572 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -4,8 +4,8 @@
  * Copyright (C) 2007  Theodore Ts'o
  *
  * %Begin-Header%
- * This file may be redistributed under the terms of the GNU Public
- * License.
+ * This file may be redistributed under the terms of the
+ * GNU General Public License.
  * %End-Header%
  */
 
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 56dea3c71..6133cb0eb 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -4,8 +4,8 @@
  * Copyright (C) 1999, Andreas Dilger and Theodore Ts'o
  *
  * %Begin-Header%
- * This file may be redistributed under the terms of the GNU Public
- * License.
+ * This file may be redistributed under the terms of the
+ * GNU General Public License.
  * %End-Header%
  */
 
diff --git a/sys-utils/eject.1.adoc b/sys-utils/eject.1.adoc
index 1ee3b2137..6db040729 100644
--- a/sys-utils/eject.1.adoc
+++ b/sys-utils/eject.1.adoc
@@ -4,7 +4,7 @@ Copyright (C) 1994-2005 Jeff Tranter (tranter@pobox.com)
 Copyright (C) 2012 Karel Zak <kzak@redhat.com>.
 
 It may be distributed under the GNU General Public License, version 2, or
-any higher version. See section COPYING of the GNU Public license
+any higher version. See section COPYING of the GNU General Public license
 for conditions under which this file may be redistributed.
 ////
 = eject(1)
-- 
2.48.1

