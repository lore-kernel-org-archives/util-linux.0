Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83191495E1
	for <util-linux@vger.kernel.org>; Fri, 15 Dec 2023 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b="cL0XWEcU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTVQlT0bhV4O5xevjrZhK4jlqCdWfXA0077KihmUdlSeSKeS0Mrqq+ALfWN3FkMTcyx23FISovyANXsSzFIQQ7OLb8QNdIf+WugbhIpZwnIYPcK4DhbQRKslND8jrswFhHsiZ4pgRZFB9X6wwe2B8xUofkXaL1dzE7L9Il0QxVizi5/5M0TtX7THxEMQCnM7zeBTPlrcuVtcBZlxEW7L7G+s1IkXTAjX4xmDQmAoApUQXTBFudBVgnOj0yidLG5MUSqM2qtVdzl4n7YpOWVCpzNWKwNguypzN9egIZG+aF8a2hQZn2osUcgLyMCBM34/IbfBfd86By3OxOKLy0U13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Klar5CD+N2/kF/Tkni3d9tkFzRt+C0TgY6IjfGhNkQU=;
 b=C25LFITOMoDJce7rKE+elbywtDb38YToI0GawvPEPItxTlrzisATWHf8bVB0m2+zT/kzrQVjltQ6HpHOdQlydZF1WhX6qjC7nJ5WUO06Ae70mG8iAyO8h5OdUQSz86LkM57TK7in6mIWLkoCh0AvKNO4nUw4ZqeXODsJLWZqwfgIaEOAUHa0xMFuNZ4lxWZGYpOa4UK36qvKfytzgX3ktPg36X+4ufzNyGlHsv7PLBtLxksD53TRNMtfC7DOkm0AsgZDtQfKIK6nwdwfxJ3hi4nKHlvTCzFFdK9frC/ip2ZIKr1PvLCUHYYV4px4+0y9wftM6lETpJh0wuX/E5E1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 155.56.68.150) smtp.rcpttodomain=redhat.com smtp.mailfrom=sap.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=sap.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klar5CD+N2/kF/Tkni3d9tkFzRt+C0TgY6IjfGhNkQU=;
 b=cL0XWEcUtqdoykHy+crJIRRNRacIPU8s/AfF9x92aihLDrTpNKbpXh+Xk3xPIwGTiwS66JaJ/nDV5eeIZxQpCRb2GPR5+FPvNPkT8cYUW94vg50x3jGuJgbM+2axzPAHlg5GfZfgLl4vz/he8HdM3ZyStmUJXdLGS4/bki1yvso8p9ZpTBKBRD2I+HQPUrwQ2fU/anX9NYUiYqWiZO1tRVNSygn4qqcpyoulIM8kxqQlEd5uY4yGyOO+zIqT4wuwEpz9A9lKAMLtLmfBtYfE1emijo1LR+Hbvpnlt7p8K8wR3fwMhz3tFLurtNJME8nrol3K+N9Sw763iDbpFDD5uQ==
Received: from AS4PR10CA0018.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::12)
 by AM9PR02MB7106.eurprd02.prod.outlook.com (2603:10a6:20b:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Fri, 15 Dec
 2023 22:18:31 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::36) by AS4PR10CA0018.outlook.office365.com
 (2603:10a6:20b:5d8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33 via Frontend
 Transport; Fri, 15 Dec 2023 22:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 155.56.68.150)
 smtp.mailfrom=sap.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sap.com;
Received-SPF: Pass (protection.outlook.com: domain of sap.com designates
 155.56.68.150 as permitted sender) receiver=protection.outlook.com;
 client-ip=155.56.68.150; helo=smtpdem02.smtp.sap-ag.de; pr=C
Received: from smtpdem02.smtp.sap-ag.de (155.56.68.150) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 22:18:31 +0000
From: Michael Trapp <michael.trapp@sap.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH] uuidd: add cont_clock persistence
Date: Fri, 15 Dec 2023 23:18:29 +0100
Message-Id: <20231215221829.46932-1-michael.trapp@sap.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|AM9PR02MB7106:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9eae8158-05ba-4ac1-4e31-08dbfdbbc580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C97+hUSusTq1UNehocJ79R+dEABpu2FBDoy+RoNjqEjz9bv00Z5ICq90LuRXpTRWkSfPOLomwNk5yGFSLIgN4wr2ZCXe9qYYIe5mZ1oaWqa1OpClKOphZ6iyV46PzISv4rkyw1xQuIhLDY3FkaZK+3jN1wjbw0tWvKk+BvLtKcwhOmNEg6gkD1YDrm5qVGwexqAWroeewolPnP0jWTfy46NTsYt6jE9BD/ii/ecdhG3bg0+0m4GqYM68y7NGsIrRDjN5i3RSOPtU24KN5e9042loEnqxQiSVMrFk3iwE7ZMWvIbFQ/PpjjCleo2zfWw751vBXooGcy6Qh4TzD9P+1KwpE7cyhNH59fiNWdC3K+VUWlG2Mh0LAbJZChLCXuVLlTJfIDiW+qg7qiDtoorhaViDSUjnuRG82I+jKdFR7em5EY5lGezZlqfHlRLYgWp+QCkKqIP0whjc79iT2qDNvxnmT227JrN0NYLD9GpxZqpO+hftWioanMNhevATZs6VMc+6Uj78H0RooK5VuCJdPNubxN+UQKQSIberaE0zVCf646/aMEYqr1Ni3rvZDfInE9oGCw+z0zOcMeaacgbV2q1xytHge0swdXmCGCt20+0vIQXREVYFUjt8lEa03F91m9Gu7fF0HTHnpBt9w2WU/TwTq3foRi6koLtBwD20LuKOf2RSQ/km2lwmebyQGX3aEMapCefCRnrHLudQpDfz1z3O0OwxE7fHqKRosrfwlYcYt5vHvVfdEkQECjrFya9A
X-Forefront-Antispam-Report:
	CIP:155.56.68.150;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpdem02.smtp.sap-ag.de;PTR:smtpdem02.mail.net.sap;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(1076003)(26005)(336012)(956004)(2616005)(6512007)(6506007)(36860700001)(83380400001)(47076005)(5660300002)(44832011)(41300700001)(2906002)(478600001)(6486002)(9316004)(4326008)(8676002)(8936002)(70206006)(316002)(36736006)(6916009)(82740400003)(82960400001)(356005)(81166007)(36756003)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 22:18:31.6820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eae8158-05ba-4ac1-4e31-08dbfdbbc580
X-MS-Exchange-CrossTenant-Id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=42f7676c-f455-423c-82f6-dc2d99791af7;Ip=[155.56.68.150];Helo=[smtpdem02.smtp.sap-ag.de]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7106

cont_clock requires a correct time setup and therefore it
must be possible to detect a step back between uuidd starts.

Reserving the next 10 seconds in clock-cont.txt is sufficient
and should not have a noticeable performance impact.
It will also provide the possibility to start with the clock_reg
from the previous session when the system was rebooted.

Whith that, the early cont_clock initialization in uuidd
should be removed because writing the cont_clock persitence
when -C was not set is useless and might be confusing.
---
 libuuid/src/gen_uuid.c | 78 ++++++++++++++++++++++++++++++++++++------
 libuuid/src/uuidP.h    |  1 +
 misc-utils/uuidd.c     |  9 -----
 3 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 826cd2245..94b99f1bd 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -355,44 +355,102 @@ static uint64_t get_clock_counter(void)
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
+         * due to the combination of tv_usec + MAX_ADJUSTMENT */
+
+	enum { fd_init = -2, fd_error = -1 };
+	/* time offset according to RFC 4122. 4.1.4. */
 	const uint64_t reg_offset = (((uint64_t) 0x01B21DD2) << 32) + 0x13814000;
 	static uint64_t last_clock_reg = 0;
-	uint64_t clock_reg;
+	static uint64_t saved_clock_reg = 0;
+	static int state_fd = fd_init;
+	static FILE *state_f = NULL;
+	uint64_t clock_reg, next_clock_reg;
 
-	if (last_clock_reg == 0)
-		last_clock_reg = get_clock_counter();
+	if (state_fd == fd_error)
+		return -1;
 
 	clock_reg = get_clock_counter();
+
+	if (state_fd == fd_init) {
+		mode_t save_umask;
+		struct stat st;
+
+		save_umask = umask(0);
+		state_fd = open(LIBUUID_CLOCK_CONT_FILE, O_RDWR|O_CREAT|O_CLOEXEC, 0660);
+		(void) umask(save_umask);
+		if (state_fd == fd_error)
+			return -1;
+
+		state_f = fdopen(state_fd, "r+" UL_CLOEXECSTR);
+		if (!state_f)
+			goto error;
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
+	state_fd = fd_error;
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

