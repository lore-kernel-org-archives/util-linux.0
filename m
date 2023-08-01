Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD2BC00528
	for <util-linux@archiver.kernel.org>; Tue,  1 Aug 2023 19:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjHAT7m (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Aug 2023 15:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjHAT7m (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Aug 2023 15:59:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C1211B
        for <util-linux@vger.kernel.org>; Tue,  1 Aug 2023 12:59:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6873f64a290so655015b3a.0
        for <util-linux@vger.kernel.org>; Tue, 01 Aug 2023 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690919980; x=1691524780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQZ+STzlfrv4v+UyC+oqZMbrqKGeRgxH+j29a7Anp/g=;
        b=A/16sGL+WvzhnQPnS9VQY3kySMbyIAgqlWthqZX5ETEUa+wHRi+iyyqY/SIYsoLm5x
         0JLjYZs8xwKnLGXyf53lrBuCp9f2YTHnGGjt4BXasIiZuc+BxHmMHMDEMMzec6qKMPY2
         3GW2KONO+dB9oIWCOt8PKeuOS6rQJ45whdEaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690919980; x=1691524780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQZ+STzlfrv4v+UyC+oqZMbrqKGeRgxH+j29a7Anp/g=;
        b=bEMAJfl4BZndyXf8IbULUPkheeq9Med5T2gHvqA0zEtNoNdrXTjdpU+PF/A+6Q0WRT
         xSiuIq4B07Y2NFC4KTzWgj+hkxe0EDgOsAwwwzrttQjbQSSWqec+0K6xHjgeSa8ILHet
         lAMFRTc9RgWJhTkTzRmH78jrt9HsLJODuERy/iklDPy0vcojx8F/VVQVckx48QfReyzH
         m1URyyzrCA9QLR+erSTwZnXlxi+C7VpuPzcGI20jr1A4cqAgKRCVDMYEWwzAO/PUsWfK
         h6Inz3lJGnrbidKN9S+u4UfJtKJoYTLedP4kHdgitnW/jg2S54bnCjCwjT6h4f6++ZlW
         cyAw==
X-Gm-Message-State: ABy/qLZXbbQC5DVzAlBjXjk/+OwVOhVqXb8BKx1yilGbonICP8Zo50z1
        v9ss7ElCTO+9jInwXpKTzRereqBknlL5A9ADW5kO6w==
X-Google-Smtp-Source: APBJJlGdcbDadkSAEFiRL5MYnJ2oJ2TjS3fEe+0leNPrvdxduQlvrz4p5API+RxoWV1eRHe1PT2kXw==
X-Received: by 2002:a17:902:ea0b:b0:1b8:95fc:cfe with SMTP id s11-20020a170902ea0b00b001b895fc0cfemr13755073plg.3.1690919980017;
        Tue, 01 Aug 2023 12:59:40 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id k19-20020a170902761300b001bc2831e1a8sm1799784pll.80.2023.08.01.12.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 12:59:39 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id A708041A; Tue,  1 Aug 2023 12:59:38 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     util-linux mailing list <util-linux@vger.kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH 1/2] libmount: check for linux/mount.h
Date:   Tue,  1 Aug 2023 12:59:26 -0700
Message-Id: <20230801195927.43090-2-mmayer@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230801195927.43090-1-mmayer@broadcom.com>
References: <20230801195927.43090-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Check that linux/mount.h is present before using features that rely on
it.

It is necessary to check for the presence of linux/mount.h explicitly.
Simply relying on the presence of several syscalls (e.g. SYS_move_mount,
SYS_open_tree) does not work reliably, at least not in a cross-compiling
environment.

The syscall definitions are provided by the C library. Meanwhile,
linux/mount.h is provided by the kernel. This opens the possibility for
discrepancies.

A problem arises if the C library (e.g. musl-1.2.3) defines all "mount
fd API" syscalls (and HAVE_MOUNTFD_API becomes true), but the kernel
headers are old enough to not provide linux/mount.h. The resulting error
looks as follows. This example is using an LLVM-13 cross-compiler from
x86_64 to aarch64 with musl-1.2.3 as the C library.

  CC       libmount/src/la-hooks.lo
In file included from libmount/src/hooks.c:30:
./include/mount-api-utils.h:11:10: fatal error: 'linux/mount.h' file not found
         ^~~~~~~~~~~~~~~
1 error generated.
make[4]: *** [Makefile:11185: libmount/src/la-hooks.lo] Error 1

To prevent this condition, we add a check to configure that will test
for the presence of linux/mount.h in addition to testing for the mount
fd API. Only if both conditions are met can we actually use the mount
fd API.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 configure.ac              | 8 ++++++++
 include/mount-api-utils.h | 4 ++--
 libmount/src/hook_idmap.c | 4 ++--
 libmount/src/hooks.c      | 2 +-
 libmount/src/version.c    | 2 +-
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 11b2e155dd2d..dd582f2a4bd1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -389,6 +389,12 @@ AC_CHECK_HEADERS([linux/fs.h ], [], [],
   #endif
 ])
 
+AC_CHECK_HEADERS([linux/mount.h ], [], [],
+ [#ifdef HAVE_LINUX_MOUNT_H
+   # include <linux/mount.h>
+   #endif
+])
+
 AC_CHECK_HEADERS([linux/gsmmux.h ], [], [],
  [#ifdef LINUX_GSMMUX_H
    # include <linux/gsmmux.h>
@@ -479,6 +485,7 @@ have_linux_blkzoned_h=$ac_cv_header_linux_blkzoned_h
 have_linux_btrfs_h=$ac_cv_header_linux_btrfs_h
 have_linux_capability_h=$ac_cv_header_linux_capability_h
 have_linux_kcmp_h=$ac_cv_header_linux_kcmp_h
+have_linux_mount_h=$ac_cv_header_linux_mount_h
 have_linux_pr_h=$ac_cv_header_linux_pr_h
 have_linux_raw_h=$ac_cv_header_linux_raw_h
 have_linux_securebits_h=$ac_cv_header_linux_securebits_h
@@ -1247,6 +1254,7 @@ UL_BUILD_INIT([libmount_mountfd_support])
 UL_REQUIRES_BUILD([libmount_mountfd_support], [libmount])
 UL_REQUIRES_LINUX([libmount_mountfd_support])
 UL_REQUIRES_HAVE([libmount_mountfd_support], [mountfd_api], [mount FDs based API])
+UL_REQUIRES_HAVE([libmount_mountfd_support], [linux_mount_h], [linux/mount.h])
 AS_IF([test "x$build_libmount_mountfd_support" = xyes ], [
   AC_DEFINE([USE_LIBMOUNT_MOUNTFD_SUPPORT], [1], [Enable support for new mount FD based kernel API])
 ])
diff --git a/include/mount-api-utils.h b/include/mount-api-utils.h
index 9044e1cd9d61..8ae546b7ed9f 100644
--- a/include/mount-api-utils.h
+++ b/include/mount-api-utils.h
@@ -5,7 +5,7 @@
 #ifndef UTIL_LINUX_MOUNT_API_UTILS
 #define UTIL_LINUX_MOUNT_API_UTILS
 
-#ifdef HAVE_MOUNTFD_API
+#if defined(HAVE_MOUNTFD_API) && defined(HAVE_LINUX_MOUNT_H)
 
 #include <sys/syscall.h>
 #include <linux/mount.h>
@@ -203,6 +203,6 @@ static inline int fspick(int dfd, const char *pathname, unsigned int flags)
 }
 #endif
 
-#endif /* HAVE_MOUNTFD_API */
+#endif /* HAVE_MOUNTFD_API && HAVE_LINUX_MOUNT_H */
 #endif /* UTIL_LINUX_MOUNT_API_UTILS */
 
diff --git a/libmount/src/hook_idmap.c b/libmount/src/hook_idmap.c
index b3e1d82d4b97..9b2425a77def 100644
--- a/libmount/src/hook_idmap.c
+++ b/libmount/src/hook_idmap.c
@@ -33,7 +33,7 @@
 # include <linux/nsfs.h>
 #endif
 
-#ifdef HAVE_MOUNTFD_API
+#if defined(HAVE_MOUNTFD_API) && defined(HAVE_LINUX_MOUNT_H)
 
 typedef enum idmap_type_t {
 	ID_TYPE_UID,	/* uidmap entry */
@@ -518,4 +518,4 @@ const struct libmnt_hookset hookset_idmap =
 	.deinit = hookset_deinit
 };
 
-#endif /* HAVE_MOUNTFD_API */
+#endif /* HAVE_MOUNTFD_API && HAVE_LINUX_MOUNT_H */
diff --git a/libmount/src/hooks.c b/libmount/src/hooks.c
index 88cf68d61110..affa162d3445 100644
--- a/libmount/src/hooks.c
+++ b/libmount/src/hooks.c
@@ -46,7 +46,7 @@ static const struct libmnt_hookset *hooksets[] =
 	&hookset_mount,
 #endif
 	&hookset_mount_legacy,
-#ifdef HAVE_MOUNTFD_API
+#if defined(HAVE_MOUNTFD_API) && defined(HAVE_LINUX_MOUNT_H)
 	&hookset_idmap,
 #endif
 	&hookset_owner
diff --git a/libmount/src/version.c b/libmount/src/version.c
index 948b1a01de98..8e5f165f4920 100644
--- a/libmount/src/version.c
+++ b/libmount/src/version.c
@@ -38,7 +38,7 @@ static const char *lib_features[] = {
 #ifdef USE_LIBMOUNT_SUPPORT_NAMESPACES
 	"namespaces",
 #endif
-#ifdef HAVE_MOUNTFD_API
+#if defined(HAVE_MOUNTFD_API) && defined(HAVE_LINUX_MOUNT_H)
 	"idmapping",
 #endif
 #ifdef USE_LIBMOUNT_MOUNTFD_SUPPORT
-- 
2.40.1

