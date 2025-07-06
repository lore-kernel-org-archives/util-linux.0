Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854914A62B
	for <util-linux@vger.kernel.org>; Sun,  6 Jul 2025 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751782198; cv=none; b=pjBB2D7yVgjfDb5KidahDLcoDANu4BK8c4M7TdD1iKGw4WIxhA4fB+18lXUGT7tDnusYxv9KaIVAGL1BmHlyluC1BNWHCPjMgYms9piZ+hrUbISucLI7XKc6WdkIhy7TYG6SdqIa8vZeTmH7D8cLmDkDJv9FRsNgXEM8/BQuXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751782198; c=relaxed/simple;
	bh=hE5alva3D5bXjR4PC7Ptnwl4aN2phplvpmkSQlJEYGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=haNTQq1Pzbl4G+AH4PBmG87D/Yc89yVvMzaFgWApC9XhDysYza3uEJvStjqbDiasYXjGPZHl5gFwrfRUOL12eXZAXhMcqZGLiPrLvwaIe9as2Lh03Ku7xPEc8KfuDMcvHjylS79pVKRIaWPIa9/3P3WMXwFquo3Am74yyQBgM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SwBm8Jkk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SwBm8Jkk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5662tZ5F000821;
	Sun, 6 Jul 2025 06:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6LT32S
	kDYRgst8PUiPJGTyxldmTdGq8PGMtR+zUhBYY=; b=SwBm8JkkWdvVwP8NFC8h2S
	uAYf9NmxpLFQs5RnxvrRxMX0+uTRtqlY8gUc/J7MvcufJKaCCWxIoiE7EuIaJNP0
	zNjqemnAlQAjR+aa44f0Ic5iImthhhtxU6yl9xm3dQ6SuyrVewtaLBF3c0DL7fp/
	yC/BohPzC3JOweXFMab6GnAQiGfcQQsCsjTW/RCOPPs2pBEEIYqSFE3r+FHHFQqn
	aVvownhPLNw1tS1Nz6ytVPzp2K4it7exe1Eun8JAGgrIoh2K1uj+ph9r80hnwCM7
	g2Sd2Z2whFoCuYWX9/ScTWmenzvZJ3FMv3yqvnOfXwQpsZUSbSr8QM82R9usZk2A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqmupsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Jul 2025 06:09:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 566657kO010918;
	Sun, 6 Jul 2025 06:09:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qeryrv0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Jul 2025 06:09:49 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56669mFh24707786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 6 Jul 2025 06:09:48 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8496458050;
	Sun,  6 Jul 2025 06:09:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FDC158045;
	Sun,  6 Jul 2025 06:09:46 +0000 (GMT)
Received: from [9.43.71.24] (unknown [9.43.71.24])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  6 Jul 2025 06:09:46 +0000 (GMT)
Message-ID: <547205fc-ae34-4ac4-a7d9-d32e65b5c3cb@linux.ibm.com>
Date: Sun, 6 Jul 2025 11:39:44 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 V2] chrt: do not try to interpret any other option as
 a PID either
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-4-bensberg@telfort.nl>
Content-Language: en-US
Cc: Karel Zak <kzak@redhat.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250703144752.29971-4-bensberg@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=686a132e cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=h6v-Vj0rM8qpTix4:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=MP4aM1IlAAAA:8 a=GZsYnREcmgbRINEaQekA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cNL50C5G4f5gRYKddA97:22
X-Proofpoint-GUID: yjDNeMZ2l88A7nJxLbCmDHthoGYUcb_3
X-Proofpoint-ORIG-GUID: yjDNeMZ2l88A7nJxLbCmDHthoGYUcb_3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDAzMSBTYWx0ZWRfXxLPEjcaMT5Hh oefZugaTJeGO8VqcFuECkrNIuN+9+24/3nuvhbutJcqdLOrQtSrZSmD7he5wN8xhG3ZorNoaRyG KiLLTUxFiXZejptzGnUa7Ej7Z8OaHaoVDgqa2i7d6Dt/xt+GAxVN7psxnqZ489AyN9HTG6pRa9A
 5SEsI3ZM/SG+0RkYrIDjyQEEBJfF2Q9f5QfDeTTtSWogWzeuhfde44bYQjMW1BezOQQ5fKfvR8c 5T9ziwXf0/u/n4QRA1c2UYECH5ZZe8BeTD2ALJ9pDQ9WCzPUmZrseyVBmwbC5J7ov4o6Ej6kZWO Wv+uAd912e8HhXm1uDoaYnZb7vrKYkqAaXEKHjiNQ8j4VjlR+DKMEXmfNBVJPb5eVHdOTrB2KhN
 7d58COh3woKUvVE2AjDClAvyRFQn0w/vhM69QhgA3Q4b1yOrSVlacM0GbmlzSj62CjYRApT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=777 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507060031

On 03/07/25 20:17, Benno Schulenberg wrote:
> When doing, for example, `chrt --pid --max`, it would report:
> 
>   chrt: invalid PID argument: '--max'
> 
> This mistakenly gave the impression that the PID argument has to follow
> directly after the --pid option.
> 
> Avoid this by delaying the parsing of a PID until after all options have
> been parsed.  Temporarily set 'ctl->pid' to zero to indicate that a PID
> needs to be read.
> 
> After this change, `chrt --pid --max` will simply report the minimum and
> maximum valid priorities.  And `chrt --pid -v`:

According to help text,
chrt [options] --pid <priority> <pid>

I’m still not sure about allowing the --max option after --pid.
I’ll leave it to Karel to decide what’s best here.

Thanks,
Madadi Vineeth Reddy

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
> index 731f995bb..10ba7fbf6 100644
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
> @@ -507,20 +503,22 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	if (argc - optind < (ctl->pid > -1 ? 1 : 2)) {
> +	if (argc - optind < (ctl->pid == 0 ? 1 : 2)) {
>  		warnx(_("too few arguments"));
>  		errtryhelp(EXIT_FAILURE);
>  	}
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

