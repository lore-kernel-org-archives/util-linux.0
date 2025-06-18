Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C219ABC2
	for <util-linux@vger.kernel.org>; Wed, 18 Jun 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239293; cv=none; b=E5KjneLHd1htUcD3BSYR9XVOhM0NQPLhuxx8KKC1knu1kewD63RiCOWSW1wSHPWkAxM57WpsDHopPhre7GJcHjcnXxvdf6J/dhzVs4YCBLAYgXfEuFNWj1sQZICY+lcVv6P01212WUJVB2vNNoui9Uh85HqdPJKk1RGt4c+CAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239293; c=relaxed/simple;
	bh=q6rx9rM5dzygQ5dmPOO47cGNNrdooJpvdOF5s2YiUsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nI9SimZU9uESym0Qi6Mw9Qp7mUT87NK50B0xHEMz51TF42fQ0UY2dMzUo9GZT1pB/a5ZIh2VmxoH3019IfTEDRfLjisd7Ig8N2egFaNFvofkscB70WTN+etRBEriWgdI+Pbv4OVhBjcwWOEMAKPgFhvlPdZ09xdjIDhNCn8Vnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=goF1Wqys; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="goF1Wqys"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HMqxX0028077;
	Wed, 18 Jun 2025 09:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/kZo/R
	GRAn9ijSkmXVh2oRV5QiaSKIa9G4s7besN/5w=; b=goF1Wqys93fVLKb/mb+v9G
	tsMAXC1G1Ra1k3GLSFkCO3OvjpeGMyYHgSzyjvMlEORYno2x3MaIIop2NwXowuEj
	J8Qowj0lFI4TeGna4nzsR8XIRq6WMEbwm/2Hi/TTWYcuxVSp/72R3fPeUmBVU+M1
	GN7geb2dJVXigc8G3xLLNXfgboxtcjYyuq9lzDwlMl75+e5pDIFDtexfrvt5Tj/b
	92qJvXk2bJvlQAyIQBsdFsCcwl+WhQImf63FpQWHIpGD2r6+csTpSz11BApr9WVy
	uR724kzUfgGKvdMS7MT+siCUc+alK64uG7rULsy1iPfPL/sydbxz+IluxthalJng
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r25car-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 09:34:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55I83ijY000720;
	Wed, 18 Jun 2025 09:34:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdp88d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 09:34:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55I9YiGm27460174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 09:34:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E184858054;
	Wed, 18 Jun 2025 09:34:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21CAA58050;
	Wed, 18 Jun 2025 09:34:42 +0000 (GMT)
Received: from [9.43.23.146] (unknown [9.43.23.146])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Jun 2025 09:34:41 +0000 (GMT)
Message-ID: <d9d6af55-e2c2-4ff9-95e6-84d5a6f76b0a@linux.ibm.com>
Date: Wed, 18 Jun 2025 15:04:40 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
To: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
 <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
 <7qx4y3d3fnfjt2bfbqs4vfat7qb2imerqoalzgeiv25ejeypzk@5mp6rya3s2v2>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <7qx4y3d3fnfjt2bfbqs4vfat7qb2imerqoalzgeiv25ejeypzk@5mp6rya3s2v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5uZIeLprCLAmx_GVqqHRSKtSQNQswrwT
X-Proofpoint-ORIG-GUID: 5uZIeLprCLAmx_GVqqHRSKtSQNQswrwT
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=68528835 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GaexKyXGNvwg5h1hJCIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA4MCBTYWx0ZWRfX7qJXMvJPO2nO rOVikocmj3u4+6ktMXdTIYVC0xAaM6AACM3a0CtdKZd6iqdviAHVJ3M8zcOXaVcK3mqFaj3rxL6 jQhfaFxYz2B3kKuVUsPpSac6A5baHMC2RKRCgYt8kLvAQ1/3mRQrkwxtfO+RTUs2SBiVe9Vl2As
 ZJzrcqYJfRqxzhehtcu2Hh3j0pHKjt3Ih2RGOqinBNE/rKfdKuG+oI1fblH7SA+iiY7rH0Q5bwP lythpYUwtWB3J6ywRqJ3SgbLiuAGfGvGcSer09XGVgY1/Ty6ffk1TVDsxXvZyJQZIzUSKHwXqrr phcFvsTK3Am2if07p9iwNYStThLDhRDEaUY2M14Ck3C3mGVtrpCUZVGBjmJwR1oqnEsRGyEkIgc
 2LLoDJSLeFI5bNc61Omy4NDgFMu4YaGfwBrDCBQY5W8jWzh0EGsbF/oKvkwcy/rOIZaQ7qO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_03,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180080

Hi Benno, Karel

On 18/06/25 14:55, Karel Zak wrote:
> On Wed, Jun 18, 2025 at 11:18:18AM +0200, Karel Zak wrote:
>> On Wed, Jun 18, 2025 at 10:18:29AM +0200, Benno Schulenberg wrote:
>>>
>>> Op 17-06-2025 om 20:24 schreef Madadi Vineeth Reddy:
>>>> Currently, chrt requires a priority argument even for scheduling
>>>> policies like SCHED_OTHER and SCHED_BATCH, which ignore it.
>>>>
>>>> This change relaxes that requirement. Now, priority is only expected
>>>> for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
>>>> is set internally and no argument is required on the command line.
>>>
>>> Doesn't this alter the "show-the-current-policy-and-priority" behavior
>>> when no priority is given?  Currently `./chrt --help` says (trimmed):
>>  
>> Very good point. The priority policy (--{other,...}) should be
>> required to ensure that the user wants to alter the setting rather
>> than print the current situation. Madadi, what do you think?
> 
> Ah, I now read Benno's note more carefully. The code just silently ignores  
> policy when priority is not specified.
> 
> $ chrt --fifo --pid $$  
> pid 994013's current scheduling policy: SCHED_OTHER  
> pid 994013's current scheduling priority: 0
> 
> This is ugly. The question is how important it is to support this for  
> backward compatibility. I'd assume that users use "chrt --pid $$" to get  
> the current setting.
> 

chrt --pid 20570
pid 20570's current scheduling policy: SCHED_OTHER
pid 20570's current scheduling priority: 0
pid 20570's current runtime parameter: 2800000

After this patch also, we still get the current setting. Can you give it
a try with the patch applied? Let me know if I am missing something.

Thanks for taking a look.

Thanks,
Madadi Vineeth Reddy

>     Karel
> 

