Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDC21FF48
	for <util-linux@vger.kernel.org>; Sat, 21 Jun 2025 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750533641; cv=none; b=bLAN1mh7ZgEarzYWDZZrIdny2f3CWG3jvW2JgKMq+7qRDGxpTkdWuQmr8tBnOHHTXXb5fWViZsUE4K8ZACWTygcRuxI5mcn3ib/HvoV7aN29aXdfwQVi5ZBW7fVp8OAme+T2TIOcyIguuKvvuMEciH1l+lG0Oj6FjhgADoDq8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750533641; c=relaxed/simple;
	bh=EwzegaH4o+3czJTa5JzdRx9wXaFfpI1MpYJxrEa+C6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbaJGLJ5qmO7gjjbngXHeAb533Eq655vF8A4iMAlqw6I6CZEV3sVl0Qz5AIEr0JZM8rJGCBel0RULJoA1v6mPH8RcgWribiUrga3XVHQmAikvtsKxv3CJOfmXfiuCYbLRAuW4irnIMVgOZqN4nz3hnX6QUXc0SPhPngtvZJIhTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ln8laXUI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ln8laXUI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L2wQqR016367;
	Sat, 21 Jun 2025 19:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oD/WJkwQr15/xh6BX
	zzvmjGtlpd0WszgVuwoHR5CtG0=; b=Ln8laXUIjt/ui9BqLCZ57uxHvwQvFg/M6
	NHP/2IT0KxmLKgmokI7yzEO/wXVUGp2SskgPMS7d4Eus6CHTg2HVkE0IMzSIysrv
	ay28XSaTfkwRmb8lpVf+kDy4elsVhRzrr5pqQaJx/MTn0Bvoz403y2fjcybtJfAD
	A2gnmDebEaSx7cptg1skH7opkBUOU2VCKilzGkIdELmoz3JdhI65MwffXZzWQXbB
	tHtNNpdXZ37kdfXOR1deQmx/22fU2Bcei1yxb4Sou8OjRiJUoZTf94FnR1kEW0PA
	vsSrqCU9+0R+7MJBpEKjhcJ8jNVya/n76D3G03h1oC5lEWqnyVBCA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme0tf34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:20:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55LEpoV2014138;
	Sat, 21 Jun 2025 19:20:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47dnndjj4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:20:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55LJKSCX46006770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 19:20:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5254120040;
	Sat, 21 Jun 2025 19:20:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41E0920043;
	Sat, 21 Jun 2025 19:20:25 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.73.245])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Jun 2025 19:20:24 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v3 3/3] chrt: Make priority optional for policies that don't use it
Date: Sun, 22 Jun 2025 00:49:56 +0530
Message-ID: <20250621191956.21142-4-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621191956.21142-1-vineethr@linux.ibm.com>
References: <20250621191956.21142-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685705ff cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=cqTbQZi6B89QFjwaFWcA:9
X-Proofpoint-GUID: I7fXm6qJSn_KEnB3hcoB8uXESzv-BDcb
X-Proofpoint-ORIG-GUID: I7fXm6qJSn_KEnB3hcoB8uXESzv-BDcb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDEyMiBTYWx0ZWRfXycscCHoHlHoY PjRtDyqwfWoljGSPkuD/pEilRsYi7OucZzGmEiO5vFrZpcvBwgZgXbwkgEK2qOxEUs7CCpLQtX8 vofdwJ9ch6sy56vJY4KIAXNyLDrMtjLKF5wU7yiYPSjv0M2UnvIwmHdIXiBlrxiLMHd/oKqfM6M
 7xpANZ5BaxSwRBj8H2IyO9bHNKutnBu3qI+nxs+/1zpvFIWuU/XnAhk1A8vAzV42QomkY8Z8j/q 7BRCFN+kCqewA6pwYgdl9qagdL2rExVZhuicRme1HfDlU0HvcE2j9erV1VghaYYN4NS2R3iXmhZ 0mb5qbe3XcQ0QZO8tIBh7+EvRho42XGttHkDpmYJoe1fz7kyqNRKk05Vm3HxDznyzRDfS3zIpW/
 z9e3YFvAlIPSalQ/P3wVJd67a6aFUYn0LxTkZg42wcFu6r98zqX51mdoBspaswhYl7Cu3TAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210122

Currently, chrt requires a priority argument even for scheduling
policies like SCHED_OTHER and SCHED_BATCH, which ignore it.

This change relaxes that requirement. Now, priority is only expected
for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
is set internally and no argument is required on the command line.

This simplifies usage when modifying runtime parameters like
--sched-runtime for non-realtime tasks.

For example, to change the EEVDF tunable base_slice, one currently
needs to run:
chrt -o -T 1000000 --pid 0 $PID

Passing '0' after --pid is not intutive and not required as priority
is not applicable to SCHED_OTHER tasks. Now with this patch, one can do:
chrt -o -T 1000000 --pid $PID

Passing '0' still works ensuring ABI doesn't break.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 schedutils/chrt.1.adoc | 14 +++++++++-----
 schedutils/chrt.c      | 24 ++++++++++++++++--------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index 36cdcc5fe..5b8d7e832 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -49,7 +49,7 @@ chrt - manipulate the real-time attributes of a process
 == POLICIES
 
 *-o*, *--other*::
-Set scheduling policy to *SCHED_OTHER* (time-sharing scheduling). This is the default Linux scheduling policy.
+Set scheduling policy to *SCHED_OTHER* (time-sharing scheduling). This is the default Linux scheduling policy. Since util-linux v2.42, the priority argument is optional; if specified, it must be set to zero.
 
 *-f*, *--fifo*::
 Set scheduling policy to *SCHED_FIFO* (first in-first out).
@@ -58,16 +58,16 @@ Set scheduling policy to *SCHED_FIFO* (first in-first out).
 Set scheduling policy to *SCHED_RR* (round-robin scheduling). When no policy is defined, the *SCHED_RR* is used as the default.
 
 *-b*, *--batch*::
-Set scheduling policy to *SCHED_BATCH* (scheduling batch processes). Linux-specific, supported since 2.6.16. The priority argument has to be set to zero.
+Set scheduling policy to *SCHED_BATCH* (scheduling batch processes). Linux-specific, supported since 2.6.16. Since util-linux v2.42, the priority argument is optional; if specified, it must be set to zero.
 
 *-i*, *--idle*::
-Set scheduling policy to *SCHED_IDLE* (scheduling very low priority jobs). Linux-specific, supported since 2.6.23. The priority argument has to be set to zero.
+Set scheduling policy to *SCHED_IDLE* (scheduling very low priority jobs). Linux-specific, supported since 2.6.23. Since util-linux v2.42, the priority argument is optional; if specified, it must be set to zero.
 
 *-d*, *--deadline*::
-Set scheduling policy to *SCHED_DEADLINE* (sporadic task model deadline scheduling). Linux-specific, supported since 3.14. The priority argument has to be set to zero. See also *--sched-runtime*, *--sched-deadline* and *--sched-period*. The relation between the options required by the kernel is runtime <= deadline <= period. *chrt* copies _period_ to _deadline_ if *--sched-deadline* is not specified and _deadline_ to _runtime_ if *--sched-runtime* is not specified. It means that at least *--sched-period* has to be specified. See *sched*(7) for more details.
+Set scheduling policy to *SCHED_DEADLINE* (sporadic task model deadline scheduling). Linux-specific, supported since 3.14. Since util-linux v2.42, the priority argument is optional; if specified, it must be set to zero. See also *--sched-runtime*, *--sched-deadline* and *--sched-period*. The relation between the options required by the kernel is runtime <= deadline <= period. *chrt* copies _period_ to _deadline_ if *--sched-deadline* is not specified and _deadline_ to _runtime_ if *--sched-runtime* is not specified. It means that at least *--sched-period* has to be specified. See *sched*(7) for more details.
 
 *-d*, *--ext*::
-Set scheduling policy to *SCHED_EXT* (BPF program-defined scheduling). Linux-specific, supported since 6.12. The priority argument has to be set to zero.
+Set scheduling policy to *SCHED_EXT* (BPF program-defined scheduling). Linux-specific, supported since 6.12. Since util-linux v2.42, the priority argument is optional; if specified, it must be set to zero.
 
 == SCHEDULING OPTIONS
 
@@ -132,6 +132,10 @@ Reset priorities to default for a process{colon}::
 ____
 *chrt -o --pid 0* _PID_
 ____
+Set a custom slice of 1 ms for a SCHED_OTHER task (priority is optional for policies other than SCHED_FIFO and SCHED_RR){colon}::
+____
+*chrt -o -T 1000000 --pid* _PID_
+____
 See *sched*(7) for a detailed discussion of the different scheduler classes and how they interact.
 
 == PERMISSIONS
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 40a006040..04582ae72 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -399,7 +399,7 @@ int main(int argc, char **argv)
 {
 	struct chrt_ctl _ctl = { .pid = -1, .policy = SCHED_RR }, *ctl = &_ctl;
 	int c;
-	bool policy_given = false;
+	bool policy_given = false, need_prio = false;
 
 	static const struct option longopts[] = {
 		{ "all-tasks",  no_argument, NULL, 'a' },
@@ -455,6 +455,7 @@ int main(int argc, char **argv)
 		case 'f':
 			ctl->policy = SCHED_FIFO;
 			policy_given = true;
+			need_prio = true;
 			break;
 		case 'R':
 			ctl->reset_on_fork = 1;
@@ -480,6 +481,7 @@ int main(int argc, char **argv)
 		case 'r':
 			ctl->policy = SCHED_RR;
 			policy_given = true;
+			need_prio = true;
 			break;
 		case 'v':
 			ctl->verbose = 1;
@@ -503,29 +505,35 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (((ctl->pid > -1) && argc - optind < 1) ||
-	    ((ctl->pid == -1) && argc - optind < 2)) {
+	if (((ctl->pid > -1) && argc - optind < (need_prio ? 1 : 0)) ||
+	    ((ctl->pid == -1) && argc - optind < (need_prio ? 2 : 1))) {
 		warnx(_("bad usage"));
 		errtryhelp(EXIT_FAILURE);
 	}
 
 	/*pid exists but priority not given*/
 	if (ctl->pid > -1 && argc - optind == 1) {
-		/* Error if a policy was specified but no priority given */
-		if (policy_given)
+		/* Error if priority is missing for a policy that requires it */
+		if (policy_given && need_prio)
 			errx(EXIT_FAILURE, ("policy %s requires a priority argument"),
 						get_policy_name(ctl->policy));
 
 		/* If no policy specified, show current settings */
-		show_sched_info(ctl);
-		return EXIT_SUCCESS;
+		if (!policy_given) {
+			show_sched_info(ctl);
+			return EXIT_SUCCESS;
+		}
 	}
 
 	if (ctl->verbose)
 		show_sched_info(ctl);
 
 	errno = 0;
-	ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
+
+	if (need_prio || argc - optind == 2)
+		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
+	else
+		ctl->priority = 0;
 
 	if (ctl->runtime && !supports_runtime_param(ctl->policy))
 		errx(EXIT_FAILURE, _("--sched-runtime option is supported for %s"),
-- 
2.49.0

