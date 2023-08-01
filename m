Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAC3C00528
	for <util-linux@archiver.kernel.org>; Tue,  1 Aug 2023 19:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjHAT7t (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Aug 2023 15:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjHAT7s (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Aug 2023 15:59:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E2B0
        for <util-linux@vger.kernel.org>; Tue,  1 Aug 2023 12:59:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbbfec0517so7942885ad.0
        for <util-linux@vger.kernel.org>; Tue, 01 Aug 2023 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690919987; x=1691524787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06aYODYW67th/tVj5HrB1L2s1tdG66tfe1XElb8yP8Y=;
        b=B6DTxzjnBUrUIzb/tQ4cmuM1DhvJT6bkF54JShcOhJBfroUp3IfAwPtn94k65Cl2Pv
         l6sFAkuPu6jU0HPSuECTa18oIfiV1wVX3DYGFZ5QpUBMReaqgn5KACd8mKOKwadnonGI
         DVegm9w5zG+1ZrC9/hAufV196ZCQ9PJ7X2Ypg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690919987; x=1691524787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06aYODYW67th/tVj5HrB1L2s1tdG66tfe1XElb8yP8Y=;
        b=Ku3isEFqsyjoNb1Wd8X3s8r/FZvPwrJEA3mBuwdT60yotjWPoGJxHQDmEFXiQvRBTX
         1rr6Xj2eg+3pSmnrkDmmKU3uBh6NFd2O+zlXOiWCYw+ECreVtFapXlwZ5AzLKmPTI+9C
         8PJ/VHpdZPyYBzqe4KIjjKIfw+P4V7AljN7rmEi1GpYYpxBEjRDOw1G2AAp9jyJc7K6h
         gNXU/64o4+jrve7BOoVpk3a3/fMBFppiAbYIzCeGwxg/WTi/pdmAsIScWO7slB2MuUVL
         3DiCBFbYhEA6HRYi5OyXhumin2iFFQnhXdplzHVtQ/CqYVpeHs7Kp4WaScUvfaeK+Wuz
         WvjQ==
X-Gm-Message-State: ABy/qLYIB/fP1FvWOCsWIeLj2Z0wieV7MmV37UTY3ue8Y0nFxY8z5gI6
        3tjjxcd7qzhyIUZvjzjoR9G3sQ==
X-Google-Smtp-Source: APBJJlHzUj+nnSOlcOLSYY0RbS5eD2Bf+dWZa8WVSlZ1skd+hS/+kOKlRnm3cLmpzdIhUNqbzFGH0Q==
X-Received: by 2002:a17:902:e810:b0:1b8:5827:8763 with SMTP id u16-20020a170902e81000b001b858278763mr13447174plg.4.1690919987281;
        Tue, 01 Aug 2023 12:59:47 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id jk21-20020a170903331500b001b88da737c6sm10804318plb.54.2023.08.01.12.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 12:59:47 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id 04A0D41C; Tue,  1 Aug 2023 12:59:46 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     util-linux mailing list <util-linux@vger.kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH 2/2] libmount: check for struct statx
Date:   Tue,  1 Aug 2023 12:59:27 -0700
Message-Id: <20230801195927.43090-3-mmayer@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230801195927.43090-1-mmayer@broadcom.com>
References: <20230801195927.43090-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Let's ensure struct statx exists before we try to use it. Checking for
the existence of linux/stat.h is not sufficient. This is because
[uapi/]linux/stat.h has existed since Linux 3.7, however struct statx
was only introduced with Linux 4.11.

The problem arises if one happens ot be using kernel headers from within
the aforementioned range, such as Linux 4.9.

  CC       libmount/src/la-utils.lo
In file included from libmount/src/utils.c:31:
./include/fileutils.h:100:33: warning: declaration of 'struct statx' will not
be visible outside of this function [-Wvisibility]
                    unsigned int mask, struct statx *stx)
                                              ^
libmount/src/utils.c:117:16: error: variable has incomplete type 'struct statx'
                struct statx stx = { 0 };
                             ^
libmount/src/utils.c:117:10: note: forward declaration of 'struct statx'
                struct statx stx = { 0 };
                       ^
libmount/src/utils.c:125:5: error: use of undeclared identifier 'STATX_TYPE'
                                STATX_TYPE
                                ^
libmount/src/utils.c:126:8: error: use of undeclared identifier 'STATX_MODE'
                                        | STATX_MODE
                                          ^
libmount/src/utils.c:127:8: error: use of undeclared identifier 'STATX_INO'
                                        | STATX_INO,
                                          ^
1 warning and 4 errors generated.
make[4]: *** [Makefile:11269: libmount/src/la-utils.lo] Error 1

Checking for the presence of struct statx explicitly avoids this
problem.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 configure.ac         | 1 +
 include/fileutils.h  | 2 +-
 libmount/src/utils.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index dd582f2a4bd1..a3cf330b5ec3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -518,6 +518,7 @@ AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 ])
 
 AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
+AC_CHECK_TYPES([struct statx], [], [], [[#include <linux/stat.h>]])
 AC_CHECK_TYPES([enum fsconfig_command], [], [], [[#include <linux/mount.h>]])
 
 AC_CHECK_MEMBERS([struct termios.c_line],,,
diff --git a/include/fileutils.h b/include/fileutils.h
index 13d2bdf0c6e5..a5fe517266f5 100644
--- a/include/fileutils.h
+++ b/include/fileutils.h
@@ -94,7 +94,7 @@ static inline int close_range(unsigned int first, unsigned int last, int flags)
 #  define HAVE_CLOSE_RANGE 1
 # endif	/* SYS_close_range */
 
-# if !defined(HAVE_STATX) && defined(SYS_statx) && defined(HAVE_LINUX_STAT_H)
+# if !defined(HAVE_STATX) && defined(HAVE_STRUCT_STATX) && defined(SYS_statx) && defined(HAVE_LINUX_STAT_H)
 #  include <linux/stat.h>
 static inline int statx(int fd, const char *restrict path, int flags,
 		    unsigned int mask, struct statx *stx)
diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 50553f1d5a14..e550b2d079e8 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -111,7 +111,7 @@ static int safe_stat(const char *target, struct stat *st, int nofollow)
 
 	memset(st, 0, sizeof(struct stat));
 
-#ifdef AT_STATX_DONT_SYNC
+#if defined(AT_STATX_DONT_SYNC) && defined (HAVE_STRUCT_STATX)
 	{
 		int rc;
 		struct statx stx = { 0 };
-- 
2.40.1

