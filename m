Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96557C433FE
	for <util-linux@archiver.kernel.org>; Thu,  9 Dec 2021 14:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhLIOQ1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Dec 2021 09:16:27 -0500
Received: from mail-am6eur05on2114.outbound.protection.outlook.com ([40.107.22.114]:42369
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231946AbhLIOQ0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 9 Dec 2021 09:16:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnzOZwK/bTvU3db5bVchPs9VqGujXsKkUIE/T05Y/J3cjxJVXYSY8vE0Kf9Szw4sM4Nlezr0Y913Ffv6I3Rhiq+G6DtYkknBUy0gu6FMAmnP46Y27mv5hhDg7HOOHTBHs6s1fJ2fj8H3vJ05LngU5TdLJna0D8NVnMBKaRYmImHTJxaxlmjG7RoaOeXO6Z8MOZkMXh9Fi5N1cQEFwYj/HhC0xlh4/sYCoo08Z29GNMBaiiuPmCZyP5SuDxeXdaJZY3j/TXM8goU35r13oz6/cpVZm9E3eXNc31MDoXQeUQGgFZuD/0J76NHG1ytlXeZ9Lx3x+E3WG0uVl9qTld7EPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCBtpBlJnU+rWs8g51Wq1COHhAvzprbO9irB2Hy1POQ=;
 b=k8aUQbTINGX0AhRJiKCMK4EmgliL1GgdyvDaoI8zdHC3rCgxxe/DXpx5hUUX7VMgPE9GX3qIRpXIXajovraNe2MxI2im8I/e78nBY/6bKKarsHyhqdi//J0WxhY+MgUDEvRjsQ4e1LISHnIhLBxHJo0guvTUZ+TG1HQ0Geptoxgnyy6n612fvqakvdpXeWyCdZjOH1LoI/1//QNXmDZfOp77MtP1jyrjCRkWln8jydC4Us9Aa9invPinz8DeHplxiqK+KpHDxsCFGIdwssGahHun4eUkz5jw1cZS4gib6TCSOFZFryaE25jEE6Fo/04D2ztVxm9M+AiajWVNElmyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCBtpBlJnU+rWs8g51Wq1COHhAvzprbO9irB2Hy1POQ=;
 b=jay+7s2jSk/OoX9OfjkvoQCMolJ7Ca47nqyqKp+t5T2HhpYxNdlyMgXMzG053SttFCTz5lfzLPfqO7XA0Vtzc6x0TX6+PAAloZA4lg5n4GwtEb7c4NR+/DvLitTHj5K+5I03W3UYg1Q31IvY8XpiQumXUe4ThlaNnJot8FBgm1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com (2603:10a6:20b:304::18)
 by AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 14:12:52 +0000
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a]) by AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a%7]) with mapi id 15.20.4669.024; Thu, 9 Dec 2021
 14:12:52 +0000
From:   Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To:     util-linux@vger.kernel.org
Cc:     jkosina@suse.cz, kzak@redhat.com, kurt@garloff.de,
        vsementsov@virtuozzo.com, den@openvz.org, msuchanek@suse.de,
        efremov@linux.com
Subject: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Date:   Thu,  9 Dec 2021 15:12:33 +0100
Message-Id: <20211209141233.3774937-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0014.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::27) To AM9PR08MB6737.eurprd08.prod.outlook.com
 (2603:10a6:20b:304::18)
MIME-Version: 1.0
Received: from kvm.ch-qa.sw.ru (130.117.225.5) by AM6PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:20b:92::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 14:12:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3128f427-e784-4aaa-c107-08d9bb1dfc98
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB60346B4EA227D658040450D9C1709@AM9PR08MB6034.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CxR8fZAmsrCBL7zEwcCcZIVJMFFwFSS3tQA2o7eIkqCUw3zDbbOEc+/cvX7NF8oIplbu2OCaQhYYjJO1x+4rlD2E32EMqU78StIjJrr/z6PWbZI1ybXhDKGsD+v5BnNDgmry8Y2T56k4sJakyMVK7xCESkebaT5dz//Xf5B7sQ7lCog259M1wSuj3/MSbIgHNIUkzVRSOMkW4kI3zhQj9OwM07nXf3eF0/QI4d+Tmay7IoJUjo2yevWh6ZIEX24hem7YHB4u96wgrCciRuw2bQnwF5YyQ6hjX7RUXDklq0ktSA8YD6DsZaOyV8bhYZ/u/wKjqXOThH+/0DRFTbmE3Ou/CylQa/LUSlLbP2WSOLlyWMaFTnv8gSUXFu6jdNxFwQmXp7/1O/yZM+sxLAODvEP4mgq7IoR6/tyfV97d3OaY8lnV83PhnikFapf03NvWsEcCTOzD8PAw4Va5eqivvme5i3/X11Ne4m2G5zarDL24AnPON2hCOMHP6LPZn9SHNdKlssdkdrWPn+d6jxaP0ssO2fxme2Gcumoyq7a1Nf28tlOhPdklJ0bv71VRbKZURNatMwZ9nQtoErEBwNvGvHveuNlyjz2PpKGAAoMKgexqaOeWeTahmQbEDSmIPB3tKJsePOt7QzaG0EDYHVKAeP2wl7nGOm6CUaVTtD2zI27kg2O4DLqptKAPseCR5Vx5T2GvDCiPGgtFAgNCpof3X1GFiqdTc5s0zvw356zjmchJKcRvu9Xx2sx2rPkk7dllYiGRNwuPXLV/7tFgCQMeBf3Qd/TdfMbp+EycajlP+lY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(66556008)(8676002)(26005)(6512007)(6486002)(966005)(508600001)(8936002)(38100700002)(5660300002)(6916009)(52116002)(38350700002)(36756003)(956004)(4326008)(2906002)(2616005)(6666004)(86362001)(186003)(6506007)(1076003)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sbHTK+YsymZg60uZ6ibM7mzBDSahLARs7jB2IZU4x12+yiV6INn3uWqxLYtH?=
 =?us-ascii?Q?0UiHhEM/wCUhdbM+Q17M/YgMFvxhBS8pp2Tywks+oqGoFCfVBWpvHuIAk0iS?=
 =?us-ascii?Q?Ea6G8M/cGAX0PqDWOxZhcI4cmmNXhHBzDdhYFVnU9VKdowJJBrFHD88NtS6V?=
 =?us-ascii?Q?Vn6MoenAJhQm1Hy/ZPM9GdwmPGqTQ47J0ESoGB1C65RV/NQWJFwDj3uGIM9Q?=
 =?us-ascii?Q?yIsQzGa5T0u8JN31HI7HYTfBZWzwYuGmIKn0XzruzEfm3K4vXymEWuJtq7Zf?=
 =?us-ascii?Q?67o1Bt/HS9DRyz2clDJA0pbHJeWP3uMoZfAEoB9gBVr+YtBOhiv7R4BDYhSX?=
 =?us-ascii?Q?dMKPnpPSUS+zIJMy3dYB833c8LI2NUoJeAdsk/D0hJw4lzFYSahxgg2EnXO6?=
 =?us-ascii?Q?syJt3MeFjM6juljVNRWyGzDLKmB5i95QM+Dau1RO7tcWHVpvs/1L/dLPzMi9?=
 =?us-ascii?Q?o5zuSb/Ywyn/C5qy82XTg/XCI4b5Kuu6DXA6sUCkyvAeYQeAM5xkD/U0S+ce?=
 =?us-ascii?Q?kEVJuGwPh4Iy/x5dRzXpM+nLFo2VuwmPst8TV9rLKYyzWe2Dr0iJXTkw+eMa?=
 =?us-ascii?Q?Ep9/ZtWo7LbWX4MQPxINFtb0yAqJgv6nENOzW2HUxXZs7GRC8Elcu9rvLNB9?=
 =?us-ascii?Q?gAwWyfNGYiMMJqDEA88izNUQtzKTreTfMtR3q78iq4tx8hnSCeCllunRRbUL?=
 =?us-ascii?Q?UJyDmShWM2oY1RlLvX3Dji3sFGz5QebKb7WlO0WEZXQp/PTigtDa5NhH+4ZP?=
 =?us-ascii?Q?39Hj1mu2RVA6rdoJJFtuRPx9ROuC9VY+GV2x1G+lAR/gKDN6tGaP/ecXjs1T?=
 =?us-ascii?Q?ZLDKPa8m/esUkUt49fLrXwaLwM8hK2inPdc6r03JQhboI5n3t/JRZFiYjHfF?=
 =?us-ascii?Q?J1uRKKbT5enNcnUiherlSNUHpQyzsbjTEGqIUvL58/bjCeoE/vUteMVm2nCy?=
 =?us-ascii?Q?h2gd7wkmmZwp5g4UtGT4qO8yxri20yYJSVoyj0Hve9ejaw9eSYqDX93EO0s8?=
 =?us-ascii?Q?qYGPlUMto1Dm4vsCGiOHPO4wX+n5M5IoJpSoKraVy33LQTjieOeZqrUktOAZ?=
 =?us-ascii?Q?N0pB6Jj8hLAKCKYfEvwyl4MGFCCbvMHCEpv2ltg5BgHyxFpt7yYaTUb9DWAI?=
 =?us-ascii?Q?pxlnvoVxEGAdo97ggaC5KSl8kykykxic6AzUQn3rjabv9XNL9pyjrQ7ObUjZ?=
 =?us-ascii?Q?mGqNDjxRUgjANh2cZVemzsW5lUe8V8b7BXhzJl0NJlklViCFRnXm1Q936ycN?=
 =?us-ascii?Q?Q4n3KClnYv+EgmbS2rHvi8d1+rJ/ch+UJO1aX7Vm/UjQO43Tq8FGoKghCr4f?=
 =?us-ascii?Q?mYBZF46CCPHefP+dae3KlqdTUz1T/8jhSQFwJ3/IiGwbTfjWMz8mgu0Q3ngE?=
 =?us-ascii?Q?xTssyhVJjHgOKGLugKsrw5QlS3aIDPy1TjCmupxjiiBQYx/FryZ7eq1+Ys4x?=
 =?us-ascii?Q?hdpmotwU2v7BYszrRZbLYY5PQUfBi1CqmgHuoRN8SIDZtzHKBNZOTwzPn/WI?=
 =?us-ascii?Q?vl0PG7b6S4z9VJ902jMWNnF9FPtwXHieJff64jovcj68JZvrqsIa4PiBVP1o?=
 =?us-ascii?Q?/taMQKWPCU42VE50V0zrUN2aY5sfKhABv7cCWKoylY6+Wlcn46tyT79HhgnJ?=
 =?us-ascii?Q?hB3f2hArgokbUDuZb8YZSrXkKkCV4fidCRGj2z41252SWIWKHJbIV+//yTeW?=
 =?us-ascii?Q?jqbZOQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3128f427-e784-4aaa-c107-08d9bb1dfc98
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6737.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 14:12:51.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGYC9LiU9N+bidemhJFla7HvSqU7ufWEwiyNRbzA2lKD6hdVvwaNu3ngCfP7jOKHq43YgT5VdNeN25ixGc4fHSrkmJoIJcO6h0CvfSwObpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6034
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Since c7e9d0020361f4308a70cdfd6d5335e273eb8717
"Revert "floppy: reintroduce O_NDELAY fix"" commit in linux kernel,
floppy drive works bad when opened with O_NONBLOCK: first read may
fail. This cause probing fail and leave error messages in dmesg. So, if
we detect that openedfd is floppy, reopen it without O_NONBLOCK flag.

Reproduce is simple:
1. start the linux system (kernel should include the mentioned commit)
   in QEMU virtual machine with floppy device and with floppy disk
   inserted.
2. If floppy module is not inserted, modprobe it.
3. Try "blkid /dev/fd9": it will show nothing, errors will appear in
   dmesg
4. Try "mount /dev/fd0 /mnt": it may succeed (as mount not only probing
   but also try filesystems one by one, if you have vfat in
   /etc/filesytems or in /proc/filesystems, mount will succeed), but
   errors about failed read still appear in dmesg, as probing was done.

Mentioned errors in dmesg looks like this:
 floppy0: disk absent or changed during operation
 blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
 floppy0: disk absent or changed during operation
 blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
 Buffer I/O error on dev fd0, logical block 0, async page read

Note also, that these errors also appear in early dmesg messages, if
probing is done on system startup. For example, it happens when
cloud-init package is installed.

Note2: O_NONBLOCK flag for probing is used since
39f5af25982d8b0244000e92a9d0e0e6557d0e17
"libblkid: open device in nonblock mode", which was done to fix the
issue with cdrom: if tray is open and we call open() without O_NONBLOCK
the tray may be automatically closed, which is not what we want in
blkid.

Good discussion on this bug is here:
https://bugzilla.suse.com/show_bug.cgi?id=1181018

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Note, that this commit is done as a "minimal change", i.e. I only try to
rollback O_NONBLOCK for floppy. The other way is to detect CDROM
instead, and reopen with original flags for everything except CDROM.

I also tried fcntl instead of close/open, and that didn't help.

 libblkid/src/probe.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 70e3dc0eb..68a644597 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -94,6 +94,9 @@
 #ifdef HAVE_LINUX_CDROM_H
 #include <linux/cdrom.h>
 #endif
+#ifdef HAVE_LINUX_FD_H
+#include <linux/fd.h>
+#endif
 #ifdef HAVE_LINUX_BLKZONED_H
 #include <linux/blkzoned.h>
 #endif
@@ -200,10 +203,32 @@ blkid_probe blkid_clone_probe(blkid_probe parent)
  * We add O_NONBLOCK flag to the mode, as opening CDROM without this flag may
  * load to closing the rom (if it's open), which is bad thing in context of
  * blkid: we don't want to change the actual device state.
+ *
+ * Still, since c7e9d0020361f4308a70cdfd6d5335e273eb8717
+ * "Revert "floppy: reintroduce O_NDELAY fix"" commit in linux kernel, floppy
+ * drive works bad when opened with O_NONBLOCK: first read may fail. This cause
+ * probing fail and leave error messages in dmesg. So, if we detect that opened
+ * fd is floppy, reopen it without O_NONBLOCK flag.
  */
 int blkid_safe_open(const char *filename, int mode)
 {
-	return open(filename, mode | O_NONBLOCK);
+	int fd = open(filename, mode | O_NONBLOCK);
+	if (fd < 0) {
+		return fd;
+	}
+
+#ifdef FDGETDRVTYP
+	{
+		char name[1000];
+
+		if (ioctl(fd, FDGETDRVTYP, &name) >= 0) {
+			close(fd);
+			fd = open(filename, mode);
+		}
+	}
+#endif /* FDGETDRVTYP */
+
+	return fd;
 }
 
 
-- 
2.31.1

