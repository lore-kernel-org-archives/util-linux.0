Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D914B06C
	for <util-linux@vger.kernel.org>; Sat, 21 Jun 2025 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750533625; cv=none; b=dkCBMkjM1xUEriTOlAmgs2zDMV7GK0JBdRQgobyHto2gm5MISANuDPhRJiIJo4e96KuHHEJuCsXFgn0qqZoTEMBBcQI4t5SJzyyT1UDecBXqfw6q/G/wb7muBDTc4cNpFk49ntnft0ENuA99pNubwCdbF/Txsr+ZaLbbq6h2qdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750533625; c=relaxed/simple;
	bh=tuO/PseznMqx44dE6/BkZXRXZfqy6ysvnzmyqaBAd/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/OwSi9fwYqeA8u4X3RpeDeoocbFsg84e59j029inzGTycKlQgVdri0d7swMz8HvG/slKGWoVLs0O27EBsU7gbb5r57flhk2KlPOJqDv2xMt1VJsQcTSEk2a54WF4wYN6CCwwxfFa6MC2m/u/8oBQQz17YaNUJIf5lRJ6+hbu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X4vT8Xwr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X4vT8Xwr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L1GgwO020281;
	Sat, 21 Jun 2025 19:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CWs6LgLmKW4aulYFy
	eT4v7c2IW0ub7RBVYMh7mSj8vo=; b=X4vT8XwrORqZy8rl/PPce65m/fBLSPsKQ
	Zjd/E5TxK4KBuDprwBBatEMEBxLGhAPxwpXiW1a7ytrgFEka6sCCEx/yAmm7f0MV
	WQO9LJV2S/xiud5DEnLep8qjojId4Rp/zlDiqKBSFkSlD5Oocx1c6ZaqHevLDyF8
	0+xZgyXz1oYCF+0SWxsD/L7yGQ4UVUvsc5D8yuVvwAdDniPoI6Rt5Dg3OeG77D+5
	HaqYk3lubvM6nL9T2sh5R/cSpqRIZmKNuIrgZYCGO+tOdRDBrzUP6JAAi1Ff/v42
	Rlo05iyNfdYe6UNOsXEbWMzD7DlcAJqjpuqZcWO17HQWfu+/Ad0Dg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tashk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:20:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55LEWBvl016454;
	Sat, 21 Jun 2025 19:20:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47dnmttk82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:20:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55LJKFsn58851764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 19:20:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB9D420043;
	Sat, 21 Jun 2025 19:20:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D5C20040;
	Sat, 21 Jun 2025 19:20:12 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.73.245])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Jun 2025 19:20:11 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v3 1/3] chrt: Make minor cleanups in chrt
Date: Sun, 22 Jun 2025 00:49:54 +0530
Message-ID: <20250621191956.21142-2-vineethr@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: P_fIUtwMYZrXvgax6_0u2zHqZGXIIimw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDEyMiBTYWx0ZWRfX6IH4GHAX4ziJ 5U3Y1ibUhnG+RlWEj4vB8EE8agtVZPj1Ipz3Sfm2sBr9zbYgy3/gaqf4RMwf0fpL4F86JdffNfu Csyk2H0XRuKvgfR8Q+nTaFYdVJvgtLramj7c4lQh+0PNYa/kLCD+VE5i0v0shCOUeSJ1hUyAsek
 hb5O3nelSDA7ndD7jNcJU8aq/07TO0ENrOX6Q0aNUQvVzbrRoYFkhic+1YfVURhMv6IGUCrgU0O ByUKtmD+d5dIOBgwI4UHcAnh1zgBXqS4EbTc99KFBzQs8qwaSfRQvF2h2dWqs8KCNt2Lf7Q1oL8 XgmKicp6dwzkZhvlFVD1GN619hr3xdq4xtmgywaGd+rf2ToXQKR0/PhaSpIh0pfCAumIbdHoxr6
 7ZJ/eT12PQWvs5v9N8dtZwOckEk2d0Aon59n9wg1fF/uuZHoWCglA/eNZCLkQ7R1H4GbZllP
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685705f1 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=CWI5U3P8YdA1OMGJAVAA:9
X-Proofpoint-GUID: P_fIUtwMYZrXvgax6_0u2zHqZGXIIimw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210122

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

