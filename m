Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E38C433F5
	for <util-linux@archiver.kernel.org>; Tue, 12 Apr 2022 05:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347343AbiDLFCP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Apr 2022 01:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346495AbiDLFCK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Apr 2022 01:02:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2076.outbound.protection.outlook.com [40.92.47.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A89533EBA
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 21:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuP7fTsP602ywdc8aN9CLGqizxk7ZBc47raDq9iCn1jOVja11VHn8vxmAPPhGMWK7pj3biMBoqtRmbaje9Q/NfLwhV/0w8vATJnjt9uZVDyNZ/DkSmUMLgk/c2Cu+Wxo5LV3mNZ7MNWlS2qpwiALKb2hj4DkOpMnHmFKiPomu8cticePX/yAKW5SD2+8daQnlbE1tSIPMT4Pyh3YQND1tPAB/fHywcCxGJVNuaN/3s+tGqAeUaFbP/amIUemFjsurqp0MGlwyBveZ2AVu4Dq/js4aBLsCHUNvrNEuR4uZArxcuD+TAH3Ia9GWKRKdIjhG5+hdKDPlTkaLqBQwwkt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz0MOaYU9PtjH/8dV3s5EKiUB43FcEFbORmPCogxsZE=;
 b=Jb/njhns2BVGyUqtcVKn3A61ztLadLdiTK9hD9uWzhHNZtFl9NkMO/SRy1SXLJ4zUIwVEVMKMan1mlHrUEubDzXeQrVYFqB0s6eGOV3wERaGrqkK/8mMPUwtV3YBrzCku7uTZGINgM0MI1tgzztQQTcmY+gp0RHdf1cvthOfHx3K6WU1oN6eGbnos1c4J3lOfd0+7aJItk35AfR28tcumrwsnyn8QfHCID9gtvHoSc6Skc2s+vVRAvANwnQizOAUfYFmMPw+EC2dcK5Gq+xdPUvlAXB1cp7Ro65RTjzIULfWFEBIjcPLB0TVOY/1UOHFDx+TIbu7I7hCgiyteW1TNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz0MOaYU9PtjH/8dV3s5EKiUB43FcEFbORmPCogxsZE=;
 b=QzVc5rVzi55BmlRthSPD+4H3z5slINz90ISfD1kABCBYj+yCZ6OiNTpTzgFL+MjocRn+Zqb8t2mmWYmDrqynTSlrzeK/vU44bwOmavJBYEMYqcLjN1/XfnV4M36RiJ93kYBJPgYIahNUX42AgjnAbm3cGeyBLZ3jdVPCG4mYpJI95Z28dkt9xcbeuBHrPCscPGkO9FlXqN6tj0JW/PtYmyyrqjMwWyjAiIMbnmciJN65WwiTkuKaHvYeRqoD2ppO21b9YeX/isoxBkwtEjaRzkvd2xb66uOtDUTZv2cAsSYLfCNAXasDfAsjGpPj7Gj5Qo1ctCuRvycSXAnKRWB19w==
Received: from SN6PR04MB3983.namprd04.prod.outlook.com (2603:10b6:805:4c::19)
 by BL0PR04MB5043.namprd04.prod.outlook.com (2603:10b6:208:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 04:59:51 +0000
Received: from SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::5102:79c8:1ec5:d316]) by SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::5102:79c8:1ec5:d316%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 04:59:51 +0000
From:   Nathan Sharp <nwsharp@live.com>
To:     util-linux@vger.kernel.org
Cc:     Nathan Sharp <nwsharp@live.com>
Subject: [PATCH RFC 3/4] pipesz: add manpage
Date:   Mon, 11 Apr 2022 22:59:29 -0600
Message-ID: <SN6PR04MB3983A98E579F2710F3303D0BC2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412045930.236051-1-nwsharp@live.com>
References: <20220412045930.236051-1-nwsharp@live.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [JDwS3LtNoQImzc5emiWf++RTVTIuKg2c]
X-ClientProxiedBy: CH2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:610:4c::25) To SN6PR04MB3983.namprd04.prod.outlook.com
 (2603:10b6:805:4c::19)
X-Microsoft-Original-Message-ID: <20220412045930.236051-4-nwsharp@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4258a9d6-d2d1-49d0-1caa-08da1c4146e1
X-MS-Exchange-SLBlob-MailProps: S/btQ8cKWiThIBhrdRr4cLcE9KU0705sYI9xf73x6L4ufrL2IcWTkTI22zCsbBLbj33NvXBdenx+SKhoAgh4gHdK7Ay9OAv/+z0EHRF4cqz59Dhu512z6npASEd6J4p3Jse372q2K3+CgKx2l2JILN6L42U2ZPrIQ3mgGU5SkmjGU1iNhukgb/T21FErrEV5y65MGwLxAq7FFf6O0IkH8j9hry+vllqvAtrziceS6YwgIxvmJ6L1ZVMoQI5IyhHflragfhuSs/lxpQ3UvvUDZjRuo3cKSWAZH9mMCwt0VQooAnfj0o6m5e2poacwtOxUz4ia/YCxNwWXVAEWNNDdtqfNcs7xrJNxJi4vSLnU57fi24xXkpNRQ0A/MUwTPxQCWXFnr1kApBpsTqXqLSqYa++vDkFcT6lBj4I4pFaaOSwLgV0Bi+qfWNB4F76LJ3oFI6d9qvl0LI+KD7g1UKuMO6LmN895Icmx5IgOGj24EpQXA0x6BNa4mIEqF1M6HtNhU+QUHyPUMJWHQLIN5T0jSLE29A9BzQny+diX9N75foiAW4/9zo9z9z8yqW2kqVtaxjQo6IE4X8/yK6iGvUVOFGdu1NdL9mq4Dvh8JVKK/pojaX0y1tWTmf7/cUMtJq/DWSMUWj4XXLO8HiREG1B4IkmTDbzjdt8sWOj8bHiYR6nFcdH79ZXBVImwAiM7a7+VOwW2WVHu2i5bzDfjrWtznhMeygrTW6otIlw9K4JYrrXfOjAn4K/b1gEKuFu+22vyV4v9thK2x1A=
X-MS-TrafficTypeDiagnostic: BL0PR04MB5043:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTz6aHT9P/qajQDTmvcjjX69zjYGSFI3sicNvejAAddYg9g9iix3BKLJ+GRXs+6ul1qh9Bk2t87YG/1mVH2lNCykwTS8Ue47C3q3eIm2mTIeAuzyyRa0YMlbvGAd4WF5ZHTJNtj6n+O70c5jJIi2t+k6BtxfKOW2xAs75UVRSJDimYdJX0FMELJEIIjtTLawxhQ/czi9OylSNWy3iIE0g40ABQrt2VUhkFfK7OgmtEV/CZu6PlhaBYREktFx0uswnFVZoMkfH+ZisgCHHPTkYrJQU9hHvqcusW8Nx8sDk7B3b3UXuzj4SWHLU7vnXIP0LZxz29NYDyp6OggA1ZUToJQQsGU/rSmd4AVWAdFZKPVMhcu/h3GYWGEEUbljvwso7xtZqTomGjEpJR8eU3Rr9n5exX1zwXu82LB0A3qEf0W1EtXLUGEyE+eETtQY9iLfAoBoNdAn1gXCfPWAXSM8o3XEDfICBY+vySxch+onAVrJwMYvTfX8BQhhBMI3PJsbiV2YsiSeV9DC/Uivo2WlW+I+rF6NY5qPxay93OjorcsMqdHOhLPDsd3Uv5uS/By3xd7zLOPhPLZqrUOHKHDkeA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hjy2Squzs0QgVbev0eVB/vEqs3CNmSV6OdhpjdGZORxJIuRXt23YHq5vo7N2?=
 =?us-ascii?Q?b8HDoIq8gv04NvSrQrGhrbKvu/lg4BeAT7NVmtY+gRdyeaRSUmIge2ciaaWt?=
 =?us-ascii?Q?anvs4oZlA/VpHCCfjgVLO4Qj7pcj1p1t7Pod0tas7ki6b22BeeaGX58mVBX/?=
 =?us-ascii?Q?WEtndWncaxkhvkDUpDK0yfq/QQOYd3TG2tF0ztR2jluTtHJg9Cze1gfFFxO5?=
 =?us-ascii?Q?CUaJ66tqYnYNrEZiQm3B4hfAdi2MOK2mrLO6g3YBWWOQBt4SRAQSEn43O5Z4?=
 =?us-ascii?Q?EDDxcftssjdoluXwnJne1l0GNi1iMFNxZmgvFKusZPA4XqiGPNGTjzWssPjX?=
 =?us-ascii?Q?enU8bqe/EHg+pmOI8/AZcwUrTG6Kxi2QEKrBmAC1H9hG1P/Odyla5o7Qkmc6?=
 =?us-ascii?Q?lvRdcOVSqTXqWtX5LiAtsRSDwhPCDUsVV0hWHgcG3+Xi4mFP01nF8g8bsXYn?=
 =?us-ascii?Q?gR6wFNZnY0OEhHwbSMrxZwwl9/UuNie5+4hgGZEYBcJMEfkt5XCvGXA5yMtR?=
 =?us-ascii?Q?Up/nJSqZ0TRlu7WmMroFDg6vxD/BJEyBNuUAC/VX13J/Snz5V7ptkcnR5Jyv?=
 =?us-ascii?Q?orgqpWYI4kpxw06qFx8ABvMqlJgkqBnOKxv3Ee7orvJLKJlsS5Q07vMhZipX?=
 =?us-ascii?Q?ezqWKOkS7h5pL9THkZqlwq1/XMk8l5/aEx3WNWwNRFHXFc4nq8eeAo7qy9bs?=
 =?us-ascii?Q?7zfvIdMOxJECgjf5IO4FQEhrK6zV5BJu7G9ciTeOGOrL5J87+PAcIzoGX5FT?=
 =?us-ascii?Q?lcjOweZ9h31UACUkVkpPEgFJovpMdaucpz19UmuCUDuPtiSKdi2uEs5nq0cJ?=
 =?us-ascii?Q?edCA0wD/IsK0iDveNb873BVRPa0tUJqBxFE8nCfs76v3vFcRNbKHk/R/CP3I?=
 =?us-ascii?Q?3BTN/RblwFmNqW0ma9p5i56gMzWG6nxQv333QbZWUadaKfaktb8Pc7oan0Ml?=
 =?us-ascii?Q?DxcRgTFF6fjjcGDHJQuQto0F4OEs8sqqsvvfID/gwUFfcLqg4ooLDMrYToXX?=
 =?us-ascii?Q?MvIEDlDAwJtT8X55Xo6d7ofWo6mwYoKKfnTKLZIYhes6LRqJjxEww7WVo3O7?=
 =?us-ascii?Q?EsliIOf8Qhz2lQp99M1XJvxiOpB2me9INPWBYTq1c4rRwD+KnC7kedMLWabZ?=
 =?us-ascii?Q?OaQ1I6X5PqKQrDMR6s0mwwJYBZSE1oEP+88W1WlwBBtRm+GnrYmFtVbzrVbi?=
 =?us-ascii?Q?Tuv9sqSGKnQCqGPwLTSUGcuCKa+o3vU/9TbR4cZ2AYmXnbJvlruGgF/heQFC?=
 =?us-ascii?Q?MuEkKIZGL73jfbLT+9rIJUbONvnntNeSCdSZ2sFAcTa65AJImTyWvMsluDLY?=
 =?us-ascii?Q?jU/yHnkSfg1BJ+oKXDQeThVuOIlB6SkUy9v1D+WhFNPoITeLVpZuyNzVOExh?=
 =?us-ascii?Q?pAksrfSg62P6Y9sNtEBaQSEMUwm3nU4CMfSIXBoayPIreBkUPgxrHjOK1raq?=
 =?us-ascii?Q?eP5Y/Tjg+1Q=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4258a9d6-d2d1-49d0-1caa-08da1c4146e1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB3983.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 04:59:51.6925
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
 meson.build              |   1 +
 misc-utils/Makemodule.am |   2 +
 misc-utils/pipesz.1.adoc | 109 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 misc-utils/pipesz.1.adoc

diff --git a/meson.build b/meson.build
index 358572e..a94b02f 100644
--- a/meson.build
+++ b/meson.build
@@ -2688,6 +2688,7 @@ exe = executable(
   install : true)
 if opt and not is_disabler(exe)
   exes += exe
+  manadocs += ['misc-utils/pipesz.1.adoc']
 endif
 
 exe = executable(
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index 60c7fe1..5e08c9a 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -269,6 +269,8 @@ endif
 
 if BUILD_PIPESZ
 bin_PROGRAMS += pipesz
+MANPAGES += misc-utils/pipesz.1
+dist_noinst_DATA += misc-utils/pipesz.1.adoc
 pipesz_SOURCES = misc-utils/pipesz.c
 pipesz_LDADD = $(LDADD) libcommon.la
 pipesz_CFLAGS = $(AM_CFLAGS)
diff --git a/misc-utils/pipesz.1.adoc b/misc-utils/pipesz.1.adoc
new file mode 100644
index 0000000..a18d775
--- /dev/null
+++ b/misc-utils/pipesz.1.adoc
@@ -0,0 +1,109 @@
+//po4a: entry man manual
+= pipesz(1)
+:doctype: manpage
+:man manual: User Commands
+:man source: util-linux {release-version}
+:page-layout: base
+:command: pipesz
+
+== NAME
+
+pipesz - set or examine pipe and FIFO buffer sizes
+
+== SYNOPSIS
+
+*pipesz* [options] [--set _size_] [--] [_command_ [argument] ...]
+
+*pipesz* [options] --get
+
+== DESCRIPTION
+
+Pipes and FIFOs maintain an internal buffer used to transfer data between the read end and the write end. In some cases, the default size of this internal buffer may not be appropriate. This program provides facilities to set and examine the size of these buffers.
+
+The *--set* operation sets pipe buffer sizes. If it is specified, it must be specified with an explicit _size_. Otherwise, it is implied and the size is read from */proc/sys/fs/pipe-max-size*. The kernel may adjust _size_ as described in *fcntl*(2). To determine the actual buffer sizes set, use the *--verbose* option. If neither *--file* nor *--fd* are specified, *--set* acts on standard output.
+
+The *--set* operation permits an optional _command_ to execute after setting the pipe buffer sizes. This command is executed with the adjusted pipes.
+
+The *--get* operation outputs data in a tabular format. The first column is the name of the pipe as passed to *pipesz*. File descriptors are named as "fd _N_". The second column is the size, in bytes, of the pipe's internal buffer. The third column is the number of unread bytes currently in the pipe. The columns are separated by tabs ('\t', ASCII 09h). If *--verbose* is specified, a descriptive header is also emitted. If neither *--file* nor *--fd* are specified, *--get* acts on all file descriptors.
+
+Unless the *--check* option is specified, *pipesz* does _not_ exit if it encounters an error while manipulating a file or file descriptor. This allows *pipesz* to be used generically without fear of disrupting the execution of pipelines should the type of certain files be later changed. For minimal disruption, the *--quiet* option prevents warnings from being emitted in these cases.
+
+The kernel imposes limits on the amount of pipe buffer space unprivileged processes can use, though see *BUGS* below. The kernel will also refuse to shrink a pipe buffer if this would cause a loss of buffered data. See *pipe*(7) for additional details.
+
+*pipesz* supports specifying multiple short options consecutively, in the usual *getopt*(3) fashion. The first non-option argument is interpreted as _command_. If _command_ might begin with '-', use '--' to separate it from argument to *pipesz*. In shell scripts, it is good practice to use '--' when parameter expansion is involved. *pipesz* itself does not read from standard input and does not write to standard output unless *--get*, *--help*, or *--version* are specified.
+
+== OPTIONS
+
+*-g*, *--get*::
+Report the size of pipe buffers to standard output and exit. As a special behavior, if neither *--file* nor *--fd* are specified, *every* file descriptor passed to *pipesz* is examined. It is an error to specifiy this option in combination with *--set*.
+
+*-s*, *--set* _size_::
+Set the size of the pipe buffers, in bytes. This option may be suffixed by _K_, _M_, _G_, _KiB_, _MiB_, or _GiB_ to indicate multiples of 1024. Fractional values are supported in this case. Additional suffixes are supported but are unlikely to be useful. If this option is not specified, a default value is used, as described above. If this option is specified multiple times, a warning is emitted and only the last-specified value is used. It is an error to specify this option in combination with *--get*.
+
+*-f*, *--file* _path_::
+Set the buffer size of the FIFO or pipe at _path_, relative to the current working directory. You may specify this option multiple times to affect different files, and you may do so in combination with *--fd*. Generally, this option is used with FIFOs, but it will also operate on anonymous pipes such as those found in */proc/PID/fd*. Changes to the buffer size of FIFOs are not preserved across system restarts.
+
+*-n*, *--fd* _fd_::
+Set the buffer size of the pipe or FIFO passed to *pipesz* as the specified file descriptor number. You may specify this option multiple times to affect different file descriptors, and you may do so in combination with *--file*. Shorthand options are provided for the common cases of fd 0 (stdin), fd 1 (stdout), and fd 2 (stderr). These should suffice in most cases.
+
+*-i*, *--stdin*::
+Shorthand for *--fd 0*.
+
+*-o*, *--stdout*::
+Shorthand for *--fd 1*.
+
+*-e*, *--stderr*::
+Shorthand for *--fd 2*.
+
+*-c*, *--check*::
+Exit, without executing _command_, in case of any error while manipulating a file or file descriptor. The default behavior if this is not specified is to emit a warning to standard error and continue.
+
+*-q*, *--quiet*::
+Do not diagnose non-fatal errors to standard error. This option does not affect the normal output of *--get*, *--verbose*, *--help*, or *--version*.
+
+*-v*, *--verbose*::
+If specified with *--get*, *pipesz* will emit a descriptive header above the table. If specified with *--set*, *pipesz* will print the actual buffer sizes set by the kernel to standard error.
+
+include::man-common/help-version.adoc[]
+
+== EXAMPLES
+
+*pipesz* *dd* if=_file_ bs=1M | ...::
+Runs *dd*(1) with an expanded standard output pipe, allowing it to avoid context switches when piping around large blocks.
+
+*pipesz* -s1M -cf /run/my-service.fifo::
+Sets the pipe buffer size of a service FIFO to 1,048,576 bytes. If the buffer size could not be set, *pipesz* exits with an error.
+
+*echo* hello | *pipesz* -gi::
+Prints the size of pipe used by the shell to pass input to *pipesz*. Since *pipesz* does not read standard input, it may also report 6 unread bytes in the pipe, depending on relative timings.
+
+*find* /proc/_PID_/fd -exec *pipesz* -gqf '{}' ';'::
+Prints the size and number of unread bytes of all pipes in use by _PID_. If some pipes are routinely full, *pipesz* might be able to mitigate a processing bottleneck.
+
+== NOTES
+
+Linux supports adjusting the size of pipe buffers since kernel 2.6.35. This release also introduced */proc/sys/fs/pipe-max-size*.
+
+This program uses *fcntl*(2) *F_GETPIPE_SZ*/*F_SETPIPE_SZ* to get and set pipe buffer sizes.
+
+This program uses *ioctl*(2) *FIONREAD* to report the amount of unread data in pipes. If for some reason this fails, the amount of unread data is reported as 0.
+
+== BUGS
+
+Before Linux 4.9, some bugs affect how certain resource limits are enforced when setting pipe buffer sizes. See *pipe*(7) for details.
+
+== AUTHORS
+
+mailto:nwsharp@live.com[Nathan Sharp]
+
+== SEE ALSO
+
+*pipe*(7)
+
+include::man-common/bugreports.adoc[]
+
+include::man-common/footer.adoc[]
+
+ifdef::translation[]
+include::man-common/translation.adoc[]
+endif::[]
-- 
2.35.1

