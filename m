Return-Path: <SRS0=h0j6=67=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19239C433DF
	for <util-linux@archiver.kernel.org>; Sun, 17 May 2020 15:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED95D206F4
	for <util-linux@archiver.kernel.org>; Sun, 17 May 2020 15:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEQPNe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 17 May 2020 11:13:34 -0400
Received: from mail-oln040092071085.outbound.protection.outlook.com ([40.92.71.85]:61906
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727973AbgEQPNd (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 17 May 2020 11:13:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4c89svqxzaUtPpNrOlHaypHrWXIAJV0BRY5EkUGFXNysh5snRDrZpiU4E8+JKDwXSr33sEYdsn0fpTVfrrfgB6M2XC77Ie4KxGEocOWU6eLlxKFUj5YRcKPkQoxbf/13Y3g6DjcLgcpuM5cOMMuMzrVksRXvOINMx/hypKozXn3Y49QjcDDyeY6Ra5K+ic6/H9uJwrJ6dA8Ccq/zA+oSyuRBRY6C7yaM+HWpGGlIdl+vdtGV9ZSTXUYCsgptbdqCsj47Xi8Sgq6gLHU8Dj1RZiusCb2MFFzcP+hsk7SMbirPSUzcFYC4KwXK5LmSwhIE2TOr9/T6htYtatvY6ijbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y6XxovUUIo4RIgEt2pFN/pQnl7jURhOnzaORA8lUJs=;
 b=JbaY51dAQ0I1gfF/1USnBkWmT3QZ2WwBmFqMEfw+76uEghczyrKMKtEjCrdpdCXFcNBgtwEa8ohAlLBoxtW3H6k4X8yHd2OUvHvkefvU6Pjx0YYiqh8R5/T6vayEsL/0xO8A/5DRCpljb69iIPk1XM1JUU27a4ErHw+NKVsXHt8ovxg0t5PATVP74uoyAEeRGoeLdhjmZMEhKO0um8uwoZP4hq2nYvzlEjysITqiZ9AU9ZhJyzXJ/RuEY0TyDS8SQ8NpRTmk6FcI5zChHRjdy4tlGwZ0pSAeX1YXHAl0pSmP2hrhZkideqc+Ujuc3MmafaZpBXTElHs9kFPpkH/Qrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.fr; dmarc=pass action=none header.from=live.fr; dkim=pass
 header.d=live.fr; arc=none
Received: from DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e0a::4a) by
 DB5EUR03HT088.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e0a::269)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Sun, 17 May
 2020 15:13:31 +0000
Received: from DBBPR08MB5548.eurprd08.prod.outlook.com
 (2a01:111:e400:7e0a::47) by DB5EUR03FT064.mail.protection.outlook.com
 (2a01:111:e400:7e0a::455) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Sun, 17 May 2020 15:13:31 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B495D9A4107ABDB8776CCD65BB8ACC1BA56B6C10080A5A7CED42E7F269466D7B;UpperCasedChecksum:9927D4C7EDA226C4F020D3D190E056A2A1359345AEAA7FB2FA4D2F7E9363321B;SizeAsReceived:8531;Count:46
Received: from DBBPR08MB5548.eurprd08.prod.outlook.com
 ([fe80::5d90:9dc6:7349:f9eb]) by DBBPR08MB5548.eurprd08.prod.outlook.com
 ([fe80::5d90:9dc6:7349:f9eb%6]) with mapi id 15.20.3000.022; Sun, 17 May 2020
 15:13:31 +0000
Message-ID: <DBBPR08MB55480F8E7F62EFE9323E29FA9BBB0@DBBPR08MB5548.eurprd08.prod.outlook.com>
Subject: [PATCH] Fix dead references to kernel documentation
From:   Yannick Le Pennec <yannick.lepennec@live.fr>
To:     util-linux@vger.kernel.org
Date:   Sun, 17 May 2020 23:13:22 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To DBBPR08MB5548.eurprd08.prod.outlook.com
 (2603:10a6:10:c1::22)
X-Microsoft-Original-Message-ID: <f6356e43b9b3250d356f08b70929e1cd5667e950.camel@live.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mogadeus (59.149.1.43) by HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.4 via Frontend Transport; Sun, 17 May 2020 15:13:30 +0000
X-Microsoft-Original-Message-ID: <f6356e43b9b3250d356f08b70929e1cd5667e950.camel@live.fr>
X-TMN:  [b76l7YpBkHIYtg0NV/kByHgsGn4LXjJu]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 5fd2d49e-77d7-4ea6-a23f-08d7fa74dc19
X-MS-TrafficTypeDiagnostic: DB5EUR03HT088:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfHhDq4DlsSUNDx3kuVpova1jFgVCpxE+roIsuBU4XNxvDZEabiRo6H7qQIAOJYr3dRmVMwiBOGAwrN+KNoXAYWuNaWUFR9r9cTm2qwSN42KqfT8t0STelMTt4AwS6funzqULRyW8qN7+pqY/pd4XkeoAuMJ2h1b3+gu1NZetrURmaTEB/v2vQP8fcdfAXAFvpuWZXVuKvkpOgbusesYu3bHXjZd+gaZhb51o8ezmMjfvi5/rbkc3eMqBCfTJYvL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB5548.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: daMzxMcxvWMENLxoa+mQ+CAPSq5iwqt+IadfMx2mGjWtDrumlO+2LXytq3G/OBuaa8Bw4zTtRSZKPMobUEOf+FLP6ej1ktyCewxc8cMwvNDSWximD10Mzw860slDsufQTLaAVa2tA6W4c4cNDq+XrQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd2d49e-77d7-4ea6-a23f-08d7fa74dc19
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2020 15:13:31.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT088
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Most date back to reorganisation of the Documentation/ tree in 2016,
new paths based on v5.7-rc5:

fdisk.8:   Documentation/{,admin-guide/}devices.txt
eject.c:   Documentation/{,userspace-api/}ioctl/cdrom.rst
mount.8:   Documentation/filesystems/adfs.{txt,rst}
rfkill.8:  Documentation/{rfkill.txt,driver-api/rfkill.rst}
tunelp.8:  Documentation/{parport.txt,admin-guide/parport.rst}
zramctl.8: Documentation/{blockdev/zram.txt,admin-guide/blockdev/zram.rst}

Signed-off-by: Yannick Le Pennec <yannick.lepennec@live.fr>
---
 disk-utils/fdisk.8  | 2 +-
 sys-utils/eject.c   | 2 +-
 sys-utils/mount.8   | 2 +-
 sys-utils/rfkill.8  | 2 +-
 sys-utils/tunelp.8  | 2 +-
 sys-utils/zramctl.8 | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index cc172a0a5..dcc587fed 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -161,7 +161,7 @@ The
 .I partition
 is a device name followed by a partition number.  For example, /dev/sda1 is the
 first partition on the first hard disk in the system.  See also Linux kernel
-documentation (the Documentation/devices.txt file).
+documentation (the Documentation/admin-guide/devices.txt file).

 .SH SIZES
 The "last sector" dialog accepts partition size specified by number of sectors
diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 2f3b200bf..651ecc7d8 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -330,7 +330,7 @@ static void auto_eject(const struct eject_control *ctl)
  * Stops CDROM from opening on manual eject button press.
  * This can be useful when you carry your laptop
  * in your bag while it's on and no CD inserted in it's drive.
- * Implemented as found in Documentation/ioctl/cdrom.txt
+ * Implemented as found in Documentation/userspace-api/ioctl/cdrom.rst
  */
 static void manual_eject(const struct eject_control *ctl)
 {
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 13a5f7167..7f5da2d2b 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1342,7 +1342,7 @@ Set the owner and group of the files in the filesystem (default: uid=gid=0).
 Set the permission mask for ADFS 'owner' permissions and 'other' permissions,
 respectively (default: 0700 and 0077, respectively).
 See also
-.IR /usr/src/linux/Documentation/filesystems/adfs.txt .
+.IR /usr/src/linux/Documentation/filesystems/adfs.rst .

 .SS "Mount options for affs"
 .TP
diff --git a/sys-utils/rfkill.8 b/sys-utils/rfkill.8
index 9eff913b8..eb640954f 100644
--- a/sys-utils/rfkill.8
+++ b/sys-utils/rfkill.8
@@ -110,7 +110,7 @@ for the Debian project (and may be used by others).
 .SH "SEE ALSO"
 .BR powertop (8),
 .BR systemd-rfkill (8),
-.UR https://\:git.\:kernel.\:org/\:pub/\:scm/\:linux/\:kernel/\:git/\:torvalds/\:linux.git/\:tree/\:Documentation/\:rfkill.txt
+.UR https://\:git.\:kernel.\:org/\:pub/\:scm/\:linux/\:kernel/\:git/\:torvalds/\:linux.git/\:tree/\:Documentation/\:driver-api/\:rfkill.rst
 Linux kernel documentation
 .UE
 .SH AVAILABILITY
diff --git a/sys-utils/tunelp.8 b/sys-utils/tunelp.8
index 5c927458f..7716ba7e1 100644
--- a/sys-utils/tunelp.8
+++ b/sys-utils/tunelp.8
@@ -34,7 +34,7 @@ irq is handled by the parport driver.  You can change the parport irq for
 example via
 .IR /proc/parport/*/irq .
 Read
-.I /usr/src/linux/Documentation/parport.txt
+.I /usr/src/linux/Documentation/admin-guide/parport.rst
 for more details on parport.
 .TP
 \fB\-t\fR, \fB\-\-time\fR \fImilliseconds\fR
diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
index c6ecdc3d5..12983f144 100644
--- a/sys-utils/zramctl.8
+++ b/sys-utils/zramctl.8
@@ -118,7 +118,7 @@ and use it as swap device.
 # zramctl --reset /dev/zram0
 .fi
 .SH SEE ALSO
-.UR http://git.\:kernel.\:org\:/cgit\:/linux\:/kernel\:/git\:/torvalds\:/linux.git\:/tree\:/Documentation\:/blockdev\:/zram.txt
+.UR http://git.\:kernel.\:org\:/cgit\:/linux\:/kernel\:/git\:/torvalds\:/linux.git\:/tree\:/Documentation\:/admin-guide\:/blockdev\:/zram.rst
 Linux kernel documentation
 .UE .
 .SH AUTHORS
--
2.20.1

