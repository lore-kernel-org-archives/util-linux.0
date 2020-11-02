Return-Path: <SRS0=qK//=EI=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA04C00A89
	for <util-linux@archiver.kernel.org>; Mon,  2 Nov 2020 22:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF8320786
	for <util-linux@archiver.kernel.org>; Mon,  2 Nov 2020 22:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOIXXTRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgKBW0Y (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgKBW0X (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 2 Nov 2020 17:26:23 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B81BC0617A6
        for <util-linux@vger.kernel.org>; Mon,  2 Nov 2020 14:26:23 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so16402965wrm.4
        for <util-linux@vger.kernel.org>; Mon, 02 Nov 2020 14:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=uUb+nYBeTsoUOUz/jaiiD6JXoScQvJ+GxOx/dEMingc=;
        b=MOIXXTRBzaOK+ullbmb5rpTaMRSJSfObNgqRBLr6sdRiJOJvTLEr7C1yEk6O+kfQs2
         EoEk+dz0oOr37HxqyD51yKdc4Z6BcO30I3EpIcezZppSdJ0tytz0vuldSUczFinI7/th
         KqNT4XQx6pmScsWsHQ0R2R9ShZyKRM7H9d/Hsp/gkfm/AXbO+YM2a799BsEF9L2Z/pJt
         Oo2Nf5fGXGks+lE9E3PumwWXiW4TBwA2OeRz/P5lrDNRHOrs51P4EyzFV/KsJ9W9km07
         JO8V/9sIX1KaBvNzpE6GiATOYABf83FcoHhGW1HiNUCDfwK1EmFV9LtCDsk9vUSWlUUk
         OOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:organization
         :content-transfer-encoding;
        bh=uUb+nYBeTsoUOUz/jaiiD6JXoScQvJ+GxOx/dEMingc=;
        b=NvkgF908l2TwZu1l5jjB89o6499DBC3sWUGFxjIt/8W1w0RtVOuFpt9mMtgOsiVTkM
         nAIlpC0J9kXfQaachvw9RHT++pAj7dMDo5Eb4Y7MOSchjBxk5kZehGFnR1o7jjoLLaMn
         zl2rMtR/jzKQxp+H/Pv9wr9UW0blPwwxvn+VGrNbUEHEn6p3n/HbDCx8BnUFxwbj7Um+
         VvWK2OT2aevt7a7aDPPZiC6Y9ZjQBeHjEvcdqzGbx/jBt26qCjkZtsYMvCZ0Q7+WH5id
         JNJwqB2nYMB1+OOUz4XOKnGW6xpF0o2r6hwIH9VkPSZByu5o4nndEylkEivitmRQ7Qr5
         pmsQ==
X-Gm-Message-State: AOAM530hVj0oKBy1cEMPxP69DtpKkbzpEZEfuXNds4rWON1ICfQOLTMe
        5S0SmOv4LGvoC0KejxqLxQs=
X-Google-Smtp-Source: ABdhPJxjWdxDsyKoLE16DkiFTVOW7jutD9AcCBn0w712/w2sLymJEFKHge/5xAhdDwzwSwc8GjL+hA==
X-Received: by 2002:adf:f109:: with SMTP id r9mr22738608wro.100.1604355982166;
        Mon, 02 Nov 2020 14:26:22 -0800 (PST)
Received: from localhost ([2a02:8010:659f:0:a8d8:38f:5807:ac47])
        by smtp.gmail.com with ESMTPSA id k84sm879101wmf.42.2020.11.02.14.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 14:26:21 -0800 (PST)
Sender: Sami Kerola <kerolasa@gmail.com>
From:   Sami Kerola <kerolasa@iki.fi>
To:     cryintothebluesky@gmail.com
Cc:     util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] lib/randutils: rename random_get_bytes()
Date:   Mon,  2 Nov 2020 22:26:18 +0000
Message-Id: <20201102222618.40770-1-kerolasa@iki.fi>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201101141608.ba365cf67d92ee3973226de9@gmail.com>
References: <20201101141608.ba365cf67d92ee3973226de9@gmail.com>
MIME-Version: 1.0
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Rename random_get_bytes() to avoid colliding a Solaris library function that
has the same name.

Reported-by: Sad Clouds <cryintothebluesky@gmail.com>
Reference: https://lore.kernel.org/util-linux/20201101141608.ba365cf67d92ee3973226de9@gmail.com/
Reference: https://blogs.oracle.com/solaris/solaris-random-number-generation-v2
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/randutils.h    | 2 +-
 lib/randutils.c        | 6 +++---
 libfdisk/src/dos.c     | 2 +-
 libuuid/src/gen_uuid.c | 6 +++---
 misc-utils/mcookie.c   | 2 +-
 sys-utils/ipcmk.c      | 6 +++---
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/randutils.h b/include/randutils.h
index 86e35f3f4..5b863d04c 100644
--- a/include/randutils.h
+++ b/include/randutils.h
@@ -11,7 +11,7 @@ extern int rand_get_number(int low_n, int high_n);
 
 /* /dev/urandom based with fallback to rand() */
 extern int random_get_fd(void);
-extern void random_get_bytes(void *buf, size_t nbytes);
+extern void ul_random_get_bytes(void *buf, size_t nbytes);
 extern const char *random_tell_source(void);
 
 #endif
diff --git a/lib/randutils.c b/lib/randutils.c
index 84c002187..bf8193338 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -102,7 +102,7 @@ int random_get_fd(void)
 #define UL_RAND_READ_ATTEMPTS	8
 #define UL_RAND_READ_DELAY	125000	/* microseconds */
 
-void random_get_bytes(void *buf, size_t nbytes)
+void ul_random_get_bytes(void *buf, size_t nbytes)
 {
 	unsigned char *cp = (unsigned char *)buf;
 	size_t i, n = nbytes;
@@ -216,7 +216,7 @@ int main(int argc, char *argv[])
 
 	printf("Multiple random calls:\n");
 	for (i = 0; i < n; i++) {
-		random_get_bytes(&v, sizeof(v));
+		ul_random_get_bytes(&v, sizeof(v));
 		printf("#%02zu: %25"PRIu64"\n", i, v);
 	}
 
@@ -227,7 +227,7 @@ int main(int argc, char *argv[])
 	if (!buf)
 		err(EXIT_FAILURE, "failed to allocate buffer");
 
-	random_get_bytes(buf, bufsz);
+	ul_random_get_bytes(buf, bufsz);
 	for (i = 0; i < n; i++) {
 		vp = (int64_t *) (buf + (i * sizeof(*vp)));
 		printf("#%02zu: %25"PRIu64"\n", i, *vp);
diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index 890e33a26..82ccb6940 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -693,7 +693,7 @@ static int dos_create_disklabel(struct fdisk_context *cxt)
 	/* random disk signature */
 	if (!has_id) {
 		DBG(LABEL, ul_debug("DOS: generate new ID"));
-		random_get_bytes(&id, sizeof(id));
+		ul_random_get_bytes(&id, sizeof(id));
 	}
 
 	if (fdisk_has_protected_bootbits(cxt))
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 69f9591a4..50039fc2e 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -275,7 +275,7 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 	}
 
 	if ((last.tv_sec == 0) && (last.tv_usec == 0)) {
-		random_get_bytes(&clock_seq, sizeof(clock_seq));
+		ul_random_get_bytes(&clock_seq, sizeof(clock_seq));
 		clock_seq &= 0x3FFF;
 		gettimeofday(&last, NULL);
 		last.tv_sec--;
@@ -413,7 +413,7 @@ int __uuid_generate_time(uuid_t out, int *num)
 
 	if (!has_init) {
 		if (get_node_id(node_id) <= 0) {
-			random_get_bytes(node_id, 6);
+			ul_random_get_bytes(node_id, 6);
 			/*
 			 * Set multicast bit, to prevent conflicts
 			 * with IEEE 802 addresses obtained from
@@ -511,7 +511,7 @@ void __uuid_generate_random(uuid_t out, int *num)
 		n = *num;
 
 	for (i = 0; i < n; i++) {
-		random_get_bytes(buf, sizeof(buf));
+		ul_random_get_bytes(buf, sizeof(buf));
 		uuid_unpack(buf, &uu);
 
 		uu.clock_seq = (uu.clock_seq & 0x3FFF) | 0x8000;
diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index 549531454..315740127 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -184,7 +184,7 @@ int main(int argc, char **argv)
 	randomness_from_files(&ctl);
 	free(ctl.files);
 
-	random_get_bytes(&buf, RAND_BYTES);
+	ul_random_get_bytes(&buf, RAND_BYTES);
 	ul_MD5Update(&ctl.ctx, buf, RAND_BYTES);
 	if (ctl.verbose)
 		fprintf(stderr, P_("Got %d byte from %s\n",
diff --git a/sys-utils/ipcmk.c b/sys-utils/ipcmk.c
index 5e942b775..0a84be77e 100644
--- a/sys-utils/ipcmk.c
+++ b/sys-utils/ipcmk.c
@@ -40,7 +40,7 @@ static int create_shm(size_t size, int permission)
 {
 	key_t key;
 
-	random_get_bytes(&key, sizeof(key));
+	ul_random_get_bytes(&key, sizeof(key));
 	return shmget(key, size, permission | IPC_CREAT);
 }
 
@@ -48,7 +48,7 @@ static int create_msg(int permission)
 {
 	key_t key;
 
-	random_get_bytes(&key, sizeof(key));
+	ul_random_get_bytes(&key, sizeof(key));
 	return msgget(key, permission | IPC_CREAT);
 }
 
@@ -56,7 +56,7 @@ static int create_sem(int nsems, int permission)
 {
 	key_t key;
 
-	random_get_bytes(&key, sizeof(key));
+	ul_random_get_bytes(&key, sizeof(key));
 	return semget(key, nsems, permission | IPC_CREAT);
 }
 
-- 
2.29.2

