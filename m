Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7CFCDB482
	for <util-linux@archiver.kernel.org>; Thu, 12 Oct 2023 21:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbjJLVzh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 12 Oct 2023 17:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347424AbjJLVzg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 12 Oct 2023 17:55:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1D0E7
        for <util-linux@vger.kernel.org>; Thu, 12 Oct 2023 14:55:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLiW11014793
        for <util-linux@vger.kernel.org>; Thu, 12 Oct 2023 21:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=J3IDkMmb4Gdm5clNGorUSrVKkQ+ah6Ww7rBbe7Q8+X4=;
 b=LLKEcufkITK6Fbumu905vHCcKLWt3NvIeRB8d+FWtM88lAb1eOBZjeKA5HIHg32hc076
 eY/B0LMOFm4oN1mFu4wKPg13ou+IcDMY3v2GMJEVZhB+eYYgzeXA98XmPwqZqdmqAP6r
 3syjhDa2LmiUAIs2AO8/Rz/NOTi+YG7Ak4A16bjhA/11ihzAeqLzqYfnOkWhZQq/tsil
 gPU4+aPx7+Y8ReDAV2CGX4/35DEgDJafQMOHS1Q9375wzQcjkYfh3DxfG8Gdf9GVRMrA
 lDZ+Hid/7aBapTyl5qN+5NB9hUwq+hJzKpHcKgqXhQPlbz87hB+zn6ai3nCvNFrk1hf4 8Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxubvuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Thu, 12 Oct 2023 21:55:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLFEgx035866
        for <util-linux@vger.kernel.org>; Thu, 12 Oct 2023 21:55:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsapt5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Thu, 12 Oct 2023 21:55:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be4sw+24TEWZOMfnJKo1O7Xv0eFjCZ/OQpPqRHtSuPucrNWTmG83cH1GRRmbINbqf90jqgMyHhL+xsvnchxD5s4oIlzvXItQwFM5ED0/D9UE0lBaK/7VeQS3jETdzm+pLQ5inr7ON/p50fVHpd6CoK6UjOI7W0O0OKrF42qXu9ZTKFuDRjauSXlPynzza+7XAxh5ZFlinMBq+V+ZKlzazMA2YBKLYF4OxYoVmLlINOnmnWOotWTzYoBokGfW3qw+EAiroTQWKaVyntA6hwr8kJlR86NsZwbKNj1ju8HvuVliP6pwY1zurK4e6K7PyGFFKXo1r6y7WvLVqo6VR4/l9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3IDkMmb4Gdm5clNGorUSrVKkQ+ah6Ww7rBbe7Q8+X4=;
 b=iP1oSu3UIpgrhof2WrFsX/5DMWaHoJiNCHvXWHd0h2r+YgN8UkeYJJqnzYfoUN4JUVlMjv8uiGR06ETNCD+2jvJ9drHjT3PG0dHASUaHzc0/IgFW1Uv/VztCVGAhj9NfBLEcvpVAZFX0S95WRN0Ch9k/crg5msYUUUdWf2xqWlBstez3rcDrLog4biCvK2rQCuBW89WjDeSVjUkZYW0SfCb6NkzyijK1YK5EK/rd6C5H4b8eJYt84MenfWWxpme0FJmGwKHEzDhfCUaFx22JrZFQirqj0AOODUbJnTpFiTMl2+Gl0N29coeraQAJcVIu73DBlxNTIFrweSgoZ2wIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3IDkMmb4Gdm5clNGorUSrVKkQ+ah6Ww7rBbe7Q8+X4=;
 b=dDG6e4HAMT97tm/S0nWt1iKEbQ1aC31EQjJXaVRcqcGS887bYmwDe0I3jWD8pPi5B1LWpwOz5uW2oihM1nC1MgcNY0SCA4C6xp6D6m7mtDvFyKjzg4g1ny13ODAAZ9OqcyEcJOjIEzT+kvBz0k7hNkKZL60jd/586jfpzD1bbT0=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 21:55:27 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::55ee:5407:c7b3:669f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::55ee:5407:c7b3:669f%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 21:55:27 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     util-linux@vger.kernel.org
Cc:     junxiao.bi@oracle.com
Subject: [PATCH] loopdev: fix losetup failure with a lost device file
Date:   Thu, 12 Oct 2023 14:55:24 -0700
Message-Id: <20231012215524.44326-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::30) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|MW4PR10MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: e38aefe2-08e1-4882-b739-08dbcb6df1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8Lmz6y0jFrg17XbnS1oPYsitH1VM2TJd82AVzwHWE42cb4uUGZSOoYKp5P1o6m7E04/1PlWbnwPDBxurQxNZAJazo7sMuYf1vSEzAYojpWXP2uiy1pJWnt0Sgdeheq2OsQxX3nDXNrEKgQu2VbD+Lt1xgLTpo/eELkOEijUOJkj86PGSt2b4FjvdOFWog9hwrak/cXkTXgpUC8d9WAXQ8A2I2rCkDxFLluiOOd82AHamA4UqmeN4XZVV9z4E4qS18YVKpMtkrD6hjxY7uAyYLiDZdqZmvsS8xAAfBhVAJ3fcMJNiK9DYpCA1rmj7Yih7KsCkA3/Dapz2y4lsY2X5gWhSXjAgqhxklOYfFAvk22QQDV6VzjHDIeOOfuGpW6qVtWYgs+XH0ZG8Wta87OLV+YAyiiPdKNjbAQ8xmGseompN/flm/z6RUzPDVCJ07g84siBfnoFyp2PXE2VMQKWMWEE3KfmlIBWHyYmGCYIOa4eK5I8f1PQ9PzWzcOO8DzPe9l1QKAUWdRNMctIC6mKdgfWpDFgNPJBF5tjfXd2CjNBEKYJUSbiYCLBIl7tKW91CkdCHJQEn702ydkRBVZjSembjTdFTuV/4b7V9NlL7jttOMjo6yzkD6pE0w4TAU5n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6512007)(26005)(6506007)(83380400001)(1076003)(2616005)(107886003)(6666004)(8676002)(6486002)(478600001)(36756003)(4326008)(41300700001)(38100700002)(5660300002)(8936002)(44832011)(2906002)(66476007)(66556008)(86362001)(66946007)(6916009)(316002)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4CZIML0hn1l5n//nyjAyaHWAVXeob5M0kxg7eAqrv8SXebH5JK1C5Jm1nnhE?=
 =?us-ascii?Q?Z+A01OKjCu/uVTOHfQfMdypSAO/vbLwbY8PfFXQRLDhkxocA91Viy6zKXGii?=
 =?us-ascii?Q?k1xOZV9YiLejstM0ZQumwpXQAAGU6spS96lxKCUjnTXCaj+YIFV1cC1CXGPI?=
 =?us-ascii?Q?+5D6ZiyP/g9G58y2wnrNizoWdrKrtkyxPPM16WpmwWtjgBENV5lfOOfNKvqt?=
 =?us-ascii?Q?YUzwu3Hk+TF1ClZKPG9M6yeLADaWhbVT0JIFVtKK2bqVCZB7aVIPwwHNa3i3?=
 =?us-ascii?Q?KgewEQTu2IfsB8ib7CV5LkE9sM/P74fIG/cMqfbDbd7gKkPYR7LkpmehwfcG?=
 =?us-ascii?Q?hhoMMsGcYBpJ8H0DkbeXeFyrIPIitQ/sgN2ZbpxPmNzWu/UBmQFZwgw/4PeY?=
 =?us-ascii?Q?XT5o6lbKKG3fWGpzU/Ug0p2c/5kb0/xMsUDKtZk4vrq9zsd4B4kx+eJPkCgO?=
 =?us-ascii?Q?LMaf2ISMYIE0O3gP5LEpzZKmVwmSrXjvyFPRc8TMnKF/HV/1fWzyn81ge4r3?=
 =?us-ascii?Q?NWSbnktWNAnSubFR2L3K6/DnVSt5yxZR7zWXMr5n8Qbm2D79/ovRByao2ysa?=
 =?us-ascii?Q?q7hgV1RU/RVsd8bvqRUe9KdQAcD/fAFM8kHB52iKvsUM0IvF2oxFKsHq46fX?=
 =?us-ascii?Q?VwQoFKphspL/+oKJvPUC1OcwehnuVEOJdzsikghafoRXgEH6YWBIjgw/cPXK?=
 =?us-ascii?Q?aEOZ3x+65U9yE/UEmjWOUGwXOSAl8VsBiPcnhYM3TOIcPOyXXU/rnDsFcT3z?=
 =?us-ascii?Q?QIBXLcUGiqd/f8jAycpA4wTwRe4DwEd2OeLpZ90hS+oLpNuuLDKsVRmvmz8d?=
 =?us-ascii?Q?lv0sbu/o9HY/bgHoRCVy93W5o7L3lsYGoKo4qKxJiAOUASoH9zDbAy7ETiVW?=
 =?us-ascii?Q?PQ9e1/WXhJwWJcDgcTI4QUAKDxcbeA2sqtcm6hc+yhWAPWeJUsF57/3iq/wV?=
 =?us-ascii?Q?BB6k/AN6Bkne54xl5fAD/tq/1REZobqv3zTaZiwtKI0OcW828bjLGOqhNYv6?=
 =?us-ascii?Q?Ow5Ai40YiQ2iayBd4L3Oi6xfAmahAD//4LtUpZKuY1M3/ZKKukDgaE6UQHMc?=
 =?us-ascii?Q?1yWZqgfayO5xFfzVqyjHpLTlsLpuf9m/16GJ5Nj95mATSm3AqnA9cMMJrtk2?=
 =?us-ascii?Q?8e8YqMIW2VtcWcTLHsIkjhnrC+noZQanp0qI5yt78fXs/zkQ16T3awihsRh9?=
 =?us-ascii?Q?f95wp8nMhtjfo5kYRZ3jhNr4QMmYUAydDreZz+H683F5P+4rrml7e9GRUyHt?=
 =?us-ascii?Q?vhQqu/RndRt7QSlpe3vWTFH984fiCYUZSg5TXFnrcpJ0qHgehaOQatqPJJMf?=
 =?us-ascii?Q?V2fxOiTp1HP9F02UgdUu90dvl/js0OI7g669/YvjSCgz1oqiRSyiweLiy6m3?=
 =?us-ascii?Q?9Xd8Jcs7t9r1nbpnxlpgDuUn7HoOFcetD55waEm+fu9z2sYI+FQ5707QWKzs?=
 =?us-ascii?Q?RM9X8dnEwLEAmR5ah4zPWtmOLAGr0VKr7QsZFbiXhuZF/yZUBeJodvz+kcgV?=
 =?us-ascii?Q?vXWYBhpYRRSfMIGdJ1SRPuE4mIC7T4Ym4GlRlvspkfqZ0MUa9/HqjK4GF6s0?=
 =?us-ascii?Q?y72BBit4bEUV6duiRfm4mM+o+60PI4id27OnYCB+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vZCi0jOQmYZkSx+UMlxQYNvIVWtgIebdk5Oj/BlYNIA0Ldog6SVoEVx0+nFt1WACDLcjy7nvrpL3S9PgJpixF3XBFDqQRKt9L91DaHOxpETlIT6FPC2btzVDN0rYY/P/nvDM4Ns8zsBS4DZN0HWfy2cuTO9hGubzkMWqtC4twoDpUzqgGetAS286Pu5FMk9MEZkA32hzmDxoMSYPllbfLD25De9Jg5vpBMvJfrBGnv9YiIQIEu7hLlnPcO+JcxhTAZESFgNTY8BAAqlijFk++m/m4PHwwKbox6U3IKsmrAehXzREGo5VID/j5tAEHeyW4Al1VhQESBrtA+k5RHQZKZ9kAdkgqDfeNjTckxIsuWcb8pH87CbKk/5QU0bIZLyL/vkP9prlCBWRoJD8cmJjDXOLUN6RNu5YZvgXfGNEKCttLnrvNOE4/Zz7mhW1OsT5yYV+UaxFcCAayA8OB9vjmyJH1xUkqN8Pj1UA03UWlmQJADVGJ8aKUCvZ616fMyy1e8/O0WO4aeBjGeGBZxhtNu/bEEny0jpvWN8rRkcSgPnNsrnTphwTrZ/my5NdXkYKY6irv4hr1RS9MfD4EXv1VbLivDm6WSa9W383Pj/f2M6QFzWuwPvzo6AZP3we1TeF2jwJpSPmqH4Bj/g5fhXutyJXtzFYsBzUNBLVmM7K1aeTZO/FETGdJmT+Rc7yEVkLA8KY/dKNNZAKnZYDR2y6AXrx4Ap6b0k89zHXWURljRBDW4DMQWox10zrQETwmhTLwYG3pt2qsLg8MtHxpBoFWg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38aefe2-08e1-4882-b739-08dbcb6df1c3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:55:27.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC1B4HV6g0q8HE8i4zSbK4paV6gSmAv7nRiATY1hfJDm92vlM3DZ/IxK6tOKifgFo5oO4WipuvQ9GIh9m/dG0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120184
X-Proofpoint-GUID: St7WCQ86RB_KZXgb7D8S1xOalOA3HeCR
X-Proofpoint-ORIG-GUID: St7WCQ86RB_KZXgb7D8S1xOalOA3HeCR
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

