Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5145EC4167D
	for <util-linux@archiver.kernel.org>; Tue,  7 Nov 2023 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjKGSss (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 7 Nov 2023 13:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjKGSsr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 7 Nov 2023 13:48:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C0413A
        for <util-linux@vger.kernel.org>; Tue,  7 Nov 2023 10:48:45 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7GeLYU019498;
        Tue, 7 Nov 2023 18:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Hp4KDZh/UGwxZ6YO/7kl8cKrRD3ZHlS2AaIxqkTgra4=;
 b=U74ZAjN3sWj4axfp/MeY4tXEc/+0yc2yvbds052X6ST+aKWW6ykZ5VTmooz5dLj08BY/
 SamxA1wvytbUzDJzMP1lqrhkBhEAPdN7l16hNOifX1y4QI5AJpmX1rwLx500lSklNfaC
 Z1qSP37VpddZLHQm6NpAmjm7eycVnnu/kbnylMC+sRvg6S0All3ZP/rnovArFVbFHlOB
 w73fMobRvpKWwdqwB1vJXX7n1w8YYC7++dUP6H9y0bL5uELfgAHCfKxQnucMZPPIRQmg
 czEGehSONfG+/UMjtRbz88MDVioPHc1QMRiGD6mA8KUGBBVVqfttr0rNCOnTw6Tw82AY 8g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5cx16uax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 18:48:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7HaPwN026789;
        Tue, 7 Nov 2023 18:48:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd79njv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 18:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObHeYG+43D2MUF25zv4Yn/at9UxYhB3MAecnYV+bV0p4Zk5ynkxKdBRTG8UJN23CJNBREEOmrk9MkIoG3RzteJ/7OFX21cBnoxeHdJt2HDUPXEzWRz+GsMgG4Mi62AoHUeYcd3JaZQgM7Dgs/lddaiaOEdVWQu3lxEN3G3lNqGRVs1qVPporpBBb6a3i/WfNPIt7kjiyRzR30z2ec7udldjrYz6+jYIuf5UDiryvDYXWodmP5xgK9iSWGpdh0gARgaDfBDy+tl9048H4KXf2WvMvwnQmFYQvD/KYXMkZ4GQirJYDzj23O7niwegeTput0xRHb8oKK1lzGf6pVQeR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hp4KDZh/UGwxZ6YO/7kl8cKrRD3ZHlS2AaIxqkTgra4=;
 b=Xtmz3xUoO2qoNXRnK63Ua2J1sMLr/M1eUhzTiu+AuvWzsHLw/62lMLQ5B/yIfUgpnrBh4W5MFy1DCQ7zYrH4UHzNp79VNd9tWwkqdHCnVVQvwy+X9yAoFy0/W77mwV5cUYyggn73Yb133HyQO+zB0oo1/XX8H6u4Y7VL9ah2AXS13wzl+Sew6/NqIqXtJVgZcmpH8PGqzqQTM5m/T24XsGkfZX1MUKre1RAKMOKwtBf6ZPTHYyxG97HstjPPf5HbWieA0G2ZfhpF8Lq4bXrdR/dk6BgZpcFZRY1kvrwGgn9vZfeHyEIFS/Qcm/1wnHoQA9pWHvKO7x6D5nnT12ejMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hp4KDZh/UGwxZ6YO/7kl8cKrRD3ZHlS2AaIxqkTgra4=;
 b=BkyJ9xEZwFVZrSljRJelcWvXF21rnYJmtedGtrACLaG59eUzo+sHU3nItKPe574WG3iHUTxY4PNEQXTEZk/DDy9rNl6LzcZlY5moqxbnOmWlmJOf74Z0sp3dTd4MX8w7K8xuk7Tdz2pOpL2E4WF9HgijVfWfMdcszmKGEq0+9Wo=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by MN2PR10MB4256.namprd10.prod.outlook.com (2603:10b6:208:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 18:48:13 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::915a:381e:a853:cf7f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::915a:381e:a853:cf7f%3]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 18:48:13 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, thomas@t-8ch.de, dsimic@manjaro.org,
        junxiao.bi@oracle.com
Subject: [PATCH] losetup: report lost loop devices for finding free loop
Date:   Tue,  7 Nov 2023 10:48:06 -0800
Message-Id: <20231107184806.48577-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::25) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|MN2PR10MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e4bede-9c7d-4020-9614-08dbdfc2186f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwMrArY6XLA3z1RbDCteVzVCmWy6CcOMBHBtLD7P5dNtUt+12AmvS58srE+6z4CfWWXVxVRcUDeAET7QgvA+f7Ttu0Q2Vq/Q3F3wgFi9PMZZW4OGB0hdQuO7v1ej7U3ZfH5KpNvD9An2dgnAbDydOYEzWPjZZOlohqMANj4Zoan8Wm1WfDTvqtHSvR3c7uJSvqGJySxpoAuqGwRfadfaKpcGNI+4Ad1A4HW24FOC2eFmbalU9xZjYn4QtDSlaaNBHNinnLYj/HMJzt2jPxt5mrjtyG1hEda4nU13sCkzydojEiWFwUxS6nN8QTUQVAV+2ki+rIFngYUXf9h6aACUkttJq62/7e1draLpdoSyXi1V8GMzvn9m2IFx8i3xi1i7xnjnbVFulX2PUUfZcZx5jPywp8lJ+Wl8YYi+5M0E9f3GPJgQlWyNd82ML4kr0XBFwt0dYmqqiDefxohPw+Grc5zyXHmsXNyEg/bavNKPWHwXcorzY6syGnIzh0XJy4jwHEoXd7xo0JlDnGfl3FUUYoIwvMUImIC7UXzQhUL89mK6hSKT+BNyaP5IanmiwS6A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(83380400001)(86362001)(38100700002)(36756003)(26005)(6666004)(41300700001)(6506007)(8936002)(8676002)(4326008)(66556008)(6512007)(44832011)(6486002)(478600001)(6916009)(316002)(66946007)(66476007)(1076003)(107886003)(5660300002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OPROiNVbCK8UR/nOt2XAHBjOytYszFtMLV/2XD1vlj4UQ2/RGdBW8Wd3kUxl?=
 =?us-ascii?Q?fzWTpAJ/VSwjPQfrZed9R5ayf3Qp7doNVKSC6F7pjtVSI9AK7F+3y01ce8zN?=
 =?us-ascii?Q?zwl5Q6FD2csWJPH2O2K0HGHzgom7+wLzELfFezSgjUT+LoIB6j/okrDZav3j?=
 =?us-ascii?Q?Ca7Yy+a57Bqf+5IVGF5Rn1KTGta6CMHdfH2WQ9rMBKd5mMuRksDoSvF0+LdY?=
 =?us-ascii?Q?s+hn9KV2Ez2NH+Dt9AwhX+coK1Ytp0gR6zq8DD5exc71y2qTb9MIFnbCoja4?=
 =?us-ascii?Q?8u3gj7j6sjKeRsGD2yBlVJh4Lxu0U7WKtzAuIo9P3CatM3gNqCN2xaja3tYi?=
 =?us-ascii?Q?CL/hU03CdpOkEgi/ZFqnLRj+NklYxa2PdUDROr5uOAxGm9pRso7ZxuzDTTFm?=
 =?us-ascii?Q?6OILR78xc+4I2TtU3rHQrAGYavlC/wZuKpFnFnmwNvtcTKkRhxPgwZwUVFQe?=
 =?us-ascii?Q?lY5UjcmlxXtniRxzTqaVKuFehRLwzIrBKJ/slH92Wer71P3BZs4AFsy7W6Xx?=
 =?us-ascii?Q?F0kMYAMM4uQg08Jy/bnKwAF71eoun9yFwksfvuGUBX/E11UB//7xuLhM82Gv?=
 =?us-ascii?Q?+KKiEHkog1o6zurTTpBAbT9tENgGwPybYinfai0RhwGpxZXwjJAspdqtriiu?=
 =?us-ascii?Q?hmXsFMw17McYSeOvy1aLWWC6J6x5QEpZ4NxR++e76P1SuIfg9QdAn4d99r6w?=
 =?us-ascii?Q?gfMAHX9okZm2taCEMXkmNwShJFt7chPkYdRxkULuVlRhSfANByf+E+3zl8LJ?=
 =?us-ascii?Q?dRBhkitBxfOGOoE0/WXsj1Kluscrt+LQXNp0fc9LiNHCVwlIv09DHJ5u7LB/?=
 =?us-ascii?Q?brVSTb1QmuSpIBDSURM64cguI0/DhuxInFf2OKbG5zUz0eZXls7lAJ0ghmka?=
 =?us-ascii?Q?MLd2b8g4dvJrAK2zYNttZWwSEEIs79xYtbOEiZApHJQDgU0oCoQ0WKQ6TwqI?=
 =?us-ascii?Q?UTGSbGelgrgWXOJYm1GxONUzx5gopMRXCndplJkckvmDSNm+WlQD1+9XfptM?=
 =?us-ascii?Q?mo7l+u6r3fFdzyAN8FttgK6b1FVaXbB/oosIoCcrJ8kboh7nEDbHKFOmp+hl?=
 =?us-ascii?Q?OExFf58pQX4Z3VisGCo9Tci5j9RxzHTnSqqKvcphC7prg7Dfksr2szxObCwv?=
 =?us-ascii?Q?BhBIgaYhpLt/bFgP6fo322rF029R5FqNdLcjugHcujQ+LQm6vEix/1u8hB1x?=
 =?us-ascii?Q?HLuAI33VdYB7wu9XADqqmyEchJkPIDUO88vz5zQ7MRa+i5ZR540tOzf5Rj39?=
 =?us-ascii?Q?fws/FAXKVNUVWbalD+uXXx4HxkACcvz6EC+IFbLGrMNegTIHSNEpAV/XpcWu?=
 =?us-ascii?Q?pPJbvU5LpGsIPOM+Ft2FhJo1Jy0FaRCrUftZuwNE7XDVruyVsv89Bbg0CqQj?=
 =?us-ascii?Q?xb82DgRXxhbB++TLdvtCCrlPrTReQWegL4c0qMF6bUOieCbvItI4L3VS2Wy7?=
 =?us-ascii?Q?ad68exRpxuUK2lEOb6rLIO0xAGd+eubPMFwL5xhlN6HheUv/kLRb5aM2j8Qd?=
 =?us-ascii?Q?Mgqx7m9NlZb3BTQL4aJZPS+YN3UaCb7CZsId9aw5/oQMm2bnbOrYBkN1Vxc1?=
 =?us-ascii?Q?/r5FzDai5rXYhRRhktYW92H1WWefF+teBbjs5eDA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mq3jMxJtjZyDRQBfzIDdmsj8hByTvhi4OAvAhAgIVXyi2L5Id2FlNav6CoHnrVxwcs+Lh+Bet05CDNMEt/UrXH/PWOxFZZ0S0I9vEkSQQ5yfug8O6ZHEeXDUCdRess8is3YzFZRCs7VJL1K0ejH3b92ubZyFFmLusUZ14SpsiSmAjaFhRGhriDBERySiVLRa/aW2a9BpP+BzRHmiuiq/pGByxegxPOlcS5LD+eEB4NVfry75q3tvN2K0+TTDxVuq28DitZzaCBcEyrejhkyf42INBNVE2S9+pRls/4W4DdqroahDM2bSLerWTAC/4sEZlvyMSazx3NEhoMCE9xspNCr0J+aH5tZnqmTlUqj3V5BAXYrgSS1zRaPY9JmRbg7mbTYDk6NF/zYkX1OBVDRWRZuNo9xW+r3sQau5ZVJ69nEWlXj8fH6hNNQNV2T41D3kwcV1WjRTAiDMHMQnULQB1sIRmKO85FaekQdenNgkWCicKoaSYd8Z6XYrx34YQNE5gfkNnVCJeEVwKhNa1Yxz3F5ckoFdymG0h9XyibXhFRqIBO4/Jk6vtTGInxOzO2CSJlz/foXOPk1CUIQonB+V6b0Mjc3hMPDPhh4uh3T12emq6UT+lBP+ExP5cSRDufR77bV+sVtAyPvv9CXPH4YHOAvf2Od0X/ZZ7+n2N9vuBkI3azXeuZSSeMpKKut4ww874PJpd6vo7IzmetMP3oUppXfXp8rXJ8C5yd/FUOvdeiP0JBjjKLwYvdpJrIk6Pn5Rfpmis9UkrX95l4W1AMspkVdAdGrBdsLMJ6BHGzRKAG7CDKRxftHsUoI49umzY4kPWk40Kd4Dv6bZIFEzyf5TCaeqUlr2g0/uOgUyEeq1hZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e4bede-9c7d-4020-9614-08dbdfc2186f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:48:13.1623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wl5G78ZX93fs3Fm9csJyb0iSOr30n4bssZJuOHusgPNDL+XRljniHwb91GBTEXHuI3uRX/NZI1ekYn0dEfjWLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_10,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070156
X-Proofpoint-GUID: HmrKF8yrPxM6TaHJWfYCGoHERt2ZaUyD
X-Proofpoint-ORIG-GUID: HmrKF8yrPxM6TaHJWfYCGoHERt2ZaUyD
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

commit a6ca0456cc6d("loopdev: report lost loop devices") forgot to
report lost loop device for finding free loop case. With this path,
it will show the following if next free loop device is lost.

 # ./losetup -f
 /dev/loop1 (lost)
 # ./losetup -f /tmp/test.img
 lt-losetup: /tmp/test.img: failed to set up loop device: No such file or directory
 lt-losetup: device node /dev/loop1 (7:1) is lost. You may use mknod(1) to recover it.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 sys-utils/losetup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index b218ce14d582..afeb5babbd8b 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -950,7 +950,8 @@ int main(int argc, char **argv)
 	case A_FIND_FREE:
 		res = find_unused(&lc);
 		if (!res)
-			printf("%s\n", loopcxt_get_device(&lc));
+			printf("%s%s\n", loopcxt_get_device(&lc),
+				loopcxt_is_lost(&lc) ? " (lost)" : "");
 		break;
 	case A_SHOW:
 		if (list)
@@ -991,6 +992,7 @@ int main(int argc, char **argv)
 	}
 
 	if (res && (act == A_SET_CAPACITY
+		    || act == A_CREATE
 		    || act == A_SET_DIRECT_IO
 		    || act == A_SET_BLOCKSIZE)
 	    && loopcxt_is_lost(&lc))
-- 
2.39.3

