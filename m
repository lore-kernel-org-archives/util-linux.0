Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B203C433F5
	for <util-linux@archiver.kernel.org>; Tue, 12 Apr 2022 04:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347323AbiDLFCI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Apr 2022 01:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346495AbiDLFCG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Apr 2022 01:02:06 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2076.outbound.protection.outlook.com [40.92.47.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9207232EE4
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 21:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBMz3Cg3zhs8zR0LRUfzcI3B2waYVsbkUAyuyRGOK0lvyY+yQvp8VjPvAdWgqOoSF/MYloihpAPcJd7gvNKM47StWpsePYjDzs1svbpqIotdLuTou7tX8aSPSGb32o/iQUd0HYFoCYt+agAMer0F6u49BG771xK58SLahk9ab6bFOcn6WpB0Sfc5VQCCukMMU4UBFAagKQR9DBcHDk55Rf+0P3xfHbhqMkbVQwVzXv057S34chMtwA025KTAAW+lLS7nOU0/Coh1Vc86NgqrrQUr46kvbggsv/ZtYd9KiwKb4FcNmHdjStKTcnm2fzLg7G7s9djKtIzHG4RMFyMMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wIGctL22R8wEjpZ4JXEtEYJSuLR3K0wreYERoqUIzE=;
 b=FpxxCSVE5s4mu3+4fx3nDLRZ8r9IPZxGJ2ClEJ3s+F/v5KXo09c3BkL7mj8XQxFWiIN7RbSvSPdJhOiH+O63D4xGhxczRWUg4W4f37F7lFsfTaAOVxhehHGTiPhFamSNnsTD+iGrK0TmY4U3xWLsagLCYh61ZQ6JJlaLwO5CKgVYFj/uoBb00YiRV5JZAbGAwwY7J0jdpHTKY7qWMPm6nctYToJ13WnYdS+RH/fr+itz0fB4UUnOR+pOy8jiig3bPnFgt6Rm/OGWeFfdR31Y6MsNJ+3e+36hb19h5icoHSIv+qjT2uiKW+s2o+d34QdQEhbjx8RrZF0Rw1m7aM9TNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wIGctL22R8wEjpZ4JXEtEYJSuLR3K0wreYERoqUIzE=;
 b=kivDHHNYONClKSLdWdI85o+3pyNTF4gQtrkVoo3eBjHvA9NBG2oKnpvY+YdImDAZLfB8/+L/X39F8BB/Eeuq4MfXehKKItylDUzWels1C24Oa5W9oP8WvKmmW/jF9FbKOmDdYJ54ib8BMZ1ICRMYZbtqniMnEHzg/8P9ncbC/M5snvXMHEkpvi14iF43D1oHsimumdH68FjPGOwlWqRdl4/hZhD0bHoYAv4mX8ruiyvU+invNKMYaszAyoj9iA7HsZrhWq8wOKrCsG/KWcHKgpisvNBgrJzgSVNx9uMjsbT4b1P0sCreIZSwLF3vlmHDqkUjOGjsLDSZVBw4h5/NWA==
Received: from SN6PR04MB3983.namprd04.prod.outlook.com (2603:10b6:805:4c::19)
 by BL0PR04MB5043.namprd04.prod.outlook.com (2603:10b6:208:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 04:59:43 +0000
Received: from SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::5102:79c8:1ec5:d316]) by SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::5102:79c8:1ec5:d316%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 04:59:43 +0000
From:   Nathan Sharp <nwsharp@live.com>
To:     util-linux@vger.kernel.org
Cc:     Nathan Sharp <nwsharp@live.com>
Subject: [PATCH RFC 0/4] pipesz: a utility for examining and resizing pipe buffers
Date:   Mon, 11 Apr 2022 22:59:26 -0600
Message-ID: <SN6PR04MB39830A8FED1D11B472DAB968C2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ZpJYc4xVYkR9L+NG6vknxXFCkx2BiaXd]
X-ClientProxiedBy: CH2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:610:4c::25) To SN6PR04MB3983.namprd04.prod.outlook.com
 (2603:10b6:805:4c::19)
X-Microsoft-Original-Message-ID: <20220412045930.236051-1-nwsharp@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1502617b-d6e6-4d3c-7c4b-08da1c414111
X-MS-Exchange-SLBlob-MailProps: mBRmoEB1kyLHnN2J/hiGTNEsYnGwGIOvwgTEV+CE3anEosvNpurOGudSFTMrL6NiABpsMPdN4Ow5vpuKikU5V4slISNV7lCwEgcGldM6yB1HwpqyrtJBjRhxH8ylIVJYJRoguWCNfgaLWP47OGfK+X/i3sVWV8ENSWG5r8hGYu6ZSLDDghTjAn0ZXAnjHZKGEglVZ1dW13MlU+8q3pAiwNjEBRbklQwKIyPx392bhIAb9Y/f3T+pSnz7VQZWyUNwgSofyhaEsweZGWH511oWSfnUFl56NlJIi3UKtje+S7SQ5fuezmAw2LPNUFtjPw+lsQZTsYSJJ1zu1cGNVybbYCt002Rs7FRrf7wBd1/6sxFh2gzzIBa8RJjZNjL0aqe5huVrIU9Lq5+bqpzbIDuRpczgiggk5F0L6OvJkMZAz4KjhcRRcEOHdEaOTRugE6vUJFvPZhEJRcTJx5p6/WNzhC7ihkjYSc6R4Vk3wofl4Gycvj8CodfHV3upaqm8ItOO/jmGJ+j+CWCwnitYy/tv/fM74LWipZKz8eeNlXMIp5S9mFukfJ/pfjjv4bTndNsDWwTeGg09dq4lHx47p/gPRUufF1Flec1WLzfDfhxbszkHQHOPgGZFCLlbFSGYEjlm47ehfkqUKW4FAINYXEUEjzQ8waPjcEbeYd7vLJJ1kJQKGHLJoAYrCNcBUrB1EtWMdKT63lylN5vQFYfa2O0gn+BOzArFTKK1rM1f7T/hm9Bxl5k4WGEyAY4KaKwM8w4C5Op9rqLhAlI=
X-MS-TrafficTypeDiagnostic: BL0PR04MB5043:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqYpFen6IYue1rWkLmxwT3rVw1OIVsM6inPicw6RnfOdyFGS/F2s7hMujUnp0YYeJOh/WYJvu7MqbLdoAb33eeXKmcbVmaggzj4erBGsnuABVpMkoil0o2cybvjd65W29GLAy9H6A+UXvYzFKe9mFhA3dqNfbsc8W9N8pHepb2s0BoFrW/EMmicm210hZ3w0KJsO99VM1vjPHjcpUiEdHNfmQh+wtXst1G+MoLYrNK/x4grXRz7Pqna5XhOtSlMXu7D6rmrMOXxwS353sou/qqKxejR8rMW4bmVB7QjgReEPcz21Klfz5jD8glYXT9v0WDEMYHc3dBS5ZU9z1cs2mal+AJ8ml5XmVW6U+JGrylHbAlQThYqVpUs1m4rzz7xxFzM7zPRoWmwHG9bs2NEhKOZN9LEr0WPVa1ukX3UazuO3LWXv5kDYjP/jKQeyh+RVwc/tZ28H9csXy9r8GKyQ78wLihftM9OvqJioOPQ1AgLm1eKqWGlXuK15g0gy35o4D/tXw6v7ilzqqFeXfacSZzXd1vEY3fN9RznFpPdFn/cq1DBwOUGccNoureAv5HU5Qo+4kct7eXLc4HFc7xtHCw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LX0q5ZXhOq66WXIxBx4OKhRskZsfTJk4auxZqYjAmPrjJuMoYN4dhUV/NXLE?=
 =?us-ascii?Q?FMRROMcKl2ak7foia3VLUvSP2sDgxceIKbDxUHPk9hs1EPIXOLF5hoiHMhgk?=
 =?us-ascii?Q?LApKSI5raNxaCew25n9JRdUo5IOdG8rvoL2RHwb+zJtte+hO9WYXib4KDRGj?=
 =?us-ascii?Q?7XH7mfjaGq0/Da2XMdZuGT6y+Cg8bOFrJ4OLw229xbd5o4npncwElEW3xis8?=
 =?us-ascii?Q?X3N4/sfg+ilb2mYB2xiZwVCU/3YGPNIGBFtCcczxS3ogP3kVWIdYCrr0LQSD?=
 =?us-ascii?Q?URbykAjdBZz/csDoNG9XyL1/KFNIeNKI12qZC57sw0lY/OTG+pqP9ElSl9h7?=
 =?us-ascii?Q?b6FiCtzkfme9mZ0kLp588N6aj1PTfkegvn9p5ZtavMSU6cv6tGCrhkLazoDp?=
 =?us-ascii?Q?VIjiHB//smcrOwp4FYl02DdKspurtpo9Bv4bX0rq9VGemRG4CYeTdFF0CZLK?=
 =?us-ascii?Q?+uYCsNoK3vy4l6PgCWMRvdRQ98LwRLI+bucA4UVPchVs85yu46Db0+cppNWD?=
 =?us-ascii?Q?hmf5O6+CacIjjloIBLhwP8Kgr/eitr4l7wqhisuXnPpuJym5+UmvM38R5/c/?=
 =?us-ascii?Q?J+3PotlPDYA+zm+laWrPEQtgmUOzMj/i7Yo1YTM5qaRsfaCnlthJ4ENo62RR?=
 =?us-ascii?Q?EOOgRxiyvS8JAORlsCv+AkBfE6nlJUEQSWZWe40Gmr+jNZ7ZpK+cnCrlyzlo?=
 =?us-ascii?Q?jY3ntAZhEdVV5H22msWcgxOYtUhR4/I45clndK4aR56VuLVfINoHt2sG+9MP?=
 =?us-ascii?Q?BWu5vce3qBUxpqiMZIZHRRgr6QRs3Ws6TnfcqUysp3yW/ooOCmyopzfsuMva?=
 =?us-ascii?Q?VmuZOS67LGrU/zs4HkCeKeCfpDUiZ4idHRGdwJP3loIPJEeS1HZtgQ5dKBkG?=
 =?us-ascii?Q?7k/QItQ0KUr878ND2ZXVQ1xwM7U+qX+Jl4voSkww/LFvCULMpwA3yKW8bgNe?=
 =?us-ascii?Q?omCZZa9XNCiJI+7wFY8tKROATaiALoYbVJ6csTElrB4fheyiOXws3a9odnKy?=
 =?us-ascii?Q?2M8JJ0MtwXTJxdT+hwnjLoc39lTvRHLlO2MSaTWQGrFMU2IYNMB3CviSkRwn?=
 =?us-ascii?Q?Xy4ObsRKFxiVBzL4Z2GnDvi/jKcUPGoTBA5Vf8T9YQYkftZ0OYfy+SRar2oQ?=
 =?us-ascii?Q?s5pK+xUqU85/ZRSpeefsChB4swb9DQCJ1HV4Plr7Dx5BreR/raEy7cegDaAI?=
 =?us-ascii?Q?SlJb8ASsFR1T6/KgPQ8qhI/WSjD8C9GqelQZAwSNXulsOe39LUu+QB/S02ak?=
 =?us-ascii?Q?Fq1Smdl/8LrWlAhishQj0BRchGF95ppRsjeJX1Dtz7/U9xXEDIUjXsxhXQlx?=
 =?us-ascii?Q?sTtmikHUBfY0FSy8+IJD+txe7j7dgqNlAQex0cqNFNUKQ4IpHicvENml5F9N?=
 =?us-ascii?Q?PQEPjgn7cfcUUQkNxNijWZMeNfQyOHBD+9SvGmVwsAGpk+X1NflUKF1PezJM?=
 =?us-ascii?Q?wdq5T9LXH04=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1502617b-d6e6-4d3c-7c4b-08da1c414111
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB3983.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 04:59:43.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5043
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Way back in Linux 2.6.35 a mechanism was added to get and set the size of the backing buffers used by a pipe. As dataset sizes have ballooned and context switches have become more costly, I've found a few cases where increasing the capacity of a pipe has improved performance. Examining disk images and tee'ing compressed data where the usual culprits for me. It is probably useful in other cases as well.

I believe that util-linux is the right place for this functionality to be given to the programmers, system administrators, and data scientists who could benefit from it but don't have the time, know-how, or permission to fctnl their way to better performance from C. As far as I am aware, this functionality is unique to Linux and hasn't previously been available outside of C/ffi until now.

While I first stumbled across the usefulness of F_SETPIPE_SZ while working at Amazon Web Services, the code here and the method of interfacing with it is entirely new. Unfortunately, with my departure from AWS several years ago, the benchmark data I had gathered is beyond my reach. I'm not in a position to provide additional benchmarks on "production-scale" workloads.

I understand that adding a new utility to util-linux represents an ongoing maintenance burden for everyone. This is an RFC in part to determine if some mechanism in util-linux is warranted at all, given the relative obscurity of F_SETPIPE_SZ.

This changeset is broken into 4 patches. The first will add the pipesz binary, the second its tests, the third its documentation, and the forth its bash-completion. Care has been taken throughout to match the util-linux coding and documentation styles and to ease the burden of translation into different languages.

Thank you for taking time to read this cover letter, and thank you in advance for the additional time you might spend reviewing these patches.

Collaboratively,
  - Nathan Sharp


Nathan Sharp (4):
  misc-utils: add the pipesz utility
  pipesz: add tests
  pipesz: add manpage
  pipesz: add bash-completion script

 .gitignore                                  |   1 +
 bash-completion/Makemodule.am               |   3 +
 bash-completion/pipesz                      | 102 ++++++
 configure.ac                                |   8 +
 include/pathnames.h                         |   4 +
 meson.build                                 |  14 +
 meson_options.txt                           |   2 +
 misc-utils/Makemodule.am                    |   9 +
 misc-utils/meson.build                      |   4 +
 misc-utils/pipesz.1.adoc                    | 109 ++++++
 misc-utils/pipesz.c                         | 347 ++++++++++++++++++++
 tests/commands.sh                           |   1 +
 tests/expected/misc/pipesz-exec             |   1 +
 tests/expected/misc/pipesz-get-fd           |   1 +
 tests/expected/misc/pipesz-get-fd-bad.err   |   1 +
 tests/expected/misc/pipesz-get-file         |   1 +
 tests/expected/misc/pipesz-get-file-bad.err |   1 +
 tests/expected/misc/pipesz-set-fd-bad.err   |   1 +
 tests/expected/misc/pipesz-set-file-bad.err |   1 +
 tests/ts/misc/pipesz                        |  73 ++++
 20 files changed, 684 insertions(+)
 create mode 100644 bash-completion/pipesz
 create mode 100644 misc-utils/pipesz.1.adoc
 create mode 100644 misc-utils/pipesz.c
 create mode 100644 tests/expected/misc/pipesz-exec
 create mode 100644 tests/expected/misc/pipesz-get-fd
 create mode 100644 tests/expected/misc/pipesz-get-fd-bad.err
 create mode 100644 tests/expected/misc/pipesz-get-file
 create mode 100644 tests/expected/misc/pipesz-get-file-bad.err
 create mode 100644 tests/expected/misc/pipesz-set-fd-bad.err
 create mode 100644 tests/expected/misc/pipesz-set-file-bad.err
 create mode 100755 tests/ts/misc/pipesz

-- 
2.35.1

