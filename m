Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625F273D89
	for <util-linux@vger.kernel.org>; Tue, 17 Jun 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184658; cv=none; b=Tft+QTFks2wtTQNTsDnd5U2luXzgthVty27yu5kTz4232uCYrDXwnIrhLZmdd8RSMH5YJ7XtdNYKfhsfz0cj8Sa6HMHmhQKuqVxG2N4mOQZjn4w7v4fhSAqdvuAtYQtl1IS6F+7pPBGobQqkDUrtbVtM3SibMtz6uWvqqgxqrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184658; c=relaxed/simple;
	bh=hTUys3KrggyDL8WWy+md8qWB0aRyjqFui8MI39KWnZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQ//Y3g+Ie55yApm63IaczJzB+G3OVc58TLO9ltzVVxM3CSN6A6BSk2KkXIBDigFJVVnPQq816wZAGGPX7UKn+bRXapuL7IdN0UDm9qaF8UM0dlNLtxLY0yjcUOeIkyDOlWm8GreWatYYBp4MltqSzc4/ytdon/J+/rsKDxoO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aLkeQAxJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aLkeQAxJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HGPNBV028616;
	Tue, 17 Jun 2025 18:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=eE/giNmycWrMcvD8nn+Qz0yYVSe36Duuf1C7lZO6h
	k0=; b=aLkeQAxJjZ6BKQE1oUaWE99LjE78fKccjZ6AuBQtpKZNhX9xe5aOThvdb
	jMInRAxdZZTdUj6lEgXhQF87JkG2ORtm5Bb+wWucs1+5rWDbVV8sB0BIPf1qfIFP
	+dLUdMFPgjs4Xp75VsuZ811mYz5cC3GEamZUpg1kRv4QI6m6+MAIhQvG1Uda2WjP
	Vjjz3aO8vj+tAfXV97DinFHk7Tzyt2KU8CI++YzSZYZdPJhzIobGbgOwqW13fF2y
	HXTBls2xkc9SUs4Eun/5BgPvd8y2Jx0Z3ypM7j7lAEJNC6c1DbOo9/oRSGiTlMuw
	AIDYm3E5PKCadTZtB8dbJsz8VzAZg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r21qed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 18:24:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HHUevY014275;
	Tue, 17 Jun 2025 18:24:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p42cjyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 18:24:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HIO95545809934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 18:24:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC90A20043;
	Tue, 17 Jun 2025 18:24:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF60920040;
	Tue, 17 Jun 2025 18:24:07 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.86.67])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Jun 2025 18:24:07 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc: vineethr@linux.ibm.com
Subject: [PATCH v2] chrt: Make priority optional for policies that don't use it
Date: Tue, 17 Jun 2025 23:54:03 +0530
Message-ID: <20250617182403.47095-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U8HP807GuKNSSH5TSIIeUFosSmh7dsjM
X-Proofpoint-ORIG-GUID: U8HP807GuKNSSH5TSIIeUFosSmh7dsjM
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=6851b2ce cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=A4eX9DuJ0rwbDsMqQxcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE0NiBTYWx0ZWRfX+GAAZZGf+YYV uw+WudimPFsyVTYTvol/iK1f/QTOf9ISMQdh+NykCHy/b3XY0NYYGYZHyAB/fcjUjQGOP74Dklp WQpQWhTH/z71ccTv4vOi3lKzWS+lC5FztpSFoUDHoaIOpV+ItsRgeFujJv5z0TUeFXvHaDTRZef
 r3dglrRlNMul1uRZcGBvX4KGvQhnZH16jCPvTCzrPPjaih7TXq3JW6TyUOcrnDAvjToeAeczoVb 8J51WpKK59XAN5HI0YqYZJ/ZupHpTXz7/Xc1VJrEwEHHyLKr9EXBz+oaoWxFIuyJT/TJcvQATVw VJ6IunY6cLm2hd/Gb3PB4hnjMLpHKZlZ5j9RRa5NIwFKjfm0frUBaCrwPW9IU84bzB9mro/iKWI
 aN8t4vZz8H1xO57KUETMpjdtviVbEB53S+vIB+YqYeE+dFl9mgNngC73wF1gt7w76BazVggn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170146

Currently, chrt requires a priority argument even for scheduling
policies like SCHED_OTHER and SCHED_BATCH, which ignore it.

This change relaxes that requirement. Now, priority is only expected
for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
is set internally and no argument is required on the command line.

This simplifies usage when modifying runtime parameters like
--sched-runtime for non-realtime tasks.

For example, to change the EEVDF tunable base_slice, one currently
needs to run:
chrt -v -o -T 1000000 -p 0 $PID

Passing '0' after -p is not intutive and not required as priority is
not applicable to SCHED_OTHER tasks. Now with this patch, one can do:
chrt -v -o -T 1000000 -p $PID

Passing '0' still works ensuring ABI doesn't break.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
Changes in v2:
- Updated the man page to reflect the optional priority behavior (Karel Zak)
- Renamed variable to 'need_prio' (Karel Zak)

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 schedutils/chrt.1.adoc | 12 ++++++++----
 schedutils/chrt.c      | 16 +++++++++++-----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index 77add535d..4f419b5f6 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
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
 *chrt -o -p 0* _PID_
 ____
+Set a custom slice of 1 ms for a SCHED_OTHER task (priority is optional for policies other than SCHED_FIFO and SCHED_RR){colon}::
+____
+*chrt -o -T 1000000 -p* _PID_
+____
 See *sched*(7) for a detailed discussion of the different scheduler classes and how they interact.
 
 == PERMISSIONS
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index cf99935dc..eb1717acc 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -495,20 +495,26 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (((ctl->pid > -1) && argc - optind < 1) ||
-	    ((ctl->pid == -1) && argc - optind < 2)) {
+	bool need_prio = (ctl->policy == SCHED_FIFO || ctl->policy == SCHED_RR);
+
+	if (((ctl->pid > -1) && argc - optind < (need_prio ? 1 : 0)) ||
+	    ((ctl->pid == -1) && argc - optind < (need_prio ? 2 : 1))) {
 		warnx(_("bad usage"));
 		errtryhelp(EXIT_FAILURE);
 }
 
-	if ((ctl->pid > -1) && (ctl->verbose || argc - optind == 1)) {
+	if ((ctl->pid > -1) && (ctl->verbose || argc - optind == (need_prio ? 1 : 0))) {
 		show_sched_info(ctl);
-		if (argc - optind == 1)
+		if (argc - optind == (need_prio ? 1 : 0))
 			return EXIT_SUCCESS;
 	}
 
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

