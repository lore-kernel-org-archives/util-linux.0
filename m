Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B34A47
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347289; cv=none; b=OkT+BLdHqmLDcPHzuaCIJR6XkDCFDky0ltfiVY3WB8dUuQnnT4W/DmE3fAVQc+nED0XoGzrBW7fXbkqrERo/mnrzD+tFWtyQsP98rf2ZWNMnsfq2hkcWrHer+A2H8EHqc08KvsPWgCXMxDjYZndJkcdn+pWl8pt/nrEB9KJajMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347289; c=relaxed/simple;
	bh=DWFKwzwmqtx7tPzVAaQjWa4QI8ENxfxrVxcC+H9OatQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=alqB7C8lki+j49jNN7VIG7X0Yp2upKo/kVFiW8Fbwvsyi2EgT8srzuUv9LEHi4c7dLLkOgndoiqsFP7R7EYFz+fjML8u3qV6WdVg9NUHKM3Uj15IW45+BOz1pBSGCGRJNi4UZdDfM9fnoWHNb6bH7XGUxTa636aOA9d40ZCqoSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ef6hDWgl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ef6hDWgl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UKxn7C027370;
	Tue, 1 Jul 2025 05:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jZycCd
	aouRLc9MWIHssqCXiEGNjr/TYRNv/iHMnkpts=; b=ef6hDWglw6/iXm72dZ6DpN
	8GpvhPzqsCYa8/v7XpJA8BEps+tNu9ew/SCU7VenAPiQC2npPHD8lRe4wlLOANhr
	tcK4mofT/joXV8OD/gGQWfoAETTVRw0Vf9ZqbGGAbJmr9Pw5UVWqAFWZauy9ID4P
	5TM8d4hh5oT5D0JU9qEX79EcRLQzsMtMlk683v/t1I6vVZrq+DyTYMKutKL7MDOz
	am9NIkXiWWVgBFVOQWai7zLdtLKAeRXfZ/FUOn4oirbctjPaj2AUVziv1SXAGPPz
	6U8GtF/NxW2Cttn9xZ0VAY4/jYbyVYmDEWQaz6sBpBF4viYiMfB19r7QDGfFFY7g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt5myc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:21:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5613r3vJ012054;
	Tue, 1 Jul 2025 05:21:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7ms2t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:21:20 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5615LJ3015532386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 05:21:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E84EA5805D;
	Tue,  1 Jul 2025 05:21:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 803E658052;
	Tue,  1 Jul 2025 05:21:17 +0000 (GMT)
Received: from [9.43.22.142] (unknown [9.43.22.142])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 05:21:17 +0000 (GMT)
Message-ID: <500d8587-136f-46a9-b34e-ca4456f754a0@linux.ibm.com>
Date: Tue, 1 Jul 2025 10:51:16 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] chrt: do not try to interpret any other option as a
 PID either
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-4-bensberg@telfort.nl>
Content-Language: en-US
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250630084052.11041-4-bensberg@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DrLqZ2GtyDb34Ev3oa6WMzeF2GSp_JAT
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=68637051 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=h6v-Vj0rM8qpTix4:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=MP4aM1IlAAAA:8 a=GZsYnREcmgbRINEaQekA:9
 a=QEXdDO2ut3YA:10 a=cNL50C5G4f5gRYKddA97:22
X-Proofpoint-ORIG-GUID: DrLqZ2GtyDb34Ev3oa6WMzeF2GSp_JAT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAyNSBTYWx0ZWRfX0Wa5VIN4KTjp 8mx9+xK90z58fpJ5qNlxn2OAMj4q+D42Oq7BNwq/cn2/doE+VLHv1lgHkRhheY3jM2r2+vddtDY PHinNCGHlkkAq2hqa1h64y7FIqg5YHAX38FOkZFVUevm6wx7gBFecve3pdBrjtMXIpTDQvfThnL
 MMccUa4HkLoUvTPJN2q6+9R3u7vpIiiX+HMueySlc5KtfLm47q2Uzeev7ZwOz2uKHYQh2PutAEH LkD3pV7XCFL15AdLc0AuhN9f3vxvJN3nRw2+BtTDk/PuU0hoeca7ITDr7Yw/ibAE4kxslbs5X1l VqNceI+6Ec465bs9RtX2thDsoI2RpK/MCwVFSCmgG2plVIByKnykFibkUBQrEZV7Mhtjldb9lGx
 Dt5khd0mA0iY0TJC553Vbu6TRtGit00mZOd3hwFF39dUMpS/6A3lyjOKDGzN8K/4t/SySgPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=783
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010025

On 30/06/25 14:10, Benno Schulenberg wrote:
> When doing, for example, `chrt --pid --max`, it would report:
> 
>   chrt: invalid PID argument: '--max'
> 

But --max is part of options right?

According to help text,
chrt [options] --pid <priority> <pid>

It should come before --pid right?

Thanks,
Madadi Vineeth Reddy

> This mistakenly gave the impression that the PID argument has to follow
> directly after the --pid option.
> 
> Avoid this by delaying the parsing of a PID until after all options have
> been parsed.  Temporarily set 'ctl->pid' to zero to indicate that a PID
> needs to be read.
> 
> After this change, `chrt --pid --max` will simply report the minimum and
> maximum valid priorities.  And `chrt --pid -v`:
> 
>   chrt: too few arguments
> 
> Also, add a missing call of gettext() for the other error message.
> 
> CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  schedutils/chrt.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
> index f5ecae6e1..f358bb273 100644
> --- a/schedutils/chrt.c
> +++ b/schedutils/chrt.c
> @@ -474,11 +474,7 @@ int main(int argc, char **argv)
>  			policy_given = true;
>  			break;
>  		case 'p':
> -			if (argc - optind == 0)
> -				errx(EXIT_FAILURE, _("too few arguments"));
> -			errno = 0;
> -			/* strtopid_or_err() is not suitable here; 0 can be passed.*/
> -			ctl->pid = strtos32_or_err(argv[argc - 1], _("invalid PID argument"));
> +			ctl->pid = 0;  /* indicate that a PID is expected */
>  			break;
>  		case 'r':
>  			ctl->policy = SCHED_RR;
> @@ -507,18 +503,20 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	if (argc - optind < (ctl->pid > -1 ? 1 : 2))
> +	if (argc - optind < (ctl->pid == 0 ? 1 : 2))
>  		errx(EXIT_FAILURE, _("too few arguments"));
>  
> -	/* pid exists but priority not given */
> -	if (ctl->pid > -1 && argc - optind == 1) {
> -		/* Error if priority is missing for a policy that requires it */
> -		if (policy_given && need_prio)
> -			errx(EXIT_FAILURE, ("policy %s requires a priority argument"),
> +	/* If option --pid was given, parse the very last argument as a PID. */
> +	if (ctl->pid == 0) {
> +		if (need_prio && argc - optind < 2)
> +			errx(EXIT_FAILURE, _("policy %s requires a priority argument"),
>  						get_policy_name(ctl->policy));
> +		errno = 0;
> +		/* strtopid_or_err() is not suitable here, as 0 can be passed. */
> +		ctl->pid = strtos32_or_err(argv[argc - 1], _("invalid PID argument"));
>  
> -		/* If no policy specified, show current settings */
> -		if (!policy_given) {
> +		/* If no policy nor priority was given, show current settings. */
> +		if (!policy_given && argc - optind == 1) {
>  			show_sched_info(ctl);
>  			return EXIT_SUCCESS;
>  		}

