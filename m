Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754F6FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089568; cv=none; b=ZdoBYvv+XQ9Ur38w/L1OxRvEOpQFJPVXqIP515RMpej0XMyhvO2FH7GpVJDKyxQnX35Ry7cIEKaYjZjWlqEyu/cUwUuWhkFP0vjjpTW4WE7A5pZWwTpwjjNpahGIEytV7v/XU08bePaXpL1H04lq112yqb36/VIS+qIOzrH+R8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089568; c=relaxed/simple;
	bh=MoaXodKXRKA4cBvG9oIh91fTdutVlzWi2h8MR2SmEzA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ5Wyf4xjGCJ2t1TD8dAto2ZQmjtY/zalfIN7HF+MIt1Ls7Ls8RaZ7RWYGSA/DUapH7OV5PtK9t2ngS7KXXEwNKS+cZjs971ug5sBu7ZxJrUJ3xGE4mKgwHkmh9ouuGmzt8lT6RHfQZX0ICslKNydGGazfbaXjAFCoa5HdKwE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=EGlN4MeI; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="EGlN4MeI"
X-KPN-MessageId: dc7ee96f-e6bf-11ef-a841-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id dc7ee96f-e6bf-11ef-a841-005056ab378f;
	Sun, 09 Feb 2025 09:28:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=bX70NM4Ztw7YZM2SSqtP4arRZblqIFgmCeESayIwBcc=;
	b=EGlN4MeIqnGW3fjpBUR1Y/VxaK3/jKXrzB/sdlpRrpxLr2hKxJleVWLwrxibQoqSi9eNxeSMORFGV
	 d7zvDVdhUHC68LRJOlr4zqukg1bQg8ZUrQrp1pKtsOv72rOh50ut7KeCYohZrOq9SHuKPQ5a83Cr00
	 Oxqjda9AnFXxJMN4=
X-KPN-MID: 33|rehkrB4Wvz6diQ0vp6LDmiy36Nq/XD2p8A7CYU8JDVoluEutmBBqrBOthM+/9Km
 xYwcKzP4K/WHYz5QRZnkjKO3AbfQesdaup0LQpR/6CgI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|yX+UHjJi0KJ+E8ZDYOBYyv18A0TtYwd9wfAk53uPyU7yv5ztafAmuxoMmIquBU/
 CdmoIh7k7I6IihO9eyA0ccg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 80b1344d-e6bf-11ef-a31b-005056abf0db;
	Sun, 09 Feb 2025 09:26:04 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 12/14] man pages: use the same verb for --version as for --help, like in usages
Date: Sun,  9 Feb 2025 09:23:28 +0100
Message-ID: <20250209082330.4235-12-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
References: <20250209082330.4235-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, avoid duplication of --help/--version in the man page for `chfn`.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 login-utils/chfn.1.adoc      |  6 +++---
 login-utils/chsh.1.adoc      | 10 +++++-----
 man-common/help-version.adoc |  2 +-
 schedutils/coresched.1.adoc  |  6 +-----
 text-utils/col.1.adoc        |  2 +-
 5 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/login-utils/chfn.1.adoc b/login-utils/chfn.1.adoc
index 35a2e82cf..527c6806c 100644
--- a/login-utils/chfn.1.adoc
+++ b/login-utils/chfn.1.adoc
@@ -50,10 +50,10 @@ Specify your home phone number.
 Display help text and exit.
 
 *-V*, *--version*::
-Print version and exit. The short options *-V* have been used since version 2.39; old versions use
-deprecated *-v*.
+Display version and exit. (Short option *-V* is used since version 2.39;
+older versions used the now-deprecated *-v*).
 
-include::man-common/help-version.adoc[]
+// Do not include::man-common/help-version.adoc[]  as --help and --version are already given explicitly above.
 
 == CONFIG FILE ITEMS
 
diff --git a/login-utils/chsh.1.adoc b/login-utils/chsh.1.adoc
index 940ded5aa..e259b593f 100644
--- a/login-utils/chsh.1.adoc
+++ b/login-utils/chsh.1.adoc
@@ -37,14 +37,14 @@ Specify your login shell.
 Print the list of shells listed in _/etc/shells_ and exit.
 
 *-h*, *--help*::
-Display help text and exit. The short options *-h* have been used since version 2.30; old versions use
-deprecated *-u*.
+Display help text and exit. (Short option *-h* is used since version 2.30;
+older versions used the now-deprecated *-u*).
 
 *-V*, *--version*::
-Print version and exit. The short options *-V* have been used since version 2.39; old versions use
-deprecated *-v*.
+Display version and exit. (Short option *-V* is used since version 2.39;
+older versions used the now-deprecated *-v*).
 
-// Do not include::man-common/help-version.adoc[]  as both -h and -V were already explicitly given above in more detail. 
+// Do not include::man-common/help-version.adoc[]  as both -h and -V are already given explicitly above in more detail.
 
 == VALID SHELLS
 
diff --git a/man-common/help-version.adoc b/man-common/help-version.adoc
index 7a3c04fb9..8bce5760f 100644
--- a/man-common/help-version.adoc
+++ b/man-common/help-version.adoc
@@ -2,4 +2,4 @@
 Display help text and exit.
 
 *-V*, *--version*::
-Print version and exit.
+Display version and exit.
diff --git a/schedutils/coresched.1.adoc b/schedutils/coresched.1.adoc
index 8a9c28846..0d4c211f8 100644
--- a/schedutils/coresched.1.adoc
+++ b/schedutils/coresched.1.adoc
@@ -67,11 +67,7 @@ The type of the PID whose cookie will be modified. This can be one of three valu
 *-v*, *--verbose*::
 Show extra information when modifying cookies of tasks.
 
-*-h*, *--help*::
-Display help text and exit.
-
-*-V*, *--version*::
-Print version and exit.
+include::man-common/help-version.adoc[]
 
 == EXAMPLES
 Get the core scheduling cookie of the {command} task itself, usually inherited from its parent{colon}::
diff --git a/text-utils/col.1.adoc b/text-utils/col.1.adoc
index 46610f0c5..bc1913a91 100644
--- a/text-utils/col.1.adoc
+++ b/text-utils/col.1.adoc
@@ -81,7 +81,7 @@ Output multiple spaces instead of tabs.
 Display help text and exit.
 
 *-V*, *--version*::
-Print version and exit.
+Display version and exit.
 
 == CONFORMING TO
 
-- 
2.48.1

