Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BB2DF707
	for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469408; cv=none; b=EY/pop92R1aNMpqXLqQ+bzoHvvnqXeBp+mUnKIGSf+j+KxFrJ5gDmj5/jaH0h5qkXDTpxH+1Tj3YMVatQOhCZ5k2vWNw5EP5IUyTV3scPXzD28rQf2cth7jpcsmqzRpTR0roIB4QToOcz51qKyygMo5b8MSnVWpZO2T4mTyYVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469408; c=relaxed/simple;
	bh=Vw9WztxzAwS0zglMX0mcHP8JZskHV3W1WCQA3Q7Iapo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mo/LaTmJFEWbLm/wNULW5ncb3zAJpI9+EFEASEZbQBxBZt3zrWMAebNknigd87LKeJ67poOjbOKqaDf+lRWS6qOOSPBGGK6KPdodiSa/ZN8AHhQVHm+v7KlLyNWp/HoOX1ZglGS60hEKL9EkcKXTY8JjemsDVKVgjpIRACDcYko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hozJS6ls; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hozJS6ls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765469405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9C6QiKsgSE3hemKIX+ekezfhqsQq3DSMly2kdJdWs0=;
	b=hozJS6lsaz+avQ7eykmch19szvldqCVxLGSC+7vnuciXHvhWgXT7sFEozPU0LOQClEQKrP
	QmcGw7RGEs2bZUMOmnQnXhGluz4lhhAVpfm/COF2+0MmxeFiw2/gJH5gKWXQUAFOJJDWGe
	a4J3silim8JDGtUVEGqZ6LnhVXA/exA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-Sl5v2s7UMhevoXVbEeu5SQ-1; Thu,
 11 Dec 2025 11:10:03 -0500
X-MC-Unique: Sl5v2s7UMhevoXVbEeu5SQ-1
X-Mimecast-MFC-AGG-ID: Sl5v2s7UMhevoXVbEeu5SQ_1765469402
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B681418009C0;
	Thu, 11 Dec 2025 16:10:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.208])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F7101800451;
	Thu, 11 Dec 2025 16:10:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: util-linux@vger.kernel.org
Cc: pizhenwei@bytedance.com,
	hare@suse.de,
	kwolf@redhat.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/3] blkpr: add read-keys command
Date: Thu, 11 Dec 2025 11:09:55 -0500
Message-ID: <20251211160956.1540114-3-stefanha@redhat.com>
In-Reply-To: <20251211160956.1540114-1-stefanha@redhat.com>
References: <20251211160956.1540114-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The new IOC_PR_READ_KEYS ioctl lists registered keys on a device. Add a
command so that users can inspect keys. This is useful both for
troubleshooting and for recovery scenarios.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build            |  3 +++
 sys-utils/blkpr.c      | 46 ++++++++++++++++++++++++++++++++++++++++++
 configure.ac           |  4 ++++
 sys-utils/blkpr.8.adoc |  3 ++-
 4 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8b7880e46..47b43c2af 100644
--- a/meson.build
+++ b/meson.build
@@ -765,6 +765,9 @@ conf.set('HAVE_DECL_BLK_ZONE_REP_CAPACITY', have ? 1 : false)
 have = cc.has_header_symbol('linux/pr.h', 'PR_REP_CAPACITY')
 conf.set('HAVE_DECL_PR_REP_CAPACITY', have ? 1 : false)
 
+have = cc.has_header_symbol('linux/pr.h', 'IOC_PR_READ_KEYS')
+conf.set('HAVE_DECL_IOC_PR_READ_KEYS', have ? 1 : false)
+
 code = '''
 #include <time.h>
 #if !@0@
diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
index c6b030def..843ef7da1 100644
--- a/sys-utils/blkpr.c
+++ b/sys-utils/blkpr.c
@@ -103,6 +103,12 @@ static const struct type_string pr_command[] = {
 	{IOC_PR_CLEAR,         "clear",
 	"  * clear: This command unregisters both key and any other reservation\n"
 	"    key registered with the device and drops any existing reservation.\n"},
+
+#if HAVE_DECL_IOC_PR_READ_KEYS
+	{IOC_PR_READ_KEYS,     "read-keys",
+	"  * read-keys: This command lists reservation keys currently registered\n"
+	"    with the device.\n"},
+#endif
 };
 
 static const struct type_string pr_flag[] = {
@@ -151,6 +157,41 @@ PARSE(pr_type)
 PARSE(pr_command)
 PARSE(pr_flag)
 
+#if HAVE_DECL_IOC_PR_READ_KEYS
+static int do_pr_read_keys(int fd)
+{
+	struct pr_read_keys pr_rk;
+	uint32_t num_keys = 8;
+	uint64_t *keys = NULL;
+	int ret;
+
+	/* Loop to grow keys[] until it is large enough */
+	do {
+		num_keys *= 2;
+		keys = xreallocarray(keys, num_keys, sizeof(keys[0]));
+
+		pr_rk.keys_ptr = (uintptr_t)keys;
+		pr_rk.num_keys = num_keys;
+
+		ret = ioctl(fd, IOC_PR_READ_KEYS, &pr_rk);
+		if (ret)
+			goto out;
+	} while (pr_rk.num_keys > num_keys);
+
+	if (pr_rk.num_keys) {
+		for (uint32_t i = 0; i < pr_rk.num_keys; i++) {
+			printf(_("%#" PRIx64 "\n"), (uint64_t)keys[i]);
+		}
+	} else {
+		printf(_("No registered keys\n"));
+	}
+
+out:
+	free(keys);
+	return ret;
+}
+#endif /* HAVE_DECL_IOC_PR_READ_KEYS */
+
 static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, int flag)
 {
 	struct pr_registration pr_reg;
@@ -190,6 +231,11 @@ static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, in
 		pr_clr.flags = flag;
 		ret = ioctl(fd, op, &pr_clr);
 		break;
+#if HAVE_DECL_IOC_PR_READ_KEYS
+	case IOC_PR_READ_KEYS:
+		ret = do_pr_read_keys(fd);
+		break;
+#endif
 	default:
 		errno = EINVAL;
 		err(EXIT_FAILURE, _("unknown command"));
diff --git a/configure.ac b/configure.ac
index a424e0947..bbd2156d7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -445,6 +445,10 @@ AC_CHECK_DECLS([PR_REP_CAPACITY], [], [], [
 	#include <linux/pr.h>
 ])
 
+AC_CHECK_DECLS([IOC_PR_READ_KEYS], [], [], [
+	#include <linux/pr.h>
+])
+
 AC_CHECK_HEADERS([security/openpam.h], [], [], [
 #ifdef HAVE_SECURITY_PAM_APPL_H
 #include <security/pam_appl.h>
diff --git a/sys-utils/blkpr.8.adoc b/sys-utils/blkpr.8.adoc
index 98983b779..3a157af38 100644
--- a/sys-utils/blkpr.8.adoc
+++ b/sys-utils/blkpr.8.adoc
@@ -25,7 +25,8 @@ The _device_ argument is the pathname of the block device.
 
 *-c*, *--command* _command_::
 The command for managing persistent reservations. Supported commands are:
-*register*, *reserve*, *release*, *preempt*, *preempt-abort*, and *clear*.
+*register*, *reserve*, *release*, *preempt*, *preempt-abort*, *clear*, and
+*read-keys*.
 
 *-k*, *--key* _key_::
 The key the command should operate on.
-- 
2.52.0

