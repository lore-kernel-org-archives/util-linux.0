Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB0237163
	for <util-linux@vger.kernel.org>; Fri, 22 Aug 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875660; cv=none; b=j79vYXwM6DKDw+WdaDIeJIZm0CpA1/XLzRb7pLL4pw5CyYMspOAaXph1EF853Np162RZyHKTnnpFEKzJqX0EzFgT8JPlPRyKHRZLeZoBhOcDlG0yk/51rd2+RrnbzskN5yAmS3s6ItzN6n2820qb0Hcly4mSk8yuy6z1gPDwV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875660; c=relaxed/simple;
	bh=J8urw+TxGUBa6jUH8XMdqt+VDhFHgjjWOYEH+TaH+CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxEn98UagbJddWqC6WvULRajRtNwnEny+wQ4DyW0Y3Us4GwzXOc/8ABEwFrRPR6mvaqHXngU1moDqTICCNcOd7MdtFoCTFx3lFJPl6nft7UtVuYmhvbdA/flX7KGDpa1a6RTTRn7//sDCZAXJL816X8hVu5REdH3BrCHFKKOTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M4Gg5MB1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M4Gg5MB1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MC9993024378;
	Fri, 22 Aug 2025 15:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=mrNBjw3pC6pAXVnWsq5MEI/jMMPJaL43MxKVhVZ0s
	Ts=; b=M4Gg5MB1w/qnmtQEO2cvfcsNSFwYY7Y08k5L9jZs82fqiee7WAqy8urZ4
	RQ6IfS2huTBUoy9p2zX6HctF7Bf3btV6uwSK886wO7zMLQA/tM5uPdkx1X8Xf2ur
	q5PqQcXJ/rewkoN4+9mGaPZaui56U3GKoiyq+2FyLpTyV4eM5QZ6k0N3s8maT7yV
	NZeR3c8XpQvj9P/pxOAkvGIxVgrIi7nnhS+DmrgwPxU15mZVLTal4Qfb2V1161R/
	Rabmm5j9pipHz2ZEMPKDJiufu5lgnE23CD4aK+ERPnmrCtk6XBWu/pVyPMZI2p12
	7gEpeST0iH7QBeTe97ZDYZR7apH5Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vy21v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 15:14:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCOfKo031845;
	Fri, 22 Aug 2025 15:14:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5yduj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 15:14:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57MFEBep41550172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 15:14:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 208AA2004B;
	Fri, 22 Aug 2025 15:14:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A57C20043;
	Fri, 22 Aug 2025 15:14:11 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 15:14:10 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, sumanthk@linux.ibm.com
Subject: [PATCH] chmem: Remove commit - chmem print warnings about failures always
Date: Fri, 22 Aug 2025 17:13:53 +0200
Message-ID: <20250822151353.508175-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX5hcMN9HwoPYa
 LTcHM1qbFYWaJREnCll/2yiB7rzWueJGUQpvcFR5fO4UOFd3uRVWYAhg74oZCUmWRVpBKNsttVa
 DhemhldJ4mxEW8HFF6p99L9nbGYeT2Wyc+iELrqshcU4cKoQnPeBwlB7uL1KJXjdmMUpzesGH7u
 Jeg9L/W9lTZuTLbsOIo+u9+Hh+fvXjRrM9iUndFcT+EL/qByr9CrpGE8yJIzIo7hkmc9Z3PhMsh
 8tS/+GxndX8xKAnp1qYSSFB0hcwEHY22EhIo4gNsBvqDnKG9K11ZP6xi0QUvyoU83c9N7WcFtuy
 ONAMkgxpECzRSMRj2RCZY87A//jAkhRogoRFYd91VXRlpDbGP5zWXuBrLZEccF3ONwAzZsr0jnk
 qRLGPwEoHHNikHMuVC60dMAHU3FTaQ==
X-Proofpoint-ORIG-GUID: EFl9Uj5Rr7yYmLDxIZyiNXAyoWpejRLj
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a88947 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=RcE6poM8lnotgKd6khcA:9
X-Proofpoint-GUID: EFl9Uj5Rr7yYmLDxIZyiNXAyoWpejRLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

Users do not care which blocks are set offline, when using size option
Consistently printing warnings/errors in this case may confuse them and
create the false impression that the enable/disable operation itself has
failed.

If size option succeeds, chmem should not print errors/warnings.

Hence, revert commit
48675a744 ("chmem: print warnings about failures always (not only with --verbose)")

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
Add signed-off-by

 sys-utils/chmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/chmem.c b/sys-utils/chmem.c
index 52e6f49b3..bee2a90f8 100644
--- a/sys-utils/chmem.c
+++ b/sys-utils/chmem.c
@@ -146,12 +146,12 @@ static int chmem_size(struct chmem_desc *desc, int enable, int zone_id)
 
 		idxtostr(desc, index, str, sizeof(str));
 		rc = ul_path_writef_string(desc->sysmem, onoff, "%s/state", name);
-		if (rc != 0) {
+		if (rc != 0 && desc->verbose) {
 			if (enable)
-				warn(_("%s enable failed"), str);
+				fprintf(stdout, _("%s enable failed\n"), str);
 			else
-				warn(_("%s disable failed"), str);
-		} else if (desc->verbose) {
+				fprintf(stdout, _("%s disable failed\n"), str);
+		} else if (rc == 0 && desc->verbose) {
 			if (enable)
 				fprintf(stdout, _("%s enabled\n"), str);
 			else
-- 
2.50.1

