Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB4BC433EF
	for <util-linux@archiver.kernel.org>; Tue, 12 Apr 2022 04:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiDLFCK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Apr 2022 01:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347291AbiDLFCH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Apr 2022 01:02:07 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2076.outbound.protection.outlook.com [40.92.47.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9760B340C8
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 21:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fddVJWJeJ5KE/D0wlKNHOPcMcW0+H+Q9B2cTQLKNJ+8x/lYx4nnE16Y6xqdhMtP+/xJJaO+HIJc4SUJBVCMKPSZqw6bHJsrEU+psHpUcvo6EUSC+kQ1UZKFXPhT1TS5kRa1dLrhNz2PA3KF+l37cIzfDZteSSfmQdmn0ABhBjXrv3HRFRJCTEWdDzhOAMintaDvkDKRbzEmEME9JtIAY22C+FlD/qa+9Y+bOt4O5hCoPB0Q2Nt3DTJgdzb2AGjKD46Fj5grqMDa21ce2+VQYSq6Ruoiv0s0q8omEm67YL1kZfQS2BrZIX6ld5pDKmHVMPEuqCE9pken+x27tiR/+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWLxB2FlG2OgDaH2cyhxQQedVgplm+uQoWNz5Kw+6R0=;
 b=OXQPkSRi/qzW1mGOQWglz1PTVO1VrjRQ5PR9wCYiBTlaSDmzr/lBHvIvxuNQaQzrgAGVw/YNrm9bMAUXrIZ+eINRGpkUqqWX31TId3yTRkk+Fg3/3PQIVwBRsK27DqAMywAbJcDrclfZp8JJJxr9L2CYhNCLIeQxS2zR+6UvW61Lcp/Dr4ai6Bi4zMLl6b5r96HJu5MdLfWe0XwcjqWbDnJHAB+wIQBDSaGrxUGe088iX0vPA8q/C+995xh/UQ8lEdjbrV7eG94G6BgLf14eaWRetTbQ02VORWVLoQh0iMSU3H15pBgZFRMWOhftCap2A+vT8iCvdFYAtgVSYkXvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWLxB2FlG2OgDaH2cyhxQQedVgplm+uQoWNz5Kw+6R0=;
 b=IVHmDrGzKcY2zfGwCPmj5Dxj57zjY/7gwuxAUdtn0aC4630nhTl2hbgLeDOAvkcPi/lHaUGTLQb9avtFDOAwYhV4JVf9RDUXXuI7x16PkqOKc/wu5janad2TfO0fWT7ogu+IAfA6Da4RfoORbsvmnrj1ogPhSMRxibzsptihAJRJkWc9PhTbj7uAKetjjYEQ3FIpBkmRygsgkVY+lX1iqvPMimFLzT0BsHxupKlzRZgUUQvFMYjoN9yjroR+1WSthCYFEQOtHjZOdYNFDGaAWGOyGoKBiRe997aD1zLaqolczu9rx0te8dunHHSj+yjRYbHS7pEgVsx12zblUPvEig==
Received: from SN6PR04MB3983.namprd04.prod.outlook.com (2603:10b6:805:4c::19)
 by BL0PR04MB5043.namprd04.prod.outlook.com (2603:10b6:208:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 04:59:46 +0000
Received: from SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::5102:79c8:1ec5:d316]) by SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::5102:79c8:1ec5:d316%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 04:59:46 +0000
From:   Nathan Sharp <nwsharp@live.com>
To:     util-linux@vger.kernel.org
Cc:     Nathan Sharp <nwsharp@live.com>
Subject: [PATCH RFC 1/4] misc-utils: add the pipesz utility
Date:   Mon, 11 Apr 2022 22:59:27 -0600
Message-ID: <SN6PR04MB3983957C75B4FF779E3D611CC2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412045930.236051-1-nwsharp@live.com>
References: <20220412045930.236051-1-nwsharp@live.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Ptra6lYR1xBt541qgjO/yeOKbkpeIopu]
X-ClientProxiedBy: CH2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:610:4c::25) To SN6PR04MB3983.namprd04.prod.outlook.com
 (2603:10b6:805:4c::19)
X-Microsoft-Original-Message-ID: <20220412045930.236051-2-nwsharp@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f261ae5-c3e6-412d-b4bb-08da1c41439e
X-MS-Exchange-SLBlob-MailProps: S/btQ8cKWiThIBhrdRr4cLcE9KU0705s/jl1q8GM7NWHMPe0qADj91wESf5qLtB4Gx913zxkrSkmW5RqY4P2O1wE6grJkq6MPAUhOBeFETdvwhi4/puP9MK8fPUzV7jA8SyZegwVHQkNRurrSOdagUrLNqNpEWItBmjGbL6OanHXPZ+ny95QtRRr9FUO+cnyX8Gq9nIXSxpIxTGZkMwbfsI1HCq7yYei76n3VQCnVPviQdwghv2fo13pX7nyblSLGm1z8hdBwAa4qJuIqN9axgRBNf9Ze3MSDaDEB4pO910b6cBhp49ANje1FpTP5jxCte+Jtusxi8A2mWZlhIiUUtbM7cqKMHGSl5hUui7eniQRdbtxgV2EwQjcqWB+o0t0njhki+pmdyVG8yGIbkCuLsECXTP2Ldk9S1bCuGbvPO0IdmFgmdPzGx7SWFTcZ0bkRGVFCAw5vSGHoWXgLi0GEze78Eg31vuAVskuQWztQj5GQ0mxufIKk17hzaIlxvTeyMn/RdHml0jz5bR9IxxR2DP7HkSdLsr2h3HZqbMPorX3adE0JDnR24Q+0o4AqyGTrwGVXrFxZjQC8f2aYy5EwJZwEVnODMUkYjm1RpOfQNJSJgVHzadg0317UwcUzRsgvnKHR2njQ5t9O8NC6U7DihtPKwAdy3JpO0wgXg2aWoWfvRTt7rv7uHksbbAKULUHzW0sEPevjvumUg8a/erBE618PQFd3c7hpKoAewoDS+c0Rn3ZIkYCkHjJoJh2tvLJRZUehtYyHiU=
X-MS-TrafficTypeDiagnostic: BL0PR04MB5043:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /l+CAQDO08RqSZJKHZ4dUXXxouaHP0GYTiA6hMXFls1XRQMY/HrMF/uNlbcUIicE5CzHRbl9rgBBgkqPtF/7ZMzmgVh0ykPa4c7WtxzFKA++b3clrdkdcMRgVqz7nmHXtF7uU5OLPyvn31kI6hSQjKVsa8MhQEnjZngPfz6Ey8OH5xUtHQEZHjQaIb6dvjflA+22r0ZyHaymv5gj2GNkB19ez1/7Vr/xz+ktEBm7ibxV0aWMCZAEIznsDaejem0XclgXB6jICG9Cvs7RuoNaY9pN5Hn0StlZqCt2whddRpUeanVi/V8JhogkT1B/VpCOzxHDgvzl1xKfvCY0JsDNczs1K+PpRzxH72A9pum+f8yhCu7WMGSE94SdOmRFI5CRBJA5LO6OSkM6ELCxsxLBYJc1mo0zjH/kEsIuiR32dDAzHJ1hnasdyhSOT+jvMb834bSshAXWBZahWMhFT+2RHnEY5rAAvrLr1MPRbKwE/CtciSjDAPBohvF1MXwBofekpFAqtMX87z9ItdsqNCeG9oIpj3tGG5cUFRqqDz6ZNlAEBynUAoyNamLBqNz/3AbXcXbstWyN+sS1Cw7jLI+6JQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TGisoKOGSyKvxSW7GfOtGmPfOX+CwM6/9isVW5sNxMBRo9bjn3E40VijOUe/?=
 =?us-ascii?Q?Q+wPdcIB+BU7yzRL9Nf3P/sAl95gxNzYpJRPkvjoFyDbVfTQkmf//CwTMHds?=
 =?us-ascii?Q?CR8arCTaQIdLX/6c8HfJn0NeVmJhMtcWxf12mEa4LE0YLP8K4aEk/QR7d/K1?=
 =?us-ascii?Q?KbJNZyAFEfxtdeDrLjmuO+kRSsU8OJplHPzF/mrTs/7DBN+klK3kAoBdAX7b?=
 =?us-ascii?Q?wON4dyRvsqvFVay0+1NCBKx8WZGtLCkQpPM1wHafX82VTxe7JWp7hYvUG7yb?=
 =?us-ascii?Q?lzdVFtvcFEAn07kPYMhDc1AdEUtYXBFSyIWvDZGheivx5zyI1s1YLcUGu1UZ?=
 =?us-ascii?Q?L4jLEs4bGVhyJ20W2V00oVA5VYnqfrPVpv2e7fXgPxdviUXJuj3AEpCoz8mU?=
 =?us-ascii?Q?HN2VhFtFy97nkQ0MH7tvQinPm4j9hDhV9ITHc+aHnk1LLaqfDjMS8j61e1ig?=
 =?us-ascii?Q?sjn0knAwRyewD8/6PQyo72r0pJ1iO9iZq0zSVvBdML3mQIjVdIsEtYtiLb+/?=
 =?us-ascii?Q?9BjcS59K8mIlnX5tbTrCxn388saGpcJIa0inPG/NBXWTfvJln8c61LFj9kn+?=
 =?us-ascii?Q?w8KdgW6715BIsKP/ozeIjHLeKS2DdvV0S3CKjBvMjHDPwmFkv6vbyLbVnwQ7?=
 =?us-ascii?Q?drhwod9p4KfAh8CcDOBMiTvmr3jRLXHPbPh9d77Y9Y08ZRnslIawLHIjTMQ3?=
 =?us-ascii?Q?8eKauBVyK8coiEw6lb589KRpQRm/K4okr/fpg7M5drBMVmRHen91H+snLso9?=
 =?us-ascii?Q?eI4raYu/w7DFMoaorz+Df6RWjje8HLSPaBsY4Htt8aowwPdo2ZqK1UGpnoZH?=
 =?us-ascii?Q?+LAmqgvaPV0iNma17pbiNyeFOAQgkIOICEG9g3OgplS+Ouhd+fM1XOqPfBpB?=
 =?us-ascii?Q?vzMVhZGrue+QYp02zTYZUR35mbcgCYIGAOvDtVYbNk78YV3MX3wOgKAdaqbG?=
 =?us-ascii?Q?Jv2oATctshTXqQShT/9QpRA1jsWidBJXVbShE+4SnbItUsoE4LkP+42dk//M?=
 =?us-ascii?Q?t2rZOrMuCWq6iKC54oo9ych4O31lLJ//P+xu2IcE1ZRYBvznw0etynqx9Y1l?=
 =?us-ascii?Q?aNPOmJRQSfnMkBhRlSMMiDY/7bZZ6L7/yIT+yFd8QkLgHDLKuRIkVBDiE3k7?=
 =?us-ascii?Q?15+QtWW41CvB32VcSxqmO4nYaM/5EgWQGJ+au3xvHKO1zxRtdXuEiDXFoj/V?=
 =?us-ascii?Q?SyC7dKfSa654UJl8dPr4aixz82DEq+VZPmn2pYjw4qUB+5bgTx3rk0MhMhCw?=
 =?us-ascii?Q?+Y75zfnsT+V8jMzdOK8ALk1Gt3BHcbLQEDzwrfusLpwaJcEGbokuxCCO57Hj?=
 =?us-ascii?Q?epTCu+DTa92h6DKibm6ybxk0lGhWJKUhDUV46L+1ScAt50ONWo9iiv5QHAdX?=
 =?us-ascii?Q?/RkiYLPl6rvk/0/9bO3oSH9VW3ZrCEl1CMwOZMKEJk+rM4U83AkboigvwS03?=
 =?us-ascii?Q?FNZNZNCZLsU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f261ae5-c3e6-412d-b4bb-08da1c41439e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB3983.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 04:59:46.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5043
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

pipesz is a utility to examine and adjust the size of pipe buffers.

It uses fctnl F_GETPIPE_SZ and F_SETPIPE_SZ to examine and resize
these buffers. This functionality is unique to Linux and was added in
version 2.6.35. Minor bugfixes were made in 4.9, but these do not
obviate the use of pipesz prior to that release.

Signed-off-by: Nathan Sharp <nwsharp@live.com>
---
 .gitignore               |   1 +
 configure.ac             |   8 +
 include/pathnames.h      |   4 +
 meson.build              |  12 ++
 meson_options.txt        |   2 +
 misc-utils/Makemodule.am |   7 +
 misc-utils/meson.build   |   4 +
 misc-utils/pipesz.c      | 347 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 385 insertions(+)
 create mode 100644 misc-utils/pipesz.c

diff --git a/.gitignore b/.gitignore
index 840f646..a31e7e5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -143,6 +143,7 @@ ylwrap
 /nsenter
 /partx
 /pg
+/pipesz
 /pivot_root
 /prlimit
 /raw
diff --git a/configure.ac b/configure.ac
index 2c3b432..3ac79a5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1785,6 +1785,14 @@ AC_ARG_ENABLE([whereis],
 UL_BUILD_INIT([whereis])
 AM_CONDITIONAL([BUILD_WHEREIS], [test "x$build_whereis" = xyes])
 
+AC_ARG_ENABLE([pipesz],
+  AS_HELP_STRING([--disable-pipesz], [do not build pipesz]),
+  [], [UL_DEFAULT_ENABLE([pipesz])]
+)
+UL_BUILD_INIT([pipesz])
+UL_REQUIRES_LINUX([pipesz])
+AM_CONDITIONAL([BUILD_PIPESZ], [test "x$build_pipesz" = xyes])
+
 UL_BUILD_INIT([getopt], [yes])
 AM_CONDITIONAL([BUILD_GETOPT], [test "x$build_getopt" = xyes])
 
diff --git a/include/pathnames.h b/include/pathnames.h
index d86d9d5..0887bd7 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -198,6 +198,10 @@
 #define _PATH_PROC_UCLAMP_MIN	_PATH_PROC_KERNEL "/sched_util_clamp_min"
 #define _PATH_PROC_UCLAMP_MAX	_PATH_PROC_KERNEL "/sched_util_clamp_max"
 
+/* sysctl fs paths */
+#define _PATH_PROC_SYS_FS	"/proc/sys/fs"
+#define _PATH_PROC_PIPE_MAX_SIZE	_PATH_PROC_SYS_FS "/pipe-max-size"
+
 /* irqtop paths */
 #define _PATH_PROC_INTERRUPTS	"/proc/interrupts"
 #define _PATH_PROC_SOFTIRQS	"/proc/softirqs"
diff --git a/meson.build b/meson.build
index 0642ab5..358572e 100644
--- a/meson.build
+++ b/meson.build
@@ -2678,6 +2678,18 @@ if not is_disabler(exe)
   bashcompletions += ['hardlink']
 endif
 
+opt = not get_option('build-pipesz').disabled()
+exe = executable(
+  'pipesz',
+  pipesz_sources,
+  include_directories : includes,
+  link_with : [lib_common],
+  install_dir : usrbin_exec_dir,
+  install : true)
+if opt and not is_disabler(exe)
+  exes += exe
+endif
+
 exe = executable(
   'test_cal',
   cal_sources,
diff --git a/meson_options.txt b/meson_options.txt
index 64c9924..5272cb3 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -150,6 +150,8 @@ option('build-more', type : 'feature',
        description : 'build more')
 option('build-pg', type : 'feature',
        description : 'build pg')
+option('build-pipesz', type : 'feature',
+       description : 'build pipesz')
 option('build-setterm', type : 'feature',
        description : 'build setterm')
 option('build-schedutils', type : 'feature',
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index cc18acb..60c7fe1 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -266,3 +266,10 @@ lsfd_SOURCES = \
 lsfd_LDADD = $(LDADD) libsmartcols.la libcommon.la
 lsfd_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
 endif
+
+if BUILD_PIPESZ
+bin_PROGRAMS += pipesz
+pipesz_SOURCES = misc-utils/pipesz.c
+pipesz_LDADD = $(LDADD) libcommon.la
+pipesz_CFLAGS = $(AM_CFLAGS)
+endif
diff --git a/misc-utils/meson.build b/misc-utils/meson.build
index d435207..16310a9 100644
--- a/misc-utils/meson.build
+++ b/misc-utils/meson.build
@@ -140,3 +140,7 @@ hardlink_sources = files(
 cal_sources = files(
   'cal.c',
 )
+
+pipesz_sources = files(
+  'pipesz.c',
+)
diff --git a/misc-utils/pipesz.c b/misc-utils/pipesz.c
new file mode 100644
index 0000000..1283d86
--- /dev/null
+++ b/misc-utils/pipesz.c
@@ -0,0 +1,347 @@
+/*
+ * pipesz(1) - Set or examine pipe buffer sizes.
+ *
+ * Copyright (c) 2022 Nathan Sharp
+ * Written by Nathan Sharp <nwsharp@live.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <getopt.h>
+#include <sys/ioctl.h>		/* FIONREAD */
+#include <fcntl.h>		/* F_GETPIPE_SZ F_SETPIPE_SZ */
+
+#include "c.h"
+#include "nls.h"
+
+#include "closestream.h"	/* close_stdout_atexit */
+#include "optutils.h"		/* err_exclusive_options */
+#include "path.h"		/* ul_path_read_s32 */
+#include "pathnames.h"		/* _PATH_PROC_PIPE_MAX_SIZE */
+#include "strutils.h"		/* strtos32_or_err strtosize_or_err */
+
+static char opt_check = 0;	/* --check */
+static char opt_get = 0; 	/* --get */
+static char opt_quiet = 0;	/* --quiet */
+static int opt_size = -1;	/* --set <size> */
+static char opt_verbose = 0;	/* --verbose */
+
+/* fallback file for default size */
+#ifndef PIPESZ_DEFAULT_SIZE_FILE
+#define PIPESZ_DEFAULT_SIZE_FILE _PATH_PROC_PIPE_MAX_SIZE
+#endif
+
+/* convenience macros, since pipesz is by default very lenient */
+#define check(FMT...) do {			\
+	if (opt_check) {			\
+		err(EXIT_FAILURE, FMT);		\
+	} else if (!opt_quiet)	{		\
+		warn(FMT);			\
+	}					\
+} while (0)
+
+#define checkx(FMT...) do {			\
+	if (opt_check) {			\
+		errx(EXIT_FAILURE, FMT);	\
+	} else if (!opt_quiet) {		\
+		warnx(FMT);			\
+	}					\
+} while (0)
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	fputs(USAGE_HEADER, stdout);
+	printf(_(" %s [options] [--set <size>] [--] [command]\n"), program_invocation_short_name);
+	printf(_(" %s [options] --get\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	/* TRANSLATORS: 'command' refers to a program argument */
+	puts(_("Set or examine pipe buffer sizes and optionally execute command."));
+
+	fputs(USAGE_OPTIONS, stdout);
+	puts(_(" -g, --get          examine pipe buffers"));
+	/* TRANSLATORS: '%s' refers to a system file */
+	printf(_(" -s, --set <size>  set pipe buffer sizes\n"
+		"                      size defaults to %s\n"
+	), PIPESZ_DEFAULT_SIZE_FILE);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	puts(_(" -f, --file <path>  act on a file"));
+	puts(_(" -n, --fd <num>     act on a file descriptor"));
+	puts(_(" -i, --stdin        act on standard input"));
+	puts(_(" -o, --stdout       act on standard output"));
+	puts(_(" -e, --stderr       act on standard error"));
+
+	fputs(USAGE_SEPARATOR, stdout);
+	puts(_(" -c, --check        do not continue after an error"));
+	puts(_(" -q, --quiet        do not warn of non-fatal errors"));
+	puts(_(" -v, --verbose      provide detailed output"));
+
+	fputs(USAGE_SEPARATOR, stdout);
+	printf(USAGE_HELP_OPTIONS(20));
+
+	printf(USAGE_MAN_TAIL("pipesz(1)"));
+
+	exit(EXIT_SUCCESS);
+}
+
+/*
+ * performs F_GETPIPE_SZ and FIONREAD
+ * outputs a table row
+ */
+static void do_get(int fd, const char *name)
+{
+	int sz, used;
+	
+	sz = fcntl(fd, F_GETPIPE_SZ);
+	if (sz < 0) {
+		/* TRANSLATORS: '%s' refers to a file */
+		check(_("cannot get pipe buffer size of %s"), name);
+		return;
+	}
+
+	if (ioctl(fd, FIONREAD, &used))
+		used = 0;
+
+	printf("%s\t%d\t%d\n", name, sz, used);
+}
+
+/*
+ * performs F_SETPIPE_SZ
+ */
+static void do_set(int fd, const char *name)
+{
+	int sz;
+	
+	sz = fcntl(fd, F_SETPIPE_SZ, opt_size);
+	if (sz < 0)
+		/* TRANSLATORS: '%s' refers to a file */
+		check(_("cannot set pipe buffer size of %s"), name);
+	else if (opt_verbose)
+		/* TRANSLATORS: '%s' refers to a file, '%d' to a buffer size in bytes */
+		warnx(_("%s pipe buffer size set to %d"), name, sz);
+}
+
+/*
+ * does the requested operation on an fd
+ */
+static void do_fd(int fd)
+{
+	char name[sizeof(stringify(INT_MIN)) + 3];
+
+	sprintf(name, "fd %d", fd);
+
+	if (opt_get)
+		do_get(fd, name);
+	else
+		do_set(fd, name);
+}
+
+/*
+ * does the requested operation on a file
+ */
+static void do_file(const char *path)
+{
+	int fd;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		/* TRANSLATORS: '%s' refers to a file */
+		check(_("cannot open %s"), path);
+		return;
+	}
+
+	if (opt_get)
+		do_get(fd, path);
+	else
+		do_set(fd, path);
+
+	close(fd);
+}
+
+/*
+ * if necessary, determines a default buffer size and places it in opt_size
+ * returns FALSE if this could not be done
+ */
+static char set_size_default(void)
+{
+	if (opt_size >= 0)
+		return TRUE;
+
+	if (ul_path_read_s32(NULL, &opt_size, PIPESZ_DEFAULT_SIZE_FILE)) {
+		/* TRANSLATORS: '%s' refers to a system file */
+		check(_("cannot parse %s"), PIPESZ_DEFAULT_SIZE_FILE);
+		return FALSE;
+	}
+
+	if (opt_size < 0) {
+		/* TRANSLATORS: '%s' refers to a system file */
+		checkx(_("cannot parse %s"), PIPESZ_DEFAULT_SIZE_FILE);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+int main(int argc, char **argv)
+{
+	static const char shortopts[] = "+cef:ghin:oqs:vV";
+	static const struct option longopts[] = {
+		{ "check",     no_argument,       NULL, 'c' },
+		{ "fd",        required_argument, NULL, 'n' },
+		{ "file",      required_argument, NULL, 'f' },
+		{ "get",       no_argument,       NULL, 'g' },
+		{ "help",      no_argument,       NULL, 'h' },
+		{ "quiet",     no_argument,       NULL, 'q' },
+		{ "set",       required_argument, NULL, 's' },
+		{ "stdin",     no_argument,       NULL, 'i' },
+		{ "stdout",    no_argument,       NULL, 'o' },
+		{ "stderr",    no_argument,       NULL, 'e' },
+		{ "verbose",   no_argument,       NULL, 'v' },
+		{ "version",   no_argument,       NULL, 'V' },
+		{ NULL, 0, NULL, 0 }
+	};
+	static const ul_excl_t excl[] = {
+		{ 'g', 's' },
+		{ 0 }
+	};
+
+	int c, fd, n_opt_pipe = 0, n_opt_size = 0;
+	uintmax_t sz;
+
+	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
+
+	/* check for --help or --version */
+	while ((c = getopt_long(argc, argv, shortopts, longopts, NULL)) != -1)
+		switch (c) {
+		case 'h':
+			usage();
+		case 'V':
+			print_version(EXIT_SUCCESS);
+		}
+
+	/* gather normal options */
+	optind = 1;
+	while ((c = getopt_long(argc, argv, shortopts, longopts, NULL)) != -1) {
+		err_exclusive_options(c, longopts, excl, excl_st);
+
+		switch (c) {
+		case 'c':
+			opt_check = TRUE;
+			break;
+		case 'e':
+			++n_opt_pipe;
+			break;
+		case 'f':
+			++n_opt_pipe;
+			break;
+		case 'g':
+			opt_get = TRUE;
+			break;
+		case 'i':
+			++n_opt_pipe;
+			break;
+		case 'n':
+			fd = strtos32_or_err(optarg, _("invalid fd argument"));
+			++n_opt_pipe;
+			break;
+		case 'o':
+			++n_opt_pipe;
+			break;
+		case 'q':
+			opt_quiet = TRUE;
+			break;
+		case 's':
+			sz = strtosize_or_err(optarg, _("invalid size argument"));
+			opt_size = sz >= INT_MAX ? INT_MAX : (int)sz;
+			break;
+		case 'v':
+			opt_verbose = TRUE;
+			break;
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
+	}
+
+	/* check arguments */
+	if (opt_get) {
+		if (argv[optind])
+			errx(EXIT_FAILURE, _("cannot specify a command with --get"));
+
+		/* print column headers, if requested */
+		if (opt_verbose)
+			printf("%s\t%s\t%s\n",
+/* TRANSLATORS: a column that contains the names of files that are unix pipes */
+				_("pipe"),
+/* TRANSLATORS: a column that contains buffer sizes in bytes */
+				_("size"),
+/* TRANSLATORS: a column that contains an amount of data which has not been used by a program */
+				_("unread")
+			);
+
+		/* special behavior for --get */
+		if (!n_opt_pipe) {
+			do_fd(STDIN_FILENO);
+			return EXIT_SUCCESS;
+		}
+	} else {
+		if (!set_size_default())
+			goto execute_command;
+
+		if (!opt_quiet && n_opt_size > 1)
+			warnx(_("using last specified size"));
+
+		/* special behavior for --set */
+		if (!n_opt_pipe) {
+			do_fd(STDOUT_FILENO);
+			goto execute_command;
+		}
+	}
+
+	/* go through the arguments again and do the requested operations */
+	optind = 1;
+	while ((c = getopt_long(argc, argv, shortopts, longopts, NULL)) != -1)
+		switch (c) {
+		case 'e':
+			do_fd(STDERR_FILENO);
+			break;
+		case 'f':
+			do_file(optarg);
+			break;
+		case 'i':
+			do_fd(STDIN_FILENO);
+			break;
+		case 'n':
+			/* optarg was checked before, but it's best to be safe */
+			fd = strtos32_or_err(optarg, _("invalid fd argument"));
+			do_fd(fd);
+			break;
+		case 'o':
+			do_fd(STDOUT_FILENO);
+			break;
+		}
+
+execute_command:
+	/* exec the command, if it's present */
+	if (!argv[optind])
+		return EXIT_SUCCESS;
+
+	execvp(argv[optind], &argv[optind]);
+	errexec(argv[optind]);
+}
-- 
2.35.1

