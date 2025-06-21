Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F96149C4A
	for <util-linux@vger.kernel.org>; Sat, 21 Jun 2025 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534036; cv=none; b=kADgeMNkYd/UwjpblSfnpUBzduEQ28/NhJBETNgs1nbUX1Q1EggYDXnwAftvqUSEpCqtSwiA4J+zN6FVvyT+UYroeCIc64gbtJD8eHt9agUpDwg3jKzG00sfvcScmxeAd54s6+1+TZEUZdzmXV+iG+q/Xd92w3ktLTpguDunUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534036; c=relaxed/simple;
	bh=BUvlrBkszFufCtYg1ZrswVVUPYWzGz4r7kou1ciqzHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D5TRKR5ZoHaJI6PNmRb7WU644ZaTrn8HTZ4dgZSGkVlsOx5VEobvBX3EBelnnOXxgkOcxQ7j7Y8UdAnGnTHYXnyZcFeNrZNDngrP3qVCvit9c9QNe4lnyjOsdRidQvM2x2jmj71e527vilnYRKGwq2KfTlQL1DhZllxO70dpv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ssV92rnr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ssV92rnr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L9ElpH012388;
	Sat, 21 Jun 2025 19:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v4ozXS
	ooDiCtoOkCsf2fbYW59UllB6DuLVLLk4+pN10=; b=ssV92rnrmSAj611i5cMVqV
	MBoe1DKGHRao7SJYTnMM5MlTuE3NkKAbQQXO2H//zfCDS8fWl5ryUTCcgCyBM3v/
	piF/mvLLlAbJHNfar33tHRRbwwCxu/VeK5lw5sPyS3gvvrSW6el2w9XWYc2p+MY4
	MuTTlahFxqHLkL/M9bwxcuBhB+h7ukMKsiydxp1u6jAXxVxhHw9w/38sc+wj3q6a
	RhdwzEg+rUybTZVNrEyZYYXFTLtdfA1Q86vBcD/6Rye4u03rYa1BbZfQSglqVko9
	YOZDGy6SkuvR0Z+l7/mdEIE1BO7Zw4oFYIv+lsN3073BhCaWiNUy7A0scp1Zb1Ew
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tasva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:27:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55LF4iYq032136;
	Sat, 21 Jun 2025 19:27:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47dnqw2j1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 19:27:06 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55LJR6Do20840998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 19:27:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB0458055;
	Sat, 21 Jun 2025 19:27:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0686B58043;
	Sat, 21 Jun 2025 19:27:04 +0000 (GMT)
Received: from [9.43.73.245] (unknown [9.43.73.245])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Jun 2025 19:27:03 +0000 (GMT)
Message-ID: <f6c52df9-5497-459c-93ae-9ecff1fb8356@linux.ibm.com>
Date: Sun, 22 Jun 2025 00:57:00 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] chrt: Only display current settings when no policy
 is specified
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@telfort.nl>
References: <20250621191956.21142-1-vineethr@linux.ibm.com>
 <20250621191956.21142-3-vineethr@linux.ibm.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250621191956.21142-3-vineethr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eCPYhmB1KQLnUMEBcHGMyRKNTVovg-nM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDEyMiBTYWx0ZWRfX3myo1C4qLEQM 4UmnsY5KSzWUrm2c+QshJ4zBjMC8ta+qYyUXLkl+zCUX1mtlEKNyWuk+fcdmTvjy7RdIH31FKY9 iqVd8flN9mVOJu/Z56HX52rjyvCouRalgx2AGKtzXDTLBrEoyyin3eLZeYwE2FyBouD2eONqo6r
 /+lEBDx7UkcUow3E8GPlTFOd9nCSQO4lgkUqri04O0Mkh1NSsotD5dp16qa+ER0P0RERP4InjSh qhc/NcQRVu6qgFs437xTjn80x9EQINyP96Kx6g8cy8x3LYB2o53HmPJKvyiJp18WScSoa7OtuNk CWPKUW/gnWbgRekpH7NAYbOqSA/1zHrhVl8hmPxNUeTsbhrzQLyW5w4Izfn73uNaKJDqPI6D1Fz
 GvedU4phIG19Hj7ztAVda7ox0W7VOEHg9J3xVBvF+EdB3oazxHMF3s/kslO2SJf0FIRtkZF5
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=6857078b cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=cU_h_M8V-9oDqACHX_UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eCPYhmB1KQLnUMEBcHGMyRKNTVovg-nM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210122

On 22/06/25 00:49, Madadi Vineeth Reddy wrote:
> Previously, running "chrt --pid <pid>" with no policy options
> would display the process’s current scheduling attributes, but
> specifying a policy without a priority (e.g. chrt --rr --pid <pid>)
> would silently fallback to displaying the same info. This was
> confusing, since a policy option normally implies an intent to
> change something.
> 
> This patch changes the behavior so that
> chrt --pid <pid> continues to show the current settings:
> 
> chrt --pid 10862
> pid 10862's current scheduling policy:  SCHED_OTHER
> pid 10862's current scheduling priority: 0
> pid 10862's current runtime parameter:  2800000
> 
> If a policy is specified but no priority follows, chrt now
> errors out:
> 
> chrt --rr --pid 10862
> chrt: policy SCHED_RR requires a priority argument
> 
> Verbose output (-v) still prints the current settings when a
> valid policy+priority is provided.
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  schedutils/chrt.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
> index 8fe748f43..40a006040 100644
> --- a/schedutils/chrt.c
> +++ b/schedutils/chrt.c
> @@ -64,7 +64,7 @@ static void __attribute__((__noreturn__)) usage(void)
>  	" chrt [options] --pid <priority> <pid>\n"), out);
>  	fputs(USAGE_SEPARATOR, out);
>  	fputs(_("Get policy:\n"
> -	" chrt [options] --pid <pid>\n"), out);
> +	" chrt --pid <pid>\n"), out);
>  
>  	fputs(USAGE_SEPARATOR, out);
>  	fputs(_("Policy options:\n"), out);
> @@ -399,6 +399,7 @@ int main(int argc, char **argv)
>  {
>  	struct chrt_ctl _ctl = { .pid = -1, .policy = SCHED_RR }, *ctl = &_ctl;
>  	int c;
> +	bool policy_given = false;
>  
>  	static const struct option longopts[] = {
>  		{ "all-tasks",  no_argument, NULL, 'a' },
> @@ -435,21 +436,25 @@ int main(int argc, char **argv)
>  		case 'b':
>  #ifdef SCHED_BATCH
>  			ctl->policy = SCHED_BATCH;
> +			policy_given = true;
>  #endif
>  			break;
>  
>  		case 'd':
>  #ifdef SCHED_DEADLINE
>  			ctl->policy = SCHED_DEADLINE;
> +			policy_given = true;
>  #endif
>  			break;
>  		case 'e':
>  #ifdef SCHED_EXT
>  			ctl->policy = SCHED_EXT;
> +			policy_given = true;
>  #endif
>  			break;
>  		case 'f':
>  			ctl->policy = SCHED_FIFO;
> +			policy_given = true;
>  			break;
>  		case 'R':
>  			ctl->reset_on_fork = 1;
> @@ -457,6 +462,7 @@ int main(int argc, char **argv)
>  		case 'i':
>  #ifdef SCHED_IDLE
>  			ctl->policy = SCHED_IDLE;
> +			policy_given = true;
>  #endif
>  			break;
>  		case 'm':
> @@ -464,6 +470,7 @@ int main(int argc, char **argv)
>  			return EXIT_SUCCESS;
>  		case 'o':
>  			ctl->policy = SCHED_OTHER;
> +			policy_given = true;
>  			break;
>  		case 'p':
>  			errno = 0;
> @@ -472,6 +479,7 @@ int main(int argc, char **argv)
>  			break;
>  		case 'r':
>  			ctl->policy = SCHED_RR;
> +			policy_given = true;
>  			break;
>  		case 'v':
>  			ctl->verbose = 1;
> @@ -501,12 +509,21 @@ int main(int argc, char **argv)
>  		errtryhelp(EXIT_FAILURE);
>  	}
>  
> -	if ((ctl->pid > -1) && (ctl->verbose || argc - optind == 1)) {
> +	/*pid exists but priority not given*/

Missed spacing in the comment. Ignore this v3. Please refer to v4.

> +	if (ctl->pid > -1 && argc - optind == 1) {
> +		/* Error if a policy was specified but no priority given */
> +		if (policy_given)
> +			errx(EXIT_FAILURE, ("policy %s requires a priority argument"),
> +						get_policy_name(ctl->policy));
> +
> +		/* If no policy specified, show current settings */
>  		show_sched_info(ctl);
> -		if (argc - optind == 1)
> -			return EXIT_SUCCESS;
> +		return EXIT_SUCCESS;
>  	}
>  
> +	if (ctl->verbose)
> +		show_sched_info(ctl);
> +
>  	errno = 0;
>  	ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
>  

