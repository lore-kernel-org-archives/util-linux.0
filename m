Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3E2ED179
	for <util-linux@vger.kernel.org>; Wed, 18 Jun 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264427; cv=none; b=BKwFh0NmsF3rkpqEFROaOKZgJby1bVpFBrrrcr9yUA8ncUzGAtQRvqdr+fMAhRXWtGrv6KCXohDjEfYmLkSYAtIJDCvegCdISMNECo4EzrCHf4rxzzHlLdPpYCIFXvXjHxNQR7uayVIVZ0GPr8CyW7doxpzecHYlIp/kW9QCo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264427; c=relaxed/simple;
	bh=zsZ/hssvS/JBEnhOMvHDopwHxEvIvmcmNbsFfuxvxzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLn8I6wCFGIjkE42uFNdeJD7joQ1Wy2M8ik95ZgG0XNGkj/gMmh33JWcxjJ28no2FOSvmDDB7W9I8KNVBDohuDEAfgB/Z6F3APWricqLWIl8GJoOwBW7d98cIadkd3y0PnkshXwP5ulfcKwKeQKVu4+noLoov9uoG9qZ29NNlns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a9NYi6dN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a9NYi6dN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IAfnHA014140;
	Wed, 18 Jun 2025 16:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8VwjSc
	Du1zDEFjG85tr60slFyrOSqjrw5sURxiEz6O0=; b=a9NYi6dNdSTEkg+n+mBOrJ
	nIkWzaucGSphqVIcIhDvHNASAYlTXecDagLLRS9tfcstwXv02SfdR1T2xLss2kQQ
	XC39wA7mHsbK9M7pY5SgY51/56Kil85bJztjfI9UV17zdK8NQSkM15/V6Q9EMIdN
	5Qy8nXflwQXpOo0Dkau6B+ww9WrUV0CvLAFuVhnzBUcK4KbMkTv4XeIBi6x/UU/+
	y8Ua4C0QvcgICxKh+wVlZ/Vwu2DlJ+rHigxLZvIt6+//5OZzmuZm7GnknTuF6nrF
	FdjqxQxhCFsMHDfkNm7JqJQzVO3Jfc8+pENsTeOuoKe6oFLmCiw2sChwNOuqK9KQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qpeyb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 16:33:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55IEvBDN027475;
	Wed, 18 Jun 2025 16:33:38 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479kt01xc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 16:33:38 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55IGXbrA65995198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 16:33:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 502F858059;
	Wed, 18 Jun 2025 16:33:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5968D58053;
	Wed, 18 Jun 2025 16:33:35 +0000 (GMT)
Received: from [9.43.73.30] (unknown [9.43.73.30])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Jun 2025 16:33:35 +0000 (GMT)
Message-ID: <4c8017d5-0f8a-475e-a9a3-730dd75c6ac0@linux.ibm.com>
Date: Wed, 18 Jun 2025 22:03:33 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
 <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
 <7qx4y3d3fnfjt2bfbqs4vfat7qb2imerqoalzgeiv25ejeypzk@5mp6rya3s2v2>
 <d9d6af55-e2c2-4ff9-95e6-84d5a6f76b0a@linux.ibm.com>
 <26rikpg7jp5ygfqog6yqixtzzgq5xbf2dhtmwi4qzcviduspnv@klu34u35cnrv>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <26rikpg7jp5ygfqog6yqixtzzgq5xbf2dhtmwi4qzcviduspnv@klu34u35cnrv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8zIeh9lpvNaQ9le8Sg69U83tiWDBHpZY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEzOCBTYWx0ZWRfX2EC2IVz2fiDH 7TP/Jhhr5bBwo1WfR2B8POT6sRVaD/2gLriSuKU4PIhirmEHxctae9LnxOfwzvimp4uXRM7GQJ6 ZNqzGJWrNlcujYV6XPKIqsosHTdjghQ6ooZIftxh/PRr3OSMdarezjI1O9M19TylCuAdTJLZ5nX
 uAOIJlYAV0eNY6pjE8fwSiU7f24Mlg0Tt2xk1yGEAKZejgelFSZKf32HKaVHftN/46tFcKjL/ql 4ibvhoF64rpH4FqeSujHgibsaALoEBPC6ZTMztAWDQgPuX/od50X3Z1ctL9c3bl+4Bo9NXKWsfu aRGRzVNOaf/7uLejavZnCWihaywxD724wlIR44nvriZ9MuqWqRNGsRYDpBr8TiQePeE57hYKNI7
 +KGNahwCQ1PrSjLwU+9q22SNU8g7xS8VDAYZAh9xSJ1zVtr3vmVCykBmfwcDugxGy7+muSau
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=6852ea62 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=84BeqtaS16Cz8HIrHIEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8zIeh9lpvNaQ9le8Sg69U83tiWDBHpZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180138

On 18/06/25 16:15, Karel Zak wrote:
> On Wed, Jun 18, 2025 at 03:04:40PM +0530, Madadi Vineeth Reddy wrote:
>> Hi Benno, Karel
>>
>> On 18/06/25 14:55, Karel Zak wrote:
>>> On Wed, Jun 18, 2025 at 11:18:18AM +0200, Karel Zak wrote:
>>>> On Wed, Jun 18, 2025 at 10:18:29AM +0200, Benno Schulenberg wrote:
>>>>>
>>>>> Op 17-06-2025 om 20:24 schreef Madadi Vineeth Reddy:
>>>>>> Currently, chrt requires a priority argument even for scheduling
>>>>>> policies like SCHED_OTHER and SCHED_BATCH, which ignore it.
>>>>>>
>>>>>> This change relaxes that requirement. Now, priority is only expected
>>>>>> for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
>>>>>> is set internally and no argument is required on the command line.
>>>>>
>>>>> Doesn't this alter the "show-the-current-policy-and-priority" behavior
>>>>> when no priority is given?  Currently `./chrt --help` says (trimmed):
>>>>  
>>>> Very good point. The priority policy (--{other,...}) should be
>>>> required to ensure that the user wants to alter the setting rather
>>>> than print the current situation. Madadi, what do you think?
>>>
>>> Ah, I now read Benno's note more carefully. The code just silently ignores  
>>> policy when priority is not specified.
>>>
>>> $ chrt --fifo --pid $$  
>>> pid 994013's current scheduling policy: SCHED_OTHER  
>>> pid 994013's current scheduling priority: 0
>>>
>>> This is ugly. The question is how important it is to support this for  
>>> backward compatibility. I'd assume that users use "chrt --pid $$" to get  
>>> the current setting.
>>>
>>
>> chrt --pid 20570
>> pid 20570's current scheduling policy: SCHED_OTHER
>> pid 20570's current scheduling priority: 0
>> pid 20570's current runtime parameter: 2800000
>>
>> After this patch also, we still get the current setting. Can you give it
>> a try with the patch applied? Let me know if I am missing something.
> 
> Sorry for the mess. I have finally tried it (sorry for doing it the first time).
> 
> Benno's note is that "chrt --other --pid $$" changed behavior. The old version 
> always just read the current setting if no priority was specified, and now it 
> alters scheduling and prints nothing. I guess this is the expected behavior now.
> 
> I have found that the old version silently ignores the policy option if 
> priority is not provided, and it always just displays the current setting. This 
> is ugly, and with your change, it's more ugly :), because it depends on the 
> specified policy.
> 
>   chrt --pid $$               # display current setting
> 
>   chrt --other --pid $$       # alter current setting
>   chrt --fifo --pid $$        # display current setting (--fifo ignored)
>   chrt --fifo --pid 10 $$     # alter current setting
> 
> I think with --{other,fifo,...} the command line should always be interpreted 
> as a request to alter the current setting, independently of whether priority is 
> specified.
> 
>   chrt --fifo --pid $$
> 
> needs to end with the error message "chrt: priority value for the policy 
> required" rather than display the current setting.

Agreed. So, IIUC, when using SCHED_FIFO or SCHED_RR, the priority should be
mandatory, and omitting it should result in an error. To simply print the
current settings, no scheduling policy should be specified, meaning
chrt --pid $$ should be the correct way to query the settings.

However, wouldn't this break existing behavior for users who may already be
using a command like chrt --other --pid $$ to display current settings?

As a first step, would it make sense to Keep the current behavior for
querying unchanged and just make priority optional for policies that
don't use it?

Maybe altering the existing behavior can be handled in a separate patch
with its own discussion.

What do you suggest?

Thanks,
Madadi Vineeth Reddy

> 
>     Karel
> 

