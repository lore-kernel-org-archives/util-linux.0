Received: from m239-4.eu.mailgun.net (m239-4.eu.mailgun.net [185.250.239.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1C195811
	for <util-linux@vger.kernel.org>; Sun, 23 Nov 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.239.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763911985; cv=none; b=FvjVK4kJUnkaQQjr4RrahgPjJgSqaIxdME8iuhZXxiLjTZgp2BBZkn36lQHrboy9rEuUfE19XRxr8PiAbWk3G8cs+UQi7PlTBt5tjHGpj4QMzues+RRGoLiP3g5AosKjIgnbUUHnh6M8id7NPRJxsUgCUtYNJUUkIttO1JWxzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763911985; c=relaxed/simple;
	bh=Epl5uJccM38RLtLmekH8o30c5BDP7Kvy3vPyJwR1FMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P01GsqgP4KN5Wwg4KZEEttfapdi45oia519wb7rVoCmLFS/ZaIH3rsmb63gaCc0EZHogV64vZDpM4x6bBKCXsPUwnPNr8wOHMk61lWYzDpDvq7pCETwg5oc9mF/M7JbcW7w8+/EpzN8TxRhVRFlu6DccnauhOMJxgBPm0G6bd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=fPUpiEet; arc=none smtp.client-ip=185.250.239.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="fPUpiEet"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1763911981; x=1763919181;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=PW6Ue8er6LTzCpJmgf3fcLre/UvrU0YVQOAE337PPE8=;
 b=fPUpiEetVG5lPR9uL7toLSoT2uOEWRWiH2iWpsJiPxltQSCABywrEXCNU1hM8VxbN30OZq+8vlyqDRmJdvHW8F6d3pRv4iKJ/dAa0fnt2TDBBn5tc7bgkHbw6BT2pAvM3Ca3hPTelxOViKVPjex931aMfe0EA3PFRjUjOaKlyjYmda2Sx4DVhMQoF3DgKqtCMhPPTfWBec1Wyfj4+DtQZfYh4ng95JIgSWy3KZHjH/Nqwm/IZErWq/0k1tCILDgFbtpvrC+X4UDenNqNpAt1qVFfXgTf8HY31Zekb91VvmtuOo6cBHlVepWFLc+UfCxvgvY5olAw4ryXbC5cFaVlQQ==
X-Mailgun-Sid: WyJlNDM3YyIsInV0aWwtbGludXhAdmdlci5rZXJuZWwub3JnIiwiNTRlZjQiXQ==
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 7cb349a42b1b1f1259b38414f775f2c20b6e7347a6127f8df26891016837968f with SMTP id
 6923292dced19bbbbb7bfb04; Sun, 23 Nov 2025 15:33:01 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	thomas@t-8ch.de,
	Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH 1/3] lib: introduce ul_default_shell() for consistent shell resolution
Date: Sun, 23 Nov 2025 16:32:44 +0100
Message-ID: <20251123153246.1056874-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251123153246.1056874-1-alessandro@0x65c.net>
References: <20251123153246.1056874-1-alessandro@0x65c.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new ul_default_shell() function to provide consistent shell
resolution across util-linux tools. The function follows a priority
order: $SHELL environment variable, user's shell from passwd database,
and finally _PATH_BSHELL as fallback.

The function supports flags to control its behavior:
- UL_SHELL_NOENV: skip $SHELL environment variable check
- UL_SHELL_NOPWD: skip passwd database lookup

This addresses the issue where tools like script(1) would default to
/bin/sh without respecting the user's configured shell, potentially
causing data loss.

Addresses: https://github.com/util-linux/util-linux/issues/3865
Suggested-by: Karel Zak <kzak@redhat.com>
Suggested-by: Thomas Weißschuh <thomas@t-8ch.de>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 include/shells.h  |  6 ++++++
 lib/Makemodule.am |  1 +
 lib/shells.c      | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/shells.h b/include/shells.h
index c770a13ba..eca2b4187 100644
--- a/include/shells.h
+++ b/include/shells.h
@@ -4,7 +4,13 @@
 #ifndef UTIL_LINUX_SHELLS_H
 #define UTIL_LINUX_SHELLS_H
 
+#define UL_SHELL_NOENV  (1 << 0)
+#define UL_SHELL_NOPWD  (1 << 1)
+
 extern void print_shells(FILE *out, const char *format);
 extern int is_known_shell(const char *shell_name);
 
+struct passwd;
+const char *ul_default_shell(int flags, const struct passwd *pw);
+
 #endif /* UTIL_LINUX_SHELLS_H */
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index a9da57734..1d598faa2 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -49,6 +49,7 @@ libcommon_la_SOURCES = \
 if LINUX
 libcommon_la_SOURCES += \
 	lib/linux_version.c \
+	lib/shells.c \
 	lib/loopdev.c
 endif
 
diff --git a/lib/shells.c b/lib/shells.c
index 13f293c5e..ef2aecd0f 100644
--- a/lib/shells.c
+++ b/lib/shells.c
@@ -1,6 +1,11 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
+#include <sys/types.h>
+#include <pwd.h>
+#include <stdlib.h>
+#include <paths.h>
+#include <unistd.h>
 #include <sys/syslog.h>
 #if defined (HAVE_LIBECONF) && defined (USE_VENDORDIR)
 #include <libeconf.h>
@@ -116,3 +121,24 @@ extern int is_known_shell(const char *shell_name)
 #endif
 	return ret;
 }
+
+const char *ul_default_shell(int flags, const struct passwd *pw)
+{
+	const char *shell = NULL;
+
+	if (!(flags & UL_SHELL_NOENV)) {
+		shell = getenv("SHELL");
+		if (shell && *shell)
+			return shell;
+	}
+	if (!(flags & UL_SHELL_NOPWD)) {
+		if (!pw)
+			pw = getpwuid(getuid());
+		if (pw)
+			shell = pw->pw_shell;
+		if (shell && *shell)
+			return shell;
+	}
+
+	return _PATH_BSHELL;
+}
-- 
2.51.1

