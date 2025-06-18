Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3E27F017
	for <util-linux@vger.kernel.org>; Wed, 18 Jun 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750240302; cv=none; b=bumm+I04e2shReIoyhv/nVOG+Lihf6o+adaxQZGAVHbyvvzVHF8dJbuAPIYqxs0nolhprJAdc/oKCuRXvsmZqCecZGSHXJNboBPIJKxSsyLWaQ+9wGiH9Gldabe8sTDanaKKZpDsGsOFouI1MoONZ7SN2GdbLjD24oEE7FmupWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750240302; c=relaxed/simple;
	bh=VQPXNtngoZ5VDpIIMK882UcriX1zpHVxTQVyPiZ35yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjIpYhmqi557OiU7Tct8BV2A957mJaF0mSlrqDAq0iHCJxEv0ORnk1vqoaWkMHzaWjTuTziOUK0aIaw3lIjXLej/xyji7E7dTploH5Jl6xfMVdYKoLnS0W1oiXZEN1Jf/XZLYildXxEkVBQZ1mZxCAaQzMvYFgY8s4W8ie9Xwgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=liiK8WEV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="liiK8WEV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I7RUCv002508;
	Wed, 18 Jun 2025 09:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BZy4B3
	3ns6SnEFV0oK+71QKEKEmWKnIXhgvllKth5mQ=; b=liiK8WEVn6kCzdpUQd7hFB
	We9d0X7Fd0axWGZgwKaQx221J7jhdjwqZEX5PnPc7XpJzFskhsivUEYS06rxxB0W
	n0/yLXR8E7y41BjGEDvDAgG9V6RQ7605PZ9bLmjzCoqnopF+CVX/A/lp0uXusNZg
	GXwgDyNUA8zbCe8knQYfNBDg+fs/mYOlq6goGCFPQrJsBwoNPD3GVWhuvMFZmq8O
	S9lQBAYhDLB0PYIXayo+gjZGjoku5jG/gOXT8rx/Ifm6qYrLzRYm0+hDsSXOp9m2
	NVlAvfumPX4bAzdpMlgM3pJo4dTPK6w/uP55qyjy7DSzoYdbXdiTHDwEp1jKNcFQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47beesuhmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 09:51:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55I6SJ8I010862;
	Wed, 18 Jun 2025 09:51:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdtgh99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 09:51:31 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55I9pUfg33817154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 09:51:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D789058052;
	Wed, 18 Jun 2025 09:51:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB75F58050;
	Wed, 18 Jun 2025 09:51:28 +0000 (GMT)
Received: from [9.43.23.146] (unknown [9.43.23.146])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Jun 2025 09:51:28 +0000 (GMT)
Message-ID: <bbd6aabd-707d-4fee-b80c-36749cf7c531@linux.ibm.com>
Date: Wed, 18 Jun 2025 15:21:27 +0530
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
Cc: util-linux@vger.kernel.org, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
 <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T153sXk4M5bNlpUAkRTuK-7upnCorU3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA4NCBTYWx0ZWRfX4JOCCL5cdBl+ niD0fAlSDKFnSMywJRoI6JqYeivNWk3rq7yt0EXiFU5+g6kl9OhQOMoSceY39TzrrK0SOYDXCnI rkhUWLCB5IX7rwcf2Pb/40a0hVzN2hKzCiay7O4YmqFMM0RwWZgDAaj4QtZUeEF0hFI3eKA+bJc
 nKo/ZD2rQ5w4sFxB2E6Ez0ISOnP0av03oUrQa0SH7N17WAU8yl8H+KFWHzjNV9VBuxI9rQplPXk SdqZAIVMHp69OLyAohggPbd/5pOrqRNAM1XvsiLEoCSogzMtHursIklypzkfnzKzIlSO4Orpl1H D83LhdguA4hJH7hdQ4A3hxTuvp6sKvkKpxaME008kHDaImvBGTq/ZMyKDaMgQCEpMUllI4XYM7N
 kv5Mgf7LYayil2p5OoCyf5k1b565u/ik9nNyJTRXgkcKjgQQnnlLUsMG4F0zQUpT/qheo+U5
X-Authority-Analysis: v=2.4 cv=PrSTbxM3 c=1 sm=1 tr=0 ts=68528c24 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=9hNhjWL65vgFmQtJuUQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: T153sXk4M5bNlpUAkRTuK-7upnCorU3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_03,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180084

On 18/06/25 14:48, Karel Zak wrote:
> On Wed, Jun 18, 2025 at 10:18:29AM +0200, Benno Schulenberg wrote:
>>
>> Op 17-06-2025 om 20:24 schreef Madadi Vineeth Reddy:
>>> Currently, chrt requires a priority argument even for scheduling
>>> policies like SCHED_OTHER and SCHED_BATCH, which ignore it.
>>>
>>> This change relaxes that requirement. Now, priority is only expected
>>> for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
>>> is set internally and no argument is required on the command line.
>>
>> Doesn't this alter the "show-the-current-policy-and-priority" behavior
>> when no priority is given?  Currently `./chrt --help` says (trimmed):
>  
> Very good point. The priority policy (--{other,...}) should be
> required to ensure that the user wants to alter the setting rather
> than print the current situation. Madadi, what do you think?
> 
>>   Set policy:
>>    chrt [options] --pid <priority> <pid>
>>
>>   Get policy:
>>    chrt [options] -p <pid>
> 
> I really don't like the use of "-p." We should use "--pid" everywhere  
> (in --help, man page, and examples).

I can spin off a separate patch to consistently use --pid instead of -p
in the help text, man page, and examples.

Thanks,
Madadi Vineeth Reddy

> 
>> Without the proposed change, running `chrt --other --pid $$` says:
>>
>>   pid 1427's current scheduling policy: SCHED_OTHER
>>   pid 1427's current scheduling priority: 0
>>
>> After the change, that same command outputs nothing.  Maybe that is
>> fine, but it would require some adjustment of the docs.
> 
> This is bug.
> 
>     Karel
> 

