Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0501B414E
	for <util-linux@vger.kernel.org>; Sat, 21 Jun 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535482; cv=none; b=pua/Dcvl+hVdYI1YXL6iFrhGrLhpS3y1WYZ3p8/HZ4BNHCoeDA4LeVATscKF6+5Qre4LAg9rJoaNII7Dg/z9qvxtkRAycFF9cN3WkkMU4Fm3KrzuVmVt61xJmLbceoMPoxwtPV7FQ+pazWKxmNsRwqT7cnQCfEAGFqeaUluq2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535482; c=relaxed/simple;
	bh=tzK37QVXuXpjmQsiYAs8yFBe3H1FqMusOlfDWbXaouE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDkCdiVtkld90h1VU1isiq0NgF54OygrrGtjdv9rL5jWjXA2GpKn4Githc1uYFVEV+fBN7tze4Zk401HGuw7332jIg4w9LugRqx0VWth1KDmHQA4A8HcMih+L590QLrjxNeczBQE7eI2fdw7MzM3m/wvFDaXrxQusIIBZqdeBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hsc9DQ/b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hsc9DQ/b"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LDc7VD032165;
	Sat, 21 Jun 2025 19:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mkN3i5
	X7+avAKb9lvhdBKBrfGWX6tDheqMGFehSOWgU=; b=Hsc9DQ/boyxcJyAtNj8TeV
	jygziCLb02WEUYBbrFQzoMeoeTWHjVZtTVhtVyxe5izUYeKO4ufYpPrtsPXBqOJD
	Be3NdDbuYkx2gmfVpc6wIQarbsBbuwiCiwBQqkVIxM2orqjktqYqlE3bq4/CkSdu
	16dr/ER9jbnjyYNn3GugJhXDqxSG+YNz7r40QxPg5p7pHD7a2qkP6oSNgIbNChtC
	f+YXDPmwp2vfcX8Mj9QMARph3P3a0XZdRfXzLxL0Up0AFGDNiy88HS/SLAef9RDN
	qJiBP6rPEVwMKh2XNYmVX1wwXC49tVr2JZPpQFzTWUewLT3FNuHYikd7O/TiLpOg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8htha0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:51:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55LEnvbH032019;
	Sat, 21 Jun 2025 19:51:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47dnqw2m0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:51:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55LJp92g58392990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 19:51:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74CC92004B;
	Sat, 21 Jun 2025 19:51:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78A6B20043;
	Sat, 21 Jun 2025 19:51:05 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.73.245])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Jun 2025 19:51:05 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v4 2/3] chrt: Only display current settings when no policy is specified
Date: Sun, 22 Jun 2025 01:20:47 +0530
Message-ID: <20250621195048.24900-3-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621195048.24900-1-vineethr@linux.ibm.com>
References: <20250621195048.24900-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDEyNiBTYWx0ZWRfX/k5jKH67Cy6m F4YIPjvjucKJ5LDEG6IwLHFioZuhNQ+B79NAJl4x1YZNJ1Xwev4rh80pjg7by6bN3yHZPrIP7R9 byeniJrACQHvKRmR8CvZ9bFxrX2HbfrhRdrAaUHm+VrpPEa+1BWWAKAcmbYuXTY5rihNEOzJxUj
 RNQppL5KlbMuShxpxomFXm4NBuy/jR+tq0RRgN2f2wdF9q/JWknlUB+FLaBtPjG87iaBMszRuhP Bxa4pU/KsRh52Oh+6D4VeFgWe5zRI3iDAwT1m/ARBlozsDwSj6ysQvZLDjLuw9Wwf1TvzhE/Q9C y5EOeyWZOP+Mg0N7gHpERz+xP6tpwamJW6ITXcla5pLj7iAaqderTG3PHOO0/HveaY0j1jYrYPY
 gvM9qrbHsvaHwbGpBCXh83fve56LHTYkOWldnhUjM4QLVkc6kzHety/b+I8J9G6GlGCjXrbR
X-Proofpoint-GUID: eR1J7TkAQqk04ZLzlHQbCpyQOVzPac6V
X-Proofpoint-ORIG-GUID: eR1J7TkAQqk04ZLzlHQbCpyQOVzPac6V
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=68570d30 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=EeF4qO850oZfgqQkHikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210126

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
index 8fe748f43..d694845ac 100644
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
+	/* pid exists but priority not given */
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

