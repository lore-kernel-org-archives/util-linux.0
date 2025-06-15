Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405DE82C60
	for <util-linux@vger.kernel.org>; Sun, 15 Jun 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750015352; cv=none; b=hBpdQc0TAZrDd+xGIAxJT0sV1cCy6rGypsvAqyYDqCEJB0zMXwAguFRm389q2hLzJJNdL36VMP+HnUk349XoMEgcmuDdl/dsmpQK9fmYM3WAT+cdr04PWYtZzuW8jOjTPjKvYdLM+4U75o9PWpazM0cvM/pOyxyXv0rSu6PMqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750015352; c=relaxed/simple;
	bh=rE6sbLkv+64b4c5ZhQg0Xouyitx/+wuASdP6En3xiOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4yy9nhOmxrPC+L8DaSVhgGW2dNiWLB4elMipv0mIwlqC2sXRr7ljuMW9FZWE03qzj8MoHQ0vRTtC13DMzYSAjDcJ99Bye0VcDExHM/r4Zy469VI3VoDDcHPpSgJ4DVQJWrjbmVBDumSQa+qi+9BbcTvm3Y9cGpwFsjjnxWkdng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kA9UU7cQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kA9UU7cQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55F9vh1J011788
	for <util-linux@vger.kernel.org>; Sun, 15 Jun 2025 19:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PgIWqRKllQ+jdhtntzE+RVMT/kU1c3hQ7huS6sHoa
	kM=; b=kA9UU7cQUvGt+1sQItK+jVBaiRubl/DNLKthEAM+F4GfWuEVvG4gQwagS
	jR9Pn3iM58Q2rmOayeA3vXFJ5d17CWbWPaasK7dm72fHwiC2tKDhphg+wsYzMks3
	bDR5YNeJBplIqcRUdH4EdPueisI0vTxMExjMmsh3W/v6ASwQvgOs4v1pbgsNRC/r
	0i+/955t2a5Y5jfj+e12GAWfjDTPBsD9AQsH7Lxb1zt3stjN39HYs6fRMwva1BWZ
	UUuRJ+1TbHlSid50oOmuV4pfIxsSRK+xtZoYtJSaR+Ipw3FMCWORednXhSFg8+VT
	eBqMrYUyog8GJgswofpnuDUNN6tmw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qnw5kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Sun, 15 Jun 2025 19:22:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55FIGS8Y005481
	for <util-linux@vger.kernel.org>; Sun, 15 Jun 2025 19:22:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mwktsr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Sun, 15 Jun 2025 19:22:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55FJMOS045679028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 19:22:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B2D72004B;
	Sun, 15 Jun 2025 19:22:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6AE420040;
	Sun, 15 Jun 2025 19:22:22 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.domain.name (unknown [9.43.8.76])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Jun 2025 19:22:22 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org
Cc: vineethr@linux.ibm.com
Subject: [PATCH] chrt: Make priority optional for policies that don't use it
Date: Mon, 16 Jun 2025 00:52:18 +0530
Message-ID: <20250615192218.70289-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qPbP4nsuYjTjB_gRzj-jwIvyjdA5j2wX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDE0MyBTYWx0ZWRfX2FE7A2rPTCve pZ+WJnfWEijLRFVSgPWAE6Goxk48xxgcEg6zhJ9TXKSElc8Ct/XwnzXb1TaODF3+ReCDxd/cS7w k+bDURZ8T6D+HU2ZNcxB8PFGlhR66KqZgTp6UAS+N/Q0mOagEyHPjhhXfhiVPDlBh4hn5QaqGGk
 NBFX5fI5F0XSiApnuG9dsEMlc1XkK/57/OqgrzoaU7CHS3ACBJTtUZQOuZNXvwC61dbWB3AxfNR GalMBbtsgE4kDVt4FXe6CH5elMQWAJMN5T+RcST0BCiKqKqfzRdS+574RVoenciFbN0Qtqoqwkd 78ftmihYDsgPMEehzCY/K5Qjsfx/nCz0tH3/DYeL8CK2zr/reQylT0k3JvoYgaONjMyNupVQ+PB
 /DQKtt1mAVM895MRF4PEJyKMGB7X3mWFMszJkLctPeLGKbgZYY8wb7yW9Dj9MIHKntaVdcmp
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=684f1d75 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=CfCIZicu8FQThxliAwwA:9
X-Proofpoint-ORIG-GUID: qPbP4nsuYjTjB_gRzj-jwIvyjdA5j2wX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506150143

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
 schedutils/chrt.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index cf99935dc..339f3e318 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -495,20 +495,26 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (((ctl->pid > -1) && argc - optind < 1) ||
-	    ((ctl->pid == -1) && argc - optind < 2)) {
+	bool policy_needs_priority = (ctl->policy == SCHED_FIFO || ctl->policy == SCHED_RR);
+
+	if (((ctl->pid > -1) && argc - optind < (policy_needs_priority ? 1 : 0)) ||
+	    ((ctl->pid == -1) && argc - optind < (policy_needs_priority ? 2 : 1))) {
 		warnx(_("bad usage"));
 		errtryhelp(EXIT_FAILURE);
 }
 
-	if ((ctl->pid > -1) && (ctl->verbose || argc - optind == 1)) {
+	if ((ctl->pid > -1) && (ctl->verbose || argc - optind == (policy_needs_priority ? 1 : 0))) {
 		show_sched_info(ctl);
-		if (argc - optind == 1)
+		if (argc - optind == (policy_needs_priority ? 1 : 0))
 			return EXIT_SUCCESS;
 	}
 
 	errno = 0;
-	ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
+
+	if (policy_needs_priority || argc - optind == 2)
+		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
+	else
+		ctl->priority = 0;
 
 	if (ctl->runtime && !supports_runtime_param(ctl->policy))
 		errx(EXIT_FAILURE, _("--sched-runtime option is supported for %s"),
-- 
2.49.0

