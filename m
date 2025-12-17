Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A012D3727
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995983; cv=none; b=jCjsF3ofIOuoZP2Jt6FRlDN+G4OwBMbSM99SvIXcNP0jQze7eRMjKJ83ur25EJxZpQS6axR5IzC604jCR8g81tFUxUfVrbEECupayBAZ2iy9y6vA6Xtk8MjmEP1C8abddLLAQNRP1AbDXluxMsNEve1JsRFipVH3sy9O6JguEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995983; c=relaxed/simple;
	bh=GCz4Ao3gCxrvewLRj/VfAsdGrboQuH0VEcfVEi1Nmqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdeIjEJxI1Tg8fJkhDxt71XqCgy9gAK+jiBXa5uCGufRFToDdOs7pwUcqL5ZDxqyppB2xwXGfap8HmZU0E+4xClmUUAfdHx08evjXKaSoqOvyBWv62w0Vw3Jx9pRM3qEUYIW+61UuipcNortdo+Xh4/tiLq8FC7pMjdOt5s97BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj6sXnK1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj6sXnK1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765995978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYdr+z2DhWolUHdUIV3j8CxTXRvBE8b8XPqxiMg9wSo=;
	b=Bj6sXnK1jP24MumQHokT7R0jQEZXMVsHeu8Zw4TUZxSfrI+dwI3lf6d0kZdGwrBe51PPzR
	W5FRuYe/+x+qZ6YmJnJoEScAeREbI+c+KPHEk8Fg38/931rUNqnfbOUcwGk6OF3aqt1+Ep
	nnhvWC+ez7nURAmT9mxc2JEDzNsf+dc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-vcJ48kcLOAOcKj-Gnz0ABw-1; Wed,
 17 Dec 2025 13:26:14 -0500
X-MC-Unique: vcJ48kcLOAOcKj-Gnz0ABw-1
X-Mimecast-MFC-AGG-ID: vcJ48kcLOAOcKj-Gnz0ABw_1765995973
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 378D2195F156;
	Wed, 17 Dec 2025 18:26:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B42CA30001A2;
	Wed, 17 Dec 2025 18:26:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: util-linux@vger.kernel.org
Cc: kwolf@redhat.com,
	hare@suse.de,
	Karel Zak <kzak@redhat.com>,
	pizhenwei@bytedance.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 2/3] blkpr: add read-keys command
Date: Wed, 17 Dec 2025 13:26:06 -0500
Message-ID: <20251217182607.179232-3-stefanha@redhat.com>
In-Reply-To: <20251217182607.179232-1-stefanha@redhat.com>
References: <20251217182607.179232-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The new IOC_PR_READ_KEYS ioctl lists registered keys on a device. Add a
command so that users can inspect keys. This is useful both for
troubleshooting and for recovery scenarios.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 sys-utils/blkpr.c      | 46 ++++++++++++++++++++++++++++++++++++++++++
 sys-utils/blkpr.8.adoc |  3 ++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
index c6b030def..84e736e9f 100644
--- a/sys-utils/blkpr.c
+++ b/sys-utils/blkpr.c
@@ -103,6 +103,12 @@ static const struct type_string pr_command[] = {
 	{IOC_PR_CLEAR,         "clear",
 	"  * clear: This command unregisters both key and any other reservation\n"
 	"    key registered with the device and drops any existing reservation.\n"},
+
+#ifdef IOC_PR_READ_KEYS
+	{IOC_PR_READ_KEYS,     "read-keys",
+	"  * read-keys: This command lists reservation keys currently registered\n"
+	"    with the device.\n"},
+#endif
 };
 
 static const struct type_string pr_flag[] = {
@@ -151,6 +157,41 @@ PARSE(pr_type)
 PARSE(pr_command)
 PARSE(pr_flag)
 
+#ifdef IOC_PR_READ_KEYS
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
+#endif /* IOC_PR_READ_KEYS */
+
 static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, int flag)
 {
 	struct pr_registration pr_reg;
@@ -190,6 +231,11 @@ static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, in
 		pr_clr.flags = flag;
 		ret = ioctl(fd, op, &pr_clr);
 		break;
+#ifdef IOC_PR_READ_KEYS
+	case IOC_PR_READ_KEYS:
+		ret = do_pr_read_keys(fd);
+		break;
+#endif
 	default:
 		errno = EINVAL;
 		err(EXIT_FAILURE, _("unknown command"));
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

