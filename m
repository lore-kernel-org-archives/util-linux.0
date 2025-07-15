Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E042D3757
	for <util-linux@vger.kernel.org>; Tue, 15 Jul 2025 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557398; cv=none; b=t1JoFPAC5evwiR6/rWxZbo3We20j4Dp9zYTCtG5Eyl7iu8iqppWhxG8gZ+Ur1PNefZC92U4OPYJ7356QyXjYgam+RuTWoypi/bFnyGmnN2304qFEFkv8BVCyJS+cWg5SfcHpgAG9WvDIEjNB2dfmTbRHEVAbpkjN2J7I76Upvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557398; c=relaxed/simple;
	bh=QwkgkEGlywSuhi5J3Tur8ZhqEy5RmU1HeCOpkaRhdho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcHtCff6eCmCwXywjNQpvLYrf2ycpqDb85nkcxJmYcjXegH0x8OFZlJ+vz2AgrEh/jq+qjTMDaw2dinNMbPJz1kpk6mtgWvxEl6rxtDz9WYqsPQfjkq6hM2Smz4Qv56gXqVLZOsuHVlazbefkF/6+5N/9fMlxC5n56J3BvJiZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WPtpkp06; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WPtpkp06"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EKcuBw028964;
	Tue, 15 Jul 2025 05:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nypInH
	2ILJDxvUA5hajH6eVzzeAS4+VDg0oL/QTmqko=; b=WPtpkp06dfWp5q8xhYYQtm
	6sBGjzUxri9SOAVluw2wXBQgYOKKP5v+H0H4a36vBOerWTblbX9QRfNpOZZ9AM3M
	u07/5TgOsh37GEdppS7zFEL1j4NyiG693TaKhURFRy/Kf1EK3tM1i3rfKA2PKN5M
	uTNQW57npBT5gN+kKzDMn2D88nrzQ4xf13ROgrr9NUuHKaXD8nc3817c8euXhn7Q
	WKLQEehSd9BJailz8ddwrm69vjPwiO7An7FNGN7Vhvu5tPiTEoD85KnFuNUikOGr
	ObbqrSZpkryPdnu+eikC7ojPdrAkX3ZIRfeOBEsq3iRjXEhxKEEUXrD85s6Rn1Lw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamtrk0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 05:29:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56F3hVm4025987;
	Tue, 15 Jul 2025 05:29:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31ph1u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 05:29:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56F5TmeR23069416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 05:29:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 522C45805D;
	Tue, 15 Jul 2025 05:29:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2334C58057;
	Tue, 15 Jul 2025 05:29:46 +0000 (GMT)
Received: from [9.43.34.230] (unknown [9.43.34.230])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Jul 2025 05:29:45 +0000 (GMT)
Message-ID: <f1b428c9-c54f-4b42-b689-a06ed09b43df@linux.ibm.com>
Date: Tue, 15 Jul 2025 10:59:44 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chrt from git segfaults
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Benno Schulenberg <bensberg@telfort.nl>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
 <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
 <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
 <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>
 <25e238da-af73-42fa-ad18-8d9e77d33bab@telfort.nl>
 <fgeg2ezfxn6ofip7huhofg6a6mmx2yqn37p2j32rfxn33mpgyu@c2ldx4q6zvzu>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <fgeg2ezfxn6ofip7huhofg6a6mmx2yqn37p2j32rfxn33mpgyu@c2ldx4q6zvzu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 84DTzBqgv0sXhZERFuWq6pU8AAf60J1T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA0NiBTYWx0ZWRfX8SBoWz9Pwqzf bxHaxsUxd2f0R/VRHNAF/7wfeCN+jh9FCo1+/qteDUYMAIwP1si4ILP9Fz6DayHKugVoan+HnLA dVJktvkWKoxsbhNK+VMtQqVLPTDpue0BwSOeUe6bKw0Km8vnFslIhoeKvBVKGOfNKTKLZBIbni8
 FrtBais+BStcpAhJfmt8Sv1p7BUXqe5c349bNIh08k5RI5AoYpc8pvfYl2g1Ie2z/S/79fYjoXJ A2DaF45/qng+pLtxOpavJZ3rA5xjpW+AiO8D7QXMC/m3Yje+wBNVGdamY84856ok54wvPBVdqDK rU85dv4OnOsjrPKFtJ8eVvDa2sYF/CS1kU7r0FsK+r5QAnX5TWlRMYzZcbeUEh40mP/NvV8m7WS
 9EBoFEOmRz2L5f0W1s0KffIKuogMbN3WuD07SnAnfEEDE3QOmYczMjS/UX5O1iUODNjwgPaA
X-Proofpoint-ORIG-GUID: 84DTzBqgv0sXhZERFuWq6pU8AAf60J1T
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=6875e74d cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KzwfLda3LRYclPMJMDQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=688 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150046

Hi Karel,

On 14/07/25 17:02, Karel Zak wrote:
> On Thu, Jul 10, 2025 at 10:11:58AM +0200, Benno Schulenberg wrote:
>>
>> Op 09-07-2025 om 20:45 schreef Madadi Vineeth Reddy:
>>> Could you spin off a patch to make sure the priority argument is
>>> optional for policies that don’t need it, even when --pid is not used?
>>
>> No.  You broke it, you fix it.
> 
> Please, please, don't forget to finalize it to avoid releasing it
> incomplete ;-)
> 
> I have merged Benno's V2 set of patches, so nothing else is in the
> queue for now.

I will send the patch to make the priority argument optional when
--pid is not used in the next couple of days. That should complete
the series.

Thanks,
Madadi Vineeth Reddy

> 
> Thanks guys!
> 
>     Karel
> 

