Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39E2DFF03
	for <util-linux@vger.kernel.org>; Wed, 18 Jun 2025 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242196; cv=none; b=bm2Nz+jEBrCUE5QC2XUOL+YVQWXB0eUUGy5ZwBRQEXmO6LVDmHSv51YVEMzyf45L6zR6o1NjbfbQLiI+2OlpNyznImFdm7T/cW0o66sk91dsqHaPJ6affLv5rnahO09pr5YQUUjnyW0rcqpwZFyw80ugOnNnMjkb855GtVvV/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242196; c=relaxed/simple;
	bh=gzTi1Zg5/e+28llqWq26iEkWQXAscJoEfbOJHUz2XiI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fn7FqeuMTOsaLQOUPRIFue2mfDX1Z2POY6ezxxtfL57uKt+Y5HocKOoMh984h82z0XzpYB3McXfQTTcUzH3JTwa7wbbp8eLzsUSVXE5QYyVxfG9KFbzkGqQJEOgh1Tx0I5oWrqO21GaWvIWbhB/z2s/osEf/GmXBIJ3jcTuNYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZEaFbtL2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZEaFbtL2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I0KDWG014140;
	Wed, 18 Jun 2025 10:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VZYQAf
	BGFXX5C1xHJAlvxoKYS1qT2Pr9ihLVUpcZc10=; b=ZEaFbtL2azcGEmjcy1G5gL
	wq3kmpoJFB+ZBas5c5Qa6FBdO3QnPIE6sBK0fjhe2mB4gl4lpv8GCjXn3eS0z3q2
	7vWvUJpg/wWAhg7SW0+vaYXt1JdAiX8d8/O/6mKUeSuLgEt9DPAeZt23/ahKN/aB
	yVOO1MWnRQbw488yBZUQKkn75vQnwA9r5gJXAA0PxXJuKUY01pcgPpPmn9nxF/aY
	wdJb7wYpFoAwMziOPNyu9gwsW2woPJZZ2SGKrzBOevImuBy+TxPVL19ypU0sm689
	tn4xifVvSCKjRZrbD61ocsSzaE5Xj5UYxcFXyXDrO8tzxxdVdb4CbQFm51tv1ZVg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qpd0jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 10:23:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55I6wa4i027509;
	Wed, 18 Jun 2025 10:23:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479kt00jnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 10:23:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55IAN60r33227428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 10:23:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 695FB58050;
	Wed, 18 Jun 2025 10:23:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7244C58045;
	Wed, 18 Jun 2025 10:23:04 +0000 (GMT)
Received: from [9.43.23.146] (unknown [9.43.23.146])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Jun 2025 10:23:04 +0000 (GMT)
Message-ID: <eedabce7-c09a-4091-9e7e-f1118bb3224f@linux.ibm.com>
Date: Wed, 18 Jun 2025 15:53:02 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
 <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
 <7qx4y3d3fnfjt2bfbqs4vfat7qb2imerqoalzgeiv25ejeypzk@5mp6rya3s2v2>
 <d9d6af55-e2c2-4ff9-95e6-84d5a6f76b0a@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <d9d6af55-e2c2-4ff9-95e6-84d5a6f76b0a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fKZuna5SPYAF4XOwt5fd50YE631I1Rh3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA4OCBTYWx0ZWRfX3J/8Nh524Czr f0JkXCJRvD7DoIGNLbkmXr/JmubFqg0wcmu193N6XtZNZ5gJa+MBQO6SkYr6mC/RwZgzAi177rD TbhqAblBYnuEqNR+tWjY4w+9j88nlMnjouSC3BEg/lySKQIHgXa5bcZG90ndIUznX0w/gRa+Hui
 UUMLDrk5wJlR2N6VBN9+VSpb6pcCNGa1Nt9/Odosp0xdT8fMO9jd1ZFeTTlz3lKRsm1XoLswR6m 1WFK2hLYi71vQSDqMmxMSd2tDLbJ1NuyolAzvR7L13XjK2puEOPwUPQqtYdvpkMrEaeXGUanJ0p 2f9HI55ZDlIngby0fwvb8yGUL0llMM3fNIROBd0HKLMEMX3AjnZXMN4usTcliKG6RnFLO3/qMx/
 9EfWCN/tG90QpFPW/OA1JrMGpd4g5Y8xR4LWXN9jwpE3v4+kBtiYA9O+warYCeDc9dB2nxpc
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=6852938b cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=F1Zp8kwY_0gy1X0RnU0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fKZuna5SPYAF4XOwt5fd50YE631I1Rh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180088

On 18/06/25 15:04, Madadi Vineeth Reddy wrote:
> Hi Benno, Karel
> 
> On 18/06/25 14:55, Karel Zak wrote:
>> On Wed, Jun 18, 2025 at 11:18:18AM +0200, Karel Zak wrote:
>>> On Wed, Jun 18, 2025 at 10:18:29AM +0200, Benno Schulenberg wrote:
>>>>
>>>> Op 17-06-2025 om 20:24 schreef Madadi Vineeth Reddy:
>>>>> Currently, chrt requires a priority argument even for scheduling
>>>>> policies like SCHED_OTHER and SCHED_BATCH, which ignore it.
>>>>>
>>>>> This change relaxes that requirement. Now, priority is only expected
>>>>> for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
>>>>> is set internally and no argument is required on the command line.
>>>>
>>>> Doesn't this alter the "show-the-current-policy-and-priority" behavior
>>>> when no priority is given?  Currently `./chrt --help` says (trimmed):
>>>  
>>> Very good point. The priority policy (--{other,...}) should be
>>> required to ensure that the user wants to alter the setting rather
>>> than print the current situation. Madadi, what do you think?
>>
>> Ah, I now read Benno's note more carefully. The code just silently ignores  
>> policy when priority is not specified.
>>
>> $ chrt --fifo --pid $$  
>> pid 994013's current scheduling policy: SCHED_OTHER  
>> pid 994013's current scheduling priority: 0
>>
>> This is ugly. The question is how important it is to support this for  
>> backward compatibility. I'd assume that users use "chrt --pid $$" to get  
>> the current setting.
>>
> 
> chrt --pid 20570
> pid 20570's current scheduling policy: SCHED_OTHER
> pid 20570's current scheduling priority: 0
> pid 20570's current runtime parameter: 2800000
> 
> After this patch also, we still get the current setting. Can you give it
> a try with the patch applied? Let me know if I am missing something.
> 

Ah, I found my mistake. With this patch, getting the current settings only
works for SCHED_FIFO and SCHED_RR, but not for the other policies, because
we don’t print them here:

+	if ((ctl->pid > -1) && (ctl->verbose || argc - optind == (need_prio ? 1 : 0))) {
 		show_sched_info(ctl);

The condition argc - optind == (need_prio ? 1 : 0) becomes true only for
SCHED_FIFO and SCHED_RR, which causes the info to be printed only for those.

I’ll send a new version with the fix.

Thanks,
Madadi Vineeth Reddy

> Thanks for taking a look.
> 
> Thanks,
> Madadi Vineeth Reddy
> 
>>     Karel
>>
> 

