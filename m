Return-Path: <SRS0=aSVg=YD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6139CC10F14
	for <util-linux@archiver.kernel.org>; Thu, 10 Oct 2019 12:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADC320650
	for <util-linux@archiver.kernel.org>; Thu, 10 Oct 2019 12:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfJJMJn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfJJMJn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 10 Oct 2019 08:09:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 030C28E587
        for <util-linux@vger.kernel.org>; Thu, 10 Oct 2019 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.2.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78E855D6C8
        for <util-linux@vger.kernel.org>; Thu, 10 Oct 2019 12:09:42 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH v1 1/4] libkmod: Add parser for modules.builtin.modinfo
Date:   Thu, 10 Oct 2019 14:09:25 +0200
Message-Id: <20191010120928.3817287-2-gladkov.alexey@gmail.com>
In-Reply-To: <20191010120928.3817287-1-gladkov.alexey@gmail.com>
References: <20191010120928.3817287-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 10 Oct 2019 12:09:43 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The kernel since version v5.2-rc1 exports information about built-in
modules in the modules.builtin.modinfo. Information is stored in
the same format as in the separate modules (null-terminated string
array). The module name is a prefix for each line.

$ tr '\0' '\n' < modules.builtin.modinfo
ext4.softdep=pre: crc32c
ext4.license=GPL
ext4.description=Fourth Extended Filesystem
ext4.author=Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
ext4.alias=fs-ext4
ext4.alias=ext3
ext4.alias=fs-ext3
ext4.alias=ext2
ext4.alias=fs-ext2
md_mod.alias=block-major-9-*
md_mod.alias=md
md_mod.description=MD RAID framework
md_mod.license=GPL
md_mod.parmtype=create_on_open:bool
md_mod.parmtype=start_dirty_degraded:int
...

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 Makefile.am                |   1 +
 libkmod/libkmod-builtin.c  | 231 +++++++++++++++++++++++++++++++++++++
 libkmod/libkmod-internal.h |   8 ++
 3 files changed, 240 insertions(+)
 create mode 100644 libkmod/libkmod-builtin.c

diff --git a/Makefile.am b/Makefile.am
index c5c2f06..176dcfc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -68,6 +68,7 @@ libkmod_libkmod_la_SOURCES = \
 	libkmod/libkmod.h \
 	libkmod/libkmod-internal.h \
 	libkmod/libkmod.c \
+	libkmod/libkmod-builtin.c \
 	libkmod/libkmod-list.c \
 	libkmod/libkmod-config.c \
 	libkmod/libkmod-index.c \
diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
new file mode 100644
index 0000000..9da0010
--- /dev/null
+++ b/libkmod/libkmod-builtin.c
@@ -0,0 +1,231 @@
+/*
+ * libkmod - interface to kernel built-in modules
+ *
+ * Copyright (C) 2019  Alexey Gladkov <gladkov.alexey@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include "libkmod.h"
+#include "libkmod-internal.h"
+
+#define MODULES_BUILTIN_MODINFO "modules.builtin.modinfo"
+
+struct kmod_builtin_iter {
+	struct kmod_ctx *ctx;
+	struct kmod_file *file;
+	off_t pos;
+	off_t next;
+};
+
+struct kmod_builtin_iter *kmod_builtin_iter_new(struct kmod_ctx *ctx)
+{
+	char path[PATH_MAX];
+	struct kmod_file *file;
+	struct kmod_builtin_iter *iter;
+	const char *dirname = kmod_get_dirname(ctx);
+	size_t len = strlen(dirname);
+
+	if ((len + 1 + strlen(MODULES_BUILTIN_MODINFO) + 1) >= PATH_MAX) {
+		errno = ENAMETOOLONG;
+		return NULL;
+	}
+
+	snprintf(path, PATH_MAX, "%s/%s", dirname, MODULES_BUILTIN_MODINFO);
+
+	file = kmod_file_open(ctx, path);
+	if (!file)
+		return NULL;
+
+	iter = malloc(sizeof(*iter));
+	if (!iter) {
+		kmod_file_unref(file);
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	iter->ctx = ctx;
+	iter->file = file;
+	iter->pos = 0;
+	iter->next = 0;
+
+	return iter;
+}
+
+bool kmod_builtin_iter_next(struct kmod_builtin_iter *iter)
+{
+	char *mm, *s, *dot;
+	off_t offset, mmsize;
+	size_t len, modlen;
+	char *modname = NULL;
+
+	mm = kmod_file_get_contents(iter->file);
+	mmsize = kmod_file_get_size(iter->file);
+
+	offset = iter->next;
+
+	while (offset < mmsize) {
+		s = mm + offset;
+
+		dot = strchr(s, '.');
+		if (!dot)
+			return false;
+
+		len = dot - s;
+
+		if (!modname) {
+			modname = s;
+			modlen = len;
+		} else if (modlen != len || strncmp(modname, s, len)) {
+			break;
+		}
+
+		offset += strlen(s) + 1;
+	}
+
+	if (!modname)
+		return false;
+
+	iter->next = offset;
+
+	return true;
+}
+
+void kmod_builtin_iter_free(struct kmod_builtin_iter *iter)
+{
+	kmod_file_unref(iter->file);
+	free(iter);
+}
+
+int kmod_builtin_iter_get_strings(struct kmod_builtin_iter *iter,
+					const char **strings)
+{
+	char *mm = kmod_file_get_contents(iter->file);
+	off_t pos = iter->pos;
+
+	char *start = NULL;
+	size_t count = 0;
+	size_t modlen = 0;
+
+	while (pos < iter->next) {
+		char *dot = strchr(mm + pos, '.');
+		size_t len;
+
+		if (!dot)
+			return -1;
+
+		len = dot - (mm + pos);
+
+		if (!start) {
+			start = mm + pos;
+			modlen = len;
+		} else if (modlen != len || strncmp(start, mm + pos, len)) {
+			break;
+		}
+
+		pos += strlen(mm + pos) + 1;
+		count++;
+	}
+
+	*strings = start;
+	iter->pos = iter->next;
+
+	return count;
+}
+
+/* array will be allocated with strings in a single malloc, just free *array */
+int kmod_builtin_get_modinfo(struct kmod_ctx *ctx, const char *modname,
+				char ***modinfo)
+{
+	char *mm, *s, *section, *dot;
+	off_t n, size, offset, mmoffset, mmsize;
+	size_t modlen, len;
+	struct kmod_builtin_iter *iter;
+	int count = 0;
+
+	iter = kmod_builtin_iter_new(ctx);
+
+	if (!iter)
+		return -1;
+
+	modlen = strlen(modname);
+
+	mmsize = kmod_file_get_size(iter->file);
+	mm = kmod_file_get_contents(iter->file);
+
+	section = NULL;
+	size = 0;
+
+	for (mmoffset = 0; mmoffset < mmsize;) {
+		s = mm + mmoffset;
+		dot = strchr(s, '.');
+
+		if (!dot) {
+			count = -ENODATA;
+			goto fail;
+		}
+
+		len = dot - s;
+
+		if (modlen != len || strncmp(modname, s, len)) {
+			if (count)
+				break;
+			mmoffset += strlen(s) + 1;
+			continue;
+		} else if (!count) {
+			section = s;
+		}
+
+		len = strlen(dot + 1) + 1;
+		mmoffset += modlen + 1 + len;
+		size += len;
+
+		count++;
+	}
+
+	if (!count) {
+		count = -ENOSYS;
+		goto fail;
+	}
+
+	*modinfo = malloc(size + sizeof(char *) * (count + 1));
+	if (!*modinfo) {
+		count = -errno;
+		goto fail;
+	}
+
+	s = (char *)(*modinfo + count + 1);
+
+	n = 0;
+	mmoffset = 0;
+
+	for (offset = 0; offset < size;) {
+		len = strlen(section + mmoffset + modlen + 1) + 1;
+
+		strncpy(s + offset, section + mmoffset + modlen + 1, len);
+		(*modinfo)[n++] = s + offset;
+
+		mmoffset += modlen + 1 + len;
+		offset += len;
+	}
+
+fail:
+	kmod_builtin_iter_free(iter);
+	return count;
+}
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index a65ddd1..17ae541 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -193,3 +193,11 @@ struct kmod_signature_info {
 };
 bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signature_info *sig_info) _must_check_ __attribute__((nonnull(1, 2)));
 void kmod_module_signature_info_free(struct kmod_signature_info *sig_info) __attribute__((nonnull));
+
+/* libkmod-builtin.c */
+struct kmod_builtin_iter;
+struct kmod_builtin_iter *kmod_builtin_iter_new(struct kmod_ctx *ctx) __attribute__((nonnull(1)));
+void kmod_builtin_iter_free(struct kmod_builtin_iter *iter) __attribute__((nonnull(1)));
+bool kmod_builtin_iter_next(struct kmod_builtin_iter *iter) __attribute__((nonnull(1)));
+int kmod_builtin_iter_get_strings(struct kmod_builtin_iter *iter, const char **modinfo) __attribute__((nonnull(1, 2)));
+int kmod_builtin_get_modinfo(struct kmod_ctx *ctx, const char *modname, char ***modinfo) __attribute__((nonnull(1, 2, 3)));
-- 
2.21.0

