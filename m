Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3F2C433EF
	for <util-linux@archiver.kernel.org>; Sat,  4 Jun 2022 02:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiFDCAk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jun 2022 22:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiFDCAj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jun 2022 22:00:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2018.outbound.protection.outlook.com [40.92.21.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534AC2127B
        for <util-linux@vger.kernel.org>; Fri,  3 Jun 2022 19:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu4yD8cFRaf3RAjX9UfRpnZTZEpk/jYYW/4ZPCe7jeJEK3bFKv2dTfazFXVl6o4sfrRpOjWS9k+LTbd0dNprQeMAbhFbPxqzYzAuP6/owu6+QuxqQRP8nXeJ2oeJKhq3jYgGMUuhXFi1iB7md3enrfzNY8DnkS8xksb8EyaW4O9gNlZZURDBN4dSD9Za0kQtwFXe9OzUChCraH2B5CAWCUz8KWGphfCgraU6cDvjqjfJBDq9gCl5keVibVrLgy5R2rqRgkT71WxHrH8MsK7H4pDaTS/56rAqIAg1/S6zzAw/s5yDs9BtuAaLI8pZTWdiw3/+taIYr+uOLTO8WZD3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JNGMmo5K+kXzmFQogBa1kjeJKpbhVgGxTbwDChnOzk=;
 b=NMA8irIYF0OnYGnD8Xq8c0dGzKddsyaCUNkfchT5/FqbDtxz9Qo9A1EsrYYqoDTK6/qqjDYfKx1Anf/zJB2CLpveMHQX+PVCYIc0P19TChqf01h2IGwfymL9oSYSwzko2Ly6hxkVk4lVmCVgJNTQg5fiQDIqlJVZebe0qmBqQHC/zY4FmYtXxYTckV/96Q6OrbjBj+/d0cd6kGkl0zVjmAUS9nGUeAs4K0Y8KaSk3AKUo1GDhtIEPgD1jGsrJxAu1jAQhSHK437GOujUQuRQumZpHt8WATIWpaodeu2BNSejN3AokKgkJfgQBkYKNSCmYZ9Z/LkpxS0JXfgkiaWO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JNGMmo5K+kXzmFQogBa1kjeJKpbhVgGxTbwDChnOzk=;
 b=SprXJSIDxAz0llY8A8yoxnXdWgdP3PCoVnadYe2Bh61BrhhiyvCtkeTdzr55S3D5ZgFDFM0k+LrJpeMX4ONTnQ5ePiKLnnv+1BChIAoW7WMeAkABC+le6HnOincpZKoqWSyXCBq+KblaVjuGD8GOTK906vM/4hMmF73xzcT+d0ID9CPlgTCWQDyn0QzAWU/mO4Ko+AXES/ziED/15qZTAvqPXXYuUj2/0Hcx20id8VoDzB4OkRpHMOUd+WCJFspUaSqRFnLdy/A2y48ZryP3QR8XsxGawO+e5oVK6ZswPrqiNg8mYmngJF+hWZ/Yh+GbAghcI5RPgops+e1PzPY+sg==
Received: from SN6PR04MB3983.namprd04.prod.outlook.com (2603:10b6:805:4c::19)
 by MN2PR04MB6960.namprd04.prod.outlook.com (2603:10b6:208:1e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Sat, 4 Jun
 2022 02:00:33 +0000
Received: from SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::ed2f:e076:7027:c9cf]) by SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::ed2f:e076:7027:c9cf%6]) with mapi id 15.20.5314.013; Sat, 4 Jun 2022
 02:00:33 +0000
From:   Nathan Sharp <nwsharp@live.com>
To:     util-linux@vger.kernel.org
Cc:     Anatoly Pugachev <matorola@gmail.com>
Subject: [PATCH] pipesz: use native PAGE_SIZE in tests
Date:   Fri,  3 Jun 2022 20:00:22 -0600
Message-ID: <SN6PR04MB39834AB02ACBCA91B949F821C2A09@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CADxRZqzipCFaFFAs-o=FDA_g=9NmrqzieXaYtWwbGCCXDeiM5g@mail.gmail.com>
References: <CADxRZqzipCFaFFAs-o=FDA_g=9NmrqzieXaYtWwbGCCXDeiM5g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Fqz25oTWwo+45uHr5AzjNO2B0GPjABrCmiKZBIrPAhhW3quXMVWCQfeM57HCSeu4]
X-ClientProxiedBy: CH2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:610:20::17) To SN6PR04MB3983.namprd04.prod.outlook.com
 (2603:10b6:805:4c::19)
X-Microsoft-Original-Message-ID: <20220604020022.340515-1-nwsharp@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7863315-042d-43c1-1d5c-08da45ce0246
X-MS-TrafficTypeDiagnostic: MN2PR04MB6960:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0SxrM92O4UfyyjSXvCtB0taUWTrzKNzdKF9AI7CsHNLMd62ogQzhfN6RhZqLRS+J70qItSOo4PGUVTY4xzkMLuhGSceqO+J3GMJYNtCY9IcqLyizqrNazqpSBoTWcYYkIHf7xPxqdXlDxyu8pFOfY/+0BgbBMtEKO1SNaegoRgGdbz3tK1J3iyCSRn1FcmKXUs4hPYwIYtJMo7ymc26nLaqtrFi7//utu0UJ89TWPUWAoOB3kn/creQ3xq9iKlL4noJ3O4msmU0/wBFsBHzDNmE/VqHeBWPXzXjzgpotx0waHk2ZaBZkOagbGrZG925OiEspkZ07a6AJTSUpHg5ax2ijEeFOOXGMwlRJhgD7lZtxAY81VCkZolJDEntQ7C5clu7X7xnVOLdHJIyp04/r4LIdIbBFoVRGDga1UePaen4Y70cOZFFmd07zL/bfrbinLz0gKdiymWwR1ALAKiJyFcJOvKIOFHs7z2LxiioObGRTKIbKjet3JJscsDs8j+dR5iwK4TmaeRAc/iSfou4AQgdgpZTZ5w5vLHIdiRHrE+eSPksZTyGJwK5n7WiQ9c043yugRdzxb94su36qp6Www==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ziDLs9eXRCpHluZtwvlm9/FeVyik4PFkQs+AB+RTaMBCuSXNLk32nZIQDfEy?=
 =?us-ascii?Q?l7JgG7Xsx+5X4qjI1Vfll/3wTMSHbjZT/+iudOKp+rfdbPbbBzFb7gCfYHfA?=
 =?us-ascii?Q?s0B4Ay+lVVKlUyIMxxz7VMQsbUX2Ne9lNFQ/jk1KQk9Vw83Cbl6IAvHjTcSP?=
 =?us-ascii?Q?3nDNeqPHqK2kwukg/F1jvKS/8Z2h09LUK3wC3yGqi0q2GAtmqP3WHotQdKU/?=
 =?us-ascii?Q?+loVdG2nJaVz6CpcDpRtKimZSn0AFE47UuVMAhI8xpRzWq8b8iYGdnd5QMWK?=
 =?us-ascii?Q?TPiAqHtFcmzZqmVohWdopvU1ZiDdnLUwUItbO5PL0B/pTg4rXrMbON7omqOH?=
 =?us-ascii?Q?LxXKmMXK/vYFTAc82LVhK4TpefWGfWlaM3CtnJL29ihzOJ99VP3P3dQ4EWlE?=
 =?us-ascii?Q?IPhMqvUtwLRZH89ekmD3mJiEBDwHzaN0CDLiAF2NgT9Htg0MIVln5heHxWBs?=
 =?us-ascii?Q?JWsajTubSmUEVMy76B6gtK/l5y/4kSgqUvqreLK0gS+W4fgKreJcZxII7P+q?=
 =?us-ascii?Q?PgP6kwKXKtIMLH0T0oiXeB/qZnTyg3NNm4VT0rvH0KTQ9qmnAP6iOQpGzrn7?=
 =?us-ascii?Q?J0FlZJd4DuFo1f3gOpN9ZsllQrNJYx+g7bVkrWaLALgsdiB5BK5mK196y9H5?=
 =?us-ascii?Q?vwC+GA2jZgujqf2SKv/fnYEdvSCO6dcXkB/yUcxj0pfJ2H8rj96iJR68w1lX?=
 =?us-ascii?Q?VaSYiewiqkKru169ceTR6HoqH//T3bQxzXib9wzEpkoL/BblTpW7WjIG101h?=
 =?us-ascii?Q?SrDCN6lR3kdaRQISXPoJ3Ld15unz0zmtH0/5ePeJBd7KfAbItMci8AaZaQ7T?=
 =?us-ascii?Q?yte3m0puMF2UP11Rb5D79qT6DwvNNMDwC4nuvUx69ftP0oRpO88JzHiZ+oHj?=
 =?us-ascii?Q?+Uejb3wVohiBkARptJvO9rdg7aS3W6cdEq89AvV6noYNxV4E8NYRLJBAnON8?=
 =?us-ascii?Q?fV33q33bBeVylp3nqcT2+fPWU8HbtWMnblZnKmT9oKwsvI8Ga61a9iHuc3sH?=
 =?us-ascii?Q?xo32rEgnDmNJjS9ROvpspbYp9fLswbflaAaqCjNYM4AtRj3uhUSr5xPgWHa4?=
 =?us-ascii?Q?MN36o5f8H1FqQJ5GJCwPJOo0kMu9E85km6URooVpG8MFmtSeeDpeOUeWN6k4?=
 =?us-ascii?Q?BBNqLK/k0NGJHs6b/h2552/NULO70CqObVSM6yGcAXASHkpnUpkIJTt67p3Z?=
 =?us-ascii?Q?ADfcdLQrWdEIYTB3QcaybMXlLRTzR2o96qzab0UHUomaLiuS4KYgvqQFPc7i?=
 =?us-ascii?Q?yhEplRgfhdJ/Ibn/oQKDXHFb0/bvgH5HDaM9bSd7OUB5XPgf+iFf/x0k42Wq?=
 =?us-ascii?Q?P6HEuUydNvIdyCPK0KyiGCAXOczwKY7UvbyZLFv7kmoXfv9Rz/zo5uA7kTNo?=
 =?us-ascii?Q?1CuNi0HKUN0NuOaBfqNj5+ZuyNFT9pI6AMhjpO1KpOHkTNe9xRR6uWPj/y09?=
 =?us-ascii?Q?YI0x1p0PhzI77KW5yZ9ICv28YDs/P5HemeUKWt1gXFep+qoo+tbo9z/I9Tom?=
 =?us-ascii?Q?rvYBQrpMFjRUp5E=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b7863315-042d-43c1-1d5c-08da45ce0246
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB3983.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 02:00:33.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6960
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Reported-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Nathan Sharp <nwsharp@live.com>
---
 tests/expected/misc/pipesz-get-fd   |  2 +-
 tests/expected/misc/pipesz-get-file |  2 +-
 tests/ts/misc/pipesz                | 10 ++++++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/expected/misc/pipesz-get-fd b/tests/expected/misc/pipesz-get-fd
index ef103dc9d..aa4cab188 100644
--- a/tests/expected/misc/pipesz-get-fd
+++ b/tests/expected/misc/pipesz-get-fd
@@ -1 +1 @@
-fd 0	65536	0
+fd 0	DEFAULT_PIPE_SIZE	0
diff --git a/tests/expected/misc/pipesz-get-file b/tests/expected/misc/pipesz-get-file
index c1e1a9d78..32dc6bd1d 100644
--- a/tests/expected/misc/pipesz-get-file
+++ b/tests/expected/misc/pipesz-get-file
@@ -1 +1 @@
-/dev/stdin	65536	0
+/dev/stdin	DEFAULT_PIPE_SIZE	0
diff --git a/tests/ts/misc/pipesz b/tests/ts/misc/pipesz
index be5eb45e6..25724cd4c 100755
--- a/tests/ts/misc/pipesz
+++ b/tests/ts/misc/pipesz
@@ -18,6 +18,10 @@ TS_DESC="pipesz"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+set -o pipefail
+
+DEFAULT_PIPE_SIZE=$(($(getconf PAGE_SIZE) * 16))
+
 ts_check_test_command "$TS_CMD_PIPESZ"
 
 ts_init_subtest "set-fd-bad"
@@ -46,7 +50,7 @@ $TS_CMD_PIPESZ --check --get --fd 42 >> $TS_OUTPUT 2>> $TS_ERRLOG
 ts_finalize_subtest
 
 ts_init_subtest "get-fd"
-echo -n | $TS_CMD_PIPESZ --check --get --stdin >> $TS_OUTPUT 2>> $TS_ERRLOG
+echo -n | $TS_CMD_PIPESZ --check --get --stdin 2>> $TS_ERRLOG | sed "s/$DEFAULT_PIPE_SIZE/DEFAULT_PIPE_SIZE/g" >> $TS_OUTPUT
 [[ $? -ne 0 ]] && ts_logerr "expected success"
 ts_finalize_subtest
 
@@ -56,7 +60,7 @@ $TS_CMD_PIPESZ --check --get --file "/dev/null" >> $TS_OUTPUT 2>> $TS_ERRLOG
 ts_finalize_subtest
 
 ts_init_subtest "get-file"
-echo -n | $TS_CMD_PIPESZ --check --get --file "/dev/stdin" >> $TS_OUTPUT 2>> $TS_ERRLOG
+echo -n | $TS_CMD_PIPESZ --check --get --file "/dev/stdin" 2>> $TS_ERRLOG | sed "s/$DEFAULT_PIPE_SIZE/DEFAULT_PIPE_SIZE/g" >> $TS_OUTPUT
 [[ $? -ne 0 ]] && ts_logerr "expected success"
 ts_finalize_subtest
 
@@ -70,4 +74,6 @@ echo this_should_be_output_by_cat | $TS_CMD_PIPESZ --check --stdin cat >> $TS_OU
 [[ $? -ne 0 ]] && ts_logerr "expected success"
 ts_finalize_subtest
 
+set +o pipefail
+
 ts_finalize
-- 
2.35.1

