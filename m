Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A9A47
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347023; cv=none; b=AH8V2tQl8LPr7/G1UguRM0WGUotu74sqZ0ii8lQOsr65NijCLn7ebwjiyJ5ppA4z9NZT3KPaY1YvOSdMMmwlK4udDDmOfCCjN9rSloEc24x4H3JeFN8WhYIomRKnS0GxaLv3d/Tjd7ZLpNyG2ve/oMhKHZE7iaHT62NdgYWgVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347023; c=relaxed/simple;
	bh=HUkCxcHeicIUuY5lZhrqLRLSaDDbk920rVu4BmZUgjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=AM1andC2ry/fzsKWFg8eHbJE9ETDnREU38Of2q+6hd3xTYd+mUOgOka41z/ecB4vDR4J9wY7eH13HwlXUtgyeVuA019qNY8z57qDs89/DlY7TmzVmuZRxOzK1eHTmyCM/FpGsFYipVCFBAG/ZuoAaV9E+ndYJgMapJrBYtbyqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oFeol5F+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oFeol5F+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UM4cxa020501;
	Tue, 1 Jul 2025 05:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lSkE3/
	UDRdZUv/0D+fD/+D0RtAhY2FkpFyCTAWwCAA0=; b=oFeol5F+gdsnrPtOsvpu92
	HRcnbjz+IoKPpjaN1hAhXRXb1E+WKyDY7zReSCsJd4KZkwOTe+VvIYF0yETYxxcW
	93u6SBm255oaDqdVXWAASOSzpf0iqC5jNiYnYthRaW+ghcZcUSLmnypKA4FVpexN
	xftYWGH8H6giCRzitEPpFkuxmS6oOwSfPVZuHZWGvhgWi3PIO2FfuF2EIzvuaU0z
	wLqgUp9JlYifmma6lmNlnz0Qe1PRE3biIUY+kYQYsjIj4bdvUA3bmVc+/8HUrOlu
	Vd3REdoPYyRt+I9ohsnxPkh5QTuuyefIVr6lVG2EeTD2xW6lYHYj8ZayleY68sYQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84d5dmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:16:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56136dVe021946;
	Tue, 1 Jul 2025 05:16:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqph5bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:16:55 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5615Gsce64553314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 05:16:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B8E058056;
	Tue,  1 Jul 2025 05:16:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CEB458052;
	Tue,  1 Jul 2025 05:16:52 +0000 (GMT)
Received: from [9.43.22.142] (unknown [9.43.22.142])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 05:16:52 +0000 (GMT)
Message-ID: <4e545c8f-8e74-462f-8416-3c1cbde81b2e@linux.ibm.com>
Date: Tue, 1 Jul 2025 10:46:51 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] chrt: simplify the other check for too few arguments
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-3-bensberg@telfort.nl>
Content-Language: en-US
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250630084052.11041-3-bensberg@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LFRpskgVYDDpVNzKvXAoN-eoSoHvB-jO
X-Proofpoint-GUID: LFRpskgVYDDpVNzKvXAoN-eoSoHvB-jO
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=68636f49 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=MP4aM1IlAAAA:8 a=qL7rV15JnZKPzMrjhFUA:9 a=QEXdDO2ut3YA:10
 a=cNL50C5G4f5gRYKddA97:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAyNSBTYWx0ZWRfX1QAX/eb6WVv3 JxQUNmPOqqD5UGpPqtbIimgXYLHFHojHu6NrkDDgtrRvHj2E/mKkXCms7DGH19YZ64L/ZkCzMuX fY9EwJHTnjzjYOXW+MzDt0VWw+/yM1coaJKywdK9sxXz4uIlqWwFnvhMmrnNiiflEYWOmZ4a5IH
 zkurmGgGn9aV6C6fxtRMYr+wIu0klnl47idZ7cRLsCAKTYceYtVFviOlQrR2Z4pLVj1xWRjeIZV PTvmN9Ml1kJqKMEn6ukmxh/7fxlAxlEYJ13SRVMLxjntOWST8/f+T7/CLBAY4QB7ksEPeZGvNEN rVr+OETp76HbDqA1phj17Q4KLL7TjpuTUbWWUcyJ/345wExfVwYz/z74KYmbY1dheGs3QwjsXam
 kJEwKQbTZuvAPiDktiR1PXrEVlF354N6jkikbw8mNWXunq64sFXSOIdf4MwS8RUnOPxgu3Rf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010025

On 30/06/25 14:10, Benno Schulenberg wrote:
> Without option --pid, always at least two arguments are needed:
> the <priority> value and a <command>.  (The 'need_prio' variable
> is relevant only for the --pid case.)
> 
> Also, make the error message more informative, and do not annoyingly
> suggest that the user try `chrt --help`.

Nit: I think we could still have "Try 'chrt --help' for more information."
along with your "too few arguments" so that user knows exactly how
many arguments are needed.

As is also is fine.

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

> 
> CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  schedutils/chrt.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
> index 8ed4d69f3..f5ecae6e1 100644
> --- a/schedutils/chrt.c
> +++ b/schedutils/chrt.c
> @@ -507,11 +507,8 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	if (((ctl->pid > -1) && argc - optind < (need_prio ? 1 : 0)) ||
> -	    ((ctl->pid == -1) && argc - optind < (need_prio ? 2 : 1))) {
> -		warnx(_("bad usage"));
> -		errtryhelp(EXIT_FAILURE);
> -	}
> +	if (argc - optind < (ctl->pid > -1 ? 1 : 2))
> +		errx(EXIT_FAILURE, _("too few arguments"));
>  
>  	/* pid exists but priority not given */
>  	if (ctl->pid > -1 && argc - optind == 1) {
> @@ -530,11 +527,10 @@ int main(int argc, char **argv)
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

