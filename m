Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E418C340
	for <util-linux@vger.kernel.org>; Mon,  4 Nov 2024 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702231; cv=none; b=J0Bq9LrLnwQZtxktTL5LWyOM4CrYoSR5Khd8WPYuJg7Xe3KCUZ1IPWeSoVfhc8W3TBo9WOOrYfSwHkbqrTDeDqs5/Gcoau4Oc6BAqGqIQ/aDqIzWqCimS4MCPZQYny+C1VfxpUoFkqN77IwGkOCKaIIsnWhnaLLwltGJM4765lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702231; c=relaxed/simple;
	bh=antRY7BiD6dgiEQ1Xowg1SMW4Vg5FsovTlh23u3fhTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iP8c8PyO9u412IyWHI1ufCSR5hahR8KZD8YG/Zvwo7ehZoB8cWN/r/SXlVRaRtLjhaMWipALPeuQ15A9fniy0X728LiG558Aq9V/qLPHw1gS76Gve+MQEmFIO+ZLR+34vcJixKqvWrdtmMbE1rW7wAF7kxpPdOlm0uRroapoz78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oOZOUZHJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oOZOUZHJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A43RFZr002136;
	Mon, 4 Nov 2024 06:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qyDuB9
	Ck3++bGDzo8xEQ0hDOgXvom9azUrft9vwAjGc=; b=oOZOUZHJKDj7JFi64d0FNt
	t1w0/DaAwI7+FaaM7lLgEb06ehxR4D/5S4If+SEEkhvQvHvJgFAievhJVcVYtBLB
	n8L6mygRLyUNWwwbyw5jkUDrvq5x7b2fW1vwSLoF0jJ+lypQPm7aevc4zYX40O4m
	/5JXDqF5UvszimwI017p/0/YJhMvu+fB2TZdQM/qxHLZstiIGPHfiQaTCK9G5wl3
	Pm6Ve3bIWtjdOyfRA5m+P/+aOr5XRcU5iGGEIcb47sqZAimqBVeYbaPlIf2vSOZd
	7bF7DKPXmBrwd29ROXrOLjPrmMCw23Rxtmdg3fYpVodIntYbG0N8qrYWLe2z4IOg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pnp98hu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 06:37:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3JVbVK012243;
	Mon, 4 Nov 2024 06:37:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140sh1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 06:37:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A46b5vF57475496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 06:37:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F1A420043;
	Mon,  4 Nov 2024 06:37:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAA9020040;
	Mon,  4 Nov 2024 06:37:03 +0000 (GMT)
Received: from [9.39.22.122] (unknown [9.39.22.122])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 06:37:03 +0000 (GMT)
Message-ID: <8798529b-6e86-406e-8742-2c3d639fc895@linux.ibm.com>
Date: Mon, 4 Nov 2024 12:07:02 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lscpu: fix incorrect number of sockets during hotplug
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, anushree.mathur@linux.vnet.ibm.com,
        anjalik@linux.ibm.com
References: <20241018104335.3481856-1-anjalik@linux.ibm.com>
 <psbp7ofmppegfcgz6w4jzaqx5ek5yeoc7zqeoh7k5bmdpp4ivg@4xkmw5pmsp4t>
Content-Language: en-US
From: Anjali K <anjalik@linux.ibm.com>
In-Reply-To: <psbp7ofmppegfcgz6w4jzaqx5ek5yeoc7zqeoh7k5bmdpp4ivg@4xkmw5pmsp4t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: desVfLvrjKNIjOk5qWp2XES7aRHz9GXV
X-Proofpoint-GUID: desVfLvrjKNIjOk5qWp2XES7aRHz9GXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=798 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040057

On 30/10/24 16:25, Karel Zak wrote:
> Would be better to allocate this only once in cputype_read_topology()
> and reuse it for all the arrays and CPUs? 
Thank you for your review. I have made the change and sent v2 of the patch. Please review.
Thank you,
Anjali K
