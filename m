Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B106C433FE
	for <util-linux@archiver.kernel.org>; Tue, 12 Apr 2022 05:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbiDLFCQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Apr 2022 01:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiDLFCI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Apr 2022 01:02:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2076.outbound.protection.outlook.com [40.92.47.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05151340D3
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 21:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+E0rv3iVY0wvzoNLUFG/6UaRyE1XJ0fRmbJgh6OZjLfHX36NmSnwdt/5S9rWlj6GD69+ANB6GRvsY0WkTEKaxc1NSVDl3gKFMtDfONefznU4LBbRqB70niuKtBrHjMutASb71y4XXKnuBlID1CfDZ6IneYziyMHFyo6dSfaiw3/Eg84LjHEhRg5RFKl5yk11rbzZz7D6scOWGLFZOSHXZ+lFcfxtf6FBqLf1mAllz2ZqIXyz0/foSSfjd263Y8KL5W+q7hyDgdjkGdL1MKzeXltifEemQgsDSlGHIENn6oOpw2i41qFzYV4uynHaVVQL0SsXnk2tZjjVgLxL35Jfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHOl6x9AeLbKRTScYF5JHJlGHtZBUR734vnEu1cBieQ=;
 b=lld2YOykWACtPEG5fl56udbySma+fE+Z8ZKUTANEk6B46/5dlMLP3834ahxlOIXhawcgavAhJ3+ZWpKnvholnRmnVthHslW8T0dHq6TC2t0MNAbkcHzeI9lsS1u7uHYCAkRvk18ntxjgySnmkbASlO+LDiu9JSowA4cNmg5FtfRr4qs+U1/0pb0Tasq14Wzs+v/5aH1eL3iEOdZS0Bd9Ajp6obBDfdy4+7AeX63Y3EuATLBUSt0UV9d/A8vOtBnbohRkfqMyMApz240fBqxVf4jilxjzXOU0AfyFyP8NvkPzzwhKifEtDDmPI2H0yXz6Z3jMaCxExpjVRru46PUVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHOl6x9AeLbKRTScYF5JHJlGHtZBUR734vnEu1cBieQ=;
 b=VEkQ4Q6cNXScqa6DeIoX/4obqYQN2WdhH6hXN9NgOwFizOjI918cIZb9+3nextbZlOZRwZ5WmuWBRTyJZQWLOxjMIlZ0S+rAQCajh9/9wlcX7kdY0SfSIRoCKqFU/EsBNRS9YIwpZNsG3qYOKUypZ9KDfFiohVqep+rJixDAllj6OnAUDV7Z04bu9vfbCiFkIYNBXYD72J/1unoUSjtaKwJL3M1Qf2RmcuCblUA3lD21S7/9OVk8xjpaXjWuyuqQWvhD8ZuD8YeUfdRAh0BisYJNtVFVNhYo/xfP5xUTsSzdRZ3fAVvuM4wKxpxKmQ4Hn8u7qzoLLlcwWbzzKxYf8w==
Received: from SN6PR04MB3983.namprd04.prod.outlook.com (2603:10b6:805:4c::19)
 by BL0PR04MB5043.namprd04.prod.outlook.com (2603:10b6:208:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 04:59:49 +0000
Received: from SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::5102:79c8:1ec5:d316]) by SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::5102:79c8:1ec5:d316%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 04:59:49 +0000
From:   Nathan Sharp <nwsharp@live.com>
To:     util-linux@vger.kernel.org
Cc:     Nathan Sharp <nwsharp@live.com>
Subject: [PATCH RFC 2/4] pipesz: add tests
Date:   Mon, 11 Apr 2022 22:59:28 -0600
Message-ID: <SN6PR04MB398387B3E32DD916801C6F93C2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412045930.236051-1-nwsharp@live.com>
References: <20220412045930.236051-1-nwsharp@live.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [J4tEL6GYuhQhI+8m6r2CYywAPeYHHp6o]
X-ClientProxiedBy: CH2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:610:4c::25) To SN6PR04MB3983.namprd04.prod.outlook.com
 (2603:10b6:805:4c::19)
X-Microsoft-Original-Message-ID: <20220412045930.236051-3-nwsharp@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4fdbb6e-bf64-4ae9-09a3-08da1c4145a4
X-MS-Exchange-SLBlob-MailProps: gjx25WM8ZNWTUkYsfs8LU6BtPgaYLwsWIegbKbWxPuvBfZ4hty81lfvuzSpIKysWNIs7wrSjIGdkzVqukwS9OX7m5xNjwqNLt6ZsfQbL2/16ch4UVfp8hCph5k51vDzB1W7wopxuyTsCPU+m7Ch4UqeO+Hu1VQ7KMXFN3hNq4m5osthaK9rrsLLyEKNaTCNaeBxxMfLBgZAuVWHnKjXWPl+Z/6NnrUxK/TXtS4qSNzXjMPLwfuIS4cTlWAq9rw01IdI/nocpgzbHpzf+Z4MiG+Zzikip3Y9TKPaTKnu7kuLn2oc81lrK8qzrtAX6DiSRpkMtpJ+DqBn9fFhsokwa5wUPbqhnpSPYY+xrn30XyVGnygF1yPPrA8Do0KKY0looxi2yT/9V0dmWZbLXwL+E+JWxSCa98OeC4c41FkInHK9f+3/Lz59qtsZAv1hMSEoHKsypMTGT3XFIhumiOD1bfVc+Ra03Ejzjwf2gJZqhWybY8wICmqAUJNUwrW1WrpupjvHfYacdJOPnNxkQZbuS1D4RHzcKgESCOmu4W3xM0XaedHwIFzbGg2IYutdWthx9lnKTD3iGWBTf2JJ2knAHLJXlDRuVlX86qI8OpFIrLLHfpUIAUm2V+SkZSKB/8MV8kFxTFYfBax8pDrBKuJMhs6oVMCotBxQdfJaRdrkwLqb3CNO9U1wd8C5wIsCb4Nm76VXTeVR5jrbfH14W06ktjoMGt6l6HnTaDkNfz4TToy4=
X-MS-TrafficTypeDiagnostic: BL0PR04MB5043:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+vzBvxamBiY+XZsz8G5o3v7ez2mVbTWRiEiI3ocsECpEP+svRtk9oDGEs1H+qc8a9osZ3KlsxZiXWqlx72x2bm7P034ggoQ7FfnH3iCGYFxz3nih3eAxJS8JO7xMoBu08jtf9rWzaflCESMwnJ7zE8s0GDKyA0yvF1UceB5Q72aTgRm8Zetvc0kZsWK8Lgw87gsERXrkJlUsnXogI+GUfzjDj11zDekQRAxRVkjjt3MAoo6XY6os/n2I7mHpwEeZGh7wQ57HVEcm1GrEO1a6aPrsKkplqh6wPBwxazqDH+XzuCWhzcdAYlzM92ORW4Uxa7C2AcMu1vrCW9D1rpzCJKM1qdsKH33lrrjCu8dkY08oPh78MHTNklgUQ0ErOqm00gyQBjZ4gHMTNxW09gAfbXcWnpVx6DUAo+Q/hJbFKpKwBS1b/k+4BvylkXut0S/i/Sd14bxoD2QaPs7AXa/NT3XU7I7LD5xIjoMsW7i2eVzp8ihpFovuy/5sU/BZ6d3NEVlFZ0nNlwDc6E8PgTEsw5LqbAKJXTN9W9kQNwIRffD0EAPYxnxys0OA1g8EN6KFSRMyevmeLofulmWVGPuUQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X/EyrurCa4/bKqHyCk/+hSVRl7LzZrWlVnhmH+TbreeIXCM3uAqj1fwyPpiz?=
 =?us-ascii?Q?32/kAxAAhMf29DxD7UxAs3l2oAgjK5E943u/ihPv0/62TXbdQ6l0u5cDj6JZ?=
 =?us-ascii?Q?pQTHZNwhMCJtUobRmTVPuudmiX+Qw6RO+CtDaCnAjcIMjhA65lVxHvzXc5Oc?=
 =?us-ascii?Q?gDHomdFKML9cPHYoc3kGiBOp0PCXZOVf72Kux+WAnm48rxkHqoGKJbXAsSKz?=
 =?us-ascii?Q?dFBk/C+AzpCjh0HWrt3QiUB4CueQa9Bvxfxfj/aWlk6FD36SvOsoapOCp69x?=
 =?us-ascii?Q?dAano5SGA0ACkASGAURXB3edLPf267qblM6WwbZ+3vEHZI5iXdEV2qLS7MvY?=
 =?us-ascii?Q?u6Vv4+ogR48Mcr7sCsPPq2YdFObzyeFfGXhK/7k118Y0xKvZE2qeviHuk+YV?=
 =?us-ascii?Q?Pvvvl/gJDbpuz/KSWviW+OhJaSlWuSnCtvdkId786Og5GHDrNU/YuJbM7Pm6?=
 =?us-ascii?Q?0VusZMRHfJ1ek6IJpAFoS7Dp9NNsQ7lrYOrsnrcZe1sLb6AJUGVfAKw+IR10?=
 =?us-ascii?Q?6kxcXHDO6Cg1rBatdbZqnm23koXPEl9jG2A3ydtCmDYX4xFU7fCC/QBE/o/g?=
 =?us-ascii?Q?51fQUS5H48DlTNR3fi2BSrQYYnoo55w75Zdw+hc1x/m6s+ylB8rDEOImhWZo?=
 =?us-ascii?Q?+A42HDiI/oG0En5/wc5u2iqMiYqDMys/MRmuqp5Y8nWjIOH8Gi3+7dINXpjH?=
 =?us-ascii?Q?XGvo/3UOfc99E4hU1W36ipKvPYPdZfPdEoE5FOCwT3n6blg17SfaPgEoscTY?=
 =?us-ascii?Q?JIfbdZZbyIoEzwhoRNtk1vFmR7ySEj9icC4bordWIhDbfYe0b/ztAKXKaIav?=
 =?us-ascii?Q?iQmqGG506ovnpnBLXBc5nomA9BX16aNW7jhuu8vFTT+GhGX85w2KSiupQ/+6?=
 =?us-ascii?Q?bYh7iocAqG0gUIyKccOc3MWC6S1r1GtjUfLKZV5k0QVQ1YsG8gow9iSHy3O0?=
 =?us-ascii?Q?XwHox6/xMR8bFnZLMpE1S4dcCzIxl/PXTFuH0z8ynCpJqB4mFN4OMKf2CQrq?=
 =?us-ascii?Q?j0fRs2KXk1eVPjasYH/dkTiQ0LmzM1TUkj6CHQIaJYobQ7sVIMr1kyIIdn/Y?=
 =?us-ascii?Q?0vTXVoe9pFSFoVdgKjXjNMfaKa5OXuKthqnn44dKbnpWDBwuWAQrierHwW7r?=
 =?us-ascii?Q?UbRqQLSeRCZii893VoBmfhC11RPR5xRZn9h7O60Jn4efmcD7EY0cN1mVxH5N?=
 =?us-ascii?Q?SJNb5MSkTxF/fbzNdbphcWWd3i29NzKPy80DVKd/GMqtArn6VacF43Bev7hP?=
 =?us-ascii?Q?mNG3vacrG6igpCeQC2XlR+YxDSH8ibtVlRCWhT9+GvZyrYsMRdWIZa8ZrXPe?=
 =?us-ascii?Q?zCtPId8glg2W6xtBmysJW7uZge9Y+CHxuBF3CbeUQO5iQMQdt2RK+hCFnDpT?=
 =?us-ascii?Q?ZdlF+ezf2/93LMqlns6paDp0uPzdCbL6PsuaGx+1x0JvFmfOmFoWiNkLtTJR?=
 =?us-ascii?Q?L0Ku5hqHPVU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fdbb6e-bf64-4ae9-09a3-08da1c4145a4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB3983.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 04:59:49.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5043
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Nathan Sharp <nwsharp@live.com>
---
 tests/commands.sh                           |  1 +
 tests/expected/misc/pipesz-exec             |  1 +
 tests/expected/misc/pipesz-get-fd           |  1 +
 tests/expected/misc/pipesz-get-fd-bad.err   |  1 +
 tests/expected/misc/pipesz-get-file         |  1 +
 tests/expected/misc/pipesz-get-file-bad.err |  1 +
 tests/expected/misc/pipesz-set-fd-bad.err   |  1 +
 tests/expected/misc/pipesz-set-file-bad.err |  1 +
 tests/ts/misc/pipesz                        | 73 +++++++++++++++++++++
 9 files changed, 81 insertions(+)
 create mode 100644 tests/expected/misc/pipesz-exec
 create mode 100644 tests/expected/misc/pipesz-get-fd
 create mode 100644 tests/expected/misc/pipesz-get-fd-bad.err
 create mode 100644 tests/expected/misc/pipesz-get-file
 create mode 100644 tests/expected/misc/pipesz-get-file-bad.err
 create mode 100644 tests/expected/misc/pipesz-set-fd-bad.err
 create mode 100644 tests/expected/misc/pipesz-set-file-bad.err
 create mode 100755 tests/ts/misc/pipesz

diff --git a/tests/commands.sh b/tests/commands.sh
index 18467cb..aff324c 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -92,6 +92,7 @@ TS_CMD_MOUNT=${TS_CMD_MOUNT:-"${ts_commandsdir}mount"}
 TS_CMD_MOUNTPOINT=${TS_CMD_MOUNTPOINT:-"${ts_commandsdir}mountpoint"}
 TS_CMD_NAMEI=${TS_CMD_NAMEI-"${ts_commandsdir}namei"}
 TS_CMD_PARTX=${TS_CMD_PARTX-"${ts_commandsdir}partx"}
+TS_CMD_PIPESZ=${TS_CMD_PIPESZ-"${ts_commandsdir}pipesz"}
 TS_CMD_RENAME=${TS_CMD_RENAME-"${ts_commandsdir}rename"}
 TS_CMD_RUNUSER=${TS_CMD_RUNUSER-"${ts_commandsdir}runuser"}
 TS_CMD_REV=${TS_CMD_REV:-"${ts_commandsdir}rev"}
diff --git a/tests/expected/misc/pipesz-exec b/tests/expected/misc/pipesz-exec
new file mode 100644
index 0000000..1c6f03b
--- /dev/null
+++ b/tests/expected/misc/pipesz-exec
@@ -0,0 +1 @@
+this_should_be_output_by_cat
diff --git a/tests/expected/misc/pipesz-get-fd b/tests/expected/misc/pipesz-get-fd
new file mode 100644
index 0000000..ef103dc
--- /dev/null
+++ b/tests/expected/misc/pipesz-get-fd
@@ -0,0 +1 @@
+fd 0	65536	0
diff --git a/tests/expected/misc/pipesz-get-fd-bad.err b/tests/expected/misc/pipesz-get-fd-bad.err
new file mode 100644
index 0000000..0394206
--- /dev/null
+++ b/tests/expected/misc/pipesz-get-fd-bad.err
@@ -0,0 +1 @@
+pipesz: cannot get pipe buffer size of fd 42: Bad file descriptor
diff --git a/tests/expected/misc/pipesz-get-file b/tests/expected/misc/pipesz-get-file
new file mode 100644
index 0000000..c1e1a9d
--- /dev/null
+++ b/tests/expected/misc/pipesz-get-file
@@ -0,0 +1 @@
+/dev/stdin	65536	0
diff --git a/tests/expected/misc/pipesz-get-file-bad.err b/tests/expected/misc/pipesz-get-file-bad.err
new file mode 100644
index 0000000..793301d
--- /dev/null
+++ b/tests/expected/misc/pipesz-get-file-bad.err
@@ -0,0 +1 @@
+pipesz: cannot get pipe buffer size of /dev/null: Bad file descriptor
diff --git a/tests/expected/misc/pipesz-set-fd-bad.err b/tests/expected/misc/pipesz-set-fd-bad.err
new file mode 100644
index 0000000..199d18c
--- /dev/null
+++ b/tests/expected/misc/pipesz-set-fd-bad.err
@@ -0,0 +1 @@
+pipesz: cannot set pipe buffer size of fd 42: Bad file descriptor
diff --git a/tests/expected/misc/pipesz-set-file-bad.err b/tests/expected/misc/pipesz-set-file-bad.err
new file mode 100644
index 0000000..f97b1f8
--- /dev/null
+++ b/tests/expected/misc/pipesz-set-file-bad.err
@@ -0,0 +1 @@
+pipesz: cannot set pipe buffer size of /dev/null: Bad file descriptor
diff --git a/tests/ts/misc/pipesz b/tests/ts/misc/pipesz
new file mode 100755
index 0000000..be5eb45
--- /dev/null
+++ b/tests/ts/misc/pipesz
@@ -0,0 +1,73 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="pipesz"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_PIPESZ"
+
+ts_init_subtest "set-fd-bad"
+$TS_CMD_PIPESZ --check --set 4096 --fd 42 >> $TS_OUTPUT 2>> $TS_ERRLOG
+[[ $? -eq 0 ]] && ts_logerr "expected failure"
+ts_finalize_subtest
+
+ts_init_subtest "set-fd"
+echo -n | $TS_CMD_PIPESZ --check --set 4096 --stdin >> $TS_OUTPUT 2>> $TS_ERRLOG
+[[ $? -ne 0 ]] && ts_logerr "expected success"
+ts_finalize_subtest
+
+ts_init_subtest "set-file-bad"
+$TS_CMD_PIPESZ --check --set 4096 --file "/dev/null" >> $TS_OUTPUT 2>> $TS_ERRLOG
+[[ $? -eq 0 ]] && ts_logerr "expected failure"
+ts_finalize_subtest
+
+ts_init_subtest "set-file"
+echo -n | $TS_CMD_PIPESZ --check --set 4096 --file "/dev/stdin" >> $TS_OUTPUT 2>> $TS_ERRLOG
+[[ $? -ne 0 ]] && ts_logerr "expected success"
+ts_finalize_subtest
+
+ts_init_subtest "get-fd-bad"
+$TS_CMD_PIPESZ --check --get --fd 42 >> $TS_OUTPUT 2>> $TS_ERRLOG
+[[ $? -eq 0 ]] && ts_logerr "expected failure"
+ts_finalize_subtest
+
+ts_init_subtest "get-fd"
+echo -n | $TS_CMD_PIPESZ --check --get --stdin >> $TS_OUTPUT 2>> $TS_ERRLOG
+[[ $? -ne 0 ]] && ts_logerr "expected success"
+ts_finalize_subtest
+
+ts_init_subtest "get-file-bad"
+$TS_CMD_PIPESZ --check --get --file "/dev/null" >> $TS_OUTPUT 2>> $TS_ERRLOG
+[[ $? -eq 0 ]] && ts_logerr "expected failure"
+ts_finalize_subtest
+
+ts_init_subtest "get-file"
+echo -n | $TS_CMD_PIPESZ --check --get --file "/dev/stdin" >> $TS_OUTPUT 2>> $TS_ERRLOG
+[[ $? -ne 0 ]] && ts_logerr "expected success"
+ts_finalize_subtest
+
+ts_init_subtest "pipe-max-size"
+echo -n | $TS_CMD_PIPESZ --check --stdin >> $TS_OUTPUT 2>> $TS_ERRLOG
+[[ $? -ne 0 ]] && ts_logerr "expected success"
+ts_finalize_subtest
+
+ts_init_subtest "exec"
+echo this_should_be_output_by_cat | $TS_CMD_PIPESZ --check --stdin cat >> $TS_OUTPUT 2>> $TS_ERRLOG
+[[ $? -ne 0 ]] && ts_logerr "expected success"
+ts_finalize_subtest
+
+ts_finalize
-- 
2.35.1

