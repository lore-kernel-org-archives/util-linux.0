Return-Path: <SRS0=A4/z=63=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE8DC433DF
	for <util-linux@archiver.kernel.org>; Wed, 13 May 2020 22:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA742054F
	for <util-linux@archiver.kernel.org>; Wed, 13 May 2020 22:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="waoBIZWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgEMWUt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 13 May 2020 18:20:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59868 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgEMWUr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 13 May 2020 18:20:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DMHcee009900
        for <util-linux@vger.kernel.org>; Wed, 13 May 2020 22:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=ZuR179kvr+6IB/rmARiFjEs1XkwqZyPfM4guqxXVqv4=;
 b=waoBIZWsqL9EJQ7MzoLw7wbhyf92zGfkOKB5KqCDZ4cubS2WxrFtWUv8XeZse6GXZEZZ
 fVDozuRSsUoaUk2b7Vnvv8wIE+SGF2KHGMdULGmwWuL32mCTOzkVuWx1Ne4QWdM4j//n
 RnEprhyLQgXFO9XCeZ1s4JPX0qBKXIzCzOcFAbEpQJcFZyrkICCNumHtaQXF215Efc2h
 1vzMvzMVmPuaqR017WyTotVvvOjPHZPywQeKSHojwYJc5Q2DMCzfplppRwxUAX+BYkIK
 FaQboqCfnYlrJyx5zFD6bav7/xfXfc1kwbkUbXrRbt9ngI8W5ZkxhjMdW0EphMYJjTcf CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3100xwq30t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <util-linux@vger.kernel.org>; Wed, 13 May 2020 22:20:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DMIdic080946
        for <util-linux@vger.kernel.org>; Wed, 13 May 2020 22:20:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3100yt01p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Wed, 13 May 2020 22:20:45 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DMKi7m028031
        for <util-linux@vger.kernel.org>; Wed, 13 May 2020 22:20:44 GMT
Received: from rsrivast-us.us.oracle.com (/10.211.44.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 15:20:44 -0700
From:   Ritika Srivastava <ritika.srivastava@oracle.com>
To:     util-linux@vger.kernel.org
Cc:     ritika.srivastava@oracle.com
Subject: [PATCH 1/1] lsblk: Ignore hidden devices
Date:   Wed, 13 May 2020 15:06:10 -0700
Message-Id: <1589407570-25740-1-git-send-email-ritika.srivastava@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130190
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130190
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Lsblk throws the following error for nvmeNcXnY devices.

lsblk: nvme1c1n1: unknown device name

This is because nvmeNcXnY devices are hidden and do not have
the file /sys/block/<nvmeNcXnY>/dev.

Following patch was added
https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=d51f05bfecb299a830897106460bf395be440c0a
Which made lsblk read from /sys/block/<nvmeNcXnY>/device/dev
which do exist for nvmeNcXnY devices.

After the above patch, the unknown error goes away.
However, another error is encountered in the very next step.

nvme1c1n1: failed to initialize sysfs handler

This is because lsblk looks for /sys/dev/block/242:1
(nvmeNcXnY major:minor) pathname which usually exists for other
block devices but not for the nvmeNcXnY devices as they are hidden.

Below patch does not even print this error for hidden devices
and exits silently.

Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>
---
 include/sysfs.h    |  1 +
 lib/sysfs.c        | 27 +++++++++++++++++++++++++++
 misc-utils/lsblk.c |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/include/sysfs.h b/include/sysfs.h
index edda8ca..d92401f 100644
--- a/include/sysfs.h
+++ b/include/sysfs.h
@@ -95,6 +95,7 @@ int sysfs_devno_is_dm_private(dev_t devno, char **uuid);
 int sysfs_devno_is_wholedisk(dev_t devno);
 dev_t sysfs_devname_to_devno(const char *name);
 dev_t __sysfs_devname_to_devno(const char *prefix, const char *name, const char *parent);
+int sysfs_devname_is_hidden(const char *name);
 char *sysfs_devno_to_devpath(dev_t devno, char *buf, size_t bufsiz);
 char *sysfs_devno_to_devname(dev_t devno, char *buf, size_t bufsiz);
 int sysfs_devno_count_partitions(dev_t devno);
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 227a1e9..b18e13f 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -823,6 +823,33 @@ int sysfs_blkdev_scsi_path_contains(struct path_cxt *pc, const char *pattern)
 	return strstr(linkc, pattern) != NULL;
 }
 
+int sysfs_devname_is_hidden(const char *name)
+{
+	char buf[PATH_MAX];
+	int rc = 0, hidden = 0, len;
+	FILE *f;
+
+	if (strncmp("/dev/", name, 5) == 0)
+		return 0;
+	/*
+	 * Create path to /sys/block/<name>/hidden
+	 */
+	len = snprintf(buf, sizeof(buf),
+	_PATH_SYS_BLOCK "/%s/hidden", name);
+	if (len < 0 || (size_t) len + 1 > sizeof(buf))
+		return 0;
+
+	f = fopen(buf, "r" UL_CLOEXECSTR);
+	if (!f)
+		return 0;
+
+	rc = fscanf(f, "%d", &hidden);
+	
+	fclose(f);
+
+	return rc == 1 ? hidden : 0;
+}
+
 static dev_t read_devno(const char *path)
 {
 	FILE *f;
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 51b9f6a..a5ec431 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1177,6 +1177,10 @@ static int initialize_device(struct lsblk_device *dev,
 	}
 	DBG(DEV, ul_debugobj(dev, "%s: filename=%s", dev->name, dev->filename));
 
+	/* ignore hidden devices */
+	if (sysfs_devname_is_hidden(name))
+		return -1;
+
 	devno = __sysfs_devname_to_devno(lsblk->sysroot, dev->name, wholedisk ? wholedisk->name : NULL);
 	if (!devno) {
 		DBG(DEV, ul_debugobj(dev, "%s: unknown device name", dev->name));
-- 
1.8.3.1

