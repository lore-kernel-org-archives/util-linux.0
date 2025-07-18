Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADC1BD9CE
	for <util-linux@vger.kernel.org>; Fri, 18 Jul 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865496; cv=none; b=c7u5iaCDVoQCUNaIW3yLI2tbZJAxo9bK4VlY5Yfsb5lgvkc6Kl8qzntvw+gpfFyxI4Xm9Bi5giNrL+ba/wQbULDHuiIYJdxBH82NMOInYJOcTu7CY4A7N4bbrQoPb5A3hwZpTS1x5yN7srJ6oVTYGlQ+CA/I7z2DtOzoAaU2eh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865496; c=relaxed/simple;
	bh=bVgpbQvVK6XnwdQNkBpGXjxtS+i+uo2aqEpElncy//8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qcv4GDAFiIdCw3o0w5nKfGN+dCl/ZWFPyfVcRtveT+PPsDdkIrAFaJv97XF2h05FXQerN5Fr/jg5JOkBeQDPuZgBfnr45ccjcGx3qRi5lLPJAtorXE2u2BEzp7+xH7pilLCoYVfU0EkTx5A2Tj6zb4iCrNmNn6noTOeX9oRVv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qv2vKRRW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qv2vKRRW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IAFn2j025766;
	Fri, 18 Jul 2025 19:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=NzXnQla2K90K3TFsYuwQgI1y/Aag
	1B+SslAkOB9Z8FY=; b=qv2vKRRWpTRFKPF5tPssSMh2m0q2PCjhMVJNzJE3jZV+
	iwqmsuWMQbHb6zdMp0yLdvPWPxvu7arjnny7kDYjJpolgodR6GCT6NdO1P5KEojd
	vV4GoS7mIPEybX8R5s62uYnK1c3LOzz2HMTUG8IDWiLjS3qlGxAa0KU1QNWEkJVk
	AFjt9AEjoV8C1y5a7BkhLm3EAfnx08f/W01N0hIIti7kRSRgPqt2pn1gkpIPDPct
	J7FiUiKqu/13dwr5SDxmt3heaSQrRkHC7KKk7uB9DKLWY7eiRPfbkT7IPl0nCnH1
	E4s+YwWmxhTkVSb7hRWAU7jyFLKT5sdjHu7ts0DvoQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4ujpwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 19:04:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56IIJr6M008957;
	Fri, 18 Jul 2025 19:04:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hn2fm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 19:04:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56IJ4iFQ25494190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 19:04:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A04FE20049;
	Fri, 18 Jul 2025 19:04:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC9320040;
	Fri, 18 Jul 2025 19:04:43 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.81.165])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 19:04:43 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@telfort.nl>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH] =?UTF-8?q?chrt:=20Allow=20optional=20priority=20for=20non?= =?UTF-8?q?=E2=80=91prio=20policies=20without=20--pid?=
Date: Sat, 19 Jul 2025 00:34:39 +0530
Message-ID: <20250718190439.85359-1-vineethr@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=687a9acf cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=5KLPUuaC_9wA:10 a=VnNF1IyMAAAA:8 a=9y1XwtaTfkTAvFIt2n8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: J1o0wkOTeGPsF5MjcngDKoUZdD-potWc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0OSBTYWx0ZWRfX3fgZAIvw8CnS 5cNf23peTsmrNFHUjGT361NjLBV7II+Ge4UhgJj/icUCMWNG6x8xhaaMsD0OKN62ncIRgRgCtyq uSiWimLz8mjUynJR7qUQwSXvpn4XltSBvU4pgXQv4v+gjEC0S3VhASd99gwJiqC6NtTkhqF5JnB
 ixTBj9cAtY6vieHQBkxzO0h+YVhyuFvNQOpuRKGNPvbW8zw8c6HA2urp33R2YNGr7TV73olvOT4 W/zBJqKFhueOU0LrNcV0GF4EXqiQASxkmJ0aOGM4H+S/4524BXtaf01ktFSBTfkHL9xcnbu7xwP g+sFPX1vO+y7nZdNAzKt0XkLB1ZX6M4Y5BVbdOuxcjDkX8KYjdhtnsBgirzcpc16dgPZCmbuiaa
 Grm0DYgr826RUlybTW4EsIGJVTja8pJuAxUOUvzRKNlGREReyNjt6cb7/UxzP6FaZq3IvE1q
X-Proofpoint-ORIG-GUID: J1o0wkOTeGPsF5MjcngDKoUZdD-potWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180149

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

Fixes: e7a2d62434c2 ("chrt: Make priority optional for policies that don't use it")
Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 schedutils/chrt.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 10ba7fbf6..44b9b9e20 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -395,6 +395,18 @@ static void set_sched(struct chrt_ctl *ctl)
 	ctl->altered = 1;
 }
 
+static bool is_number(const char *s)
+{
+	if (!s || *s == '\0')
+		return false;
+
+	for (const char *p = s; *p; p++) {
+		if (!isdigit((unsigned char)*p))
+			return false;
+	}
+	return true;
+}
+
 int main(int argc, char **argv)
 {
 	struct chrt_ctl _ctl = { .pid = -1, .policy = SCHED_RR }, *ctl = &_ctl;
@@ -503,7 +515,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (argc - optind < (ctl->pid == 0 ? 1 : 2)) {
+	if (argc - optind < 1) {
 		warnx(_("too few arguments"));
 		errtryhelp(EXIT_FAILURE);
 	}
@@ -527,7 +539,10 @@ int main(int argc, char **argv)
 	if (ctl->verbose)
 		show_sched_info(ctl);
 
-	if (argc - optind > 1) {
+	bool have_prio = need_prio ||
+		(ctl->pid == -1 ? (optind < argc && is_number(argv[optind])) : (argc - optind > 1));
+
+	if (have_prio) {
 		errno = 0;
 		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
 	} else
@@ -568,9 +583,19 @@ int main(int argc, char **argv)
 		show_sched_info(ctl);
 
 	if (!ctl->pid) {
-		argv += optind + 1;
-		if (strcmp(argv[0], "--") == 0)
+		argv += optind;
+
+		if (need_prio)
+			argv++;
+		else if (argv[0] && is_number(argv[0]))
+			argv++;
+
+		if (argv[0] && strcmp(argv[0], "--") == 0)
 			argv++;
+
+		if (!argv[0])
+			errx(EXIT_FAILURE, "Missing command to execute");
+
 		execvp(argv[0], argv);
 		errexec(argv[0]);
 	}
-- 
2.49.0

