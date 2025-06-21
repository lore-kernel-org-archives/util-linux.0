Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7841BD01F
	for <util-linux@vger.kernel.org>; Sat, 21 Jun 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534615; cv=none; b=ZicklJhmGvIZ4BSpWwbmCJfcxZIVJYseUTqTNt3NlHZwjSzkiOOEJo9zt+muNtgFMxgQ9B4HLFVC1UVWaG0bU6f4Mkz78oMmx/fLftcun0eIUsg592iCeFJCpG9DoOJbERo1mQcTeXFpdb5C1g+tyXJjRO/DoZyfe82KjqI6w90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534615; c=relaxed/simple;
	bh=d9fnS1I3aiOdOmaUFjGcgir+SMjaOTLEdg6ClzzQ8pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nU4HeCV6WFBa3YeRjF0t0SoGUcnNR4SNzySfQLfVhOWZtm0tMXgLcx4QV58UwSdiAjz+5mVCPdHVAcM/bMLXcj1zWScs5RSPlLb3thv04PCQxQu131dN6kKcq+Hy6I+1xYeMCZrO/sJZXW+tzXtEPn1k1CFIcsmHi9x4sYJ6T0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K3xHe4dT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K3xHe4dT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LCPtbw005178;
	Sat, 21 Jun 2025 19:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XijPVC
	SH+lUvTQi0aPMehY/jlp/KYojBYW1gLOQ7upM=; b=K3xHe4dTMTudH1EJW6T8Hl
	606cPHM6Qa3vEtjnNUcmJylb2gWFpF5FhaERPHpNLoleWmT7iAEooI/E4PG1zma2
	sgdG5d2n+rv5F5rz6R4U9dkmGrHGeC2ZYWO+awXVMo8hr9coszzd93Rs8D09nn6q
	7YeO1zJGpqU0Z4VfDFs18xxttt8qjkoUyVyWnHI1UajIJU39BcvlP3QjrgZMI79x
	msQNyDOnHXiWYVXjolq04jy6i3NwUrzUSiUuYaUtdPDtQFcJ02JSeQA8V9lnpra/
	Dd6mD8OrK5a2BF73IpsACmXY5VD6TDm8C+vX4VZvOWMXnLnxeOFOXOFfcVxkxurQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8htf7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:20:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55LEnTDI014156;
	Sat, 21 Jun 2025 19:20:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47dnndjj4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:20:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55LJKMit58851778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 19:20:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4762520040;
	Sat, 21 Jun 2025 19:20:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BA3720043;
	Sat, 21 Jun 2025 19:20:18 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.73.245])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Jun 2025 19:20:17 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v3 2/3] chrt: Only display current settings when no policy is specified
Date: Sun, 22 Jun 2025 00:49:55 +0530
Message-ID: <20250621191956.21142-3-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621191956.21142-1-vineethr@linux.ibm.com>
References: <20250621191956.21142-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDEyMiBTYWx0ZWRfX9/XyM5baLeFw GZiWix9YjUFxcOZnw4hMp4ZGJkXU2kXSv7RE96rRGNk6QU4M+nBSNabIuuPOZaRT3l+H0Sm7kXk XTfzhGG9GpjeYXbJ4EEpr5duq0sMok5TTlvMp+U67PxXcORTl/Y21utonpxSVFFCYgj08Knv5ot
 sJGiQAl+iEPGDdiflWdsWhHdM40PMt4/yhKDsNPpgaguTwoZjqIV4UGODuBUcC5mmDjHale+enZ AQm9IdvaAWqMLpg/OXBorHb4AAgRJwhRPdWB5fSO4kavihhYKs94Pv4UArHcTakNL+W7NAb0Vkq oVC05uCTCKLD7FyMUKIvAXCKfV7tAiSe4NvvLv2TFkN3pwcPRRA78Sw+pK3GoHiDnjb0qaGQIaR
 MPocBTpWPmUY7WN0rt9paMWKG1ezxLoxFwE0OUCfypfvaL3QQ7Uk8Fyn/yeB9DXmEneJvhBj
X-Proofpoint-GUID: CtAWIVefxOKOIh4I6dARMaSDmm2e2FYX
X-Proofpoint-ORIG-GUID: CtAWIVefxOKOIh4I6dARMaSDmm2e2FYX
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685705f9 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=EeF4qO850oZfgqQkHikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210122

Previously, running "chrt --pid <pid>" with no policy options
would display the process’s current scheduling attributes, but
specifying a policy without a priority (e.g. chrt --rr --pid <pid>)
would silently fallback to displaying the same info. This was
confusing, since a policy option normally implies an intent to
change something.

This patch changes the behavior so that
chrt --pid <pid> continues to show the current settings:

chrt --pid 10862
pid 10862's current scheduling policy:  SCHED_OTHER
pid 10862's current scheduling priority: 0
pid 10862's current runtime parameter:  2800000

If a policy is specified but no priority follows, chrt now
errors out:

chrt --rr --pid 10862
chrt: policy SCHED_RR requires a priority argument

Verbose output (-v) still prints the current settings when a
valid policy+priority is provided.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 schedutils/chrt.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 8fe748f43..40a006040 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -64,7 +64,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	" chrt [options] --pid <priority> <pid>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Get policy:\n"
-	" chrt [options] --pid <pid>\n"), out);
+	" chrt --pid <pid>\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Policy options:\n"), out);
@@ -399,6 +399,7 @@ int main(int argc, char **argv)
 {
 	struct chrt_ctl _ctl = { .pid = -1, .policy = SCHED_RR }, *ctl = &_ctl;
 	int c;
+	bool policy_given = false;
 
 	static const struct option longopts[] = {
 		{ "all-tasks",  no_argument, NULL, 'a' },
@@ -435,21 +436,25 @@ int main(int argc, char **argv)
 		case 'b':
 #ifdef SCHED_BATCH
 			ctl->policy = SCHED_BATCH;
+			policy_given = true;
 #endif
 			break;
 
 		case 'd':
 #ifdef SCHED_DEADLINE
 			ctl->policy = SCHED_DEADLINE;
+			policy_given = true;
 #endif
 			break;
 		case 'e':
 #ifdef SCHED_EXT
 			ctl->policy = SCHED_EXT;
+			policy_given = true;
 #endif
 			break;
 		case 'f':
 			ctl->policy = SCHED_FIFO;
+			policy_given = true;
 			break;
 		case 'R':
 			ctl->reset_on_fork = 1;
@@ -457,6 +462,7 @@ int main(int argc, char **argv)
 		case 'i':
 #ifdef SCHED_IDLE
 			ctl->policy = SCHED_IDLE;
+			policy_given = true;
 #endif
 			break;
 		case 'm':
@@ -464,6 +470,7 @@ int main(int argc, char **argv)
 			return EXIT_SUCCESS;
 		case 'o':
 			ctl->policy = SCHED_OTHER;
+			policy_given = true;
 			break;
 		case 'p':
 			errno = 0;
@@ -472,6 +479,7 @@ int main(int argc, char **argv)
 			break;
 		case 'r':
 			ctl->policy = SCHED_RR;
+			policy_given = true;
 			break;
 		case 'v':
 			ctl->verbose = 1;
@@ -501,12 +509,21 @@ int main(int argc, char **argv)
 		errtryhelp(EXIT_FAILURE);
 	}
 
-	if ((ctl->pid > -1) && (ctl->verbose || argc - optind == 1)) {
+	/*pid exists but priority not given*/
+	if (ctl->pid > -1 && argc - optind == 1) {
+		/* Error if a policy was specified but no priority given */
+		if (policy_given)
+			errx(EXIT_FAILURE, ("policy %s requires a priority argument"),
+						get_policy_name(ctl->policy));
+
+		/* If no policy specified, show current settings */
 		show_sched_info(ctl);
-		if (argc - optind == 1)
-			return EXIT_SUCCESS;
+		return EXIT_SUCCESS;
 	}
 
+	if (ctl->verbose)
+		show_sched_info(ctl);
+
 	errno = 0;
 	ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
 
-- 
2.49.0

