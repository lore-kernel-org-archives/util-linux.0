Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8ADC433F5
	for <util-linux@archiver.kernel.org>; Fri, 27 May 2022 03:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiE0DAP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 26 May 2022 23:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiE0DAO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 26 May 2022 23:00:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2081.outbound.protection.outlook.com [40.92.40.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B452532
        for <util-linux@vger.kernel.org>; Thu, 26 May 2022 20:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0erByRPy5azGGXmQgQZu5Eh2sH6XHAU3jRi4yqL+vKyaN3d3Os1l14fmUb+m+tA3vwWmEDOYkoPDQQj5pRu/p6ZN7GLDSunoMENFeWZOq3BxjwWQ1IbH9MaA51NznXmlLNs1uPgDmWepzOrE3ErtsYPZHG89g/6ZHYbv3aIxFTGkA1GA4PcsXPQQm6tmelSvqqBXGe1MBqE7KAyoDCobgRn0DV9vDQR0W9I7g1lkTBaBRi5Sh7qL9Fm888D9IEAuQ085VpTFjHWfGxG1E2SWe6PVgUzSCRkbLfXQaTXSZCoUIDfPlrL4yJSz5z9OQrQWZv0PEtSeJCIBazeeiulCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zq6MjU5cy/LfkuK9u33HxR//nFocoZctgUgHSRy5Y3o=;
 b=MHjsF0cN3s9pPzIypF3Civvt1s8wHOrLY+CwFeEh1HO8ae8QQKnDta6ZnZsBZgoPAavkFKCUEn3yt6nrtdp50wTK7nTHfzcbO8bp6OlXCgaV8Gs7Ss/8l47GUvmrIMDqOP6BjsIledDy/eqRSr4M5Jux8vnV38mgFRYz12xQ3L6tlcQbwKwHExVsHDW+97FLQToYe73heEyMXwQS8jbct4DHYwKVZ5S9l1BKqwbHfli7BwnNM0Bwybf4Ge268ykrv5uEcBLduUGtAlJtOXQ1OmRZcECkTVFTBelGzLW5LX34X5XaUkAvH1vSZOP0/8BzlfPRy4igTXvvCnaUaAH0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq6MjU5cy/LfkuK9u33HxR//nFocoZctgUgHSRy5Y3o=;
 b=TIaMHSiynjiuAWnQmRk39xk0dgqujmKJxdxD0QdGWwKKvE/nk9TfilLfG8aGcVKITlj8YcEGWXkL37dO1OfSofiolGYTwqqzKqqef+852CIiBexYxzPdZeUYDwJfpVDkmZE+7OOPhE5hGEu7bfJ9fFoZOR+O2O3rEALn2cyz2mFaRgrVR7AxRur3nytPXqk0esIQdbqDhjKoit3/x5byCQoNNbMvOsoJXfo5hPNSQP+1vzi2jvrZhni31s4FQpbxGYQs54JK13ixr+injXCcHZCDm35lUJDLXnconaP1+AqrI4jIwoOpFo0rOn/cZbbjz3pWTSOZTBFfuK9XRJXOcQ==
Received: from SN6PR04MB3983.namprd04.prod.outlook.com (2603:10b6:805:4c::19)
 by CY4PR04MB0617.namprd04.prod.outlook.com (2603:10b6:903:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Fri, 27 May
 2022 03:00:10 +0000
Received: from SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::252a:967b:ebf:733a]) by SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::252a:967b:ebf:733a%4]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 03:00:10 +0000
From:   Nathan Sharp <nwsharp@live.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] pipesz: correct manpage issues
Date:   Thu, 26 May 2022 20:59:44 -0600
Message-ID: <SN6PR04MB398339AA1E5BC7F8863D66DAC2D89@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [NLv554klUh+6D85adZLgpW1OJWzcROdek3vDWElBCVfB25Pyexghywgd4Z7zVhax]
X-ClientProxiedBy: CH2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:610:4f::14) To SN6PR04MB3983.namprd04.prod.outlook.com
 (2603:10b6:805:4c::19)
X-Microsoft-Original-Message-ID: <20220527025944.182171-1-nwsharp@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb6c5952-a040-4203-ef17-08da3f8cffbc
X-MS-TrafficTypeDiagnostic: CY4PR04MB0617:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6o2UFqgMj0/1P93veVzYRRI0XgtH1M5AwGbayT3p86rvjhrNCUbDNXP3o6Nlcczpz7ooqy+0btd5V5ocpmOIEoSgfCK4U+dY8P+/d9EjWIpwJpqZSdjCXzzS3paZn6t9VWBr3zh3AipAT8CaJHuoD/tHvqE8XVwCsn0CMDT6t4lu3ICyQ+y4KnrRCpsf+MX8SuRrWKT5HR3KokL2kh4wJ5U5gTnfgi5AMWNPBfiIoQllVl737/zl2h0tUR3P3d55lRAE4YM/CgvjrhXAoz8fs2AW2j5bFGHmHA4Cd2ywokYvFa3oSLADMyWQcl1vvpNSxVavCiGuNrztHxbWJRyrA8fiE2cMqXXRJjKVwznYCKJvhMUeBGw/fu5sbTrnIMSjXh0QVQ4vwGO1dV/22VAon6p53AMTgW5KA+ugg0KJDzvLR647mtQJYnclNMKwEjVCrQliY3jEVNWWGzNTKG1EYNHmYjBopDZ954fM/wGpapiryQcnNdIr/vTHmv8Fbt6d4F7BaLSfxq0XwNDb9KX45uJSgSPijBBI+kQPYDlwyD+WdLG6wDC/Mr1P3FjkhtzoNZDgxYwRXlOhECejA1vQA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LBDKzjFd3wP2HlQTl2jXxyDugEkN+iF0owsFNiJRsnYQ3uEkYmqeRmEVpEQ?=
 =?us-ascii?Q?VIYrd/AsEN/5ocrEic7l3irQZnqbKzglr9bFpZE2DGlSXBx0pzmrzxEYJFWm?=
 =?us-ascii?Q?VbuUE6qIBso0oQ5p2NUFwknL1kqdPSIBOzqCItsz3znLfDfEaqA5LEmdzUZm?=
 =?us-ascii?Q?ztWLgfD2eQhAMrZ/lV/7uj3pSA6f3vClEuwy+YXhXTW98qznmf1j3bDS7rv7?=
 =?us-ascii?Q?D822EaI3xZUq3XqRe9O4JqG/Pn6BwqbAthPmZU70UaoZYNZXrh0YI8sMJKVS?=
 =?us-ascii?Q?7mAEmFmSCDyCXf00cAlJpuwAe7nFl/Y+UdmuutsPBr+8xHvr61hx68iEA3Ci?=
 =?us-ascii?Q?0q2cD6iUKj8SSXXOSf63a8SD6QxBrr+fuC+1eizQWxm3nMCmsIxo5eixa0C0?=
 =?us-ascii?Q?s2ywKmetWAF4jxcFPRnaS0a0g0qyRlghvNEX3MeIXPNRy9E+FjivWRcYqHZT?=
 =?us-ascii?Q?h9H7ZLbKNmHWDPMUysMqEPMQwElRzeYa+6n+PJstC1wv+sTzXQfFHSmZmrhn?=
 =?us-ascii?Q?9Q5ECqo3HLmQCu1eB3yefHOD/Q91nIUxDwWfrssh0E03WbZZtvR+YlVJpISo?=
 =?us-ascii?Q?1yBA8Eae/3yhoKYMNr0TJBfY1IeVueKkCjifuFzWv76U7SDy91a7L34aMb9/?=
 =?us-ascii?Q?520+gYYb3cAKz7YbNhdDUUJ6oHO5J0joMx+GtRyxWGS54pYSOtppjmT+MnHv?=
 =?us-ascii?Q?q+NFQBm3bqkW0jaL4UZnVHbbLI3TOQxaiTkXRqvNDK2WlVO3zZbvufu2XJs8?=
 =?us-ascii?Q?N4wasLFtLaOoZ7eHFYuTj5xUgq6L2ncp1HD6Y1FdlJfWuZrNTkKgSO+QDymc?=
 =?us-ascii?Q?kOj1ItwU+e6EmEjKFhr70tb2bs6+Bwew3SlYIvguS8DlW5WTi058RS+s4KVZ?=
 =?us-ascii?Q?brKwfGsT59OHN/HZK9ceSBa59CAhAYxFSsDmM8jPdEaohOl5uYQ8DKVZ9Sae?=
 =?us-ascii?Q?lmmH5Ap/yfzccQhVYEm7Gu19kD/uCvY9y375awbOcz2egMTBviaEyll2CkMw?=
 =?us-ascii?Q?ZmGdfq0Y40wQXbICVFYU3eIuoeqON/dg3kCgpNNVPOTcQvUpjT0Oze6entAv?=
 =?us-ascii?Q?pb2ugk9YL0dJHwsn9S8Tifmrrjhne9XGRBZu6IVPxa3YjrWTNfi9cWyN/7r2?=
 =?us-ascii?Q?SjpNGRLkIdD6Bn5OiE3nFncYMd0E1/TWPx1iMWNW2HNatiUKUlKgHbx7psDr?=
 =?us-ascii?Q?el7IoAzzu7sZuZplt6GnFC//ZwDuMamTqWEK0nSX5KxOaNRKzS3DMekxPyxh?=
 =?us-ascii?Q?93K3cahYZpXdsDjHcIN7Ev2HOQj8IM10LgJuWpyRTJKn8Y9He4e4KC8Pfaq3?=
 =?us-ascii?Q?tqNu6hgsjyHstji/aGehPJ61h+6VVNwCoDNfV3qoqeTMz4+582TQM5pqyjwK?=
 =?us-ascii?Q?UrPFwBCqtvXsXXbgg5TkP2N9gFh88D7/rfyN7Y+/Nb/Jrqis1lEjYHsZUpLL?=
 =?us-ascii?Q?BsIydDHVsDJczJp++Ejfm+EbK4A8lB1h4unFRcw/ThC1ku+0IFMgiABZ7nGN?=
 =?us-ascii?Q?SSl8cyPGmM2pb8w=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6c5952-a040-4203-ef17-08da3f8cffbc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB3983.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 03:00:09.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0617
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

pipesz's manual page reflects an older version which examined all file
descriptors when --get was specified without --fd or --file.

This patch corrects this, fixes a spelling issue, and makes some
formatting tweaks to improve the clarity of some sections.

Signed-off-by: Nathan Sharp <nwsharp@live.com>
---
 misc-utils/pipesz.1.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc-utils/pipesz.1.adoc b/misc-utils/pipesz.1.adoc
index a18d7757a..b51de5887 100644
--- a/misc-utils/pipesz.1.adoc
+++ b/misc-utils/pipesz.1.adoc
@@ -24,21 +24,21 @@ The *--set* operation sets pipe buffer sizes. If it is specified, it must be spe
 
 The *--set* operation permits an optional _command_ to execute after setting the pipe buffer sizes. This command is executed with the adjusted pipes.
 
-The *--get* operation outputs data in a tabular format. The first column is the name of the pipe as passed to *pipesz*. File descriptors are named as "fd _N_". The second column is the size, in bytes, of the pipe's internal buffer. The third column is the number of unread bytes currently in the pipe. The columns are separated by tabs ('\t', ASCII 09h). If *--verbose* is specified, a descriptive header is also emitted. If neither *--file* nor *--fd* are specified, *--get* acts on all file descriptors.
+The *--get* operation outputs data in a tabular format. The first column is the name of the pipe as passed to *pipesz*. File descriptors are named as "fd _N_". The second column is the size, in bytes, of the pipe's internal buffer. The third column is the number of unread bytes currently in the pipe. The columns are separated by tabs ('\t', ASCII 09h). If *--verbose* is specified, a descriptive header is also emitted. If neither *--file* nor *--fd* are specified, *--get* acts on standard input.
 
 Unless the *--check* option is specified, *pipesz* does _not_ exit if it encounters an error while manipulating a file or file descriptor. This allows *pipesz* to be used generically without fear of disrupting the execution of pipelines should the type of certain files be later changed. For minimal disruption, the *--quiet* option prevents warnings from being emitted in these cases.
 
 The kernel imposes limits on the amount of pipe buffer space unprivileged processes can use, though see *BUGS* below. The kernel will also refuse to shrink a pipe buffer if this would cause a loss of buffered data. See *pipe*(7) for additional details.
 
-*pipesz* supports specifying multiple short options consecutively, in the usual *getopt*(3) fashion. The first non-option argument is interpreted as _command_. If _command_ might begin with '-', use '--' to separate it from argument to *pipesz*. In shell scripts, it is good practice to use '--' when parameter expansion is involved. *pipesz* itself does not read from standard input and does not write to standard output unless *--get*, *--help*, or *--version* are specified.
+*pipesz* supports specifying multiple short options consecutively, in the usual *getopt*(3) fashion. The first non-option argument is interpreted as _command_. If _command_ might begin with '-', use '--' to separate it from arguments to *pipesz*. In shell scripts, it is good practice to use '--' when parameter expansion is involved. *pipesz* itself does not read from standard input and does not write to standard output unless *--get*, *--help*, or *--version* are specified.
 
 == OPTIONS
 
 *-g*, *--get*::
-Report the size of pipe buffers to standard output and exit. As a special behavior, if neither *--file* nor *--fd* are specified, *every* file descriptor passed to *pipesz* is examined. It is an error to specifiy this option in combination with *--set*.
+Report the size of pipe buffers to standard output and exit. As a special behavior, if neither *--file* nor *--fd* are specified, standard input is examined. It is an error to specify this option in combination with *--set*.
 
 *-s*, *--set* _size_::
-Set the size of the pipe buffers, in bytes. This option may be suffixed by _K_, _M_, _G_, _KiB_, _MiB_, or _GiB_ to indicate multiples of 1024. Fractional values are supported in this case. Additional suffixes are supported but are unlikely to be useful. If this option is not specified, a default value is used, as described above. If this option is specified multiple times, a warning is emitted and only the last-specified value is used. It is an error to specify this option in combination with *--get*.
+Set the size of the pipe buffers, in bytes. This option may be suffixed by _K_, _M_, _G_, _KiB_, _MiB_, or _GiB_ to indicate multiples of 1024. Fractional values are supported in this case. Additional suffixes are supported but are unlikely to be useful. If this option is not specified, a default value is used, as described above. If this option is specified multiple times, a warning is emitted and only the last-specified _size_ is used. As a special behavior, if neither *--file* nor *--fd* are specified, standard output is adjusted. It is an error to specify this option in combination with *--get*.
 
 *-f*, *--file* _path_::
 Set the buffer size of the FIFO or pipe at _path_, relative to the current working directory. You may specify this option multiple times to affect different files, and you may do so in combination with *--fd*. Generally, this option is used with FIFOs, but it will also operate on anonymous pipes such as those found in */proc/PID/fd*. Changes to the buffer size of FIFOs are not preserved across system restarts.
@@ -62,7 +62,7 @@ Exit, without executing _command_, in case of any error while manipulating a fil
 Do not diagnose non-fatal errors to standard error. This option does not affect the normal output of *--get*, *--verbose*, *--help*, or *--version*.
 
 *-v*, *--verbose*::
-If specified with *--get*, *pipesz* will emit a descriptive header above the table. If specified with *--set*, *pipesz* will print the actual buffer sizes set by the kernel to standard error.
+If specified with *--get*, *pipesz* will emit a descriptive header above the table. Otherwise, if specified, *pipesz* will print the actual buffer sizes set by the kernel to standard error.
 
 include::man-common/help-version.adoc[]
 
@@ -71,10 +71,10 @@ include::man-common/help-version.adoc[]
 *pipesz* *dd* if=_file_ bs=1M | ...::
 Runs *dd*(1) with an expanded standard output pipe, allowing it to avoid context switches when piping around large blocks.
 
-*pipesz* -s1M -cf /run/my-service.fifo::
+*pipesz* -s1M -cf _/run/my-service.fifo_::
 Sets the pipe buffer size of a service FIFO to 1,048,576 bytes. If the buffer size could not be set, *pipesz* exits with an error.
 
-*echo* hello | *pipesz* -gi::
+*echo* hello | *pipesz* -g::
 Prints the size of pipe used by the shell to pass input to *pipesz*. Since *pipesz* does not read standard input, it may also report 6 unread bytes in the pipe, depending on relative timings.
 
 *find* /proc/_PID_/fd -exec *pipesz* -gqf '{}' ';'::
-- 
2.35.1

