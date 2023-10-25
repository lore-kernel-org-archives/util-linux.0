Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3A8C07545
	for <util-linux@archiver.kernel.org>; Wed, 25 Oct 2023 20:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYUgg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Oct 2023 16:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYUge (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 25 Oct 2023 16:36:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C158ADE
        for <util-linux@vger.kernel.org>; Wed, 25 Oct 2023 13:36:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwTIa025027;
        Wed, 25 Oct 2023 20:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=RMBiKKnwjrZvzpsI+fHOUEYAh8lZb+XxGKG/XhxR0xU=;
 b=v48H7cnvEu0kweJ9yCvl2IOiEV8zh4H00sGrlfB3Vto0wy8NQsVhHLAjTC4mdFsjmuu6
 Ee0TdbTRxmdjTGVvOdQHewZ+eaGKidgzHR9GYgHKfc8gB4rkE1Bh/rWObzz643SccIrJ
 HgX2B8l+lGqBBGtGls65+DEnyCaKlymT+cKqjvXLRWLaXfVvbjpxRz+//vT/l15yEb/O
 tzTzBg4u9U7Ywke/MV+QacE7LKUZxgmKFdlYl5E7A+MvY7AZpVDN1x9HSUM5vOIAZ58J
 IRWlZANu5v+DoMdyYvyrxxcgBBv2QuRDWX69MP6eOGBwIdA0SVHWuQS4GhsJ8cxg6wd5 dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbgrgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 20:36:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PJhcdw031225;
        Wed, 25 Oct 2023 20:36:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53dpp94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 20:36:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC2HaIzQUfkZfIapWrcfM78yy0Csh4YDyYILjy70517SZykfcW09uKyMgGyERvGEcwAFJXc5Qan/HDZgMa0Ci++5zhyAWlitDQWIheVg1BG8VQs0T4KalRszlAJN8Ezyb9YyQAWQhKPMI3iInhI5hnVnZ55NWF33LMmSOId7wYhLWfW/XCcRtsMmvqHp7sBGAG1LlOeIqNlCzA2cShnzA/qkkfVSu5pnOJpgQIjpGvgVvfYSjoyMpagOZqHRY5QsIUnz7DjOU2dPQ8Kh34txOJANz0MnlR6jmqYhyOIAFP+X4/omT3YDIniECe1730q+ENyTgvld1M+9LQAVKV8qyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMBiKKnwjrZvzpsI+fHOUEYAh8lZb+XxGKG/XhxR0xU=;
 b=kPvawbcKEZYoYjtamry7iMqmJGS4Wdkm1QGmLI9v9mJKjrxHZso0LXVjsvmC9ZIeCcof7ERaEmHrJ0aFSBCbQVQunloeb9LY6MISeKz/WcJLuuYUgH+MBIc8zc+JspImFlxFVPBpdhmO3jxtDbvcwPpZ1iNtAjPQP9ZCiziuCU7YzIYd5e7EtwEH3LVlshKuDzU8BIBgoUjjGxb3PE+TdbbxfGyBZ1GU60TNhDf6qdUuGoI4aCRUtd8Rk5L3UHSPUbgHoojjn7p4OCzpPGaTzlgGpk48xsI53VGMbNXrrPvxJ3kOinlm8xY5hZe/4Ue+uj+ma8VPyqADCDvriaJU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMBiKKnwjrZvzpsI+fHOUEYAh8lZb+XxGKG/XhxR0xU=;
 b=T33+7rKQ7QrgU0teSo/7AB28NVUHn3c/gsXE2deBa7kuV879J1a3BT9KxUGBFc/V4iV7yjbUxYskQASth6XPJr82tgMpvQBUIjfAXI2S5Vd8IUPlaQdyzvMSeV4fr3/LSObcV9TcbRXiBSjXchutXBKHRUpkYiRCAyrExouqx/c=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by PH7PR10MB6353.namprd10.prod.outlook.com (2603:10b6:510:1b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 20:36:12 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::915a:381e:a853:cf7f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::915a:381e:a853:cf7f%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 20:36:12 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, thomas@t-8ch.de, dsimic@manjaro.org,
        junxiao.bi@oracle.com
Subject: [PATCH V2] loopdev: report lost loop device file error
Date:   Wed, 25 Oct 2023 13:36:03 -0700
Message-Id: <20231025203603.48584-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|PH7PR10MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 24dc3ff5-6118-4942-ba51-08dbd59a06f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfDHhQumr3v/Pr4qUwKw6vB1zJnkRwx/HL5YZzhuxwvzdo9iXjeJP0xLydV2bD/oHfPxKRHvqmh3d7GoxLSQi0S/9qedHQ/+tg55DycjiffcbNdY0gGd81B5iFRBj2FDKuLNe2wAJy6OgqdvYQ0bNxIlNlPhACg53Tb/TrYoODFD3xJe9X0Odgian8isLJBWSZ17AjY3WJH/IcvVsm8xwO8TBLTwlMf3MI1gw/O7Mp5X8GQXa2gopjoWCbOkEKW2bBQmgJS+HTxiJ5Ed3u/2Pl7ofeX/tr+Vt4PAN9kpSuGMeP42ITRu2cLthdXpiK2OrAqFPuWSl+zHAWLCzmQK6M7Hj19uKNubqlszdp4Qof9b2EhO7i7nuBjFIf9IFeshzzeWwIpoB36hDODydsyZ1b1y6GGkMXA0CYzI+yL+pj5Bik3QiWtheqwZwBZuib8zozeV4+XXiynApHKVKzGM/ymuSggwrOB+L2kc/pj+/obsii25Ee4cXqTr44BV9W/1ekuc0U7Ljr5h5FOjKKHMePPLg2t61KpDDcopFUrufD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(2906002)(38100700002)(6916009)(316002)(66556008)(66946007)(66476007)(6506007)(6666004)(966005)(6486002)(478600001)(1076003)(26005)(41300700001)(2616005)(107886003)(44832011)(8936002)(8676002)(6512007)(4326008)(5660300002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8cv+eAYhuCJBxl3QTGEO8Jxgujy7CFesD4PGNt2zO3UU/sWXNQskb+jOHjEK?=
 =?us-ascii?Q?op/Q4OQKA5JHjKy43lgWpZroc/O/pGNf+M3ptv6bgdP1eIg1ySnxbGZzm1xK?=
 =?us-ascii?Q?y1wwRyps/7JqyBgz2NejFJ3uA3+0NLpLx4/K7GHS+qRNsGARtg1H2ZB1g4Kv?=
 =?us-ascii?Q?f9paJKeBoU7XiEZfV11g3D4b1VRJhjEZxDOTKVPOph0ZGTAuQXijtkAw6/Hh?=
 =?us-ascii?Q?C5gWRoWfHWpsp78xUaA1kCvpGu1v1V4gfj0yXE5XgjIvTvKYSERbbjO7j9jh?=
 =?us-ascii?Q?WvDqWyLlViyqqPSpgHV3t6qtT6q6nLVzdvqR3i0nG8OdnU/vWWwi9LzKyEXp?=
 =?us-ascii?Q?HiKdmMxfHI+ImVGiGX+n5Nuyp3WXHF3IVgy/CfHJUB2JcaNoO+mrK+ZkNSQo?=
 =?us-ascii?Q?d5UD4WNgPt1QlVyM0PRoWJvIDM1fp3T7nZ1Wed7LkST0Md3B+Qzb2gvjSjFV?=
 =?us-ascii?Q?XTlw088qM4S866kvuHB6iA9WaZZy8c5StuA2PkuPRFrdf223XyWKPX0ysdL5?=
 =?us-ascii?Q?/6rWj11XNjCdp4hVDufccrKAir43hxHp6quiZo7+R/OVtpAt1VoYpzsWQ0WC?=
 =?us-ascii?Q?NkYPZMTuFMH0qkPGnYInGweCBLptF07vB0kX5abm7pRs8fkmjU6dMR55gYic?=
 =?us-ascii?Q?NeT2uOcTnAvsI2Hqef+6SozjST9D4bX5PJUo4zu9UK1r2RjieZepdshOCZMo?=
 =?us-ascii?Q?lOqetpwcGC4JChVMb3PnNgLSAwI3bJW6Y1UGKMZxGlKCmLIuK2df8JkqjM+M?=
 =?us-ascii?Q?AratjmX+UvbUYu0tBFisFXfPWf7D1LYbuCLoBdFM9AhCNqfEe4dvkO7wEhZ7?=
 =?us-ascii?Q?fXfZcUnamebKYZo6472uOSW8A5WaJk/LVnfRjeCGsIS261CN92952/QNTm1a?=
 =?us-ascii?Q?6uzjN6lb/6kiNrooTrQTyWCTZ8sQcADlFgwpUpeBEDIUFdMPWhRTKXqCWAsU?=
 =?us-ascii?Q?5AKVTGRfYXA5UhRek1GiCp4j8Yl2PsHFsOkqr20GFxAJ+Mcrvzp1uPd0wbLk?=
 =?us-ascii?Q?1BpJPi3U44Q4AYFcUVt3T976gNtUq5a7v6HSF7h6o8ZaWoR6/t9XoqxhqpGS?=
 =?us-ascii?Q?tqYre9xOceIbjVPSb4RRJWAjj24NzKxVaxLIrBaayqMX+U+ej09IHt3ugrlm?=
 =?us-ascii?Q?QlMLj9epTHBwiHYVIGhZv2vEZN3vyr+FH9h1nDE6TIfAGVSL3u+zC/IbSlH2?=
 =?us-ascii?Q?k5/iVPmxEDgQIDXZtUFKJt2lP+T8zxvs5hA9HbrzkijCiKcBsiri82DhIKol?=
 =?us-ascii?Q?ge2SM1cgUGAKoR/GAIEUfQyIvOEbcNb3NazLcfl/DDnVQp19MHyK4Q3LL4Kw?=
 =?us-ascii?Q?oA2ETDR4gsKUnE0NbAhGiN9xeBtM3wmetIlNVMWK/6cdCFGKTk/QFl0rKHfn?=
 =?us-ascii?Q?flVtzaoag3XMVtZFWvnoFby+DicE4KTEUr3oMTeQpyROBteD3NCuNxs01mzx?=
 =?us-ascii?Q?BGBx1e52aKYxD054pbw4R/1lZQoqQo+vK4soNL4KVqdE/tXEYB7wWY0l2pVK?=
 =?us-ascii?Q?/nruy2tIlBz6vNtGw6LrP7jbjDOQOgYw7mDB8GRD0JX6lUvaA1HghFO5657K?=
 =?us-ascii?Q?wQHQaJaM7yqf3oTdrHmIKWNmeq38izpdiMuFbnNz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vwtHP6uvJLopAHMjB3kSgC8G/WsrjUVEyTMKzU+XLbaaEy0hGDBEeRK7R2r1GKbYBfhKRsedqG/aAjOW6xuNj0BOUqUnWwtcMi4d+j1qy7b8JMI5cu/hjBilU7unDQE8M0v3NaDXT4V8ILIKMWHXMV/PTNCokWP8cEgo3ZoJsqds0NK1SfaMY6ZKbGZ8X7yWY6VwVnZWKW8t++CHP61uqXeW/s66b6lSbsA71PaIqAUBZqenz7lbCv9E/iXFoLD9/mdKjuG1m+Af2Gof54peyNa59q25VAC7aBPlXDJrtXpMoPtpCbDa3GmUHbcj0z9e7MMFYLhd3dniRj955pDmwZ9RsVFpzJa6E6P1OYh8aFl9QeT9uaZjTuUEcZFMJEF6ndZD/cLWUY5iXlxDHpn7/6oLUk1uH2Ms9W8/ddl8xG3eSx1vKhyIzwg7HEn5SRi34L78t4/YVSvKwsxjBsgYIAxAT8XahJLsS7KmV28dUdDWl7DnSlz2H5y2ECOoRe+1/QGTGMrxpx1ofi/3jaXQCAc5QjZ/7YUKwNbxU5GwzN+XnkoR0doUEI5XMICvX1Qe+hnr9yoFBYHjqJu1gsAPU2tXpC25ypNdbbEaUPkQgWeMKbTPKepxA/Y26vdo+SXp7r8fjphA5EvkSXuL0r7rFlE3OOYcONc9Nu30NQ4ExJZPW4z224ZckjIR3N8XI3fxD/ddmZAQZjeu8kLMMJo/oKs1godMEUlQVKXxbcyhw8nUKpMUwXPRlytb1YvQhyBPoa0S/3cI/FgDwWk39TEjHmlx87/9QHMAPptks6nQLIztXK4zbpkkw3SevAD204TITOCHlKR2sB4oQkeRWYKFmDOjbgEInkTVBUaeT1v/3x4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dc3ff5-6118-4942-ba51-08dbd59a06f1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 20:36:12.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuumbAOR0Oj+cqbL1mIjXlKu28OE8XnOL+22bWB/kHo3MOp2Hq8H0fn19RANlJueqes6p+DDzKDxzHFjwVjc7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_10,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250175
X-Proofpoint-GUID: LKlJ-ai2yY32dGJTGhnHLXPvpf9xbP8a
X-Proofpoint-ORIG-GUID: LKlJ-ai2yY32dGJTGhnHLXPvpf9xbP8a
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If a /dev/loopX is lost because someone might have removed it by mistake,
future losetup operations on that loop device will fail.
For examples, following cmds will fail when loop device file is lost.
- "losetup -d $loop_device"
- "losetup -f $file" or "mount $file $dev"

Since /sysfs still have the loop device intact, detect that and report
detailed log message to guide user to recover the lost loop device file.

    # ./losetup -a
    /dev/loop0: [64512]:19133870 (/tmp/test.img)
    # rm -rf /dev/loop0
    # ./losetup -d /dev/loop0
    /dev/loop0 is lost, run "mknod /dev/loop0 b 7 0" to recover it.
    lt-losetup: /dev/loop0: detach failed: No such file or directory

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
v2 <- v1:
 - Reporting lost loop device file instead of using mknode to recreate
v1:
https://www.spinics.net/lists/util-linux-ng/msg17471.html

 lib/loopdev.c       | 37 ++++++++++++++++++++++++++++++-------
 sys-utils/losetup.c | 14 +++++---------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index dae499f256fa..c8407857972a 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -279,6 +279,29 @@ static struct path_cxt *loopcxt_get_sysfs(struct loopdev_cxt *lc)
 	return lc->sysfs;
 }
 
+/*
+ * losetup cmds could fail if /dev/loopX is removed by mistake.
+ * This function will detect that and report a detailed error
+ * log to help sysadmin recreate the lost loop device file.
+ */
+static void loopcxt_scan_lost_device_file(struct loopdev_cxt *lc)
+{
+	static int scanned = 0;
+	dev_t devno;
+
+	/*only scan sysfs once for losetup cmd*/
+	if (!scanned)
+		scanned = 1;
+	else
+		return;
+	devno = sysfs_devname_to_devno(lc->device);
+	if (devno <= 0)
+		return;
+
+	fprintf(stderr, "%s is lost, run \"mknod %s b %d %d\" to recover it.\n",
+			lc->device, lc->device, major(devno), minor(devno));
+}
+
 static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
 {
 	int old = -1;
@@ -304,6 +327,13 @@ static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
 				mode == O_RDONLY ? "ro" :
 			        mode == O_RDWR ? "rw" : "??"));
 
+		/* loop device file not exist. */
+		if (lc->fd < 0 && errno == ENOENT) {
+			DBG(CXT, ul_debugobj(lc, "%s doesn't exist.",
+						lc->device));
+			loopcxt_scan_lost_device_file(lc);
+			errno = ENOENT;
+		}
 		if (lc->fd < 0 && old >= 0) {
 			/* restore original on error */
 			lc->fd = old;
@@ -416,13 +446,6 @@ static int loopiter_set_device(struct loopdev_cxt *lc, const char *device)
 	    !(lc->iter.flags & LOOPITER_FL_FREE))
 		return 0;	/* caller does not care about device status */
 
-	if (!is_loopdev(lc->device)) {
-		DBG(ITER, ul_debugobj(&lc->iter, "%s does not exist", lc->device));
-		return -errno;
-	}
-
-	DBG(ITER, ul_debugobj(&lc->iter, "%s exist", lc->device));
-
 	used = loopcxt_get_offset(lc, NULL) == 0;
 
 	if ((lc->iter.flags & LOOPITER_FL_USED) && used)
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 0ca910ae3347..b45cc2ee8f3c 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -653,7 +653,7 @@ static int create_loop(struct loopdev_cxt *lc,
 		}
 
 		/* errors */
-		errpre = hasdev && loopcxt_get_fd(lc) < 0 ?
+		errpre = hasdev && lc->fd < 0 ?
 				 loopcxt_get_device(lc) : file;
 		warn(_("%s: failed to set up loop device"), errpre);
 		break;
@@ -741,8 +741,7 @@ int main(int argc, char **argv)
 			break;
 		case 'c':
 			act = A_SET_CAPACITY;
-			if (!is_loopdev(optarg) ||
-			    loopcxt_set_device(&lc, optarg))
+			if (loopcxt_set_device(&lc, optarg))
 				err(EXIT_FAILURE, _("%s: failed to use device"),
 						optarg);
 			break;
@@ -754,8 +753,7 @@ int main(int argc, char **argv)
 			break;
 		case 'd':
 			act = A_DELETE;
-			if (!is_loopdev(optarg) ||
-			    loopcxt_set_device(&lc, optarg))
+			if (loopcxt_set_device(&lc, optarg))
 				err(EXIT_FAILURE, _("%s: failed to use device"),
 						optarg);
 			break;
@@ -883,8 +881,7 @@ int main(int argc, char **argv)
 		else
 			act = A_SHOW_ONE;
 
-		if (!is_loopdev(argv[optind]) ||
-		    loopcxt_set_device(&lc, argv[optind]))
+		if (loopcxt_set_device(&lc, argv[optind]))
 			err(EXIT_FAILURE, _("%s: failed to use device"),
 					argv[optind]);
 		optind++;
@@ -935,8 +932,7 @@ int main(int argc, char **argv)
 	case A_DELETE:
 		res = delete_loop(&lc);
 		while (optind < argc) {
-			if (!is_loopdev(argv[optind]) ||
-			    loopcxt_set_device(&lc, argv[optind]))
+			if (loopcxt_set_device(&lc, argv[optind]))
 				warn(_("%s: failed to use device"),
 						argv[optind]);
 			optind++;
-- 
2.39.3

