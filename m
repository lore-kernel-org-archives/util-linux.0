Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A37E1
	for <util-linux@vger.kernel.org>; Sat, 21 Jun 2025 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535489; cv=none; b=bS5yhQjcGnBeCZHLp37qTQYKwApgZ6g68I8BbTVFbDkE/QnwLGnH1Xv76eKEjACmoB4+wt8D3NLg6g/2m1GjziqggAuzXGwHSKX2KSsIufOK+uNjHmmUCzW7x0IfOXJ5lPxfiX0fAeo5gwGqJMzNanvJ5A/GBe8JRuINVjpU2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535489; c=relaxed/simple;
	bh=BPg884UmuIsUxjNu5/wXMDI0M81T6wTCkaYCK+yCUsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZ9VAURUrZ1jwZUiSiwOJpeuX0Xude4aS0/YS1dsHZaQrKaJPB0syG7GTAkcCQGW1sk9utMgnVRAFnahlVoTRxPpynOb4f5BjB8k3/BUqOCpNqjug7maV5o94Myds0ba+X9fEnQHQVNCxO/TPs+91dD2Ivv/DFay54AAq6Tb1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OzUSCj9Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OzUSCj9Z"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LIt21s007478;
	Sat, 21 Jun 2025 19:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MVyCyzbwaKlrUd9QO
	zHjVKSLxcudoKpG/jbRVrH38ps=; b=OzUSCj9ZfV+cmmWcYfY32QmFMqT29IJ/n
	2un0WDbLSOCrMDFBBGm2UGdmWFV/MXMc4bQo4QSTQhcnl3VcEnWd76GIfwnQGfnt
	MrpCW8L9f6ztTRdMVRzPR48BE7YMr8oNJ0WBJ1F2IKKUxVJWjoqIlapi4akeqrAS
	RALlFcG9TVhsgRZ0bfrKx8Gq7SaG/GuZIRHEG3ZNmiPhqSKUoQST7cYaPKbEGlFV
	rhe7arqxxWKt+xyjhqCSH5ym3Tq7GMrbSakPHRgJpd4n9f8WpvvxYjs4RChJ3OuA
	ARTUTbuYf9wk9ZSRUVn6X3NzjvjWfeLrnfcNII1P3jAYY/gp6RT5g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5taugn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:51:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55LJoaZW014199;
	Sat, 21 Jun 2025 19:51:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47dnndjmhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:51:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55LJpHkN18284838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 19:51:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B4C72004B;
	Sat, 21 Jun 2025 19:51:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A21C20043;
	Sat, 21 Jun 2025 19:51:13 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.73.245])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Jun 2025 19:51:12 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v4 3/3] chrt: Make priority optional for policies that don't use it
Date: Sun, 22 Jun 2025 01:20:48 +0530
Message-ID: <20250621195048.24900-4-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621195048.24900-1-vineethr@linux.ibm.com>
References: <20250621195048.24900-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J54Os77MBmy9vXIsqfyPaPNNjdxU1BaF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDEyNiBTYWx0ZWRfX3aePhjLGm+7q QS1bBGidKCekLJmkxkAb44VJV6PinOMrJxhztP11ralHCwUHStLkoJWWanfQDwnGNZkk7B8d3uO 5UnOu34pQL8wAXSHY92kJNInOy0VaNw3cds9gw/v9MtSfzUScM+pYoUSQkTQ0mWTir5CU3fRTVB
 zYLyc1P9hdT9qc5C+am/nraxL+4YOEVND1zq6t3HSHkrXiTLAPR/RA/r5/LE22eO1GFyDtQAS3T BEefEIaex0aO724n/w2gSBlop1g6MA2WT2IG7VP3pj8W4HuOFR6P/kxhgNqUuQsz8IRnNvBReRr eA9NOJc44VFn1169gktGDJDv/mlnFmWQNwDIt0Ks+LFGKKui3x3BgW3z+zLYRiCXJ3cnwM8+2PR
 +hDPWGVMRAygo5qvjLfveY7mr57brDSlPdKvBLo7WEaE7FfqBL8c0Pq+aNkv9NjmrEtCt8mb
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=68570d37 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=cqTbQZi6B89QFjwaFWcA:9
X-Proofpoint-GUID: J54Os77MBmy9vXIsqfyPaPNNjdxU1BaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210126

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
index d694845ac..0bcdd1a1e 100644
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
 
 	/* pid exists but priority not given */
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

