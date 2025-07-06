Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F9D35972
	for <util-linux@vger.kernel.org>; Sun,  6 Jul 2025 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751781538; cv=none; b=snxhuOYfYPJWsQS+DcpufqO4sGicblSCEHRFbtyTzzrRCenKEYWh1ScDjtdBCWPwVje0vJVdT2ugdsvdhbZj1m3fNaY0wh9MCBHPaXj9fc19ATc16aAhytqbuFlb60LbzTvL/i0JjvF42SyDPBrcypEyZdiQdf45KsndiwgW9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751781538; c=relaxed/simple;
	bh=0dhz0C4TCnPxroYHOUzgqhrChJLgxcErkyx3eypPwX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=qCm3fSR34MYu079Fx9ujLgFwC39fvjqJ38Eem0OFzHN5rofhTTyfUKsw4AHtlVgplNEe0fZhjkAFT3B3OpHXwKNmh/f4FVB4duzFDJHtEH5gQdHe5t6HkJg48An7VF0o0tqLTp1RLimz0+YDoYLd8wn7a1xbTaMTckDHOU6wK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQFSUYDj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQFSUYDj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5665HcFD011470;
	Sun, 6 Jul 2025 05:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BzcHLY
	jbHsjLr4XDExD2xbEeJYF79dyMIa3fSDdzWxk=; b=qQFSUYDjVg+UP9aX5FolSz
	QAIl18SiPVod3urG6CQDiz9x1ESHtQ61/BsPMf6NO+1B5Cn6AEcD+Bh09oTm3h4M
	x/sQbgg9ZptZI85vL/OkhgUIq9fnEX1lqzQMAxBBMkLLymrFMIKvkZCi7ms/jois
	0W683lfphKCtne3b9+Xes72GNFJstDfn87y521v4/kO3HteCRFt9iVCqjoPZ4p0i
	yC16U1MBzZY2OY/nOfGxRtGAt8JN9Jbl/34SZJ3T2miczNbzdXi1UQQKVOfbtQGD
	BVvMfo5pAgs7S6ag6u0lDF1NeNVPGZ+I+08e5DwQakvJF7GFqV5vqUjWnM87YT2g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk3kwg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Jul 2025 05:58:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5661rUpf002888;
	Sun, 6 Jul 2025 05:58:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvm0m6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Jul 2025 05:58:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5665wNDp25821876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 6 Jul 2025 05:58:24 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A588858050;
	Sun,  6 Jul 2025 05:58:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1AD658045;
	Sun,  6 Jul 2025 05:58:21 +0000 (GMT)
Received: from [9.43.71.24] (unknown [9.43.71.24])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  6 Jul 2025 05:58:21 +0000 (GMT)
Message-ID: <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
Date: Sun, 6 Jul 2025 11:28:20 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 V2] chrt: simplify the other check for too few
 arguments
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Karel Zak <kzak@redhat.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250703144752.29971-3-bensberg@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDAzNCBTYWx0ZWRfXxqifRjGC1lYA iULiL8pJF8WMfZnIBnfaSn3TAbjOR4p3FN+9i9k12qThNvcemFEKB1tfST5OrDzn48VVUKeR6gQ OHybuAvd587F3Lus1hRjPyIflNA7tf3UAn7YyYiS+p1bj4LDL2gzKdD2jIPb0FK+5UC+rfDrjlm
 5ldy4UBZlDQVym3dviypo3leyJHkX9zqPtHW3x4tajx3Xo1f6qs9U6HF0sBCaB2y0U8wO8zdIZm ymfFcvCsSggRqLkgv6rTK6wDpxYGutyM87/23O9ZLjSgiCb+bxfhe5G8sjM3KVD38kRbYj6IW8X IZTWv/qI3GEq7RIrlt8ZD1m2ZpNp8UrU4vxU+UfDI2da21pKIv4+8Sjcm/CW9a2v9fUCraJFyCg
 +1EuYqc6YnqY1GJSGMSQtpr+ffi0nbzLwqQ52rHsgRXvOJCuTOdTiU2xwHA0cbYpHnIqlhGq
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686a1098 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=MP4aM1IlAAAA:8 a=0rpJSIS3nKIaKwb6vUYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cNL50C5G4f5gRYKddA97:22
X-Proofpoint-ORIG-GUID: Q1zMY7Ks5FW6n1EpLPAWcrghuwRDhEXQ
X-Proofpoint-GUID: Q1zMY7Ks5FW6n1EpLPAWcrghuwRDhEXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507060034

On 03/07/25 20:17, Benno Schulenberg wrote:
> Without option --pid, always at least two arguments are needed:
> the <priority> value and a <command>.  (The 'need_prio' variable
> is relevant only for the --pid case.)

Yes, need_prio is only relevant for the --pid case as of now.

But priority should also be optional when --pid is not used, for
policies that don’t require it.

With your patch, this fails:
chrt --other ls
chrt: too few arguments
Try 'chrt --help' for more information.

while this works:
chrt --other 0 ls

The first case should work too, to match the behavior introduced in
commit e7a2d62434c2 ("chrt: Make priority optional for policies that don't use it").

Thanks,
Madadi Vineeth Reddy.

> 
> Also, make the error message more informative.
> 
> CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
> 
> V2: left in the call errtryhelp()
> 
>  schedutils/chrt.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
> index a72c0de26..731f995bb 100644
> --- a/schedutils/chrt.c
> +++ b/schedutils/chrt.c
> @@ -507,9 +507,8 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	if (((ctl->pid > -1) && argc - optind < (need_prio ? 1 : 0)) ||
> -	    ((ctl->pid == -1) && argc - optind < (need_prio ? 2 : 1))) {
> -		warnx(_("bad usage"));
> +	if (argc - optind < (ctl->pid > -1 ? 1 : 2)) {
> +		warnx(_("too few arguments"));
>  		errtryhelp(EXIT_FAILURE);
>  	}
>  
> @@ -530,11 +529,10 @@ int main(int argc, char **argv)
>  	if (ctl->verbose)
>  		show_sched_info(ctl);
>  
> -	errno = 0;
> -
> -	if (need_prio || argc - optind > 1)
> +	if (argc - optind > 1) {
> +		errno = 0;
>  		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
> -	else
> +	} else
>  		ctl->priority = 0;
>  
>  	if (ctl->runtime && !supports_runtime_param(ctl->policy))

