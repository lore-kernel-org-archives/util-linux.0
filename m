Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB43AC0C6
	for <util-linux@vger.kernel.org>; Thu, 20 Aug 2026 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206089; cv=none; b=LJncWeQ1ysoes4R5bQH+jS5NlPNWeLNso/hVkkFzEh3AaR5HQVhuCkKuT+PY92vvAUKqYvZJUgo5hds00IJyiGBVgmv9LO0TA55NxvFj9QHTkhl9iCQQS+0q6mrxcrBNcixm4Ehvi9VkFS1aZ41dN/N5Lv0z7mAOQGOXJOJI9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206089; c=relaxed/simple;
	bh=cE1V5TTprvH5OG8yOmZPkYVA/FTug/sH+M6dkfP06kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fxuGW0Eg0SgxJyRxcTRcKvcORlhh274g8QU/idMXpfQdE+X0NgeP7pgMxz/3OE377F66RmjolcZojY5DsqHg91rABNspK7rSepnpAW+VAcDMx2JKOG25hR9I99eAh/iBOVIABz1F9UIFq2eIp7tcWNJpVnjjveR4+SdVKtbxme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EtCV8oHH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hLitfNqd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EtCV8oHH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hLitfNqd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K5AZO41457423
	for <util-linux@vger.kernel.org>; Thu, 20 Aug 2026 06:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=F80mM9/gCeikqOJ6EFJtHVLok+FiR9P+Fqn
	LbERPCCM=; b=EtCV8oHH5jNJM7+zHxGAXs/X/MKGcXj5cB6ugflDTZIqJTmUWAI
	jFX8y1EMfY8OQBmySr2FRF0pwsTryz0yBD+PDBsJ7aP4LEcBKEDA2Ur8ocmA6izr
	B5Ubs6BJqqZxgWFeEDFbNAHNcmoUpldbyltg7wZk8plEn9gyo51E0/8heSc5JO0a
	KwBMR1gHRqnwz6J9S3uBWVSrxhFCQ9CN0RTtL9sVIHUlvFUA5G7/mzf0phSvGiVO
	58Xlqb2ELv+N4HfcO5Nx+4zEcDcXSP7KYTOmFCW+NPqBx0e9K4wXDFS6rWTKrLyh
	b65KgyeTzzfdxNB7FwgKSxp56EY8EN4JzGw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es4bbsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <util-linux@vger.kernel.org>; Thu, 20 Aug 2026 06:08:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so2306890a91.1
        for <util-linux@vger.kernel.org>; Wed, 19 Aug 2026 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787206086; x=1787810886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F80mM9/gCeikqOJ6EFJtHVLok+FiR9P+FqnLbERPCCM=;
        b=hLitfNqd4IZoSyB1lF5ZYtWf+YLym5DEku0dL2R4Wlg/sykbGgLz8lu1plRyVWFSsE
         sbx6ejncMNLTR7CDKllAVSY8dttlTH+gizVi+VPsPoupbfzZwfOw4yceRaOgxDMya3om
         /25vgKF8LZg8sR4n+z/sRa3L82ex/bInrb8jcL58mJycPrNiFgqvS1YghgmMXm3+gdEF
         ZEaZT+FFEL6kNxaZDnA9fLZGvQ//aWuHY7TFtYksCBmzGV6NlGo2iIepunKyHOt5JwGm
         IzUkXN7rMvzhbYUbjH8fQSW4b1joG1SJn/QVcBEGHbTprMdrNZd67UDDbBVw1HOaXb4+
         LkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787206086; x=1787810886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F80mM9/gCeikqOJ6EFJtHVLok+FiR9P+FqnLbERPCCM=;
        b=ehP1GMZNKrU8KPaqyXB61K+rYfkSVjvJt0GoS6YyvRr+/CgyipQopDt5H2Vdt9QhJy
         Ze8WZdsE/hDmOffZK8Bb8WzlSfSUd4o/4LdeOIfs1hJRxORN3NeBpYcUpZX4gdDV+9tU
         9KPi5tPNZ8nF/tfeuvTtxh/b+A5d1bMqJNe+JXxt8XkqcXDUdn16W5k4jEjqEYShHRym
         Zmmf4RImm6X1U8izmH4d8/sV8N9mVhqrZrq9gBVXioljIHWD42cxE3K8O6l3chaVn5W1
         ST60Bk+cANFE6b2JD0NlKQXFTBmSBsufk2vIWfjgyDqmD14gM2vLKVuCJ4uPVnsB4XYi
         EoFA==
X-Forwarded-Encrypted: i=1; AHgh+Rqak38oxJqLbQBOqGUY2ZcejFaDPtHkgoZJ9rBjD+Zr22D3UKpWxbUkC1OjUtL9qyrL3RxqnkbNfgW0@vger.kernel.org
X-Gm-Message-State: AFuF++lbo4LESIewUhw5d8HZGCXoxlsJmJ3v6b2p+3KCpMvkDyYhom7r
	irLJSPW/Fw/zzI0IYASuTOLyuk39SBTx0HiMAXkVx03KMV1I630krABbtN/EEmxxq4o7MJy2ieS
	ZXlnSVDRwlvqo8tCLGzgDhAyDDGr/FgWW1SKJdvOJa0w25o2VsJIE36tmv81zUW1E
X-Gm-Gg: AR+sD11J675FpbICFD600/jKGL/DwFwRWk6ENT0TxYuU4ING/vZn76Y4FoqTX9OkjXd
	3rDRFa0JwlL7El88q4HiDXVt/mQ/cDFdQgza5JZe/qrulQIRJ3avl4tCYodH7ANxNAdRvELLkbZ
	EfxwIrPE/ns5qaGDe7qkvmzqGjBg95YahDEjB9y3zzi4z6GOPEmo0kX0AXJvV0etsxVo3T2JYoN
	YiPN/FeU/sUYteLU9seThoCcDmpM89FbQJaEdJWqIyOcPGnsRZjL+ZFKIeNE0YMHoCH9sKuQ7+K
	F18jFPrNGMutGq4sflGptkkOdOA7iiwcFNiVAG7Q0pm3DDE93ZbMAwCxWaJXOfzIy4Oi3/H9mg/
	sEMzXO7T2jDocdjd+0RGk2DK4gtxPoiNg3YfyfsCeerJlu7tG9d8FaduZ2FFVfK6Fc5S4jeaoky
	GImD62nzq3OuWv
X-Received: by 2002:a17:90b:5645:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-3958125af4bmr19273229a91.2.1787206086222;
        Wed, 19 Aug 2026 23:08:06 -0700 (PDT)
X-Received: by 2002:a17:90b:5645:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-3958125af4bmr19273118a91.2.1787206085754;
        Wed, 19 Aug 2026 23:08:05 -0700 (PDT)
Received: from hu-lmr-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb4ffcasm5577602a91.6.2026.08.19.23.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 23:08:05 -0700 (PDT)
From: Lokanadha M R <lokanadha.r@oss.qualcomm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: ganapatrao.kulkarni@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        ashok.raj@oss.qualcomm.com, rajendra.nayak@oss.qualcomm.com
Subject: [PATCH] lscpu: prefer model over revision for the Model field
Date: Thu, 20 Aug 2026 11:38:01 +0530
Message-Id: <20260820060801.2094422-1-lokanadha.r@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WcAGTnRYVrXFbF8vEVde-AJZwCWD324h
X-Authority-Analysis: v=2.4 cv=PZXPQChd c=1 sm=1 tr=0 ts=6a8699c7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=qozy9jy58_juZRYjmA0A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0MiBTYWx0ZWRfX6+F5E+ienbSZ
 yT01JU7pUU4xZ3Ja2i0T1k4FRfEaCKXd5HZRBgEBs2rhGId6ZDmJc9LxueSlGn2cKoiq8iwLJu8
 0EM5QGMa/mmFI7qjU8YHgPXWvnbwkGE=
X-Proofpoint-GUID: WcAGTnRYVrXFbF8vEVde-AJZwCWD324h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0MiBTYWx0ZWRfXzNPvTUp3YHJS
 jJrOt03RSi1tchxDFT5qPtrYQvJnCvXMsdRmPWdM8/D+VS0kkwx0xW2knvxQ5ObpplRIYZh1tSa
 xBJ1mgRVkExkaLHC90+8SIERuHjzsJ6emkL8+BNRcbo/aZxasLcAR2DQPqU4RBdVEnzEQBsK50h
 eCGDzwMWjkTaM5gtT61s8w2mHgHNLy5xRmGB/SxlFdnhMFUxrQeCUK9IFOK9ybpiXvFqoK/g2Rp
 YB/vZYbJn5JGMY2O5aF0yhIBNZYUiVwH3Zq/u7rNmx5xvMFgiY0LV2TPDJBXnu7dn14hoqim49w
 4KVgEeeCtJNnZvd9ylQZn5Ki0D9ztFdmI3ZBRD+nRKgdYwTP32i+6HqGz0fU9IURXvKPUhJi3/j
 BP2YYYsRlHSWkmxmm5B8ojOz1nP7SbudU7PktoBFpHUcHqiTIwxHFURh1jIshjR+tG2KkwwUgFc
 18gk6KbQU/XwYZ7orsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200042

Current logic prefers ct->revision over ct->model whenever
revision is set. This is not appropriate for any
architecture that populates both fields, because the CPU
model (part number) is the meaningful identifier for the
"Model:" line, not the revision.

Make ct->model take precedence and use ct->revision only as
a fallback.

Signed-off-by: Lokanadha M R <lokanadha.r@oss.qualcomm.com>
---
 sys-utils/lscpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index deb9b12bd..e52dc6312 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -910,7 +910,7 @@ print_summary_cputype(struct lscpu_cxt *cxt,
 	if (ct->family)
 		add_summary_s(tb, sec, _("CPU family:"), ct->family);
 	if (ct->model || ct->revision)
-		add_summary_s(tb, sec, _("Model:"), ct->revision ? ct->revision : ct->model);
+		add_summary_s(tb, sec, _("Model:"), ct->model ?: ct->revision);
 
 	add_summary_n(tb, sec, _("Thread(s) per core:"), ct->nthreads_per_core);
 	if (cxt->is_cluster)
-- 
2.34.1

