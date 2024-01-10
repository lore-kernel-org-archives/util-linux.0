Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587504D102
	for <util-linux@vger.kernel.org>; Wed, 10 Jan 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b="S2vnZpYn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXyhV+1s8S9YCIwzer8HD8+PsdcFqhZBYafEYuhBtWfPTNjcaOKhA9DPP2Idq7zAhCxpOU6T0lXUgkk6LQ0yvTqmHqm5OyQhk4sWPdLnU3H7QgnjKP35gRNj6K+sDO7oiIQdIsw+Yi6i7ZpT+CxWMfKyeelis2ImIOOq/AHcLXcx+LmJ9TOQwYNL9MYbl9yH/3NH8F6ldCxNQoNymxGW6rD3ASDBYdQLwzjbrDavYaPNQIAjxAGhQ5LZ4vdUMIxOJWgYh/Kc0N18DtzHHMSicT0UfKivzzYo5TYYMccKO691oTrtAFS9RisZqJqYKLIuqRvXxApIIJM9TknJZQDpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5UGFa8FTyUCtMoYhtZPDOJs4BjrTRM36DJs+64Wx1s=;
 b=i+2gSL66QnwUkKw4D8R09xtKdHkb6oCH1i6Lp7HL62+++FBAYxbFf0R3t3fMbB9m6XTuCVIIsht7Fx64C9rH3AGGplWIPfDPFDgKnsCgpwS+O7sqwt8w3apG/ta/tXocI3RvjYqI/Tvtrb+ddFwx6Lq3tovitwZXoRMF+/ON4N4E+/0gXc24kxPvY0IhwpiJvRc0TgJpq3mwBKPQgjeUMgNVlcg2KUhuC2zCxnI1sD7GJMMW8+lCJRILryVy1kaLjlWbADDX+BTutLA9SfswVpVV7U5Rox52Mi0FB+SLW/pm8QPF40TdXQV3vhElhlBTeeJJ7MXJFg1Hl7aILrkSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 155.56.68.180) smtp.rcpttodomain=redhat.com smtp.mailfrom=sap.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=sap.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5UGFa8FTyUCtMoYhtZPDOJs4BjrTRM36DJs+64Wx1s=;
 b=S2vnZpYnm41GDXUwKA7qrK61XeM8N2MrnLeObRbspClatuaXKHb/l321SZLnepNyQk6QOiKlCrumv9LypEqI0h0jSXzKOYVe/u0Ri9AJwDcUjKUfgIAqLWPStpAaGUAaCG8MlaCdLFT65EY1L/zAV6E42wNDwnAa3ujlPv333RI1E9XD1YT9gst6GFnxktkAEEB4DF+g1o0PRC+y05ylXA0U+SrAjXoAS082MGez4vL9hXyl5lMPrHDu3gZZpclElocBgcz6eQFc08n1EyKA7AuBXjmFYwHvpuaJv7Day6MesB6OHlMdvFoeFajYXhgtlp5GUshjJg8atLvlUmMt1g==
Received: from DUZPR01CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::20) by PAXPR02MB7886.eurprd02.prod.outlook.com
 (2603:10a6:102:276::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.26; Wed, 10 Jan
 2024 16:29:40 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::29) by DUZPR01CA0050.outlook.office365.com
 (2603:10a6:10:469::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Wed, 10 Jan 2024 16:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 155.56.68.180)
 smtp.mailfrom=sap.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sap.com;
Received-SPF: Pass (protection.outlook.com: domain of sap.com designates
 155.56.68.180 as permitted sender) receiver=protection.outlook.com;
 client-ip=155.56.68.180; helo=smtpdem01.smtp.sap-ag.de; pr=C
Received: from smtpdem01.smtp.sap-ag.de (155.56.68.180) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 16:29:40 +0000
From: Michael Trapp <michael.trapp@sap.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH v2] uuidd: add cont_clock persistence
Date: Wed, 10 Jan 2024 17:29:38 +0100
Message-Id: <20240110162938.20672-1-michael.trapp@sap.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B88:EE_|PAXPR02MB7886:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6cd57335-8822-4c86-5e11-08dc11f9585b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E9+eZ4wtt/tHTGtHHj2seUCRS/s11dfgn4Ly3G3PArC7xwWmHk2D10IkM8aeOeG/1I4v5OUfTUAFP/PqIZgjO2zFGBchlfnW3YGsIndGBp38CDLWnGgOWGbC6ur6u/gNP0tATjjW1YYvfiasdzzPp6cHl1hboGCMR6c1GuoH1Ornd4NxfDGdt/B3G5d0hS0laxClFw1qO+m0aXTPy96lqgmlKSOd3/5kFK/3/jkxjC8THKCxgf7ACaJaUfaAlOj+HEcRkxYnqQdWkDG4CgW5NODfz4Q/7TlwRvubufxeagdMDCXD6S9jfyVrlG1ewVqTf4grv+QsLxt7OYmrN+Rxg8jTnRhfgneMZPmzLCWpSJo15qLcWRRh4XoH9TtRmKec4UC4HJy8dy178EqQ3PQdM4RCaENjC4Q9ymNxq7oKSO09IOeYuT1t4Wa0oMNd5rT5smkwH+nEox0Newm5Lwkb+q0Ezx51rRkpuiH4U6sEcHcdUDCJf3luRliI2SNxsBozlLESMfZCl0979pftE7Y3gEN6p1MZZa20gik1PnAmHljsAiKDCXf1TpGMj0pJ+jpQsa1/X7hHtOWulJ6GAkAoLG3TJqs26zfbmHxSI65z3xNHZVRIL87VD0IYOelhWJZh8Ib6q/nBzsM8sVpfc9viow6ImoajGhQzylt3mEcAC2NSM+zBi3GF/8l7y2O8WxPdtZ8GXHtkL223xfH7+THs1I2CelgaKuTdssbIdpKv1s5Zsyg56sYs9FHyFdjmwTKB
X-Forefront-Antispam-Report:
	CIP:155.56.68.180;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpdem01.smtp.sap-ag.de;PTR:smtpdem01.mail.net.sap;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(47076005)(9316004)(86362001)(82960400001)(36756003)(81166007)(356005)(36860700001)(82740400003)(8676002)(4326008)(83380400001)(2616005)(1076003)(956004)(26005)(336012)(6512007)(6506007)(6916009)(6486002)(70206006)(316002)(36736006)(44832011)(478600001)(41300700001)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:29:40.5742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd57335-8822-4c86-5e11-08dc11f9585b
X-MS-Exchange-CrossTenant-Id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=42f7676c-f455-423c-82f6-dc2d99791af7;Ip=[155.56.68.180];Helo=[smtpdem01.smtp.sap-ag.de]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7886

cont_clock requires a correct time setup and therefore it
must be possible to detect a step back between uuidd starts.

Reserving the next 10 seconds is sufficient and should not
have a noticeable performance impact. It will also provide
the possibility to start with the clock_reg from the previous
session when the system was rebooted.

Whith that, the early cont_clock initialization in uuidd
should be removed because writing the cont_clock persitence
when -C was not set is useless and might be confusing.
---
 libuuid/src/gen_uuid.c | 120 ++++++++++++++++++++++++++++++-----------
 libuuid/src/uuidP.h    |   1 +
 misc-utils/uuidd.c     |   9 ----
 3 files changed, 90 insertions(+), 40 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 826cd2245..79e5e285c 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -207,6 +207,28 @@ static int get_node_id(unsigned char *node_id)
 	return 0;
 }
 
+enum { STATE_FD_ERROR = -1, STATE_FD_INIT = -2 };
+
+static int state_fd_init(const char *clock_file, FILE **fp)
+{
+	mode_t save_umask;
+	int state_fd;
+	FILE *state_f;
+
+	save_umask = umask(0);
+	state_fd = open(clock_file, O_RDWR|O_CREAT|O_CLOEXEC, 0660);
+	(void) umask(save_umask);
+	if (state_fd != -1) {
+		state_f = fdopen(state_fd, "r+" UL_CLOEXECSTR);
+		if (!state_f) {
+			close(state_fd);
+			state_fd = STATE_FD_ERROR;
+		} else
+			*fp = state_f;
+	}
+	return state_fd;
+}
+
 /* Assume that the gettimeofday() has microsecond granularity */
 #define MAX_ADJUSTMENT 10
 /* Reserve a clock_seq value for the 'continuous clock' implementation */
@@ -223,32 +245,16 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 {
 	THREAD_LOCAL int		adjustment = 0;
 	THREAD_LOCAL struct timeval	last = {0, 0};
-	THREAD_LOCAL int		state_fd = -2;
+	THREAD_LOCAL int		state_fd = STATE_FD_INIT;
 	THREAD_LOCAL FILE		*state_f;
 	THREAD_LOCAL uint16_t		clock_seq;
 	struct timeval			tv;
 	uint64_t			clock_reg;
-	mode_t				save_umask;
 	int				ret = 0;
 
-	if (state_fd == -1)
-		ret = -1;
+	if (state_fd == STATE_FD_INIT)
+		state_fd = state_fd_init(LIBUUID_CLOCK_FILE, &state_f);
 
-	if (state_fd == -2) {
-		save_umask = umask(0);
-		state_fd = open(LIBUUID_CLOCK_FILE, O_RDWR|O_CREAT|O_CLOEXEC, 0660);
-		(void) umask(save_umask);
-		if (state_fd != -1) {
-			state_f = fdopen(state_fd, "r+" UL_CLOEXECSTR);
-			if (!state_f) {
-				close(state_fd);
-				state_fd = -1;
-				ret = -1;
-			}
-		}
-		else
-			ret = -1;
-	}
 	if (state_fd >= 0) {
 		rewind(state_f);
 		while (flock(state_fd, LOCK_EX) < 0) {
@@ -256,11 +262,13 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 				continue;
 			fclose(state_f);
 			close(state_fd);
-			state_fd = -1;
+			state_fd = STATE_FD_ERROR;
 			ret = -1;
 			break;
 		}
-	}
+	} else
+		ret = -1;
+
 	if (state_fd >= 0) {
 		unsigned int cl;
 		unsigned long tv1, tv2;
@@ -355,44 +363,94 @@ static uint64_t get_clock_counter(void)
 /*
  * Get continuous clock value.
  *
- * Return -1 if there is no further clock counter available,
+ * Return -1 if there is no valid clock counter available,
  * otherwise return 0.
  *
  * This implementation doesn't deliver clock counters based on
  * the current time because last_clock_reg is only incremented
  * by the number of requested UUIDs.
  * max_clock_offset is used to limit the offset of last_clock_reg.
+ * used/reserved UUIDs are written to LIBUUID_CLOCK_CONT_FILE.
  */
 static int get_clock_cont(uint32_t *clock_high,
 			  uint32_t *clock_low,
 			  int num,
 			  uint32_t max_clock_offset)
 {
-	/* 100ns based time offset according to RFC 4122. 4.1.4. */
+	/* all 64bit clock_reg values in this function represent '100ns ticks'
+	 * due to the combination of tv_usec + MAX_ADJUSTMENT */
+
+	/* time offset according to RFC 4122. 4.1.4. */
 	const uint64_t reg_offset = (((uint64_t) 0x01B21DD2) << 32) + 0x13814000;
 	static uint64_t last_clock_reg = 0;
-	uint64_t clock_reg;
+	static uint64_t saved_clock_reg = 0;
+	static int state_fd = STATE_FD_INIT;
+	static FILE *state_f = NULL;
+	uint64_t clock_reg, next_clock_reg;
 
-	if (last_clock_reg == 0)
-		last_clock_reg = get_clock_counter();
+	if (state_fd == STATE_FD_ERROR)
+		return -1;
 
 	clock_reg = get_clock_counter();
+
+	if (state_fd == STATE_FD_INIT) {
+		struct stat st;
+
+		state_fd = state_fd_init(LIBUUID_CLOCK_CONT_FILE, &state_f);
+		if (state_fd == STATE_FD_ERROR)
+			return -1;
+
+		if (fstat(state_fd, &st))
+			goto error;
+
+		if (st.st_size) {
+			rewind(state_f);
+			if (fscanf(state_f, "cont: %lu\n", &last_clock_reg) != 1)
+				goto error;
+		} else
+			last_clock_reg = clock_reg;
+
+		saved_clock_reg = last_clock_reg;
+	}
+
 	if (max_clock_offset) {
-		uint64_t clock_offset = max_clock_offset * 10000000ULL;
-		if (last_clock_reg < (clock_reg - clock_offset))
-			last_clock_reg = clock_reg - clock_offset;
+		uint64_t co = 10000000ULL * (uint64_t)max_clock_offset;	// clock_offset in [100ns]
+
+		if ((last_clock_reg + co) < clock_reg)
+			last_clock_reg = clock_reg - co;
 	}
 
 	clock_reg += MAX_ADJUSTMENT;
 
-	if ((last_clock_reg + num) >= clock_reg)
+	next_clock_reg = last_clock_reg + (uint64_t)num;
+	if (next_clock_reg >= clock_reg)
 		return -1;
 
+	if (next_clock_reg >= saved_clock_reg) {
+		uint64_t cl = next_clock_reg + 100000000ULL;	// 10s interval in [100ns]
+		int l;
+
+		rewind(state_f);
+		l = fprintf(state_f, "cont: %020lu                   \n", cl);
+		if (l < 30 || fflush(state_f))
+			goto error;
+		saved_clock_reg = cl;
+	}
+
 	*clock_high = (last_clock_reg + reg_offset) >> 32;
 	*clock_low = last_clock_reg + reg_offset;
-	last_clock_reg += num;
+	last_clock_reg = next_clock_reg;
 
 	return 0;
+
+error:
+	if (state_fd >= 0)
+		close(state_fd);
+	if (state_f)
+		fclose(state_f);
+	state_fd = STATE_FD_ERROR;
+	state_f = NULL;
+	return -1;
 }
 
 #if defined(HAVE_UUIDD) && defined(HAVE_SYS_UN_H)
diff --git a/libuuid/src/uuidP.h b/libuuid/src/uuidP.h
index 200702c1e..fef7e6cb5 100644
--- a/libuuid/src/uuidP.h
+++ b/libuuid/src/uuidP.h
@@ -40,6 +40,7 @@
 #include "uuid.h"
 
 #define LIBUUID_CLOCK_FILE	"/var/lib/libuuid/clock.txt"
+#define LIBUUID_CLOCK_CONT_FILE	"/var/lib/libuuid/clock-cont.txt"
 
 /*
  * Offset between 15-Oct-1582 and 1-Jan-70
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index fd121c5bc..42a252dd0 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -442,15 +442,6 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	pfd[POLLFD_SOCKET].fd = s;
 	pfd[POLLFD_SIGNAL].events = pfd[POLLFD_SOCKET].events = POLLIN | POLLERR | POLLHUP;
 
-	num = 1;
-	if (uuidd_cxt->cont_clock_offset) {
-		/* trigger initialization */
-		(void) __uuid_generate_time_cont(uu, &num, uuidd_cxt->cont_clock_offset);
-		if (uuidd_cxt->debug)
-			fprintf(stderr, _("max_clock_offset = %u sec\n"),
-				uuidd_cxt->cont_clock_offset);
-	}
-
 	while (1) {
 		ret = poll(pfd, ARRAY_SIZE(pfd),
 				uuidd_cxt->timeout ?
-- 
2.39.3 (Apple Git-145)

