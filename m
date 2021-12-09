Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E381C433EF
	for <util-linux@archiver.kernel.org>; Thu,  9 Dec 2021 14:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhLIOQY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Dec 2021 09:16:24 -0500
Received: from mail-eopbgr20118.outbound.protection.outlook.com ([40.107.2.118]:4359
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232048AbhLIOQX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 9 Dec 2021 09:16:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSzgWIYInOwuogw03AO1QRKeeY6hiIGkuwjeKKUTZjXR0W6p3PGSU3y4h8fXBoZuVBzdoXTKPxTiRuLX9QOhwkMr0PcjffumY5V5oZbKjUsnas1j1EE0ECs2giJJSYi3IjtniytdJ1fxy5jnwzLJRAKk6RsTwTAkb/KCzVizrn57axkPehzoHQpxZNjTSN9qZc4pFxZUaStvHl6h6h4v6P+pm0cPxATTAikOwS0doAtIDqxAK0l9XW2W+bfYXdpXnZJ6uzNmyTuQBQ4rbO7NDsFxWlHy+4d4/LEkCK19M4iAXexKJdeEfO+O9LRfoktq7b049sr9jzCBjLSK2Z/mDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1c+T7v03dourScLrr05osfDXuXj15AIXlulPDGWA6I=;
 b=j4cLJEK5WqvjT5lG7o5OiPQe1j1TOZcdiOMolvGrVf4Ad2uQrBk5h+eIQsfN95Ik84d21Me6AGc8YXvOV21IEQoocyS6n7++Y0b0lWbIfuQxD5YCEj1r+BHqhvJLYXuFXWcWXb37lGmdnPhXSHnZnn75/7fcMm+3d7OQPwXlBF6/y+CRzq4TaMH3z/aNze41255f5PBfsfsvhJhRMuiviaekS+FPdJEkInmLe3/yxdDD3121weJel1mYcBZkjeSy22cZQGI09VbeXGjN9V/1VNBVQWPqDtZU9OqANBbMfZrIVmLvA/q9CdqAM0rV9A7s18w8CDGrlTTPUUWPJoMggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1c+T7v03dourScLrr05osfDXuXj15AIXlulPDGWA6I=;
 b=Kr9Stlki2NK00LsQZGgtMzIthKaES4A+miOTrHtk/17hT4Ou8OSrvwnpUSe3fDhNHAu/Q5K4VUDedAHDHXV++lizZFtyHYWz81PVBcNcqrVE1IaQigBTpyu0Pf4z/I7jvc0LKGl4mIaWSfEYTwWlI3u88CfRvWdG97xLE7KPehM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com (2603:10a6:20b:304::18)
 by AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 14:12:48 +0000
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a]) by AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a%7]) with mapi id 15.20.4669.024; Thu, 9 Dec 2021
 14:12:48 +0000
From:   Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To:     util-linux@vger.kernel.org
Cc:     jkosina@suse.cz, kzak@redhat.com, kurt@garloff.de,
        vsementsov@virtuozzo.com, den@openvz.org, msuchanek@suse.de,
        efremov@linux.com
Subject: [PATCH 0/2] libblkid: don't use O_NONBLOCK for floppy
Date:   Thu,  9 Dec 2021 15:12:31 +0100
Message-Id: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0014.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::27) To AM9PR08MB6737.eurprd08.prod.outlook.com
 (2603:10a6:20b:304::18)
MIME-Version: 1.0
Received: from kvm.ch-qa.sw.ru (130.117.225.5) by AM6PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:20b:92::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 14:12:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2ae0b8b-3038-42d7-7777-08d9bb1dfa44
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB60348FABE557D06169456DA6C1709@AM9PR08MB6034.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wJQl60zhqSsV0asXFQZr0bSVrbJ+bZj1elbgFIEiy5ET+g8BSDc+7kj3lfqpQz5CgdA9j+oxs64qQ0g09SLrqOiglGhvc/2TDSmCf+Dtwrv0HWdbj5YJi/2VwvxrzIq3zDtuI4YPJC4RCHqRApslSGKMD8HNpkQqWMA2s95f+6CtBzllqeVV7EiPzUyikUEt1tuPlExllhDF43AHMiumfM8bAddM6L/zbQGWKW9AGnK/D+fwAVoC/TCt4F9xUBhWLuyckZh2tCnCau1XJDRLUyMfuH/L9tf1sWyPZCg7XhgvMDxf6w/v6PpXVL+CFm6GDGARxqtUc1NffpMKG9TLBhTeKABCDIE5ApxExsrR2xa5zszSTLOSoLaVW6RL0HOpZmtKdTEWyjtzLa9IISaaLUbLGSh4Kn18DHbsMAeaahhR2wNChl+TNu1tTL1LIIJvZbsTe0Yd49naaxuOBAqySEi3loqgRsNhrOXOz4uEEJu62i7fErLbpUcEpROXO1G1yqIS/XkzsBpt5FtNXXuPE+htkvI3Akj9IS//H9aBMRiJVpcBrKUt2HJbOJK7Xsu9O9RzlpjBqNU6sxtytdDgGxvatLjH1PkKQyz0RZucRlvtcruFv63AV924BnJPEm7TG7R8Lr/ld3TUMdCcva2KfUS+NdD/dXDJpWCTJ5Lrd/lBLPt/YbUdvi3pO1dsqy6boFfXhGgiw/X31keJCw8rE6HpGZocZyeN9Eoh/0XprOom1ZwxqRePrA0atzZXwcWRSkK3XcgRU+XDSdg58h1pZsZ6kxitLozFVvmL5vVsA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(66556008)(8676002)(26005)(6512007)(6486002)(966005)(508600001)(8936002)(38100700002)(5660300002)(6916009)(52116002)(38350700002)(36756003)(956004)(4326008)(2906002)(2616005)(6666004)(86362001)(4744005)(186003)(6506007)(1076003)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f1V+qd4un24n6nAiWZPA4DxpEaiyOfBCDKtZW6wRPMG+tWJ8/Ps5A/viUUgL?=
 =?us-ascii?Q?AVUV48Tt1r4eNOovFCzlTk4rHAS8Nq8Tyy8zPrCU0zMEe2kCSCzthFz1l8x5?=
 =?us-ascii?Q?zte0uT2OGtb3pq8RE8uCN5mMGYQHuBSCu108t+DG2dPpjGYzGUpoJZ3jxfQF?=
 =?us-ascii?Q?lh+e14nW8F0g1iVMqcE3FzEYzZbCFED0VjHHzVF18U+u1syU5q2qtkwsOIF8?=
 =?us-ascii?Q?5SNECDIFmPjdNPpDZfQQGWJDM/x9/wnGCfX5WMZHMulnoY97xbmMMwz4ncp0?=
 =?us-ascii?Q?8Xp3gjpV1BeAAo1IJemySfeeXPKkQKzgnwZjBQCmg+sXUTR7er5tfokXrYoE?=
 =?us-ascii?Q?XU8JyN+HshlQ29BmoWOT7lcQEo11HB9sK9/8yJvWZthQPiBQKnE60diALWXu?=
 =?us-ascii?Q?0KzsAGLqLZ0P0mLpLKi9A2kvfOoo44qhbwUJR8R8Uea2CLfybUqTrs3QVl08?=
 =?us-ascii?Q?Km6dj3S3iytB/iEViPTKAJgdqZF9d0XrhyvwvCu1VkAaE8aKVg+2BGBv/FUH?=
 =?us-ascii?Q?47Neddk6irbWK/HZp0FKC/jFRekl4xOZ92mMi00TElqMCD2xDTgwGngX6vxg?=
 =?us-ascii?Q?ytjrxoTJjq72ib8LNOsZc9KYocXRao9WsKeJSLXVRmZ/RFyO7Eubk/y032S9?=
 =?us-ascii?Q?goeInxEXxfTGykZq8wtGdUY0ZXWzpN47GiMlnBSpU+lui4VZIl6F/4EYvWRx?=
 =?us-ascii?Q?R9MtbLCzhsuPaXeWKvYkX0xOlSfIA+WPpIdILJQZY92heG/WNM6YhHds8d2B?=
 =?us-ascii?Q?/nx5bS7mfCogRN7/hYkYlifikTvLJU4LkbTr2/Pk8UBgsqcQlTLUAv0UzuKv?=
 =?us-ascii?Q?XbQ7RZ47PHD/r6jeF4D4NFkO4s87reWZb/yZwKoahCxLMcXvM43WVI9bP2AQ?=
 =?us-ascii?Q?uAlv6IOWdyPEtlx7Q+/2B6htLk5tDhM3VRfohfHeZ2iATYiRWlWzOSvuwYZK?=
 =?us-ascii?Q?JRNpu4lJ0TUyoxVuNu4W1qZ3PYX01BvPKsqSYihNJON+i1UUHj4j3fLzgu2T?=
 =?us-ascii?Q?zAptN/GSKVjnTv3QiGkOsZPJW4BW1Cu4/CYbphTor8Yrv76Mj+l9E11BTcT5?=
 =?us-ascii?Q?S8RoVhkEPU+nYhxidWTjsJ1GdgG8JccnlIlk3UO+BYvXE+BPMhDOQdcV+7A+?=
 =?us-ascii?Q?FaJ8VlO03AgVFnjZU1G7kYjBp6pC/2gKM35KcJMAU1NtYxh3bquKl9EwVF9o?=
 =?us-ascii?Q?1Lvp9jI+HnnE+YkxHEGC72bygmw0U9SA4Q9VzWwpO5Xbr26A4vcaZhhZwbsM?=
 =?us-ascii?Q?E3Mu8+FY4ayvGGrKEJg4w2B9hsNjTdETXc2QZ1TiKpixuhSeZkIogOkmhYkR?=
 =?us-ascii?Q?5fLi80Mactb0Jfsu6HlpVHy2QWtnFiklI3QGoFG5pmvXGCgC8OZ7ZKtahwQa?=
 =?us-ascii?Q?HiWJvHcp0qRLpHnIlsmZLL1DAxWnYIm6yYcL9P+ikZdhV86Zq6r1CwHKg7pG?=
 =?us-ascii?Q?KuYVu2XDkNGxSz2HKNPcijyRjOTnA3ICr7jkSGw+q5N2/8hMTQGfgjFfrv6W?=
 =?us-ascii?Q?cQhrjPUkuOkhWaGoSHklRrauSjVfYs59f2oo5VkS9411RvSQ7JOJbQLer17V?=
 =?us-ascii?Q?+MxfdUp3k+nZJvrsxYPFDBZMGQl4wjFXYXeBcZnIScnVFCPofpOsAYaXz4+r?=
 =?us-ascii?Q?NTP9tSYuiYCf9YOqsnukoP3BlvClnUP6FXjPo0ryqYS3pqvs1hS9G9I/IESJ?=
 =?us-ascii?Q?EZcaYw=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ae0b8b-3038-42d7-7777-08d9bb1dfa44
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6737.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 14:12:48.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cSxgC6gTCdWeE30aXlE7HeauDXnR/4eSb06Gbna4wOGgpf3BwP0yixCKlo7sqd41BmTm0DDztb515rUKjaVh/dj4JvgA1EafGuGlVf0nak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6034
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Good day everyone!

The commit "floppy: reintroduce O_NDELAY fix" was removed from kernel,
so we faced the bug described and discussed here:
https://bugzilla.suse.com/show_bug.cgi?id=1181018

Discussion in kernel list on reverting the commit:
https://www.spinics.net/lists/stable/msg493061.html

In short, I can quote Jiri Kosina's comment:

   opening floppy device node with O_NONBLOCK is asking for all kinds
   of trouble

So opening floppy with O_NONBLOCK in blkid leads to failure of blkid,
probable failure of mount and unpleasant error messages in dmesg (see
also patch 02 for details).

Vladimir Sementsov-Ogievskiy (2):
  libblkid: introduce blkid_safe_open
  libblkid: reopen floppy without O_NONBLOCK

 libblkid/src/blkid.h.in   |  2 ++
 libblkid/src/evaluate.c   |  2 +-
 libblkid/src/libblkid.sym |  4 ++++
 libblkid/src/probe.c      | 44 ++++++++++++++++++++++++++++++++++++++-
 libblkid/src/verify.c     |  2 +-
 misc-utils/blkid.c        |  2 +-
 misc-utils/wipefs.c       |  2 +-
 7 files changed, 53 insertions(+), 5 deletions(-)

-- 
2.31.1

