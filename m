Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05106C433F5
	for <util-linux@archiver.kernel.org>; Fri, 22 Apr 2022 10:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446200AbiDVKLd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 22 Apr 2022 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiDVKL3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 22 Apr 2022 06:11:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D0153A7B
        for <util-linux@vger.kernel.org>; Fri, 22 Apr 2022 03:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwGbIm9+u5HTVcWbuKTWB2MefocjrvlnJWng0n+hUiFhZO0HITwsLLBtX8/4I42wagxJ/7kvgjCO4BRbzExw2pcf7djhvj2/R84nY9VYe6TUNYJOoR3knif/g+2TRLS678T+Ae/GU1POjsZNPITb//iHbeR3dvdAKvs99W2r8/QCktIVV2Uzi1BQ7o9e4HfatVWPA6Je8Ikxm+2BqEPhxGzt1+yy61BRgxHLh3B+mrj6B8JqpzaLXm4SzRMjy+KnfSBfav7xIiQSLM62/GxGEpDSCK47sN0K5moGdEFH1bCTvKdUizXCkU9+gwsFJh1RGimJUfBAZnghgI8bYh2NYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKGFbySJcE93DfQ77i22uKrOM8aNsxr8s0BmrBzEaUc=;
 b=ZH10HcGWivH0UCsEI3PIiQuf/B5+AH+GfyXZbCfVWl1HNHKCh4pLF8WuhYBqPCm2p6uFCWT4+fBgcmzCWDAYxQAKqnioXuuPbDM1BQdD5O+6lIw5KnTNMPRXiX4JIuIp9juYN8gztK7xxIy4+NH7zry/MJWnB4l1P2sk1WapV5vfLTuET9gPoeGdEaIxWZhxrB0AmZC902M2233BBoWQd/EluZFmK3Oyt0oiDS0zPzQMp6OJy3wu4eoQFf74/kLq9QDH57LNHcXLsXKM3REpNOc+61O/6hJwM24ObZG1M4u94Huzdz4PyTJoMoAumgX7pU9K+UnekceVm8LZMe+V7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 155.56.66.106) smtp.rcpttodomain=redhat.com smtp.mailfrom=sap.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=sap.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKGFbySJcE93DfQ77i22uKrOM8aNsxr8s0BmrBzEaUc=;
 b=oZKhS9kDZWEc5x4ZpRym4QwOhEF6ZAN8SoHLIE0fRhcNydXtfxAjsBJeSRFjINd4qIBi85TKLOsiu4/OGmHYvwLkncHembhzE9UpoGAy0uINsXzpGlyJxGCx7VccPIR8xs9w0ohIR5m9pbeqSTcKzHWL5vjBiG1a9zBuQPsmR+Kg+hl4g/Rbtwb4QJZKzc5vg0U2TdJry7EIwd3M/JrgNZkJx4m6VNmTTQ8HQlY8D7WRtLdjv0d03eRqaUJ0Yh56Uh8urr3Wlw3iZrhx0NYdPqJTExdn7/7MqvchM+TDsglqdit3C1wQFjMGu0JJ+Bc54hZU8nbKNNaR28DH0IjD7Q==
Received: from DB6PR07CA0189.eurprd07.prod.outlook.com (2603:10a6:6:42::19) by
 DB9PR02MB8369.eurprd02.prod.outlook.com (2603:10a6:10:398::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Fri, 22 Apr 2022 10:08:32 +0000
Received: from DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:42:cafe::3e) by DB6PR07CA0189.outlook.office365.com
 (2603:10a6:6:42::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Fri, 22 Apr 2022 10:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 155.56.66.106)
 smtp.mailfrom=sap.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sap.com;
Received-SPF: Pass (protection.outlook.com: domain of sap.com designates
 155.56.66.106 as permitted sender) receiver=protection.outlook.com;
 client-ip=155.56.66.106; helo=mail.net.sap;
Received: from mail.net.sap (155.56.66.106) by
 DB5EUR03FT014.mail.protection.outlook.com (10.152.20.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 10:08:32 +0000
X-purgate-ID: 152705::1650622111-000061B5-E8C54337/0/0
X-purgate-size: 10218
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate-type: clean
X-SAP-SPAM-Status: clean
From:   Michael Trapp <michael.trapp@sap.com>
To:     <util-linux@vger.kernel.org>
CC:     <kzak@redhat.com>
Subject: uuidd: Implement continuous clock handling for time based UUIDs
Date:   Fri, 22 Apr 2022 12:08:30 +0200
Message-ID: <20220422100830.32187-1-michael.trapp@sap.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f53047af-97b6-4922-bd6e-08da24480e9a
X-MS-TrafficTypeDiagnostic: DB9PR02MB8369:EE_
X-Microsoft-Antispam-PRVS: <DB9PR02MB8369319A0ABAA6F0166C6CC4F9F79@DB9PR02MB8369.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTduo9Swbj6hHHPPC7lhlEmHuOm/HrMBSQCYoU0UkQIgAlrfrICL7ZO1e/jltNY84KEDQsut4e7DEoh/5lba4GFqfHyjAr26JqZlSl8434zlg+qVjBB49RvJfOjGcDsZCfwXeJQUQu2qaVAIKoowv4UtKIvoJHpPfxVcthx6WZTxePLad1PE8t36gnR3LcAF9+fK1cqMkgK3y98n3c7GDX6W0ZDlY1oDz37PIJzQVxXz5X4l5oub4whhXMTuoxZ7xc3QxKKxGElUg9F8MIZZ+7IP8zPZucrinwjqkoatlK4opdhUJlNVy1P+hE0rEVfMxp2oLwFGYEJ0O471wBzBZb1OT8yh3s0uS11634gMH+e0wzP/Bwocwuk8G1AN2Xp0v78Bo5l+DSeD5q2AE1yOZcYB6edhfzxg9m2MrxEPZZh/p3/pCgFuP/YYhgIZ3XEhsv8ObyC+Tfqn1RMIWt1R8Kw8lOPiKUl+yguC/6fmD6D1atLlM4LVGnALZNbgUoWOs1vEgQCwFExZToIPi8pObh71fu+yVFUXZQlWyc/tCVshrewjv8UxYr0bxHTG6x5j3qtDVuZ7iuVEOuSu+RoYDrc9gLELmF2zA8wIkE2S5LQkJTphBij7cuOWRwUsX1uzQGsspUYVbK2qaQHnsisrtf9Gjp2t93nxYYlF9ivXVxIPLjVtVpvMmdHK1hmpMsuf
X-Forefront-Antispam-Report: CIP:155.56.66.106;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.net.sap;PTR:smtpgw08.mail.net.sap;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(336012)(47076005)(40460700003)(356005)(86362001)(36756003)(2616005)(44832011)(6486002)(2906002)(508600001)(1076003)(5660300002)(83380400001)(186003)(8936002)(4326008)(82310400005)(6916009)(956004)(70206006)(6506007)(36860700001)(6512007)(8676002)(82960400001)(36736006)(316002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 10:08:32.6520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53047af-97b6-4922-bd6e-08da24480e9a
X-MS-Exchange-CrossTenant-Id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=42f7676c-f455-423c-82f6-dc2d99791af7;Ip=[155.56.66.106];Helo=[mail.net.sap]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8369
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In a uuidd setup, the daemon is a singleton and can maintain it's own
resources for time based UUID generation. This requires a dedicated
'clock sequence range' but does not need any further lock/update of
the LIBUUID_CLOCK_FILE from uuidd. The range of available clock values
is extended by a continuous clock update - instead of updating the
value to the current timestamp, it is incremented by the number of
requested UUIDs.
---

Here is the first implementation of a continuous clock for time based
UUIDs. Of course, there are pros + cons to have the current time in
the timestamp - which needs be discussed, but in some use cases it's
not relevant at all.
The feature has to be enabled with '-C' and can be checked with

# uuidgen -t
d1ff28e1-c21a-11ec-8000-f80f41fc650a
# uuidgen -t
d1ff28eb-c21a-11ec-8000-f80f41fc650a

which shows an increment of 10 UUIDs for each request (due to the
cache in libuuid).


 libuuid/src/gen_uuid.c  | 84 ++++++++++++++++++++++++++++++++++++++---
 libuuid/src/libuuid.sym |  1 +
 libuuid/src/uuidd.h     |  1 +
 misc-utils/uuidd.8.adoc |  3 ++
 misc-utils/uuidd.c      | 32 +++++++++++++---
 5 files changed, 111 insertions(+), 10 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 805b40d90..cb6ceb50e 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -209,6 +209,8 @@ static int get_node_id(unsigned char *node_id)
 
 /* Assume that the gettimeofday() has microsecond granularity */
 #define MAX_ADJUSTMENT 10
+/* Reserve a clock_seq value for the 'continuous clock' implementation */
+#define CLOCK_SEQ_CONT 0
 
 /*
  * Get clock from global sequence clock counter.
@@ -275,8 +277,10 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 	}
 
 	if ((last.tv_sec == 0) && (last.tv_usec == 0)) {
-		ul_random_get_bytes(&clock_seq, sizeof(clock_seq));
-		clock_seq &= 0x3FFF;
+		do {
+			ul_random_get_bytes(&clock_seq, sizeof(clock_seq));
+			clock_seq &= 0x3FFF;
+		} while (clock_seq == CLOCK_SEQ_CONT);
 		gettimeofday(&last, NULL);
 		last.tv_sec--;
 	}
@@ -286,7 +290,9 @@ try_again:
 	if ((tv.tv_sec < last.tv_sec) ||
 	    ((tv.tv_sec == last.tv_sec) &&
 	     (tv.tv_usec < last.tv_usec))) {
-		clock_seq = (clock_seq+1) & 0x3FFF;
+		do {
+			clock_seq = (clock_seq+1) & 0x3FFF;
+		} while (clock_seq == CLOCK_SEQ_CONT);
 		adjustment = 0;
 		last = tv;
 	} else if ((tv.tv_sec == last.tv_sec) &&
@@ -331,6 +337,56 @@ try_again:
 	return ret;
 }
 
+/*
+ * Get current time in 100ns ticks.
+ */
+static uint64_t get_clock_counter(void)
+{
+	struct timeval tv;
+	uint64_t clock_reg;
+
+	gettimeofday(&tv, NULL);
+	clock_reg = tv.tv_usec*10;
+	clock_reg += ((uint64_t) tv.tv_sec)*10000000;
+
+	return clock_reg;
+}
+
+/*
+ * Get continuous clock value.
+ *
+ * Return -1 if there is no further clock counter available,
+ * otherwise return 0.
+ *
+ * This implementation doesn't deliver clock counters based on
+ * the current time because the last clock counter is only
+ * incremented by the number of requested UUIDs.
+ */
+static int get_clock_cont(uint32_t *clock_high,
+			    uint32_t *clock_low,
+			    int num)
+{
+	/* 100ns based time offset according to RFC 4122. 4.1.4. */
+	const uint64_t reg_offset = (((uint64_t) 0x01B21DD2) << 32) + 0x13814000;
+	THREAD_LOCAL uint64_t last_clock_reg = 0;
+	uint64_t clock_reg;
+
+	if (last_clock_reg == 0)
+		last_clock_reg = get_clock_counter();
+
+	clock_reg = get_clock_counter();
+	clock_reg += MAX_ADJUSTMENT;
+
+	if ((last_clock_reg + num) >= clock_reg)
+		return -1;
+
+	*clock_high = (last_clock_reg + reg_offset) >> 32;
+	*clock_low = last_clock_reg + reg_offset;
+	last_clock_reg += num;
+
+	return 0;
+}
+
 #if defined(HAVE_UUIDD) && defined(HAVE_SYS_UN_H)
 
 /*
@@ -403,7 +459,8 @@ static int get_uuid_via_daemon(int op __attribute__((__unused__)),
 }
 #endif
 
-int __uuid_generate_time(uuid_t out, int *num)
+static int __uuid_generate_time_internal(uuid_t out, int *num,
+					 int cont)
 {
 	static unsigned char node_id[6];
 	static int has_init = 0;
@@ -423,7 +480,14 @@ int __uuid_generate_time(uuid_t out, int *num)
 		}
 		has_init = 1;
 	}
-	ret = get_clock(&clock_mid, &uu.time_low, &uu.clock_seq, num);
+	if (cont) {
+		ret = get_clock_cont(&clock_mid, &uu.time_low, *num);
+		uu.clock_seq = CLOCK_SEQ_CONT;
+		if (ret != 0)	/* falback to previous implpementation */
+			ret = get_clock(&clock_mid, &uu.time_low, &uu.clock_seq, num);
+	} else {
+		ret = get_clock(&clock_mid, &uu.time_low, &uu.clock_seq, num);
+	}
 	uu.clock_seq |= 0x8000;
 	uu.time_mid = (uint16_t) clock_mid;
 	uu.time_hi_and_version = ((clock_mid >> 16) & 0x0FFF) | 0x1000;
@@ -432,6 +496,16 @@ int __uuid_generate_time(uuid_t out, int *num)
 	return ret;
 }
 
+int __uuid_generate_time(uuid_t out, int *num)
+{
+	return __uuid_generate_time_internal(out, num, 0);
+}
+
+int __uuid_generate_time_cont(uuid_t out, int *num)
+{
+	return __uuid_generate_time_internal(out, num, 1);
+}
+
 /*
  * Generate time-based UUID and store it to @out
  *
diff --git a/libuuid/src/libuuid.sym b/libuuid/src/libuuid.sym
index 342453368..96372a857 100644
--- a/libuuid/src/libuuid.sym
+++ b/libuuid/src/libuuid.sym
@@ -60,6 +60,7 @@ global:
 UUIDD_PRIVATE {
 global:
 	__uuid_generate_time;
+	__uuid_generate_time_cont;
 	__uuid_generate_random;
 local:
 	*;
diff --git a/libuuid/src/uuidd.h b/libuuid/src/uuidd.h
index fbe821ff3..1557bb6ca 100644
--- a/libuuid/src/uuidd.h
+++ b/libuuid/src/uuidd.h
@@ -49,6 +49,7 @@
 #define UUIDD_MAX_OP			UUIDD_OP_BULK_RANDOM_UUID
 
 extern int __uuid_generate_time(uuid_t out, int *num);
+extern int __uuid_generate_time_cont(uuid_t out, int *num);
 extern int __uuid_generate_random(uuid_t out, int *num);
 
 #endif /* _UUID_UUID_H */
diff --git a/misc-utils/uuidd.8.adoc b/misc-utils/uuidd.8.adoc
index 49e7b6359..07c01c20b 100644
--- a/misc-utils/uuidd.8.adoc
+++ b/misc-utils/uuidd.8.adoc
@@ -24,6 +24,9 @@ The *uuidd* daemon is used by the UUID library to generate universally unique id
 
 == OPTIONS
 
+*-C*, *--cont-clock*::
+Activate continuous clock handling for time based UUIDs. *uuidd* uses all possible clock values, beginning with the daemon's start time.
+
 *-d*, *--debug*::
 Run *uuidd* in debugging mode. This prevents *uuidd* from running as a daemon.
 
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index dfcd1487b..51e4e78a4 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -75,7 +75,8 @@ struct uuidd_cxt_t {
 	unsigned int	debug: 1,
 			quiet: 1,
 			no_fork: 1,
-			no_sock: 1;
+			no_sock: 1,
+			cont_clock:1;
 };
 
 struct uuidd_options_t {
@@ -106,6 +107,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -P, --no-pid            do not create pid file\n"), out);
 	fputs(_(" -F, --no-fork           do not daemonize using double-fork\n"), out);
 	fputs(_(" -S, --socket-activation do not create listening socket\n"), out);
+	fputs(_(" -C, --cont-clock        activate continuous clock handling\n"), out);
 	fputs(_(" -d, --debug             run in debugging mode\n"), out);
 	fputs(_(" -q, --quiet             turn on quiet mode\n"), out);
 	fputs(USAGE_SEPARATOR, out);
@@ -438,6 +440,10 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	pfd[POLLFD_SOCKET].fd = s;
 	pfd[POLLFD_SIGNAL].events = pfd[POLLFD_SOCKET].events = POLLIN | POLLERR | POLLHUP;
 
+	num = 1;
+	/* trigger initialization */
+	(void) __uuid_generate_time_cont(uu, &num);
+
 	while (1) {
 		ret = poll(pfd, ARRAY_SIZE(pfd),
 				uuidd_cxt->timeout ?
@@ -494,7 +500,11 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			break;
 		case UUIDD_OP_TIME_UUID:
 			num = 1;
-			if (__uuid_generate_time(uu, &num) < 0 && !uuidd_cxt->quiet)
+			if (uuidd_cxt->cont_clock)
+				ret = __uuid_generate_time_cont(uu, &num);
+			else
+				ret = __uuid_generate_time(uu, &num);
+			if (ret < 0 && !uuidd_cxt->quiet)
 				warnx(_("failed to open/lock clock counter"));
 			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
@@ -505,7 +515,11 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			break;
 		case UUIDD_OP_RANDOM_UUID:
 			num = 1;
-			if (__uuid_generate_time(uu, &num) < 0 && !uuidd_cxt->quiet)
+			if (uuidd_cxt->cont_clock)
+				ret = __uuid_generate_time_cont(uu, &num);
+			else
+				ret = __uuid_generate_time(uu, &num);
+			if (ret < 0 && !uuidd_cxt->quiet)
 				warnx(_("failed to open/lock clock counter"));
 			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
@@ -515,7 +529,11 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			reply_len = sizeof(uu);
 			break;
 		case UUIDD_OP_BULK_TIME_UUID:
-			if (__uuid_generate_time(uu, &num) < 0 && !uuidd_cxt->quiet)
+			if (uuidd_cxt->cont_clock)
+				ret = __uuid_generate_time_cont(uu, &num);
+			else
+				ret = __uuid_generate_time(uu, &num);
+			if (ret < 0 && !uuidd_cxt->quiet)
 				warnx(_("failed to open/lock clock counter"));
 			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
@@ -581,6 +599,7 @@ static void parse_options(int argc, char **argv, struct uuidd_cxt_t *uuidd_cxt,
 		{"no-pid", no_argument, NULL, 'P'},
 		{"no-fork", no_argument, NULL, 'F'},
 		{"socket-activation", no_argument, NULL, 'S'},
+		{"cont-clock", no_argument, NULL, 'c'},
 		{"debug", no_argument, NULL, 'd'},
 		{"quiet", no_argument, NULL, 'q'},
 		{"version", no_argument, NULL, 'V'},
@@ -596,9 +615,12 @@ static void parse_options(int argc, char **argv, struct uuidd_cxt_t *uuidd_cxt,
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 	int c;
 
-	while ((c = getopt_long(argc, argv, "p:s:T:krtn:PFSdqVh", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "Cp:s:T:krtn:PFSdqVh", longopts, NULL)) != -1) {
 		err_exclusive_options(c, longopts, excl, excl_st);
 		switch (c) {
+		case 'C':
+			uuidd_cxt->cont_clock = 1;
+			break;
 		case 'd':
 			uuidd_cxt->debug = 1;
 			break;
-- 
2.32.0 (Apple Git-132)

