Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC857C433EF
	for <util-linux@archiver.kernel.org>; Mon, 20 Jun 2022 15:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbiFTPTk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 20 Jun 2022 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245117AbiFTPTE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 20 Jun 2022 11:19:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B67ED
        for <util-linux@vger.kernel.org>; Mon, 20 Jun 2022 08:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIRi7kFwZRNITZUlOmB3JYoUfkAgH2OVPg7tKbd7O+ETW6flIaWL9q6pYcF/kb9KWWrGSS4uCk1t0qDX7izLyUcrkeYgQsIqtjc/h0mrAIp7V+Th/cQzeYzlBla7HzIySTj36eo0tI77MGSAI7+q0bMAVQPzPGi5r84FO3d1XaSjrq68TySf15gMy99TkzSJ8FjUDKSJAuJqBHpK1b3M7UpSlHzaMX7eBp9KFwLC7w21J9xlPSvPt0gP88nY5btixZDUZOmdIqH9qU/VLSjHQPnpNMCqdi1rqxIj+r/T4Zlow2rKtRp6n7I5wMfF3qgnL8Pt67sHtxHoJPiY4dqoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9Cr4rvfcByGuBSwPsDPKQYukWtEAuGgPRhSueTraZQ=;
 b=QkQ/rTFHmrue+J9oPGO8Rqmw7Yj4ORHzUs1B5rkKxgmslJyDeXU54RmvGmiej1rtnL39yprDYEwKvgV8Lz8oM7JQKMc3SmqIJtQeNKlXitBbG9rHmC85N175RfiOeYxjkRyUQyrxJ/kC5M8PVKjev0YZ9w+10iF2TqgpPZiyL2OGMkhhmBpL84T3+ifzEqLnkT5zCBZH47Gp9Hc49d8Ood+Aay+vXdb0Jci7dimwtqamqVj1MZB9AQHT545ezrr8+RKImkzD6zft/nwUNoYyyp0MBOLZT7KnCh51VJuem73SpqPfZqm4lKm14NmyJC3B88Ik92TOUi+E1dyQaUVgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 155.56.68.170) smtp.rcpttodomain=redhat.com smtp.mailfrom=sap.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=sap.com;
 dkim=pass (signature was verified) header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Cr4rvfcByGuBSwPsDPKQYukWtEAuGgPRhSueTraZQ=;
 b=qMSZTztZeljxrGBnVYpHQ4T6Pb8TgS6e9zKzYWREgaRURs4LihRWgEPSCIYVRv/4cOuI72q59cd2c+P+EsgQiO6URFOHtUKcV2KPXG5kvIjhbIbTpuCgJvrTR7NxQaSanNeVe5vGhQ/Z0hGNFOkj0NhIXmss/B/LvbB3QQc/S1Cd44F2ryJLEzn3Od0mmg2/RgNua/2CLP7FHxxo+wES3BMdGTdSzEJYNK29dyKpJKix2DLVViNt7FFErHM8fxjLdcnfkIL8LE3uNWHjZff+JlzGwn1RkmdBbVgOVl0dMPj4BElnqWwr11fwjf9K0yd8aXAZLdvd2LJrzour15ic+A==
Received: from DB6PR0301CA0026.eurprd03.prod.outlook.com (2603:10a6:4:3e::36)
 by PA4PR02MB6830.eurprd02.prod.outlook.com (2603:10a6:102:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Mon, 20 Jun
 2022 15:10:38 +0000
Received: from DBAEUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::10) by DB6PR0301CA0026.outlook.office365.com
 (2603:10a6:4:3e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21 via Frontend
 Transport; Mon, 20 Jun 2022 15:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 155.56.68.170)
 smtp.mailfrom=sap.com; dkim=pass (signature was verified)
 header.d=sap.com;dmarc=pass action=none header.from=sap.com;
Received-SPF: Pass (protection.outlook.com: domain of sap.com designates
 155.56.68.170 as permitted sender) receiver=protection.outlook.com;
 client-ip=155.56.68.170; helo=smtpde01.mail.net.sap; pr=C
Received: from smtpde01.mail.net.sap (155.56.68.170) by
 DBAEUR03FT056.mail.protection.outlook.com (100.127.142.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 15:10:38 +0000
X-purgate-ID: 152705::1655737837-00000271-6F571727/0/0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com;
        s=it-20211118; t=1655737838; x=1657033838;
        bh=Q9Cr4rvfcByGuBSwPsDPKQYukWtEAuGgPRhSueTraZQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From;
        b=vhGnIt46VkzpC+AZxHWJWVNhiOtJgoWyi/qfyJy/W1vxU7aoo/84+EELS/XiWZmE8
         gBR1vBWXVqTezIDNgWOjPBnLqzBcCV85DrwwKxUqXP7piGbRQvZILJyafAYg4PnpTE
         oMOmlEgW1DZbXqArVV6eeVX/bWIkSalb8bOoPUIE4osI9ko5AHCav6Cqnzjp8doeyK
         X7NUHM/17z1F3qpRi4XeHFbcLQ78JXdOA6l+8cL1uisFK0sUpJBCWirLkBozl350e4
         wd1+/kQu/RweqFOaKuZ34ZH8IiWOrI0W6YZVRvEqiKOIeXCVd/kIQUcxIDSIlVhXB3
         Ait0VkIr6JsnQ==
X-purgate-size: 12201
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate-type: clean
X-SAP-SPAM-Status: clean
From:   Michael Trapp <michael.trapp@sap.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com
Subject: [PATCH] Implement continuous clock handling for time based UUIDs
Date:   Mon, 20 Jun 2022 17:10:36 +0200
Message-Id: <20220620151036.97706-1-michael.trapp@sap.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8cd5124d-d4a6-4ab6-192d-08da52cf08f8
X-MS-TrafficTypeDiagnostic: PA4PR02MB6830:EE_
X-Microsoft-Antispam-PRVS: <PA4PR02MB68302877EB7391FA99AEE4F3F9B09@PA4PR02MB6830.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adi7tpf67RCs/QldJPZ+sWAoBMo+a+YQuQVtlRNkDPEx/TfMDeansxvYtID5SxB/1z2RTG80YptZK09B3o6H3nVz5G9pBUYmRBS5ZsCHNjqojAC5RcinGJzYR+89x8mZr5DbKf2mwd8mZIMnss3DddO29Jik2leLXIzvNlbuSMamUPOqc1Rppgzx3NZFfBmh3V+YabhcZkkQhz/XW8+GxqlWNg4E8TOZvC9bM9h5c5+j100lQHdW3fITRdWB0JyqcpqZjgpNnPyDE39J5MbnjyZIsZTddLqmX4DurtTLTnek1sAZ3zASqD4T8XdElocEjW5yDH4Hr6TC+ZJKBlN09GboY2lC7hmn0ryWlUTh7ddwlCYA65okQlaCV4uih1bxzqzU29dzQdquPdhS7jBqoihEVxecMFOtM1ILpxdbcBg3+w3ipohVn8rBT0RfWOWQl1P8HHBZIPY6aszq+OWiz/7UDyLkEFtVpH2vMYe/UHV/57lLWtJ7OjRx3MTC24inxqdN9xUy5XbfdL1k0rEgDwoLTWv8NLHVW9lbLcaZvB3PBcE32EiZqr++molXM0A1SvtCIxUVJJMyQYBsUAYCC79QjkyziCUkQo91pBkpPJtygPaxJ5BM0vhaiz6KEgLn/D5O0zbyZCG3MrYFcab0Frgi0a8cKuaMjKsIgHYvTCr8LceT6lYayC6uOOKcM0C0
X-Forefront-Antispam-Report: CIP:155.56.68.170;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpde01.mail.net.sap;PTR:smtpde01.mail.net.sap;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(6506007)(6486002)(956004)(1076003)(2616005)(8676002)(4326008)(36756003)(5660300002)(47076005)(498600001)(6512007)(36860700001)(8936002)(30864003)(44832011)(70206006)(86362001)(82960400001)(82310400005)(40460700003)(186003)(83380400001)(36736006)(26005)(6916009)(7596003)(2906002)(356005)(316002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 15:10:38.7594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd5124d-d4a6-4ab6-192d-08da52cf08f8
X-MS-Exchange-CrossTenant-Id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=42f7676c-f455-423c-82f6-dc2d99791af7;Ip=[155.56.68.170];Helo=[smtpde01.mail.net.sap]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DBAEUR03FT056.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6830
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In a uuidd setup, the daemon is a singleton and can maintain it's own
resources for time based UUID generation. This requires a dedicated
'clock sequence range' but does not need any further lock/update of
the LIBUUID_CLOCK_FILE from uuidd. The range of available clock values
is extended by a continuous handling of the clock updates - instead of
updating the value to the current timestamp, it is incremented by
the number of requested UUIDs.
---

Updated version
  cont clock handling needs to be activated with '-C' or '--cont-clock'.
  default value of max_clock_offset is 7200 seconds.
  custom value of max_clock_offset can be defined by optional argument.
  maximum value of max_clock_offest is 365 days.


 libuuid/src/gen_uuid.c  | 91 ++++++++++++++++++++++++++++++++++++++---
 libuuid/src/libuuid.sym |  1 +
 libuuid/src/uuidd.h     |  1 +
 misc-utils/uuidd.8.adoc |  3 ++
 misc-utils/uuidd.c      | 54 +++++++++++++++++++++---
 5 files changed, 140 insertions(+), 10 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 805b40d90..807dcd115 100644
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
@@ -331,6 +337,64 @@ try_again:
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
+	clock_reg += ((uint64_t) tv.tv_sec) * 10000000ULL;
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
+ * the current time because last_clock_reg is only incremented
+ * by the number of requested UUIDs.
+ * max_clock_offset is used to limit the offset of last_clock_reg.
+ */
+static int get_clock_cont(uint32_t *clock_high,
+			  uint32_t *clock_low,
+			  int num,
+			  uint32_t max_clock_offset)
+{
+	/* 100ns based time offset according to RFC 4122. 4.1.4. */
+	const uint64_t reg_offset = (((uint64_t) 0x01B21DD2) << 32) + 0x13814000;
+	static uint64_t last_clock_reg = 0;
+	uint64_t clock_reg;
+
+	if (last_clock_reg == 0)
+		last_clock_reg = get_clock_counter();
+
+	clock_reg = get_clock_counter();
+	if (max_clock_offset) {
+		uint64_t clock_offset = max_clock_offset * 10000000ULL;
+		if (last_clock_reg < (clock_reg - clock_offset))
+			last_clock_reg = clock_reg - clock_offset;
+	}
+
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
@@ -403,7 +467,7 @@ static int get_uuid_via_daemon(int op __attribute__((__unused__)),
 }
 #endif
 
-int __uuid_generate_time(uuid_t out, int *num)
+static int __uuid_generate_time_internal(uuid_t out, int *num, uint32_t cont_offset)
 {
 	static unsigned char node_id[6];
 	static int has_init = 0;
@@ -423,7 +487,14 @@ int __uuid_generate_time(uuid_t out, int *num)
 		}
 		has_init = 1;
 	}
-	ret = get_clock(&clock_mid, &uu.time_low, &uu.clock_seq, num);
+	if (cont_offset) {
+		ret = get_clock_cont(&clock_mid, &uu.time_low, *num, cont_offset);
+		uu.clock_seq = CLOCK_SEQ_CONT;
+		if (ret != 0)	/* fallback to previous implpementation */
+			ret = get_clock(&clock_mid, &uu.time_low, &uu.clock_seq, num);
+	} else {
+		ret = get_clock(&clock_mid, &uu.time_low, &uu.clock_seq, num);
+	}
 	uu.clock_seq |= 0x8000;
 	uu.time_mid = (uint16_t) clock_mid;
 	uu.time_hi_and_version = ((clock_mid >> 16) & 0x0FFF) | 0x1000;
@@ -432,6 +503,16 @@ int __uuid_generate_time(uuid_t out, int *num)
 	return ret;
 }
 
+int __uuid_generate_time(uuid_t out, int *num)
+{
+	return __uuid_generate_time_internal(out, num, 0);
+}
+
+int __uuid_generate_time_cont(uuid_t out, int *num, uint32_t cont_offset)
+{
+	return __uuid_generate_time_internal(out, num, cont_offset);
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
index fbe821ff3..f76acc8b2 100644
--- a/libuuid/src/uuidd.h
+++ b/libuuid/src/uuidd.h
@@ -49,6 +49,7 @@
 #define UUIDD_MAX_OP			UUIDD_OP_BULK_RANDOM_UUID
 
 extern int __uuid_generate_time(uuid_t out, int *num);
+extern int __uuid_generate_time_cont(uuid_t out, int *num, uint32_t cont);
 extern int __uuid_generate_random(uuid_t out, int *num);
 
 #endif /* _UUID_UUID_H */
diff --git a/misc-utils/uuidd.8.adoc b/misc-utils/uuidd.8.adoc
index 49e7b6359..8eee3e91b 100644
--- a/misc-utils/uuidd.8.adoc
+++ b/misc-utils/uuidd.8.adoc
@@ -24,6 +24,9 @@ The *uuidd* daemon is used by the UUID library to generate universally unique id
 
 == OPTIONS
 
+*-C*, *--cont-clock* _opt_arg_::
+Activate continuous clock handling for time based UUIDs. *uuidd* could use all possible clock values, beginning with the daemon's start time. The optional argument can be used to set a value for the max_clock_offset. This gurantees, that a clock value of a UUID will always be within the range of the max_clock_offset. '-C' or '--cont-clock' enables the feature with a default max_clock_offset of 2 hours. '-C<NUM>[hd]' or '--cont-clock=<NUM>[hd]' enables the feature with a max_clock_offset of NUM seconds. In case of an appended h or d, the NUM value is read in hours or days. The minimum value is 60 seconds, the maximum value is 365 days.
+
 *-d*, *--debug*::
 Run *uuidd* in debugging mode. This prevents *uuidd* from running as a daemon.
 
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index dfcd1487b..b25439db3 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -72,6 +72,8 @@ struct uuidd_cxt_t {
 	const char	*cleanup_pidfile;
 	const char	*cleanup_socket;
 	uint32_t	timeout;
+	uint32_t	cont_clock_offset;
+
 	unsigned int	debug: 1,
 			quiet: 1,
 			no_fork: 1,
@@ -106,6 +108,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -P, --no-pid            do not create pid file\n"), out);
 	fputs(_(" -F, --no-fork           do not daemonize using double-fork\n"), out);
 	fputs(_(" -S, --socket-activation do not create listening socket\n"), out);
+	fputs(_(" -C, --cont-clock[=<NUM>[hd]]\n"), out);
+	fputs(_("                         activate continuous clock handling\n"), out);
 	fputs(_(" -d, --debug             run in debugging mode\n"), out);
 	fputs(_(" -q, --quiet             turn on quiet mode\n"), out);
 	fputs(USAGE_SEPARATOR, out);
@@ -438,6 +442,15 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	pfd[POLLFD_SOCKET].fd = s;
 	pfd[POLLFD_SIGNAL].events = pfd[POLLFD_SOCKET].events = POLLIN | POLLERR | POLLHUP;
 
+	num = 1;
+	if (uuidd_cxt->cont_clock_offset) {
+		/* trigger initialization */
+		(void) __uuid_generate_time_cont(uu, &num, uuidd_cxt->cont_clock_offset);
+		if (uuidd_cxt->debug)
+			fprintf(stderr, _("max_clock_offset = %u sec\n"),
+				uuidd_cxt->cont_clock_offset);
+	}
+
 	while (1) {
 		ret = poll(pfd, ARRAY_SIZE(pfd),
 				uuidd_cxt->timeout ?
@@ -494,7 +507,8 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			break;
 		case UUIDD_OP_TIME_UUID:
 			num = 1;
-			if (__uuid_generate_time(uu, &num) < 0 && !uuidd_cxt->quiet)
+			ret = __uuid_generate_time_cont(uu, &num, uuidd_cxt->cont_clock_offset);
+			if (ret < 0 && !uuidd_cxt->quiet)
 				warnx(_("failed to open/lock clock counter"));
 			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
@@ -505,7 +519,8 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			break;
 		case UUIDD_OP_RANDOM_UUID:
 			num = 1;
-			if (__uuid_generate_time(uu, &num) < 0 && !uuidd_cxt->quiet)
+			ret = __uuid_generate_time_cont(uu, &num, uuidd_cxt->cont_clock_offset);
+			if (ret < 0 && !uuidd_cxt->quiet)
 				warnx(_("failed to open/lock clock counter"));
 			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
@@ -515,7 +530,8 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			reply_len = sizeof(uu);
 			break;
 		case UUIDD_OP_BULK_TIME_UUID:
-			if (__uuid_generate_time(uu, &num) < 0 && !uuidd_cxt->quiet)
+			ret = __uuid_generate_time_cont(uu, &num, uuidd_cxt->cont_clock_offset);
+			if (ret < 0 && !uuidd_cxt->quiet)
 				warnx(_("failed to open/lock clock counter"));
 			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
@@ -567,6 +583,27 @@ static void __attribute__ ((__noreturn__)) unexpected_size(int size)
 	errx(EXIT_FAILURE, _("Unexpected reply length from server %d"), size);
 }
 
+static uint32_t parse_cont_clock(char *arg)
+{
+	uint32_t min_val = 60,
+		 max_val = (3600 * 24 * 365),
+		 factor = 1;
+	char *p = &arg[strlen(arg)-1];
+
+	if ('h' == *p) {
+		*p = '\0';
+		factor = 3600;
+		min_val = 1;
+	}
+	if ('d' == *p) {
+		*p = '\0';
+		factor = 24 * 3600;
+		min_val = 1;
+	}
+	return factor * str2num_or_err(optarg, 10, _("failed to parse --cont-clock/-C"),
+				       min_val, max_val / factor);
+}
+
 static void parse_options(int argc, char **argv, struct uuidd_cxt_t *uuidd_cxt,
 			  struct uuidd_options_t *uuidd_opts)
 {
@@ -581,6 +618,7 @@ static void parse_options(int argc, char **argv, struct uuidd_cxt_t *uuidd_cxt,
 		{"no-pid", no_argument, NULL, 'P'},
 		{"no-fork", no_argument, NULL, 'F'},
 		{"socket-activation", no_argument, NULL, 'S'},
+		{"cont-clock", optional_argument, NULL, 'C'},
 		{"debug", no_argument, NULL, 'd'},
 		{"quiet", no_argument, NULL, 'q'},
 		{"version", no_argument, NULL, 'V'},
@@ -596,9 +634,15 @@ static void parse_options(int argc, char **argv, struct uuidd_cxt_t *uuidd_cxt,
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 	int c;
 
-	while ((c = getopt_long(argc, argv, "p:s:T:krtn:PFSdqVh", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "p:s:T:krtn:PFSC::dqVh", longopts, NULL)) != -1) {
 		err_exclusive_options(c, longopts, excl, excl_st);
 		switch (c) {
+		case 'C':
+			if (optarg != NULL)
+				uuidd_cxt->cont_clock_offset = parse_cont_clock(optarg);
+			else
+				uuidd_cxt->cont_clock_offset = 7200; /* default 2h */
+			break;
 		case 'd':
 			uuidd_cxt->debug = 1;
 			break;
@@ -673,7 +717,7 @@ int main(int argc, char **argv)
 	char		*cp;
 	int		ret;
 
-	struct uuidd_cxt_t uuidd_cxt = { .timeout = 0 };
+	struct uuidd_cxt_t uuidd_cxt = { .timeout = 0, .cont_clock_offset = 0 };
 	struct uuidd_options_t uuidd_opts = { .socket_path = UUIDD_SOCKET_PATH };
 
 	setlocale(LC_ALL, "");
-- 
2.32.1 (Apple Git-133)

