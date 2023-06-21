Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F063EB64D7
	for <util-linux@archiver.kernel.org>; Wed, 21 Jun 2023 20:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjFUUSm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFUUSl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 21 Jun 2023 16:18:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2131.outbound.protection.outlook.com [40.107.20.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16C71994
        for <util-linux@vger.kernel.org>; Wed, 21 Jun 2023 13:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITSYWyoEwVMdiPshAreGF694AkN0Uszm1Kzq3mob/TCkILvEx7izQURAovCzG8aC9+QBOGTxL7GQL2MkWivV9fjxa/aVA6w+LjYonYwzU0e4U1x2V1yi2eBCftU2nCTP0KFtMvg8e11r0yAt9HaLiI2pF6xYNCnRsZ4clF4VsTKgQjKumCpTWfpIA5LjP0nGRzAswu2qPzs0eDufEY0FSPIFajmpY5Vr6cI1DUKWbODWzJizxjfE9pc55EnqANSiNe2KelBMeavKdOrr6iPvG9ZPKOK/CvFEOLBcBXZYG1FbQLBkwXBKQUyIA8bDmCkpPbT7zTJbDGPmsdRWZeC3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU+aoFiYIQW2GPhOPgZrKX71Ukdi9w7PxM4KLacxu/o=;
 b=LVcj6CYw8R8vnYXLVl8WV8e65Ur8Rgj0hgpyEK5i1VtjYkieQVyoDjiQsfDLrEu87RBEH7LGm6UxXTWTKlD+ODLMw/62yNzQEdnsAg2AuZKGBsA1+ZwXdrOWJRfaUbHD9aYjSh7vXCGnJmk5t0fs33uqDWPgayprYo6jn8vd5cZNrfg5QRh43lvD0DzmvyQ1A5cWfmKbAWEuXjUKU4x+lyUZG7RBXGWjOZIlS4JZ3TZ5BbqxJHn4cRqZ2j2u2kpsXejoddwOlHQGyqM2X7elVv2lgN7uh5S9NzSAtIbcUjLoQeUIZYQCK0pi9YAokpE/v0U3bBfZye2D5Wxr/+Sfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU+aoFiYIQW2GPhOPgZrKX71Ukdi9w7PxM4KLacxu/o=;
 b=O/JOxL3enAO8VfJX8YZ3MiFvEm0bDs38PPlkmYezD+mfhAHdfHGZvR4ujXnDMYJ3PQ+ZqX6Ur2/7QTV8iKFgbL8y+aNFSjiiV3+22Oz1ZGBSg565wQ1edJQ9wXYXy02Vn6XYAPUl5Ol7/xYinDiv2oUxaPpCnOX27aamLeZTYuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS1PR10MB5676.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 20:18:33 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d66c:ec:aa54:f318]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d66c:ec:aa54:f318%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 20:18:33 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     util-linux@vger.kernel.org
Cc:     Karel Zak <kzak@redhat.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] hwclock: add --vl-read, --vl-clear documentation and bash-completion
Date:   Wed, 21 Jun 2023 22:18:23 +0200
Message-Id: <20230621201823.874883-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0042.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::7)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS1PR10MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1d78d5-212d-4b00-089f-08db7294afa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qJF3GfT0EVGLC7VZ0wKFFPOsASzak3iXhobWYFBJHYXNeS3AildNg9naaLhsvgvztySqYADSmKqF/qsioThjWTgh7U69zhPxRFCPmIGYtfcCHH7TuGutSfJ7eFtX+c3/i07hbnq/NSUzU+jbfkRGwnxTeeRt7Ks6qQ924Ex8hHZ1uZhSa9X9TrjUE/Ebi3+mwu0vPOPngcrUiuW3t+1aytu+I7vCpxJgBYbPaqaSxBZgOIu57sqrO96m+G1dcpPvd6LAgGZpNuTQypcEf6SW3A7EEkDdz3QWOpEU8AGYJTlMUuudKlCwm9zIZHoy+L2qG4faRdbsD3i2gl9chblcvfleDvI6gdOPrIbBYRUdXpRsl7cAvkFvjTF5KDmynD6xf5qOaAhB4jrvPugeXaZmSIq9qdgq5Uiq9QAlIrjnHh5L8BGE6iuFm412eWL7f1X5oF1/jHFuYvY30XWcGMqM3oXM+rTxgO1H6Gw5zb/xLwpPu31Ra/sP/8E9x8c5AH1HEa9hY2jHUonkBadGRmJo3jFpNauV8klxilMmQKwr89hLFvbqr1GIzirfTUrFqIbXEbpy7t+5TPgly0yizH32yOABdy7G8ZYE++BPio4x8EcydjcKa7jsPVLItc9GqTH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39840400004)(366004)(376002)(396003)(451199021)(2906002)(8976002)(44832011)(8676002)(8936002)(83380400001)(86362001)(38100700002)(38350700002)(36756003)(2616005)(6666004)(52116002)(6486002)(41300700001)(5660300002)(316002)(4326008)(478600001)(6916009)(66476007)(66556008)(54906003)(66946007)(1076003)(186003)(26005)(6512007)(6506007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Ax2TrelUVv1cdh4HVtWVy5fd8nMfIfhckhmVaPA2tD6mldWGp8cVq6UlwW9?=
 =?us-ascii?Q?Qru+uc/Nc5I0YYbXTbkaGvW7KjxQW3Cs/cT2SEC4ZNMc5vFzGaRvGnPW4yL7?=
 =?us-ascii?Q?o1aN/CSNvQPkKX0sRsz20HkHt0aEiy3LUyjsxmfbdwEM0nZJ0Qhmmch/ORRn?=
 =?us-ascii?Q?DM1D7NGTeTsrgJ2bAPQ/+5J1B7wLkTlPhwjEH/N727mACsKFBhfdCyOU6WzM?=
 =?us-ascii?Q?9wWvGY2R5ecurOq/yMkre0SSXyAyqElJglRUv/0NkzujXB3T8fu8ppWc0pFf?=
 =?us-ascii?Q?lXMnYOGK2JFi62ejIOqVtxkL4m9JyTosImBtRV/uLoJXv1R7XCFsWcpOiS6J?=
 =?us-ascii?Q?Sh9+gmV2LZDBVwMtuI5fkWTRjfL+DDd8/84sVUBzAxD04gvsJihx9sDzpdkZ?=
 =?us-ascii?Q?B93BFEO0niK45UeszQO+sfU75+0J7Xha1IWqTCqb5f1Kmf21eBowZk7o1PnJ?=
 =?us-ascii?Q?lB3gQevM1Jg4sUUc8xG/bSTTB4I3UYNL/cu/LOsadholf1I9uyXDTKmmE2HA?=
 =?us-ascii?Q?rf8YTYiijnugrGxLm1D2JRRM6eGh6W97Ce8wMSCKQvhaCIxX7fSbjcsKC8/W?=
 =?us-ascii?Q?qCrKH3ZHTPFUklNzyh6BdxvKR+OaDaOUZqdSkXxd7Ltg7IEADCXkfoLzqkXm?=
 =?us-ascii?Q?/YrG6zu+zkcFLmtN3dH8V9z9tTWEgD3Xjt9BVtFSKJf1QEmaitoMffalB7bL?=
 =?us-ascii?Q?z9YdRQxJN9qesnc8SAAxwB1bDBxrvtcBhoBGUj3V0oc7d07DfAa9uoO/yNPr?=
 =?us-ascii?Q?IcdW3vfiA7kaMPlL3dNr21lqT2bFeL1d/LJaHFlbTYos4WPAv4GCk+ro5m6U?=
 =?us-ascii?Q?6+KewhU6TmsANDVyqa7FW40njYRwBeHL0+5SU00cj49JkDHcttnwOiu5LH3+?=
 =?us-ascii?Q?MHuA9ozphmDOJ01iaOP4uehvSVPZ6lSQ9WYvRL4hr94mmQX/YXTc/r3r9uFp?=
 =?us-ascii?Q?142wKVh4pvM3rpgCxuYUN391LDcE48XWVJ0lTHyCR0UAuc3+drk1UzUEvfEC?=
 =?us-ascii?Q?JbBQ41moubiTQw4Kq0McWdM+gVxiBZPWzlBWB8Rck3DSl03ce0No0GrZID9F?=
 =?us-ascii?Q?r8EoLaszL4LeWsQQ0VaSGW9nCVWN3pnRQsAck/ccwLF8uVaHvkY09QuXURBs?=
 =?us-ascii?Q?GlsUe7C8r0bMLN8Tnzr4r9xIUjwG/DBeGmKKYJQkFTxnrbDkHM1ddlpbDwGT?=
 =?us-ascii?Q?+6mF6C2kmT15GSE/8i58/ezIo4Dk5k6B2rsSOf9Qw2SLZisJ5x/DPF3+vlRx?=
 =?us-ascii?Q?BtW360mm1OaWRdJRGrRbi92yn/ldwG5gYV/QNGkqM3BT8gQRfV31ek8NB2qj?=
 =?us-ascii?Q?9pG7pnt3NyxCP/pkALsqqlU9ZiK+dICrLV9kwxuRfAdSHybMALX9tecOxHsh?=
 =?us-ascii?Q?Xc6FKQloPSKSktOpyEjFjjOOo9xv+oMMoKKazgu9WLyA8kK/kpMF7u2b9mEE?=
 =?us-ascii?Q?CVdP2FgpEX6UPVerAHEGPMtDhirM8Wtd7kA86kdIDow/muVBKXtviMQGBm3f?=
 =?us-ascii?Q?h0z0jOjklCUGrhwwqbO8/J6AXAKVr7NK8VWd2axNd6Gz7fww52Nw2EwfUfBd?=
 =?us-ascii?Q?QwjqGL20cNIMb+9ztRvD+mCZLB8TkYSU7n3LGOeb31hfF3CIm0rusq1f7eb9?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1d78d5-212d-4b00-089f-08db7294afa3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 20:18:33.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzKkmR/nk6mp2rydgDlRO/R2NxOv7B59feweKfE7pBMmYCFeqC5ScW/GIjyAugbhKo08Fk+ElzkltJUErjoj8X2nRTsTtoeujFqAKv+cH5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5676
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 bash-completion/hwclock  | 2 ++
 sys-utils/hwclock.8.adoc | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/bash-completion/hwclock b/bash-completion/hwclock
index 6b4c01724..6240d7d4b 100644
--- a/bash-completion/hwclock
+++ b/bash-completion/hwclock
@@ -54,6 +54,8 @@ _hwclock_module()
 				--epoch
 				--param-get
 				--param-set
+				--vl-read
+				--vl-clear
 				--update-drift
 				--noadjfile
 				--adjfile
diff --git a/sys-utils/hwclock.8.adoc b/sys-utils/hwclock.8.adoc
index 3e181edd2..0b23a37e8 100644
--- a/sys-utils/hwclock.8.adoc
+++ b/sys-utils/hwclock.8.adoc
@@ -101,6 +101,11 @@ The first two are only available on the first call of *settimeofday*(2) after bo
 *-w*, *--systohc*::
 Set the Hardware Clock from the System Clock, and update the timestamps in _{ADJTIME_PATH}_. With the *--update-drift* option also (re)calculate the drift factor. Try it without the option if *--systohc* fails. See *--update-drift* below.
 
+*--vl-read*, *--vl-clear*::
+Some RTC devices are able to monitor the voltage of the backup battery and thus provide a way for the user to know that the battery should be replaced. The *--vl-read* function retrieves the Voltage Low information and decodes the result into human-readable form. The *--vl-clear* function resets the Voltage Low information, which is necessary for some RTC devices after a battery replacement.
++
+See the Kernel's _include/uapi/linux/rtc.h_ for details on which pieces of information may be returned. Note that not all RTC devices have this monitoring capability, nor do all drivers necessarily support reading the information.
+
 include::man-common/help-version.adoc[]
 
 == OPTIONS
-- 
2.37.2

