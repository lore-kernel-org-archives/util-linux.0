Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6A9C433EF
	for <util-linux@archiver.kernel.org>; Thu,  9 Dec 2021 14:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhLIOQ0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Dec 2021 09:16:26 -0500
Received: from mail-am6eur05on2114.outbound.protection.outlook.com ([40.107.22.114]:42369
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhLIOQ0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 9 Dec 2021 09:16:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcF6vJS6p2dG+zhySeYwpB2p8p2v23gU9LauVCcFE/YJAi8bQJHulzo9DHBC2E8W1C2VgUF+hogqWhTVs4IAZ21fGitL70xwjewb+Yonp6yPpi1F8elZHAn/EwguMtKFFzCVApN9XCxFdAAKXQtCfO9VPNCYBDhMDRXHMu2T6fpK3yqVwO7KfSlPZCfN/G+019F+ItEcSTyfRpI4LFADzNeG9iSKeXWTsWbstAalenEKYuej++RVpAmpVAK1X2IFyCk/ZInv3TBfSuI5+KJkgt3kL9XUxprAcxnD1hhfQa9KwIq5rUX3Nctj893KYmFizRn2f37r7TfjwtYuc67kQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCWA5yMwKuKvIdVxTe3uAwGT8XxTufmNiNaNgla+rZ4=;
 b=l35QFfGGmAh5F3/Ig8BtyiROBbaWUIOqtb8n0wVh4DR0Or6g/NbrFY4HkDz/y4937SP40HQ+c4rNuQ2UB5oDuM/rczWXvm1nveu+G9JujbeJq9ApAQOPBFckHtuDKp2xQRFPy1OYt7DPH7Z89yRI/PfQIZI2IGG4ixk/ZFc7aZZ8QOcRUuueInMRSFXa28bqhZI+M6zR4scKcsjyso9WGSMdwKFB/aAMMTyoME2UwpFEKY1zqiuWH5bCI6lvRXbuJZhVzfIEyEKZ5eA2Co4uYxdkCZ3sE9XPhcXXsMkaiSWjxdP/G3nssf/hSe59Pt+DjQHue3uPzZ9osXUZzaxlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCWA5yMwKuKvIdVxTe3uAwGT8XxTufmNiNaNgla+rZ4=;
 b=JnfOEZbFY7VThhahi7Bx17VJAZVrlkc1Y9EooRJfGl0nTOVTJWNxMcmafHPiwAfZo2hsAeTImscR74PO9W7tvToukWLr/QCEo+pB9ha+tOmjlAPxw3kqBCXs8VH2ds5vMspRaFBrNhz5SNJrECIBmRdC85EgBD2Fe78QiYkYlNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com (2603:10a6:20b:304::18)
 by AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 14:12:51 +0000
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a]) by AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a%7]) with mapi id 15.20.4669.024; Thu, 9 Dec 2021
 14:12:50 +0000
From:   Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To:     util-linux@vger.kernel.org
Cc:     jkosina@suse.cz, kzak@redhat.com, kurt@garloff.de,
        vsementsov@virtuozzo.com, den@openvz.org, msuchanek@suse.de,
        efremov@linux.com
Subject: [PATCH 1/2] libblkid: introduce blkid_safe_open
Date:   Thu,  9 Dec 2021 15:12:32 +0100
Message-Id: <20211209141233.3774937-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0014.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::27) To AM9PR08MB6737.eurprd08.prod.outlook.com
 (2603:10a6:20b:304::18)
MIME-Version: 1.0
Received: from kvm.ch-qa.sw.ru (130.117.225.5) by AM6PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:20b:92::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 14:12:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ad3d16a-0e81-4d00-4a1a-08d9bb1dfc01
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB60343988015DA7348ED98FDAC1709@AM9PR08MB6034.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:208;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBDhMb8LfZvGI0z6QcizLjZdHjUyyBHJlJ115r+gSKg2c1XUR8T/bt/B1hbtKrb5uw8P0aJooiRvrth5biWqGF7bNm+QYGqbAgTIbsVwtD1VTuQDyykkEy5YQBGa7gIJBg02sHDSaaqlLmha9yIIWSaDJdMLiHGIxqjDaJdjEdeEYNVhdajNARcLCdbOtgolpVpCd8ND6YKopMfKvrgW1KWu7oHtfy63ncHYv9OZ8x2qNq1Y4km9hUAgdRKFkh3K42P2iDjGW0hwehYTz3EjQxL2d13qpHmjPDGDMRH0+zXUznfhHzUbe2/jItwFz4SOtLSOmxb6PfDmJuMq+FuSBlj5Ly10x7e7nmXYXO6jkIVZ7MQjQgqgRCa5Is/A0tTTld6K5hDX3pTiyr1HUzqyYV0OFnZxyz+0/Y70WZ+bBMYWeo9OHDBlN5vRNT0hkCoLaqR6UYxQJrL5WZTpcJaeiaaFVCE0nd3k2fjMOOJDDCLC5qi1N5lvKUTKF5NNCRL2XEkOe0RiDWyFldFlhp8ymYHQg/ymWJkMOfzgWBJLP/IzgUJbJPpE8TSMuJBV3p4cIAG1QHIUe5H4pG6bjDkA79HkkxI0ibIFl4YfbJchm/1R86EJOIII2w7krX1U/ZNk2ihSB+ARlWMAo1OY6Ho8wThScfW5+sWPdXdVNluTkMKId6PaObqthDtX1rulos8c4CWguGmSkusSd20xFK3Sdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(66556008)(8676002)(26005)(6512007)(6486002)(508600001)(8936002)(38100700002)(5660300002)(6916009)(52116002)(38350700002)(36756003)(956004)(4326008)(2906002)(2616005)(6666004)(86362001)(186003)(6506007)(1076003)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q0y71rE7jWLDJe52IQn4lM7ExQJ28Vy//LptvqimPoZ9o5lOh10knCv9GFxb?=
 =?us-ascii?Q?OFTIBRUhsmVCZWSWua7WhBVp5OOeptXYkxWGNKmxzS80s71Ku3DJvaQzxALu?=
 =?us-ascii?Q?gE4Hh0aP2VLZOQJKmHLE8D5m71PouHHDb8Kfce3+Zyruy+Myi959y4Ub79Sr?=
 =?us-ascii?Q?deQ9C8NA+/hYXXXi7yUlYFmpKP0SItcTTT7AyrS6kQAageG7CGWmmGlIrIBl?=
 =?us-ascii?Q?xTKUJMkb51IaiBCBZWw7UPkdkmuKIqWDY4sNo4l0Ih/0OiMeWTTa8r6SH6p6?=
 =?us-ascii?Q?7lRWwxKSklJynMkFYah8nV4Ml2XT+rJdp/vRmb20VS8DbE7rfiwxAJIVxUUH?=
 =?us-ascii?Q?bM96u9FRyEyS9VmY5R9UJagZHuyAAhFjm83IOVVmAOSp/9C9QsTukD4FrmiV?=
 =?us-ascii?Q?YWqPZRPeqkhcT7XMwlCU8O+YK7yFtQcKhO8n7ZB4gPBjdtNncg4cyEUuFrvD?=
 =?us-ascii?Q?tWrirGMrfKI1g/uzwJz4HpPAMjMqVrkrMX9dGIwuEj8unhc0kYlFp4ex/5ZQ?=
 =?us-ascii?Q?/I36ON7luN2yDweYy7rBbuikrJ8Ro5pyzsdcBBtu/cqq2Kpie+DwRG1zeHnw?=
 =?us-ascii?Q?Y6BXnJkCOoIARGNd9Fbdv6fXrpwjZkwFbxDTKxjWdJMIi7Yi3uDokhPRIF5d?=
 =?us-ascii?Q?6nbW2ai+TT23npqs29gYL2quGUIZdWt4QzMRnmdDn6lZ80Cs0VCXIR2KOveT?=
 =?us-ascii?Q?qmHYctUw5H6N1OvRAuJ9H82Wcnh2nSNAIQQaHrwIupUEK4BpKJujvhMvZRqJ?=
 =?us-ascii?Q?WxnqjvVT+3ivNzzAaF1G95yTFhQlExJRdWyP3GoTCWBSkrkwjRXBY2dF608R?=
 =?us-ascii?Q?K88RqvWJoJPsExEeXGdOJ8FDqGEjbEsBdpHGg9/O1Rf9Jx6hPa7OqqFMMtVZ?=
 =?us-ascii?Q?FezrTGGr1XaR3C75diHW9ANKa8vFL2AIp16axi+I0crs2WelXpr8CdGZB8LE?=
 =?us-ascii?Q?bboO26j8qZ3oqiWEVdn9oXyMLzxz8bswrgt8gmb/BkmU/WpU0cnqQM5Aad63?=
 =?us-ascii?Q?QNUgq0WE/LChR1NhJaW04J8eK8xQyohk01Z0z2KNUrwQgxmZpNLKB7x3QNLS?=
 =?us-ascii?Q?cIq5S/AQBkz8Ide9wgTMIzbun6A7yUhM/medvLgzWNSQ02zajjbd32jqbi/m?=
 =?us-ascii?Q?Tqr3AY61wS5KdbgetJjsZuSlLQfCv3G8cJKgt8nmSgxVfaHPQ/TLnpkaeshc?=
 =?us-ascii?Q?tX9uGjwHSI7jesSH+mH2Zj0oe6ZDr08yj7sbaMdcaMdGKs1DLpK5dl2+5CVE?=
 =?us-ascii?Q?wrWICxEJ2Jcnu+2YMDe0GPTGRoP/Dyd7Mk1+Rz4TWKjAafCOPMpKjjs7XTS7?=
 =?us-ascii?Q?kjRJDR2GoNucEui3fxlU1RfwKzgesr8LvRd6WvOVAovYzQjIjR40B4q9mus+?=
 =?us-ascii?Q?kR5RMhmMaPapPdxZrKW/fhSF53XDc+NcN9wfnQi4+bNOWRJSYigKGB+BDHCi?=
 =?us-ascii?Q?N0OJ/h6kSTNVAmBu/FaqLTdK0HTsdMsv+55Fz3ZGVVqbgrdT/k+/HfybTXBC?=
 =?us-ascii?Q?/h+uV+NJ6QtmQ4PxInLZKKTKrM6tuZSkbzKKb/mav+kMYhjDxom+WyDV2LUk?=
 =?us-ascii?Q?lerWyCjT605MnugQcBpS5UVI8kIbhCSV4eIVm8PRsjaXw0FCLl1a6DtzEfL/?=
 =?us-ascii?Q?JbW0UC6UbIHG7hQsJYaI6TY9oYXf/i07hCpKGfj05l3i65D6OsLiNAltD7N0?=
 =?us-ascii?Q?84lUlQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad3d16a-0e81-4d00-4a1a-08d9bb1dfc01
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6737.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 14:12:50.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVEmAkHKhbndRBiBAIPNUgNeeKd6aGZR8kwVZWNZpaScAo8P8qimDJtYBvIzAR54D22S8x4qtHgImOKNh5UQSN+7th9CW0qn9Xx+Rlo2UIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6034
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Commit 39f5af25982d8b0244000e92a9d0e0e6557d0e17 modified open() calls
used to get fds for probing by adding O_NONBLOCK flag.

We want to modify this logic in the following commit. So, as a first
step create a generic wrapper on open, so blkid-related open logic live
in one place.

Formally blkid_safe_open() becomes recommended method to open device
file for probing, as it workarounds problems of opening CDROM (and in
further patch also of FLOPPY). So, it's good to make a public API
function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 libblkid/src/blkid.h.in   |  2 ++
 libblkid/src/evaluate.c   |  2 +-
 libblkid/src/libblkid.sym |  4 ++++
 libblkid/src/probe.c      | 19 ++++++++++++++++++-
 libblkid/src/verify.c     |  2 +-
 misc-utils/blkid.c        |  2 +-
 misc-utils/wipefs.c       |  2 +-
 7 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/libblkid/src/blkid.h.in b/libblkid/src/blkid.h.in
index 3cd4116d9..7ecf4f9be 100644
--- a/libblkid/src/blkid.h.in
+++ b/libblkid/src/blkid.h.in
@@ -217,6 +217,8 @@ extern char *blkid_evaluate_spec(const char *spec, blkid_cache *cache)
 			__ul_attribute__((warn_unused_result));
 
 /* probe.c */
+extern int blkid_safe_open(const char *filename, int mode)
+			__ul_attribute__((warn_unused_result));
 extern blkid_probe blkid_new_probe(void)
 			__ul_attribute__((warn_unused_result));
 extern blkid_probe blkid_new_probe_from_filename(const char *filename)
diff --git a/libblkid/src/evaluate.c b/libblkid/src/evaluate.c
index 710eac956..1eefe455c 100644
--- a/libblkid/src/evaluate.c
+++ b/libblkid/src/evaluate.c
@@ -73,7 +73,7 @@ static int verify_tag(const char *devname, const char *name, const char *value)
 	blkid_probe_enable_partitions(pr, TRUE);
 	blkid_probe_set_partitions_flags(pr, BLKID_PARTS_ENTRY_DETAILS);
 
-	fd = open(devname, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
+	fd = blkid_safe_open(devname, O_RDONLY|O_CLOEXEC);
 	if (fd < 0) {
 		errsv = errno;
 		goto done;
diff --git a/libblkid/src/libblkid.sym b/libblkid/src/libblkid.sym
index 366f2c0c0..1549a29f4 100644
--- a/libblkid/src/libblkid.sym
+++ b/libblkid/src/libblkid.sym
@@ -183,3 +183,7 @@ BLKID_2_37 {
 	blkid_probe_set_hint;
 	blkid_probe_reset_hints;
 } BLKID_2_36;
+
+BLKID_2_38 {
+	blkid_safe_open;
+} BLKID_2_37;
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 3685ea5e1..70e3dc0eb 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -189,6 +189,23 @@ blkid_probe blkid_clone_probe(blkid_probe parent)
 }
 
 
+/**
+ * blkid_safe_open
+ * @filename: device or regular file
+ * @mode: open mode
+ *
+ * This wrapper is blkid-specific wrapper on open(). It's "safe" in a meaning
+ * that it doesn't change
+ *
+ * We add O_NONBLOCK flag to the mode, as opening CDROM without this flag may
+ * load to closing the rom (if it's open), which is bad thing in context of
+ * blkid: we don't want to change the actual device state.
+ */
+int blkid_safe_open(const char *filename, int mode)
+{
+	return open(filename, mode | O_NONBLOCK);
+}
+
 
 /**
  * blkid_new_probe_from_filename:
@@ -208,7 +225,7 @@ blkid_probe blkid_new_probe_from_filename(const char *filename)
 	int fd;
 	blkid_probe pr = NULL;
 
-	fd = open(filename, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
+	fd = blkid_safe_open(filename, O_RDONLY|O_CLOEXEC);
 	if (fd < 0)
 		return NULL;
 
diff --git a/libblkid/src/verify.c b/libblkid/src/verify.c
index 3b9754f57..96b43634c 100644
--- a/libblkid/src/verify.c
+++ b/libblkid/src/verify.c
@@ -126,7 +126,7 @@ blkid_dev blkid_verify(blkid_cache cache, blkid_dev dev)
 		}
 	}
 
-	fd = open(dev->bid_name, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
+	fd = blkid_safe_open(dev->bid_name, O_RDONLY|O_CLOEXEC);
 	if (fd < 0) {
 		DBG(PROBE, ul_debug("blkid_verify: error %s (%d) while "
 					"opening %s", strerror(errno), errno,
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 41826e6dc..1f7be80eb 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -516,7 +516,7 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 	int rc = 0;
 	static int first = 1;
 
-	fd = open(devname, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
+	fd = blkid_safe_open(devname, O_RDONLY|O_CLOEXEC);
 	if (fd < 0) {
 		warn(_("error: %s"), devname);
 		return BLKID_EXIT_NOTFOUND;
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 78dc63ee7..2597135b5 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -390,7 +390,7 @@ new_probe(const char *devname, int mode)
 		return NULL;
 
 	if (mode) {
-		int fd = open(devname, mode | O_NONBLOCK);
+		int fd = blkid_safe_open(devname, mode);
 		if (fd < 0)
 			goto error;
 
-- 
2.31.1

