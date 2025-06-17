Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3B2FA64B
	for <util-linux@vger.kernel.org>; Tue, 17 Jun 2025 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179903; cv=none; b=OWNlXFXN1ZgR/Sjpiwv7/UYxkhrnI2lAWo9/S9VP564w+fhIiRzQzVflZ3nqTQ9/N054YTf3MxDxtkunI67sBZaq7jh1km/IzuMwnaa/T6Z+WF/DRkAlzhI6uUxVLlhUFeqvflIpRv7php0BK1oaPt3CzIVVLgHuPvC37g8y5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179903; c=relaxed/simple;
	bh=el1erH9LqVO8/g1T3QrtUc5hckAI4aNl0Q1HjFbEG4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKBOGumd7uPuYbkJ6+D8PoJHe4GCrRF3br/UO/RTaNsnystoQovup1vZfVIbY6pEAM1Zc7mZm9Kq8YKdQu0LRrvjZcvgZ0pGjC49kEhn19PLuUjSCTBqC6bKFB/mjeXUuHSoJlihxzDx2TYyJjGHUIXNtYafqmHVaEPzlnjyzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oFm34ft9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oFm34ft9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HASlEB010546;
	Tue, 17 Jun 2025 17:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wddp7t
	XVL9vC+oy7+pHTvgcLSLrMfpcOCBxYABYVuKY=; b=oFm34ft9F+fOctkt4455Sd
	I4heIm8F8mtJbHe9/vPqgcvNK/W3Bo9D1Z8gKlFgGHKN5yPwXYj1lQbmTpWqchwn
	H75lkuL8kDsamkKu+7c7cdSzs8rUO8JZcx9YBDFT886Qy/lF7JypboMJlb2PBPFx
	dTa1KXOU/wTsvuNiMNsJ1tanNGoqJSbaT/P/wwfRgW3PIiOR3eNBt1rRxSUMps1v
	d5xlq3qmBSeA+ODfFLAZBm7nMiq744CnYv75FpBHFx8iIOL0JDhGUuJLayCvY9mA
	v0m70n8KXL5pQgC/0B2dL6NEb4yOby47gWXQ3peClE4y9C1/s+RUs/PkhRwpUqnA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790kthy13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 17:04:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HH0ZRl014267;
	Tue, 17 Jun 2025 17:04:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p42c9dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 17:04:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HH4vrl58720572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 17:04:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1779058058;
	Tue, 17 Jun 2025 17:04:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FB4458059;
	Tue, 17 Jun 2025 17:04:55 +0000 (GMT)
Received: from [9.43.86.67] (unknown [9.43.86.67])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Jun 2025 17:04:54 +0000 (GMT)
Message-ID: <f56c22e3-c855-46ef-af98-befdbed34e7d@linux.ibm.com>
Date: Tue, 17 Jun 2025 22:34:52 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chrt: Make priority optional for policies that don't use
 it
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250615192218.70289-1-vineethr@linux.ibm.com>
 <4kuoetpvezrzurjsgbu37jngbu5qteqowcdvukhoh6jlz3rcso@jr2ofz4ddfwm>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <4kuoetpvezrzurjsgbu37jngbu5qteqowcdvukhoh6jlz3rcso@jr2ofz4ddfwm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K9AyV5iWkrtW6amceHcvqc2RsgsNcnpV
X-Proofpoint-ORIG-GUID: K9AyV5iWkrtW6amceHcvqc2RsgsNcnpV
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=6851a03b cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yNCpiho_9qJUJ8dX9eAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEzMyBTYWx0ZWRfX8ekz324QvTCa +Q7f6PTFub3luPI1KZI+9HobEwGTAISlrCtVUGGlRGP0jAyM6TEhh/IoAhriRkkN+zYHga1FqDT K9CC1x/PkoKFtwrkwSiWrMgRJ2FpEWDK+vzCpmdjWmGAf0IkQ10y4XURZeCs59a7OglbMHaihjo
 93kBQV0/NBo2KLHqA/rX8/iSzArWkjVdxnicsCllH1ARpuUTShih+HQTUqyKd+qqKwRlTph/uO8 h8yIXsZObgh67h00X5zbaEoLkRrnYPfMZ7w2eqi3bjH3YyKXEbpUg0JtW2EQ4I3zhAEvUpaKzXE n+21dIj9ZETxtxCR3uxKJmFSLzBmrKAd7PvCkprel9cAZ8ANRsre0qppPYLPW36gtTDdI32FTIg
 QJOQ3sG0mRLC1EQMo5JvBf7useT1yA4T6cBqzxm1ut2rkBXA6+rxoWZLN8EATboN4Ni7umY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=982 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170133

Hi Karel,

On 17/06/25 17:35, Karel Zak wrote:
> On Mon, Jun 16, 2025 at 12:52:18AM +0530, Madadi Vineeth Reddy wrote:
>> Currently, chrt requires a priority argument even for scheduling
>> policies like SCHED_OTHER and SCHED_BATCH, which ignore it.
>>
>> This change relaxes that requirement. Now, priority is only expected
>> for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
>> is set internally and no argument is required on the command line.
>>
>> This simplifies usage when modifying runtime parameters like
>> --sched-runtime for non-realtime tasks.
>>
>> For example, to change the EEVDF tunable base_slice, one currently
>> needs to run:
>> chrt -v -o -T 1000000 -p 0 $PID
>>
>> Passing '0' after -p is not intutive and not required as priority is
>> not applicable to SCHED_OTHER tasks. Now with this patch, one can do:
>> chrt -v -o -T 1000000 -p $PID
>>
>> Passing '0' still works ensuring ABI doesn't break.
> 
> Looks good. It would be nice to update the man page and add a note  
> that -p is not required since util-linux v2.42.
> 

I believe you meant that the priority argument is not required for some
scheduling policies. The -p / --pid option is still required.

I’ll update the man page accordingly.

>> +	bool policy_needs_priority = (ctl->policy == SCHED_FIFO || ctl->policy == SCHED_RR);
> 
> Nitpicking... can't we use a shorter name, for example "need_prio"? ;-)

Sure, will update it in v2. Thanks for taking a look.

Thanks,
Madadi Vineeth Reddy

> 
>     Karel
> 

