Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318C1E834B
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995981; cv=none; b=ei9O4KUyJh3D+X3B53O8FYB4f3T7sEHsUX5UUgTvrXOfgaXlOJuUo+zWk5iPMWbWS4IJGjmb682PVH8LBjq1HsakRKXaK0Opg+6fkCpWooFLL9hKMUZAo8SQmQfHvVncktzhT0pWByZbFadwezWyTgTkI8y8GeEuGuNFHjpfbw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995981; c=relaxed/simple;
	bh=M94ITJjq3EmDvSpSQDmm7pFsZxC19kmfXliYZkGO5zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMnLeatoYoMG6jB7iePsF5BK1R5bf9DbezGiDslkJDioCGOi/ltrbmWQtuuByt11RyRuFakd1IJrNNOP9vYKMm0I8Z6NMw3fLhY5jVu6qPIwhbBn94he72DN9LUB8Z4VpGDkTYNiz2W8d/cO9ZovgHILMpJG5tcaJJGDsoVETPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTJP63s1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTJP63s1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765995977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SCUR+BLU7SyYGmf1u6CczcztpDC10xzQq58UE0jIpc=;
	b=NTJP63s1+LehnT9T2KFuDpGNqON4biqHnluzX3LkMcCUD/oakP2bq+WAve5ejncvWPxjQa
	xxuoKiCrfFJAPrT6KoDIl6v/d59a+BslmcPTxEe4/qpRUubtRojwAA5e+7MLaTOT0C1KFi
	N/g/3llnTauJIenK2iOvMp6JNZYDkLU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-3Kk_KEvxOlyfWsiWNVgSyw-1; Wed,
 17 Dec 2025 13:26:15 -0500
X-MC-Unique: 3Kk_KEvxOlyfWsiWNVgSyw-1
X-Mimecast-MFC-AGG-ID: 3Kk_KEvxOlyfWsiWNVgSyw_1765995974
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8AAF19560B2;
	Wed, 17 Dec 2025 18:26:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30E8D1956056;
	Wed, 17 Dec 2025 18:26:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: util-linux@vger.kernel.org
Cc: kwolf@redhat.com,
	hare@suse.de,
	Karel Zak <kzak@redhat.com>,
	pizhenwei@bytedance.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 3/3] blkpr: add read-reservation command
Date: Wed, 17 Dec 2025 13:26:07 -0500
Message-ID: <20251217182607.179232-4-stefanha@redhat.com>
In-Reply-To: <20251217182607.179232-1-stefanha@redhat.com>
References: <20251217182607.179232-1-stefanha@redhat.com>
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
 sys-utils/blkpr.c      | 60 +++++++++++++++++++++++++++++++++++++-----
 sys-utils/blkpr.8.adoc |  4 +--
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
index 84e736e9f..e2e67b3f1 100644
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
 
 #ifdef IOC_PR_READ_KEYS
-	{IOC_PR_READ_KEYS,     "read-keys",
+	{IOC_PR_READ_KEYS,        "read-keys",
 	"  * read-keys: This command lists reservation keys currently registered\n"
 	"    with the device.\n"},
 #endif
+
+#ifdef IOC_PR_READ_RESERVATION
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
 #endif /* IOC_PR_READ_KEYS */
 
+#ifdef IOC_PR_READ_RESERVATION
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
+#endif /* IOC_PR_READ_RESERVATION */
+
 static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, int flag)
 {
 	struct pr_registration pr_reg;
@@ -235,6 +276,11 @@ static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, in
 	case IOC_PR_READ_KEYS:
 		ret = do_pr_read_keys(fd);
 		break;
+#endif
+#ifdef IOC_PR_READ_RESERVATION
+	case IOC_PR_READ_RESERVATION:
+		ret = do_pr_read_reservation(fd);
+		break;
 #endif
 	default:
 		errno = EINVAL;
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

