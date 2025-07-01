Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41921F03C5
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751345844; cv=none; b=aLrm/qDK8hcRuIUWPk32kRCKjyM7cxK6+gdlRfqHBgoavyHuTEPBIj8l+DmS9Qm3uwstnsHSCy4o+tQxB2ml17HdETEYSWmEEuj2ftbmwx/vN7aEuxa7uLcMFvtAhV0HE7QR1vku8nrNLYWlwWyExxeQosavX8FXqYybfnjWv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751345844; c=relaxed/simple;
	bh=tPEFIIcyawPA02E/l6gFfgfGb6jxQj6meQru6uT43KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=nC5UwQYgnKMJtBo0Q82dCK7cumnwzgmXcsy5y0K6EV3g0zfIMtRum7Z/1FmNn5L0iJqjgf3fh7zzBqRmVYd+dfoJe7vQuebo5ldnLKdF8pfvEc5iUQmQNfJGLnoc6+25QKOwrMKAZujg/12PDfTbH1HbRu/ty54GEIhUvvtxAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fHyAbcuk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fHyAbcuk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UI1pWa004384;
	Tue, 1 Jul 2025 04:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2JhXVO
	Zhp5NhTkxU1nNccn3jzOY/V6T3SM+OU5Xe+s4=; b=fHyAbcukl6cQp0axJ+c2wG
	y2JNBh2mownAdh2y9LIbpb+ZKX9tVoX/53GJD7rA4xyBI6JLT2qyiHoKgjDQGY8A
	lHf68/GJvlKfnA/Z6kaTQzSyGYb4i0ZqoUlxYkmiUGXgG0b+zHxyBn7jZakusIyO
	ooBfApRIC5Zm67jUzv/ZEs4eY7kygvNffip3CSsnmpGKtseQisjSy04dBxgHUsCk
	ZaOFdU7eWHvA9mOCYSvc8qUrYOgjj4oNzanxfwWoC6QhY5XNmAv5w1RjzRJ0VlZV
	FOjUS5mPnj6ep4dELuk8DOqQwZbCNg/O2NyUqb9ePdLYiNKpwDUNFVpNUjo+hLzA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82fn1gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 04:57:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56141ook006830;
	Tue, 1 Jul 2025 04:57:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxm8wga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 04:57:15 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5614vEn713435614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 04:57:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77FE05806C;
	Tue,  1 Jul 2025 04:57:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2236858068;
	Tue,  1 Jul 2025 04:57:13 +0000 (GMT)
Received: from [9.43.22.142] (unknown [9.43.22.142])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 04:57:12 +0000 (GMT)
Message-ID: <d18a16a4-693e-4935-8bab-b99299868569@linux.ibm.com>
Date: Tue, 1 Jul 2025 10:27:11 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] chrt: with more than one argument, interpret first
 argument as priority
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
References: <20250630084052.11041-1-bensberg@telfort.nl>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250630084052.11041-1-bensberg@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OlaVFus1mhVMgJWuBB0-KMqCwcCBeDIp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAyMSBTYWx0ZWRfX38YhkejtWtXZ LB5GYLxZtpiSiTpWZRvS2u1sz2ImlZn4bW9iXi6pL1R7CNWTCfaQnpQvfkEZPKC9wz7sCfH1m6O ujxiUBPDh4LB1UTTAkxqu9BHb5kiMWm1/8yuEw0f2/Z4YrgOjFWtmJIJRHocBGf/OUOJN1Zr8qr
 t5yiksN1NHJL6q5PBxhxGkirfb0FJw/RJlIN8qMcKGTEbBvtGVrPj6W6SnjuMPvM57rJiWFFB/5 4dClXhdl6JaRA0nqGctr7ZdHIsX50hIYXl164DZar94fvlPZbhlKtiy247tLkuojt7bKBR28MGp l76OrE8c0IDmDytLpcNH3jM7pLOroMBrLikNjhxZ8JhYk1EP1LxRYGr56FcqmKl+z+GnRHYaPnA
 hKsh5Iq/KLMTaG74fWwWBlNiiposVqYsA33KgMpAAbBCjddaBeEpYFeO7/vvXaEUrIF9Fi3B
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=68636aac cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=MP4aM1IlAAAA:8 a=h_0jaJnDdOg_-67HHiAA:9
 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=cNL50C5G4f5gRYKddA97:22
X-Proofpoint-GUID: OlaVFus1mhVMgJWuBB0-KMqCwcCBeDIp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=901 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010021

Hi Benno,

On 30/06/25 14:10, Benno Schulenberg wrote:
> The first argument is a priority not only for `chrt --pid <prio> <pid>`
> but also for `chrt <prio> <command> [<argument>...]`.
> 
> This fixes an oversight in recent commit e7a2d62434.
> 
> CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  schedutils/chrt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
> index 0bcdd1a1e..4c45eae80 100644
> --- a/schedutils/chrt.c
> +++ b/schedutils/chrt.c
> @@ -530,7 +530,7 @@ int main(int argc, char **argv)
>  
>  	errno = 0;
>  
> -	if (need_prio || argc - optind == 2)
> +	if (need_prio || argc - optind > 1)
>  		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
>  	else
>  		ctl->priority = 0;

LGTM.

Without this patch:
chrt 12 grep boo README
chrt: unsupported priority value for the policy: 0: see --max for valid range

With this patch:
chrt 12 grep boo README
      See: http://vger.kernel.org/majordomo-info.html#taboo

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

