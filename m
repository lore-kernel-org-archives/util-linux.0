Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04A227EA8
	for <util-linux@vger.kernel.org>; Tue, 29 Jul 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782438; cv=none; b=tUcfjdp2p9whpAOUfbiZh6hAaXWYU2TMZDhw14ObhHPlcoXCnqUHyZ4E+Q/gQmcZrQsUSBCijl2QSCMardPppACD44cQviWMLOmsrTx5ICakR9gBr+Yi+2i/9xjrTa0bfxMj1OoSKCXDMRIKqKX+NZuJ/O21T31Nz9reOoeO93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782438; c=relaxed/simple;
	bh=DYN24NOCC64IF32sWpxJhSnZShqMTm7GERrC/1a+CtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HvLdy3Jse0pWw7Q2LRIU0twJ4aAf/6n86Tlbwe0ghYE+OzR25fwXkr7rTnuZfu7NaphJ3Nz0BGJBDh3QSI8vO89yfZC4D7R4DP3oPb49z6X6VrZvtZs7VJO3RWyJBbJYMa4cU40CPMlWHmzO3zu+yzWr3DHhTqI6FrZJ1fcesDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fdlFwxqX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fdlFwxqX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4Z4sr009162;
	Tue, 29 Jul 2025 09:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=8A4GpXt/KJsJVlHW8edjr6rFsaJQ
	rz1zG3Mkq3/a0cE=; b=fdlFwxqXWvsq5gk8quYMP0rFraDikYUcFt1NE73hJeer
	JVHPVh0q8BJt5x4LoipMPcfh6f0JKoFRMRLIhZO8y6wnpdAlzKr3/zf/pgCV7juU
	2zSX1tAB4guxlhSpcPZ+dol8ikTV6vH6zgFbho6s6XCGQQ6cUq5xq9MHlLkzrMJv
	e+FB4KU99b01OOXfYB6rMIfYdrW7IWFOp3xpfsbeegRZQfqGSXLUp5/OC2tztiBA
	Jfamp5wihAxFaZockKByV375mKTtftpq93nq1SIJf7fr7BAk94C3wa4DH8ha+X49
	srltQydhJFZg6R7S/43tn7jwux8d259YcNHgdwK/Hg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcfww4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 09:47:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7oB2O017959;
	Tue, 29 Jul 2025 09:47:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859bthyrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 09:47:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56T9l7KL49938752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:47:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE53120043;
	Tue, 29 Jul 2025 09:47:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2F7420040;
	Tue, 29 Jul 2025 09:47:05 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.in.ibm.com (unknown [9.204.207.125])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Jul 2025 09:47:05 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@telfort.nl>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v2] =?UTF-8?q?chrt:=20Allow=20optional=20priority=20for=20?= =?UTF-8?q?non=E2=80=91prio=20policies=20without=20--pid?=
Date: Tue, 29 Jul 2025 15:17:03 +0530
Message-ID: <20250729094703.62408-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA3NiBTYWx0ZWRfX0MFcdysIS5jU
 xIaK61IACEAwUyxeqR9yTfqNdjUpIhhLTbDkLL5TakxIo1Up0KG2dks/57sy7FmgbSVtju4zyLm
 iZ/iHDX4SB4oe6/0Jn4DBVEv//EKxmxPVXGpQW3ugJgYnUhuvqES+Xuudsy5J6vIAFzxV0WFQay
 3uclkqnBYvrR8RKxUM3PcoFAiUdpPQoeH1jYBNe26/8lEMbhEdW6OWLtxoG1oGqeRKQWQ0pJZf1
 vBeyM/s7cTOrPVr09LC32zKyzzk8yNuXJou1IUoXZkqvzwco6uARDNIKEalNnTBGHde2J9jFv7T
 Oo27HB9tKwWrbxLaMnwyYf+5Fhu3018pGSoeG6fKk0MINJh5VqvfG8mZJA+jQIF7DtqKY5uHw8X
 RY6aoH3/B59WU27Pa5dOP/n/jIvFWpApDqj6pkU0Fu2Umbk3kC+KmJeGpl2kCKX1jT6z5zWL
X-Proofpoint-ORIG-GUID: X4kAc9-0LBAZQr5SH6UZz2bcfyY7JMcL
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=6888989d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=5KLPUuaC_9wA:10 a=VnNF1IyMAAAA:8
 a=9y1XwtaTfkTAvFIt2n8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: X4kAc9-0LBAZQr5SH6UZz2bcfyY7JMcL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290076

This extends commit e7a2d62434c2
("chrt: Make priority optional for policies that don't use it")
so that priority arguments are optional even when --pid is not specified.

Before this patch:
$ chrt --other ls -lh
chrt: invalid priority argument: 'ls'
-> only "chrt --other 0 ls -lh" would work

After this patch:
$ chrt --other ls -lh
$ chrt --other 0 ls -lh
-> both now work

If an out‑of‑range priority is given, it reports an error:
$ chrt --other 1 ls -lh
unsupported priority value for the policy: 1 (see --max for valid range)

Changes in v2:
- Removed is_number() and used isdigit_string() (Karel Zak)
- used _() for translation (Karel Zak)

Fixes: e7a2d62434c2 ("chrt: Make priority optional for policies that don't use it")
Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 schedutils/chrt.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 10ba7fbf6..1a9522728 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -503,7 +503,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (argc - optind < (ctl->pid == 0 ? 1 : 2)) {
+	if (argc - optind < 1) {
 		warnx(_("too few arguments"));
 		errtryhelp(EXIT_FAILURE);
 	}
@@ -527,7 +527,10 @@ int main(int argc, char **argv)
 	if (ctl->verbose)
 		show_sched_info(ctl);
 
-	if (argc - optind > 1) {
+	bool have_prio = need_prio ||
+		(ctl->pid == -1 ? (optind < argc && isdigit_string(argv[optind])) : (argc - optind > 1));
+
+	if (have_prio) {
 		errno = 0;
 		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
 	} else
@@ -568,9 +571,19 @@ int main(int argc, char **argv)
 		show_sched_info(ctl);
 
 	if (!ctl->pid) {
-		argv += optind + 1;
-		if (strcmp(argv[0], "--") == 0)
+		argv += optind;
+
+		if (need_prio)
 			argv++;
+		else if (argv[0] && isdigit_string(argv[0]))
+			argv++;
+
+		if (argv[0] && strcmp(argv[0], "--") == 0)
+			argv++;
+
+		if (!argv[0])
+			errx(EXIT_FAILURE, _("no command specified"));
+
 		execvp(argv[0], argv);
 		errexec(argv[0]);
 	}
-- 
2.49.0

