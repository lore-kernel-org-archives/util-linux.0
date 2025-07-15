Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F63161302
	for <util-linux@vger.kernel.org>; Tue, 15 Jul 2025 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557640; cv=none; b=lh6fmgFVdYO1wIBmmjj+eycSQ9G4BLs4GEH2f+E6BIA2lqXfG+Ui+8Oyiy9yb73tJFXwAcBNPxvBrvb0zoE/ZPHwJH1R5NbselDMe5Pyw8ObKYs7cg70PtgOs/7fFH1BNYPVokQN8W8dBG7P6QC03gQw5Ns/+XFbpSxlBD74nJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557640; c=relaxed/simple;
	bh=cjMHOjmexnUcA16YsTAzkX+wAR9nvsJ1JlIsks0a0QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uw3rbl44xjt9vsMII+ZJ9gZlc9yzozz7TBuRjnpuARKSANDRqS46HGsKkyhjRbYh+Ujhv15+83ep+qloSrIy+IBK3d3zkXo9ulpvf7eqq6hwNC2FSik0/e5dGQ3Xt/oASx26fKh4YRww7QtGHuEYSCJ7oSD11Qi5hp87tzAlxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qAgjj43D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qAgjj43D"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EHxOrk014677;
	Tue, 15 Jul 2025 05:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X5xquq
	ziYC1REh0E24GEN1DvAy2AENDGBWuz+sa1FXI=; b=qAgjj43Df18Axi3AanJUuU
	w2ihVs+h1PkPo5utjO5KdDJ6Cv7IadQE+ZAdjwF4fuikH2SyYgM/TCYDG37lkPzi
	LrjWYHcuJOKsxDTsfI7pjk07f2mz7QjxLSd69bPbtk1uGmhjmtJRPgn0X/dOI58t
	eCw68icxV0doCOa1lC1UOyExVvqiB1RplNrqgtjnwhhPOF9wIYgJufSCj37MAfyW
	0NMpOs/VlIz0dnrIClRfv6jl4hJLV9p/wO3f/CL8la8w36sQPvaG5YhxAo80+J67
	LotkD1LRckUg7i4Jg/+NGvS9LtF+Lqla7R8weZImy3qhCc7D31llKUscSm/buf3w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tw6b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 05:33:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56F4RjxQ008954;
	Tue, 15 Jul 2025 05:33:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmgxma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 05:33:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56F5Xoaw28312192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 05:33:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E8A058058;
	Tue, 15 Jul 2025 05:33:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF04C58057;
	Tue, 15 Jul 2025 05:33:47 +0000 (GMT)
Received: from [9.43.34.230] (unknown [9.43.34.230])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Jul 2025 05:33:47 +0000 (GMT)
Message-ID: <41444f08-31a0-4a04-91ba-31b5c006d92f@linux.ibm.com>
Date: Tue, 15 Jul 2025 11:03:45 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 V2] chrt: do not try to interpret any other option as
 a PID either
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-4-bensberg@telfort.nl>
 <547205fc-ae34-4ac4-a7d9-d32e65b5c3cb@linux.ibm.com>
 <ceu2o6v4tz6g2hvt7olpg2v2viomyv22xm2jgodv4h4rzr4x3m@pmunyjscofn5>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <ceu2o6v4tz6g2hvt7olpg2v2viomyv22xm2jgodv4h4rzr4x3m@pmunyjscofn5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=6875e83f cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=h6v-Vj0rM8qpTix4:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=coSk2xeomUEhlL2xLOcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8bLeYWmFfGPA58oa_sOthrALaDwHyT0g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA0NiBTYWx0ZWRfXyTguf5W6VxHN qnNnVY0+IIdUjOJuY3+3XshUBqSFUG2h7LwERHaHjGBlRrOTCcnXirBniAS0odbMaPBUDPDFLEM EZF22xzKicHELLu7kVPAqaxxzkI+ItMQIr0BtfEWTgEBL5U/rOW4YZDdt9ZJyLunjBd4Ub3yoZd
 Mf7RzIP0NYe2ljHBDJ5Yh+sfF1F/2vi33RqQPWvQndW8qNkFRqlh/8oTWSuHgs5J+jMXer4iuKj U2RhyyPtFIBQ9SzINXfB7LXaVhuByHVrJB9jF+Be3oZyzqxZ940qLxTPR4bj2lKhb900XZTqsvt If2DCzHZbtU4r/h8dYYyTGL3T2x298Z2B0Yq3TyPQ/1VD5vsUbklvtE+XM+4MzT1cZg7ST6Mtf1
 Mjsi4FSx9iouf8oAk+13ol9RNgHL2FTp0J+CFSasygBjo6WS8IXFEMQdhl2z6GzC6LMz90/x
X-Proofpoint-ORIG-GUID: 8bLeYWmFfGPA58oa_sOthrALaDwHyT0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=930
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150046

On 14/07/25 16:58, Karel Zak wrote:
> On Sun, Jul 06, 2025 at 11:39:44AM +0530, Madadi Vineeth Reddy wrote:
>> On 03/07/25 20:17, Benno Schulenberg wrote:
>>> When doing, for example, `chrt --pid --max`, it would report:
>>>
>>>   chrt: invalid PID argument: '--max'
>>>
>>> This mistakenly gave the impression that the PID argument has to follow
>>> directly after the --pid option.
>>>
>>> Avoid this by delaying the parsing of a PID until after all options have
>>> been parsed.  Temporarily set 'ctl->pid' to zero to indicate that a PID
>>> needs to be read.
>>>
>>> After this change, `chrt --pid --max` will simply report the minimum and
>>> maximum valid priorities.  And `chrt --pid -v`:
>>
>> According to help text,
>> chrt [options] --pid <priority> <pid>
>>
>> I’m still not sure about allowing the --max option after --pid.
>> I’ll leave it to Karel to decide what’s best here.
> 
> My point of view (may be wrong, sched-utils CLI is odd). The core of  
> the chrt command line can be described as:
> 
>    chrt <options> [<prio>] <process>
> 
> where <process> is
> 
>     1) new process by exec()
>     2) already running process
> 
> The default is 1), --pid enables the 2) and in this case  
> <process> is PID.
> 
> The --pid is just an option to switch between the cases. There is no  
> argument for the option; it informs how to interpret the <process>.
> 
> The ideal would be to use "--" before <process>.
> 
> It means that arbitrary options could be after --pid, including --max.
> 
> Does it make sense?
> 

Yes. That makes sense.

Thanks,
Madadi Vineeth Reddy

>     Karel
> 

