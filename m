Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8E1B414E
	for <util-linux@vger.kernel.org>; Sat, 21 Jun 2025 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535493; cv=none; b=pavHxZTqIljV/iy2lFZuWtFE/H2yXGedSBA+i0E6X/sYpIQkgDk+JwS7A7NgiDf8wpFc1O57jVoS3qJMY/qIINS6xH9gmY24LuU5QYSsik7IE9YaKLMvcyodza9PDQ91RGBCtcO1ez+5GtBsSjGNw5mh6U3zJ26hJf8Si0nb1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535493; c=relaxed/simple;
	bh=tuO/PseznMqx44dE6/BkZXRXZfqy6ysvnzmyqaBAd/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSJNXoYVU2kYoJb6C1MPx5s6eRpzPzwrVPOXgMvxvWndJnsxpx/EOyCH0aobrLpepSRjeiZ4WfxjrBcDeCJ2sZ1Hd34TOOW/pMW2vS0Oh7wElL19INQpItDb8w8xj2Cqic1WMmopIco2a/kDcQyoDt4xa1h965g0ZXfUXTv6M0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ofe23Ikl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ofe23Ikl"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LJj2QL021581;
	Sat, 21 Jun 2025 19:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CWs6LgLmKW4aulYFy
	eT4v7c2IW0ub7RBVYMh7mSj8vo=; b=ofe23IklmePcq2/fRQDPR18k5er0ZQxAS
	6rRGt2OD5wKio8k+liUEAGjxyCdaEPWnghgHzK/ewxox3C74FDdfMI0FV2ebp2vZ
	h0uOGT5q0jeTT3M/CEVCgvH+YZkpG1xw/gxvdFJS7yzAlW/bJpCVMDNdfvCDAb+/
	upJteqBlQ1EQV0Xz+A+nRwg9eQ4tMYK8iKX4mNMp3Ih56xgEhTqha+cq5DpooXkt
	k5yxzGICF3LkS+Q8oByULWHGHrkqGvJ7CsnNYlueDvk5LCo1kpl1xmDsADZFza91
	CM3ppiBBMvVmHBVYtM+qpd0QQ5fv/aaocLsSRfAMi8kD0jidXytkw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8hth9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:51:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55LJV9Nt016436;
	Sat, 21 Jun 2025 19:51:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47dnmttnk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:51:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55LJp3Tw18284828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 19:51:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32CF92004B;
	Sat, 21 Jun 2025 19:51:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D503820043;
	Sat, 21 Jun 2025 19:50:59 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.73.245])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Jun 2025 19:50:59 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v4 1/3] chrt: Make minor cleanups in chrt
Date: Sun, 22 Jun 2025 01:20:46 +0530
Message-ID: <20250621195048.24900-2-vineethr@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDEyNiBTYWx0ZWRfX8eMT7ujmTD46 m5OaIcacKBorN+gYU++2hguTDd1RnnmQtw44jgkLpAENlc63TFz0Px6LDA4dtszhfLr5eOT3TsC gdslKJjHPSgmAUvUbZOxK1UXnlTfbDC/Ovzk0NR7j0ux1jv/4HKB1pkY0NEpBIIjx30nPCPCduF
 uKtBesyaNSDAwgoKBE2sbbbDVfflcAzlrwmPNG2qQF87PIKSiFcXThZICJGVENqysisuMOS2AP7 rWJPchPRETS1k8UOkKHZqAJ1HBUvyMvhQu0irl8lTPEt31YIXo0UWq0Kkc1nVSy5lQgkRc9NskU y2pJ2WeNGSrlOqw7C68PCps8m4wk6e7iQFihMzyMHWM2Ib4jlzhw1+FfX/PSomq6eHQsbWz6vjt
 qkm1yOGevSXhlHexnpjJ+jR0vrR9mL18jElSnEwdkbWJMuofI1xC01YgxGQ67PGrvHY0UMKo
X-Proofpoint-GUID: tA515pyoJAHxMbhUh6PEvwNaB8vHwrqu
X-Proofpoint-ORIG-GUID: tA515pyoJAHxMbhUh6PEvwNaB8vHwrqu
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=68570d2a cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=CWI5U3P8YdA1OMGJAVAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210126

Minor changes such as fixing an incorrect comment and aligning
the closing brace of an if condition in main() were made, along
with making the usage of --pid consistent across files instead
of -p, although -p still works, for better readability.

No functional change is intended.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 schedutils/chrt.1.adoc | 10 +++++-----
 schedutils/chrt.c      |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index 77add535d..36cdcc5fe 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -40,7 +40,7 @@ chrt - manipulate the real-time attributes of a process
 
 *chrt* [options] _priority command argument_ ...
 
-*chrt* [options] *-p* [_priority_] _PID_
+*chrt* [options] *--pid* [_priority_] _PID_
 
 == DESCRIPTION
 
@@ -117,20 +117,20 @@ ____
 //TRANSLATORS: Keep {colon} untranslated
 You can also retrieve the real-time attributes of an existing task{colon}::
 ____
-*chrt -p* _PID_
+*chrt --pid* _PID_
 ____
 //TRANSLATORS: Keep {colon} untranslated
 Or set them{colon}::
 ____
-*chrt -r -p* _priority PID_
+*chrt -r --pid* _priority PID_
 ____
 This, for example, sets real-time scheduling to priority _30_ for the process _PID_ with the *SCHED_RR* (round-robin) class{colon}::
 ____
-*chrt -r -p 30* _PID_
+*chrt -r --pid 30* _PID_
 ____
 Reset priorities to default for a process{colon}::
 ____
-*chrt -o -p 0* _PID_
+*chrt -o --pid 0* _PID_
 ____
 See *sched*(7) for a detailed discussion of the different scheduler classes and how they interact.
 
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index cf99935dc..8fe748f43 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -64,7 +64,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	" chrt [options] --pid <priority> <pid>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Get policy:\n"
-	" chrt [options] -p <pid>\n"), out);
+	" chrt [options] --pid <pid>\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Policy options:\n"), out);
@@ -341,7 +341,7 @@ static int set_sched_one(struct chrt_ctl *ctl, pid_t pid)
 	return set_sched_one_by_setscheduler(ctl, pid);
 }
 
-#else /* !HAVE_SCHED_SETATTR */
+#else /* HAVE_SCHED_SETATTR */
 static int set_sched_one(struct chrt_ctl *ctl, pid_t pid)
 {
 	struct sched_attr sa = { .size = sizeof(struct sched_attr) };
@@ -499,7 +499,7 @@ int main(int argc, char **argv)
 	    ((ctl->pid == -1) && argc - optind < 2)) {
 		warnx(_("bad usage"));
 		errtryhelp(EXIT_FAILURE);
-}
+	}
 
 	if ((ctl->pid > -1) && (ctl->verbose || argc - optind == 1)) {
 		show_sched_info(ctl);
-- 
2.49.0

