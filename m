Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56302DF707
	for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469412; cv=none; b=mzdfWen6+XMzxH6v1lUFcUg53/jYfledZ8V8BmMQlIgETC0NxaUmodxNaRevL4pV/6E9c9sEABvq7KpvdZIrNceK3JURqyaIAQp6oHSrpnhnFxWntbFuLYIOZzfa0iiJGt1sLxhEnlIU6bGPUoj7vGNHoZWaNpo3FGe9tX3THkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469412; c=relaxed/simple;
	bh=i8KlPbaAI2fCxebzja30evR0xmEK9VWwDObh8kOzdhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwieZ0l9Izt2dJRgkWv64RNATXwdRrAc66G9v4964dMioxVk92Z8o8Vxpujn9GZF1hjDfIsB6l5bezUwKdPPgPQ8s0hB5ZJbOwhNYDlagb+wF1rc+5lEdNF8lJYr7BdkfatfaPAlnHDspAUBUkWXFd2Z0mJ45wIGzreyT0kluxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XF4vc4Ec; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XF4vc4Ec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765469409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTZejoPzYVaXiKaOUh2JVz3JMO3iuR2QARX7Pee/5sA=;
	b=XF4vc4EcUV8F8o6UmIpzkG7aKg6jo1eMYiVwE289jyX4PUNgXSXbTvqivhqgOFzV0mQ5rg
	L9a0adxAxgh7fg2+9gzh/8UDI7KYXFGv/HyuIlMEJIzLVhRCyKBNluWE2LU1FHVkQmxrFb
	Sb3RS5tWwK1a2oeJhA51NSCcvcfNv4U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-n-WGAN-TMVyR1v3jJX492g-1; Thu,
 11 Dec 2025 11:10:05 -0500
X-MC-Unique: n-WGAN-TMVyR1v3jJX492g-1
X-Mimecast-MFC-AGG-ID: n-WGAN-TMVyR1v3jJX492g_1765469404
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5119A1956094;
	Thu, 11 Dec 2025 16:10:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.208])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00A3A19540DF;
	Thu, 11 Dec 2025 16:10:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: util-linux@vger.kernel.org
Cc: pizhenwei@bytedance.com,
	hare@suse.de,
	kwolf@redhat.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/3] blkpr: add read-reservation command
Date: Thu, 11 Dec 2025 11:09:56 -0500
Message-ID: <20251211160956.1540114-4-stefanha@redhat.com>
In-Reply-To: <20251211160956.1540114-1-stefanha@redhat.com>
References: <20251211160956.1540114-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The new IOC_PR_READ_RESERVATION ioctl reports the current reservation on
a device. Add a command so that users can inspect the current
reservation. This is useful both for troubleshooting and for recovery
scenarios.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build            |  3 +++
 sys-utils/blkpr.c      | 60 +++++++++++++++++++++++++++++++++++++-----
 configure.ac           |  4 +++
 sys-utils/blkpr.8.adoc |  4 +--
 4 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 47b43c2af..b759e992f 100644
--- a/meson.build
+++ b/meson.build
@@ -768,6 +768,9 @@ conf.set('HAVE_DECL_PR_REP_CAPACITY', have ? 1 : false)
 have = cc.has_header_symbol('linux/pr.h', 'IOC_PR_READ_KEYS')
 conf.set('HAVE_DECL_IOC_PR_READ_KEYS', have ? 1 : false)
 
+have = cc.has_header_symbol('linux/pr.h', 'IOC_PR_READ_RESERVATION')
+conf.set('HAVE_DECL_IOC_PR_READ_RESERVATION', have ? 1 : false)
+
 code = '''
 #include <time.h>
 #if !@0@
diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
index 843ef7da1..0cb73a3bd 100644
--- a/sys-utils/blkpr.c
+++ b/sys-utils/blkpr.c
@@ -73,7 +73,7 @@ static const struct type_string pr_type[] = {
 };
 
 static const struct type_string pr_command[] = {
-	{IOC_PR_REGISTER,      "register",
+	{IOC_PR_REGISTER,         "register",
 	"  * register: This command registers a new reservation if the key argument\n"
 	"    is non-null. If no existing reservation exists oldkey must be zero, if\n"
 	"    an existing reservation should be replaced oldkey must contain the old\n"
@@ -81,34 +81,39 @@ static const struct type_string pr_command[] = {
 	"    reservation passed in oldkey.\n"
 	},
 
-	{IOC_PR_RESERVE,       "reserve",
+	{IOC_PR_RESERVE,          "reserve",
 	"  * reserve: This command reserves the device and thus restricts access for\n"
 	"    other devices based on the type argument.  The key argument must be\n"
 	"    the existing reservation key for the device as acquired by the register,\n"
 	"    preempt, preempt-abort commands.\n"},
 
-	{IOC_PR_RELEASE,       "release",
+	{IOC_PR_RELEASE,          "release",
 	"  * release: This command releases the reservation specified by key and flags\n"
 	"    and thus removes any access restriction implied by it.\n"},
 
-	{IOC_PR_PREEMPT,       "preempt",
+	{IOC_PR_PREEMPT,          "preempt",
 	"  * preempt: This command releases the existing reservation referred to by\n"
 	"    old_key and replaces it with a new reservation of type for the\n"
 	"    reservation key key.\n"},
 
-	{IOC_PR_PREEMPT_ABORT, "preempt-abort",
+	{IOC_PR_PREEMPT_ABORT,    "preempt-abort",
 	"  * preempt-abort: This command works like preempt except that it also aborts\n"
 	"    any outstanding command sent over a connection identified by oldkey.\n"},
 
-	{IOC_PR_CLEAR,         "clear",
+	{IOC_PR_CLEAR,            "clear",
 	"  * clear: This command unregisters both key and any other reservation\n"
 	"    key registered with the device and drops any existing reservation.\n"},
 
 #if HAVE_DECL_IOC_PR_READ_KEYS
-	{IOC_PR_READ_KEYS,     "read-keys",
+	{IOC_PR_READ_KEYS,        "read-keys",
 	"  * read-keys: This command lists reservation keys currently registered\n"
 	"    with the device.\n"},
 #endif
+
+#if HAVE_DECL_IOC_PR_READ_RESERVATION
+	{IOC_PR_READ_RESERVATION, "read-reservation",
+	"  * read-reservation: This command shows the current reservation.\n"},
+#endif
 };
 
 static const struct type_string pr_flag[] = {
@@ -140,6 +145,18 @@ static int parse_type_by_str(const struct type_string *ts, int nmem, char *patte
 	return -1;
 }
 
+static inline const char *type_to_str(const struct type_string *ts, int nmem,
+                                      int type)
+{
+	int i;
+
+	for (i = 0; i < nmem; i++) {
+		if (ts[i].type == type)
+			return ts[i].str;
+	}
+	return "unknown type";
+}
+
 
 #define PRINT_SUPPORTED(XX) \
 	static void print_##XX(FILE *out) \
@@ -192,6 +209,30 @@ out:
 }
 #endif /* HAVE_DECL_IOC_PR_READ_KEYS */
 
+#if HAVE_DECL_IOC_PR_READ_RESERVATION
+static int do_pr_read_reservation(int fd)
+{
+	struct pr_read_reservation pr_rr;
+	const char *type_str;
+	int ret;
+
+	ret = ioctl(fd, IOC_PR_READ_RESERVATION, &pr_rr);
+	if (ret)
+		return ret;
+
+	type_str = type_to_str(pr_type, ARRAY_SIZE(pr_type), pr_rr.type);
+
+	if (pr_rr.key) {
+		printf(_("Key: %#" PRIx64 "\n"), (uint64_t)pr_rr.key);
+		printf(_("Generation: %#x\n"), pr_rr.generation);
+		printf(_("Type: %s\n"), type_str);
+	} else {
+		printf(_("No reservation\n"));
+	}
+	return 0;
+}
+#endif /* HAVE_DECL_IOC_PR_READ_RESERVATION */
+
 static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, int flag)
 {
 	struct pr_registration pr_reg;
@@ -235,6 +276,11 @@ static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, in
 	case IOC_PR_READ_KEYS:
 		ret = do_pr_read_keys(fd);
 		break;
+#endif
+#if HAVE_DECL_IOC_PR_READ_RESERVATION
+	case IOC_PR_READ_RESERVATION:
+		ret = do_pr_read_reservation(fd);
+		break;
 #endif
 	default:
 		errno = EINVAL;
diff --git a/configure.ac b/configure.ac
index bbd2156d7..9dfb12a7a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -449,6 +449,10 @@ AC_CHECK_DECLS([IOC_PR_READ_KEYS], [], [], [
 	#include <linux/pr.h>
 ])
 
+AC_CHECK_DECLS([IOC_PR_READ_RESERVATION], [], [], [
+	#include <linux/pr.h>
+])
+
 AC_CHECK_HEADERS([security/openpam.h], [], [], [
 #ifdef HAVE_SECURITY_PAM_APPL_H
 #include <security/pam_appl.h>
diff --git a/sys-utils/blkpr.8.adoc b/sys-utils/blkpr.8.adoc
index 3a157af38..630bafb92 100644
--- a/sys-utils/blkpr.8.adoc
+++ b/sys-utils/blkpr.8.adoc
@@ -25,8 +25,8 @@ The _device_ argument is the pathname of the block device.
 
 *-c*, *--command* _command_::
 The command for managing persistent reservations. Supported commands are:
-*register*, *reserve*, *release*, *preempt*, *preempt-abort*, *clear*, and
-*read-keys*.
+*register*, *reserve*, *release*, *preempt*, *preempt-abort*, *clear*,
+*read-keys*, and *read-reservation*.
 
 *-k*, *--key* _key_::
 The key the command should operate on.
-- 
2.52.0

