Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AFCCDB474
	for <util-linux@archiver.kernel.org>; Thu, 12 Oct 2023 21:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbjJLVzA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 12 Oct 2023 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344165AbjJLVy7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 12 Oct 2023 17:54:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375CCBB
        for <util-linux@vger.kernel.org>; Thu, 12 Oct 2023 14:54:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLim2b014911
        for <util-linux@vger.kernel.org>; Thu, 12 Oct 2023 21:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=J3IDkMmb4Gdm5clNGorUSrVKkQ+ah6Ww7rBbe7Q8+X4=;
 b=oe2TgSGlGZiJ5+7NFyIYv9JmW2JFFZ1x4j3pMmOom17iGNYZlbevlNt+JozoLB5D5jH9
 PFMGTiLUykPamObKMAQyaweMnpJRDzzl746hlF4pWfj9116Crii6BCwgpnQn2ll+obDL
 LKNpqPyvlvZnDgCCOa+4n2X2wI6ZxW5O7BlxT0Y7EyIy4+d1xzvmxOXq+UbdOswWeWrf
 xC24xHXfmv3mDUT0xTog4d6G41xGtmhtHznvQEmw1LupT8LWRjW6HVcQPpISwqqPm5K5
 Y8aT/JA83Fbz5AZpzuxTqE5XnSdaKiPzyR2AhprNcaEmbo0CF1fiwL9fPpYvz2zj6oHY 8g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxubvtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Thu, 12 Oct 2023 21:54:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CJqrbS020238
        for <util-linux@vger.kernel.org>; Thu, 12 Oct 2023 21:54:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsb14af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Thu, 12 Oct 2023 21:54:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/g3fdzHYqv5BIngTLPoUuEUcflTh7JwpVTQEXfQY7GSIgJldrxWoMW6+4K2RjzSekSngjMfVNeH77PKyfHUnJdlrNvm9Ulcp57EUi0oHGdCbU+fVVBsaJAazdovcny0+VUo7IBeCHR879RVwvINN+DUvn30z5sUkahBTCZvm2laU8yPC/NgvQQBIoGywuirLWCH07LpXj45tlRpEJwGx1a3Jg/O9Wzrg19K3VL2KOxOvHXjT+fNS5K6Dea9XbGF1urjT+bn2cPvlxr+kUOc6DWW6opyKG8PR1iKULKuRzXT3XzhFS8/qYF+b+Yg+oYoo9yJMZgeikKF2wqExatJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3IDkMmb4Gdm5clNGorUSrVKkQ+ah6Ww7rBbe7Q8+X4=;
 b=ePMkGojHifoiwZCywLlQcwRYhoMaER00Iz5P4/AvXg9zQ86GZhGywAdlrfrNIGLL4DemcxgAxn1J9w0Q8pGUW+a37w5Y33g8QUa2xoL8bpJqKuRlsOTM1NdKqV2QkhD28Oi5Sr8kvB7MPwd9goSsQMsSZSi79IFOlBvpFff7wd3ULJSdlxKJYakxoXbFWfOHOEciSVcVXdq4d5z7NC1a0mBdXAloqzGIphCAnSl9YqM0dxW28x9B6gF1Mz/y0jJzHJUwrAxgEQ0XbaY84Gh81KjwjYtaPAi6Q3AIHovNNoxmMF8C3bN3k7aDawkgKgC6k9i/al6qUBYy4eZyVzKCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3IDkMmb4Gdm5clNGorUSrVKkQ+ah6Ww7rBbe7Q8+X4=;
 b=xtSzswr4WUGPrleDT4nnDF6GyFdqXwOicHpAoQkxoS1eUpJeByhGqQQDcBxUe8wQfIF9V2d25uubR6cQ7bsTPYlNTZiTbHblbwUDbReIh44lcygoldY1NUrbyVW00MNmu3pAHcqXMjW+4RWqrHCQkZlauZSEHNR2/A8iLRTeOkg=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 21:54:52 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::55ee:5407:c7b3:669f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::55ee:5407:c7b3:669f%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 21:54:52 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] loopdev: fix losetup failure with a lost device file
Date:   Thu, 12 Oct 2023 14:54:49 -0700
Message-Id: <20231012215449.44312-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:510:5::27) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|MW4PR10MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ca4f41-7ce0-4f9a-9db8-08dbcb6ddcf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2+LIIYAAGUKdXkIvrgvUAWK2GSjEIklkeQbCNs06uau7cEC+xdin5q3PdrUxHRnHJG8YAE1mqlU5Ic4Hfk885UsXEAkqBvpfnTvBTHkUbQfLQxbOqJ/CW3Mc5BRBRyV9rs/3XLyg0C5/BJNQ1eUonjCVk6DOywhxla7ebtKB6g18C9NviO1a864WUOmpgYYUCu7Ee5cnj5cGqXKmZ7Bcs17WxpNLRmAMm//CFvdHB7rdLifkkd0W6rvcN96wyPIlfOpD4sLjTy3aNi8YFv+1qijg7jBsU404pQLTdwL2zl5JgFKIM4DKbP3LzAB0PekPGnDkjBim4KESXC+9uQx7Oq07kWe/OLBZ0plWVQWC3Dx05uLk4CLZID0C4lC0lW4ssrbv8GjzQulH3dEKNcMWh8Fkg5LqkYK7Vo5000G8Oqg1bEDh2gc3kNQkOHNMMwtV1Tb9dmZxSkT3vKxplPDRjKAyNBc9LMZUWDxaAkMZjcWadFd+WiA+guM5Jc07sjVqkokqzfU4L7H6bqGrQYRn29znxwLPhuq6KaUjSS5ewWKkAOlsK9CCo9T0M9cbMo+fRJ1Ndr6fSdODH0ziTngbr/ddgQtTpy0WUH1JbcgjWa9NsuzfMBX37YzAtrXTmZc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6512007)(26005)(6506007)(83380400001)(1076003)(2616005)(6666004)(8676002)(6486002)(478600001)(36756003)(41300700001)(38100700002)(5660300002)(8936002)(44832011)(2906002)(66476007)(66556008)(86362001)(66946007)(6916009)(316002)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b3GXvKE+p6Mzr5jbSeMd38iG5Vd3oetk6dgg7VwFqd3Jg7RknkaCKBsBIhV/?=
 =?us-ascii?Q?OO7uJYSpjArFLNH4BH/UU8olOCzMYUKAloMTscL8ZEi1xVqgwiGueA256gJs?=
 =?us-ascii?Q?Wuw1lEmFJ/mBN5teOGUPZcXl4OQpKryC4PntMFhJbDYPbikwKUTvxfneFDXa?=
 =?us-ascii?Q?BwQzMEVr9ziKn7WjM84CRwujbl8LMMdJkhjKwiO4PkksKMV41d9HUXRQchvL?=
 =?us-ascii?Q?zCZiNuDV9VJSCoEZHITIJ3Q0sKVJmF9UU5wK0YwBItJJ2lGL5Roq+12OhxJF?=
 =?us-ascii?Q?7BOCL7oV64aqlYrCcjmPAJc+Ie9kP6oD1lVSIKxovJxdB+Xy8MedyP2hRmbp?=
 =?us-ascii?Q?h8+xfDXj1wJjiTFl/h1A11/J1kN2lbNH2KmFDZy0fHhadFrFIjD4jQ4ejuYc?=
 =?us-ascii?Q?4+iymaMZtCOB9vO/69XDR7mNRexRPM2JDSh6K43w57vInl9l7py63kLTWcEm?=
 =?us-ascii?Q?YMV8AAQyVYSk18lBlaq0f4eNCJHqqke+wg00qZiOYLnAl0lNsmUwyk0oN3h1?=
 =?us-ascii?Q?8jzWYrzA61eUflXODUiXXMezJ5sEtcEmmQh5WnC0kJEdzpRN4eHw1BUsDViE?=
 =?us-ascii?Q?nguu6ga0WfxlJGYZzmxW/xYQzmTVRFIeIh611EacQ+0HYQgn5rc43RWE+hU2?=
 =?us-ascii?Q?JAOjzkxHxsnUxFktrFx53yu7PIWTeRKV2k1+h1iKPSiIW8/c2LrZc1EznI3g?=
 =?us-ascii?Q?qkgVNuzR8b3Jk/9+fgOOLBB4qJVGiEflYtSld6aNMUECFX9zK5SbE+R31YPd?=
 =?us-ascii?Q?NG8HnVRO1MxHk5E43cUn2PfcleXNrNCElQVgZLWyRus1hL4ptoQkS551bwbS?=
 =?us-ascii?Q?ODvz5Ksm/thV9dnhtHVwU3bwdLb+MC0Kn3hedEuB3ruJ7Hi4HQD0ubMPCNRx?=
 =?us-ascii?Q?HYNIIyKRY8AY7YqQyrOKvumvVMYZa2K28wjWdpNjKaTYFUzEb/Ry2n/A9/AP?=
 =?us-ascii?Q?DarFhxPZUz+d5ixQnmzzgZIVGU1PpKVB5SawyNMr0Jvh3re5f/fmySCG2KLP?=
 =?us-ascii?Q?adz1j08XHH5Vk5wL5qMe7P3NZ5Gjzy3iu3fqZ3WnI/HOpcmonlW7zMPtguiN?=
 =?us-ascii?Q?ALJBoS33qc/CztHzd1uqMpENQjWpM4SYjLrIwf8Q0oWKJNENtokxxik9/Px6?=
 =?us-ascii?Q?JmrZQR1H+TbBDnRZdxry9YyzoRpmZkBGgacCB1aqUnFgPfkQQNsRLPgpO8d/?=
 =?us-ascii?Q?6IAi/xHAriS0vrzBZ9xhgTikkBVnKASDTta572fV7ez+tEiB/er8cr1jHIrZ?=
 =?us-ascii?Q?Ry7BC0WyTZP272U8ErQ4EuGB1aU3JpgwFcjvTjdDFbgsQnEOx7WhJDBgVxPV?=
 =?us-ascii?Q?zbBxrhrxhzm5TBdohYy+Vl/J5lmUjeDYWeRTHfjmXxiWos8nRZl8NtevoeLw?=
 =?us-ascii?Q?svBw38NpxgTkctJ3viK/ld93JAoNBD/9CtpwgPzfIcNryUS1L93juwbnLQt5?=
 =?us-ascii?Q?Ks4udAOVuY9MuofszlTtAjEN/ql49kaMHsBEOlpUhxHL2cv8BbMsvOWA26QR?=
 =?us-ascii?Q?mkAXYSqgaFWKUsdafUqTM/EMhxtP6WbL/kU337vH+5S417+Sq+vpbLe329kL?=
 =?us-ascii?Q?R0cl2L7sh7ukxAeM2r3Gv+PYwjZTKA3fqZDYAQaV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JGFunwEfvGH3VbiwbhCbtTvMlWG7vNvWzDQW3+7nw2Q4OEN1T2PHgJX1jhIWW0HnW6dM3a9Rf7nhixqTshQqO33peaPEbTccHv5w/zmaVjsJ1X2zV0suqk0/3tpvNMV1hNkgrdglZpDaPXtSipoHkhhn6oXJE0Bde8sc2Ph4yOQ7EYuiQG6MNfxHOnNnS9QNiXgdKB2fB+DX2z8mPaBMDduB1P0VQMZpsZ5XrmI6LPv6NIgOa0TbChY6D9Cu9dmIw9UzDaCVMW4stD6/rEsyPOsF87pO5w6mLdvwflO/dcGiV7j68hfQnfWEiSvtGb2eOd2bvGd2aD3UHhc0PavJNBmXItAiqy1DPBr9PtwFwwnqO32CGq/TPHrOeMtYMFb07tIO6NIUAC+sfnSKdEcZx5UbrN9oTCKqMy2gFEI1wCyr8s2ozOeCKcDzKpk8wopc0DzXfaL5xMa1Guop7o+Dl75VeZtsMR5wuNuzxAMjRJyOlaC66BWnc0oHtZUqEuUKX22IqMUyTDkubcFSFn8jtkegJuHhUEwIOSDRex0xv+tCuCx11W9YUvHCpUhOb7kcu/6uKvG6F842D6+DIcL2mEktLTvjiUonf99R0AZLcwf1vc9IV5YQa+4e7+LGCuSPUzSKp+raUKtRqzGGlM0LyC9xOyHDJ46IvA/U1zZkhl63+Y22MOMpF+6TroCXThbFhBawhS81VdraOpAcgeWaxGOXHgwUXx5DzMPuFXy8YpG+Ek5FQrUpr4j6JrCHRrCWBdMudUHuzj2KBRYtzt7L0w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ca4f41-7ce0-4f9a-9db8-08dbcb6ddcf2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:54:52.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3KxGf6AZCnd4DK7ocQn/RBNEtx0uVpsrpUIgYhEvB8YXiIGwLEwo8ag4l2nuY1tCdbCzKCxkoVaGhnha2UxsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120184
X-Proofpoint-GUID: jUIrzwdjiBQHp3REdc98gfbNAzw2ic75
X-Proofpoint-ORIG-GUID: jUIrzwdjiBQHp3REdc98gfbNAzw2ic75
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If a /dev/loopX is lost because someone might have removed it by mistake,
future losetup operations on that loop device will fail.
For examples, following cmds will fail when loop device file is lost.
- "losetup -d $loop_device"
- "losetup -f $file" or "mount $file $dev"

Users can resurrect the loop device by recreating the device using mknod,
but regular users might not be aware. Since /sysfs still have the loop
device intact, this commit will detect that case by scanning sysfs and
recreate the lost device file.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 lib/loopdev.c       | 100 ++++++++++++++++++++++++++++++++++++++++----
 sys-utils/losetup.c |  14 +++----
 2 files changed, 97 insertions(+), 17 deletions(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index dae499f256fa..4fc617830bae 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -279,6 +279,87 @@ static struct path_cxt *loopcxt_get_sysfs(struct loopdev_cxt *lc)
 	return lc->sysfs;
 }
 
+static int loopcxt_get_devid(struct loopdev_cxt *lc)
+{
+	int devid = -1;
+	const char *p, *dev = loopcxt_get_device(lc);
+
+	if (!dev)
+		return -EINVAL;
+
+	p = strrchr(dev, '/');
+	if (!p || (sscanf(p, "/loop%d", &devid) != 1
+				&& sscanf(p, "/%d", &devid) != 1))
+		return -EINVAL;
+
+	return devid;
+}
+
+/* scan sysfs entry for loop device. */
+static int loopcxt_scan_sysfs(struct loopdev_cxt *lc)
+{
+	struct dirent *d;
+	DIR *sysblock;
+	int nr;
+	char name[256];
+
+	if (!loopcxt_sysfs_available(lc))
+		return 0;
+
+	sysblock = opendir(_PATH_SYS_BLOCK);
+	if (!sysblock)
+		return 0;
+
+	nr = loopcxt_get_devid(lc);
+	sprintf(name, "loop%d", nr);
+
+	while ((d = readdir(sysblock))) {
+		if (!strcmp(d->d_name, name))
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * losetup cmds could fail if /dev/loopX is removed by mistake.
+ * This function will try to detect whether that is case,
+ * if so, it will recreate the device file and open it.
+ * Return fd if succeed, otherwise negative error code.
+ */
+static int loopcxt_fix_lost_device_file(struct loopdev_cxt *lc)
+{
+	char path[PATH_MAX];
+	int nr, ret;
+	FILE *fp;
+	unsigned int major, minor;
+
+	if (!loopcxt_scan_sysfs(lc))
+		return -1;
+
+	nr = loopcxt_get_devid(lc);
+	if (nr < 0)
+		return -1;
+	ret = snprintf(path, PATH_MAX, "%s/loop%d/dev",
+			_PATH_SYS_BLOCK, nr);
+	if (ret <= 0 || ret >= PATH_MAX)
+		return -1;
+	fp = fopen(path, "r");
+	if (!fp)
+		return -1;
+	ret = fscanf(fp, "%d:%d", &major, &minor);
+	fclose(fp);
+	if (ret != 2)
+		return -1;
+	sprintf(path, "/dev/loop%d", nr);
+	/* default loop device permission is "brw-rw----" */
+	umask(0003);
+	ret = mknod(path, S_IFBLK|0660, makedev(major, minor));
+	if (ret)
+		return -1;
+	return open(path, lc->mode | O_CLOEXEC);
+}
+
 static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
 {
 	int old = -1;
@@ -303,7 +384,17 @@ static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
 		DBG(CXT, ul_debugobj(lc, "open %s [%s]: %m", lc->device,
 				mode == O_RDONLY ? "ro" :
 			        mode == O_RDWR ? "rw" : "??"));
-
+		/* loop device file not exist. */
+		if (lc->fd < 0 && errno == ENOENT) {
+			lc->fd = loopcxt_fix_lost_device_file(lc);
+			DBG(CXT, ul_debugobj(lc, "recreate %s fd %d",
+						lc->device, lc->fd));
+			/* loop file is not lost but doesn't exist,
+			 * reset errno to have user know.
+			 */
+			if (lc->fd < 0)
+				errno = ENOENT;
+		}
 		if (lc->fd < 0 && old >= 0) {
 			/* restore original on error */
 			lc->fd = old;
@@ -416,13 +507,6 @@ static int loopiter_set_device(struct loopdev_cxt *lc, const char *device)
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
2.39.3 (Apple Git-145)

