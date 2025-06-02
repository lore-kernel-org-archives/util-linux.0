Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242920F07C
	for <util-linux@vger.kernel.org>; Mon,  2 Jun 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873699; cv=none; b=m136Grlvuz3g59nq5Uz2ziVq4RydY10F+ehGntkkh+77nBrJfbXlDeC4jy1RVq/a2aBmY3JCkdlMoDSatsOKpO+tq2rBFXIpwvrNuvmflppQxRSUSdOPzSCY8xAcjX+rVZjYVKKDflDkz97SCUIgd1kGNMQbxr9Qij0OZYkKl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873699; c=relaxed/simple;
	bh=vWg0BUrms1qjc73NJZAXsUOzMK7yKvpA/1NOD63Zoxk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE88fn0NlINlqApQXPIjRpE0fkTPsWu8nUQ6h2Giqnilok43fD6ajWqejtfWj8dH1u6DG8SkK8lwV6bExRLHGmDAzT+lrBA3ajWQ837jfo7g0+llXaouV0bCshU3w3OREfNz8bb5aRaHV9CwGv9b702ZO4XPG0MI00nFkbv4Z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=qssL6Uu1; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="qssL6Uu1"
X-KPN-MessageId: 14d8091e-3fbc-11f0-86cf-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 14d8091e-3fbc-11f0-86cf-005056aba152;
	Mon, 02 Jun 2025 16:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Wa1lDYNh7yfBEY1FAnxyfLHNctwmCPkecIbI1u80xnk=;
	b=qssL6Uu1yscEJBZGu6g6HtyGqtq1+Bc0DC4uMUg9dUz8tiODnSkUppjfY1LnnaH3y6ckXAgaf69s7
	 3kt9CIuoXMG4JZw933XrCT4fjxajujNZeTxIz/kOWs38L4Nn5pycUvCTacL4JlTkHrAVkW3VwgmQXT
	 pJxSLT2kcQCK7zVo=
X-KPN-MID: 33|LWkInltaZaSG4qOSyMQHqn2JmWgxO4GqBt28aTQilImC5tjKMfsRjDfjg5LCc2U
 iSYOsUJAKxxkHwhUwR+L/gyntAI4MvuHHSYx6MTOZFBM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kkLqDIPXYTraYampo7wGtn4BUlhuTa5aBfopb4d9GwYjYtAq+ymuiAscVPC2P6z
 WWDSD3x7vum16zZm0C1To1g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f1ab9e8f-3fbb-11f0-9bf3-005056ab1411;
	Mon, 02 Jun 2025 16:14:49 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/6] remove "Copyright (C) ...." notes from files that claim no copyright
Date: Mon,  2 Jun 2025 16:14:32 +0200
Message-ID: <20250602141436.11156-2-bensberg@telfort.nl>
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

Replace them with a "Written by" or "Authors:" label.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 include/color-names.h | 2 +-
 include/procfs.h      | 2 +-
 include/sysfs.h       | 2 +-
 lib/color-names.c     | 2 +-
 lib/langinfo.c        | 8 ++++----
 lib/mangle.c          | 2 +-
 lib/path.c            | 2 +-
 lib/procfs.c          | 2 +-
 lib/strutils.c        | 6 +++---
 lib/sysfs.c           | 2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/color-names.h b/include/color-names.h
index d6a5267b2..af8e075d5 100644
--- a/include/color-names.h
+++ b/include/color-names.h
@@ -2,7 +2,7 @@
  * No copyright is claimed.  This code is in the public domain; do with
  * it what you wish.
  *
- * Copyright (C) 2012-2015 Karel Zak <kzak@redhat.com>
+ * Written by Karel Zak <kzak@redhat.com> [2012]
  */
 #ifndef UTIL_LINUX_COLOR_NAMES_H
 #define UTIL_LINUX_COLOR_NAMES_H
diff --git a/include/procfs.h b/include/procfs.h
index fdfe1455b..d90146fc5 100644
--- a/include/procfs.h
+++ b/include/procfs.h
@@ -2,7 +2,7 @@
  * No copyright is claimed.  This code is in the public domain; do with
  * it what you wish.
  *
- * Copyright (C) 2021 Karel Zak <kzak@redhat.com>
+ * Written by Karel Zak <kzak@redhat.com> [2021]
  */
 #ifndef UTIL_LINUX_PROCFS_H
 #define UTIL_LINUX_PROCFS_H
diff --git a/include/sysfs.h b/include/sysfs.h
index 8d77f7579..758340702 100644
--- a/include/sysfs.h
+++ b/include/sysfs.h
@@ -2,7 +2,7 @@
  * No copyright is claimed.  This code is in the public domain; do with
  * it what you wish.
  *
- * Copyright (C) 2011 Karel Zak <kzak@redhat.com>
+ * Written by Karel Zak <kzak@redhat.com> [2011]
  */
 #ifndef UTIL_LINUX_SYSFS_H
 #define UTIL_LINUX_SYSFS_H
diff --git a/lib/color-names.c b/lib/color-names.c
index fa5453c6b..ec53e3d47 100644
--- a/lib/color-names.c
+++ b/lib/color-names.c
@@ -2,7 +2,7 @@
  * No copyright is claimed.  This code is in the public domain; do with
  * it what you wish.
  *
- * Copyright (C) 2012-2015 Karel Zak <kzak@redhat.com>
+ * Written by Karel Zak <kzak@redhat.com> [2012]
  */
 #include "c.h"
 #include "color-names.h"
diff --git a/lib/langinfo.c b/lib/langinfo.c
index a20008546..8a5af8e55 100644
--- a/lib/langinfo.c
+++ b/lib/langinfo.c
@@ -1,13 +1,13 @@
 /*
- * This is callback solution for systems without nl_langinfo(), this function
- * returns hardcoded and on locale setting indepndent value.
+ * This is a fallback solution for systems without nl_langinfo().  This
+ * function returns a hardcoded value, independent from locale settings.
  *
- * See langinfo.h man page for more details.
+ * See `man langinfo.h` for more details.
  *
  * No copyright is claimed.  This code is in the public domain; do with
  * it what you wish.
  *
- * Copyright (C) 2010 Karel Zak <kzak@redhat.com>
+ * Written by Karel Zak <kzak@redhat.com> [2010]
  */
 #include "nls.h"
 
diff --git a/lib/mangle.c b/lib/mangle.c
index 2d31943cb..4c505bce7 100644
--- a/lib/mangle.c
+++ b/lib/mangle.c
@@ -4,7 +4,7 @@
  * No copyright is claimed.  This code is in the public domain; do with
  * it what you wish.
  *
- * Copyright (C) 2010 Karel Zak <kzak@redhat.com>
+ * Written by Karel Zak <kzak@redhat.com> [2010]
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/lib/path.c b/lib/path.c
index 42a33ffc5..48324d6dc 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -2,7 +2,7 @@
  * No copyright is claimed.  This code is in the public domain; do with
  * it what you wish.
  *
- * Copyright (C) 2018 Karel Zak <kzak@redhat.com>
+ * Written by Karel Zak <kzak@redhat.com> [2018]
  *
  *
  * Simple functions to access files. Paths can be globally prefixed to read
diff --git a/lib/procfs.c b/lib/procfs.c
index 136ec7c05..5dab11b88 100644
--- a/lib/procfs.c
+++ b/lib/procfs.c
@@ -2,7 +2,7 @@
  * No copyright is claimed.  This code is in the public domain; do with
  * it what you wish.
  *
- * Copyright (C) 2021 Karel Zak <kzak@redhat.com>
+ * Written by Karel Zak <kzak@redhat.com> [2021]
  */
 #include <ctype.h>
 #include <unistd.h>
diff --git a/lib/strutils.c b/lib/strutils.c
index 64fefa878..de0be7596 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -1,9 +1,9 @@
 /*
- * Copyright (C) 2010 Karel Zak <kzak@redhat.com>
- * Copyright (C) 2010 Davidlohr Bueso <dave@gnu.org>
- *
  * No copyright is claimed.  This code is in the public domain; do with
  * it what you wish.
+ *
+ * Authors: Karel Zak <kzak@redhat.com> [2010]
+ *          Davidlohr Bueso <dave@gnu.org> [2010]
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 0a016be97..951de6332 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -2,7 +2,7 @@
  * No copyright is claimed.  This code is in the public domain; do with
  * it what you wish.
  *
- * Copyright (C) 2011 Karel Zak <kzak@redhat.com>
+ * Written by Karel Zak <kzak@redhat.com> [2011]
  */
 #include <ctype.h>
 #include <libgen.h>
-- 
2.48.1

