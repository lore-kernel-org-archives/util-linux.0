Return-Path: <SRS0=aSVg=YD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4216C10F14
	for <util-linux@archiver.kernel.org>; Thu, 10 Oct 2019 12:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEC320650
	for <util-linux@archiver.kernel.org>; Thu, 10 Oct 2019 12:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbfJJMJr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:09:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733089AbfJJMJr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 10 Oct 2019 08:09:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8192A18C4289
        for <util-linux@vger.kernel.org>; Thu, 10 Oct 2019 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.2.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08AB25D6C8
        for <util-linux@vger.kernel.org>; Thu, 10 Oct 2019 12:09:45 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH v1 3/4] Lookup aliases in the modules.builtin.modinfo
Date:   Thu, 10 Oct 2019 14:09:27 +0200
Message-Id: <20191010120928.3817287-4-gladkov.alexey@gmail.com>
In-Reply-To: <20191010120928.3817287-1-gladkov.alexey@gmail.com>
References: <20191010120928.3817287-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 10 Oct 2019 12:09:46 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

New modules.builtin.modinfo duplicates modules.builtin in the built-in
module name search. If it exists, then we can use this file, but if not,
then we need to fallback to the old file.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 libkmod/libkmod-internal.h |  1 +
 libkmod/libkmod-module.c   | 10 ++++--
 libkmod/libkmod.c          | 25 +++++++++++++++
 libkmod/libkmod.h          |  1 +
 tools/depmod.c             | 63 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index d2000fe..ebed886 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -89,6 +89,7 @@ int kmod_lookup_alias_from_config(struct kmod_ctx *ctx, const char *name, struct
 int kmod_lookup_alias_from_symbols_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
 int kmod_lookup_alias_from_aliases_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
 int kmod_lookup_alias_from_moddep_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
+int kmod_lookup_alias_from_kernel_builtin_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
 int kmod_lookup_alias_from_builtin_file(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
 bool kmod_lookup_alias_is_builtin(struct kmod_ctx *ctx, const char *name) __attribute__((nonnull(1, 2)));
 int kmod_lookup_alias_from_commands(struct kmod_ctx *ctx, const char *name, struct kmod_list **list) __attribute__((nonnull(1, 2, 3)));
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 82b9fbe..0754ad5 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -575,10 +575,16 @@ KMOD_EXPORT int kmod_module_new_from_lookup(struct kmod_ctx *ctx,
 	err = kmod_lookup_alias_from_aliases_file(ctx, alias, list);
 	CHECK_ERR_AND_FINISH(err, fail, list, finish);
 
-	DBG(ctx, "lookup modules.builtin %s\n", alias);
-	err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
+	DBG(ctx, "lookup modules.builtin.modinfo %s\n", alias);
+	err = kmod_lookup_alias_from_kernel_builtin_file(ctx, alias, list);
 	CHECK_ERR_AND_FINISH(err, fail, list, finish);
 
+	if (err == 0) {
+		DBG(ctx, "lookup modules.builtin %s\n", alias);
+		err = kmod_lookup_alias_from_builtin_file(ctx, alias, list);
+		CHECK_ERR_AND_FINISH(err, fail, list, finish);
+	}
+
 finish:
 	DBG(ctx, "lookup %s=%d, list=%p\n", alias, err, *list);
 	return err;
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 69fe431..c9d9e2a 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -57,6 +57,7 @@ static struct _index_files {
 	[KMOD_INDEX_MODULES_DEP] = { .fn = "modules.dep", .prefix = "" },
 	[KMOD_INDEX_MODULES_ALIAS] = { .fn = "modules.alias", .prefix = "alias " },
 	[KMOD_INDEX_MODULES_SYMBOL] = { .fn = "modules.symbols", .prefix = "alias "},
+	[KMOD_INDEX_MODULES_BUILTIN_ALIAS] = { .fn = "modules.builtin.alias", .prefix = "" },
 	[KMOD_INDEX_MODULES_BUILTIN] = { .fn = "modules.builtin", .prefix = ""},
 };
 
@@ -522,6 +523,30 @@ static char *lookup_builtin_file(struct kmod_ctx *ctx, const char *name)
 	return line;
 }
 
+int kmod_lookup_alias_from_kernel_builtin_file(struct kmod_ctx *ctx,
+						const char *name,
+						struct kmod_list **list)
+{
+	struct kmod_list *l;
+	int ret = kmod_lookup_alias_from_alias_bin(ctx,
+						KMOD_INDEX_MODULES_BUILTIN_ALIAS,
+						name, list);
+	if (ret > 0) {
+		kmod_list_foreach(l, *list) {
+			struct kmod_module *mod = l->data;
+			kmod_module_set_builtin(mod, true);
+		}
+	} else if (ret == -ENOSYS) {
+		/*
+		 * If the system does not support this yet, then
+		 * there is no need to return an error.
+		 */
+		ret = 0;
+	}
+
+	return ret;
+}
+
 int kmod_lookup_alias_from_builtin_file(struct kmod_ctx *ctx, const char *name,
 						struct kmod_list **list)
 {
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 352627e..3cab2e5 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -70,6 +70,7 @@ enum kmod_index {
 	KMOD_INDEX_MODULES_DEP = 0,
 	KMOD_INDEX_MODULES_ALIAS,
 	KMOD_INDEX_MODULES_SYMBOL,
+	KMOD_INDEX_MODULES_BUILTIN_ALIAS,
 	KMOD_INDEX_MODULES_BUILTIN,
 	/* Padding to make sure enum is not mapped to char */
 	_KMOD_INDEX_PAD = 1U << 31,
diff --git a/tools/depmod.c b/tools/depmod.c
index 391afe9..fbbce10 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2402,6 +2402,68 @@ static int output_devname(struct depmod *depmod, FILE *out)
 	return 0;
 }
 
+static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
+{
+	int ret = 0, count = 0;
+	struct index_node *idx;
+	struct kmod_list *l, *builtin = NULL;
+
+	idx = index_create();
+
+	if (idx == NULL) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	ret = kmod_module_get_builtin(depmod->ctx, &builtin);
+	if (ret < 0) {
+		if (ret == -ENOENT)
+			ret = 0;
+		goto fail;
+	}
+
+	kmod_list_foreach(l, builtin) {
+		struct kmod_list *ll, *info_list = NULL;
+		struct kmod_module *mod = l->data;
+		const char *modname = kmod_module_get_name(mod);
+
+		ret = kmod_module_get_info(mod, &info_list);
+		if (ret < 0)
+			goto fail;
+
+		kmod_list_foreach(ll, info_list) {
+			char alias[PATH_MAX];
+			const char *key = kmod_module_info_get_key(ll);
+			const char *value = kmod_module_info_get_value(ll);
+
+			if (!streq(key, "alias"))
+				continue;
+
+			alias[0] = '\0';
+			if (alias_normalize(value, alias, NULL) < 0) {
+				WRN("Unmatched bracket in %s\n", value);
+				continue;
+			}
+
+			index_insert(idx, alias, modname, 0);
+		}
+
+		kmod_module_info_free_list(info_list);
+
+		index_insert(idx, modname, modname, 0);
+		count++;
+	}
+
+	if (count)
+		index_write(idx, out);
+	index_destroy(idx);
+fail:
+	if (builtin)
+		kmod_module_unref_list(builtin);
+
+	return ret;
+}
+
 static int depmod_output(struct depmod *depmod, FILE *out)
 {
 	static const struct depfile {
@@ -2416,6 +2478,7 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 		{ "modules.symbols", output_symbols },
 		{ "modules.symbols.bin", output_symbols_bin },
 		{ "modules.builtin.bin", output_builtin_bin },
+		{ "modules.builtin.alias.bin", output_builtin_alias_bin },
 		{ "modules.devname", output_devname },
 		{ }
 	};
-- 
2.21.0

