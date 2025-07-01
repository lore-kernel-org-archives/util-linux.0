Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790B72627
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751346345; cv=none; b=am3NLY4wZF8bhxFMy1eH4GllN9kFDLp5H7sm4Dhu+zU0X7fVgbDv57SvK105X8HCkYOoCjD5q5w/e82G+hA96F4OhAYDU40ulMNBdIfv6t0PUkJFHBgx5drOzfPYppgmUneVaH6WLrcnJD5FU2xnx85bRiUf1I2PskgUGuobQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751346345; c=relaxed/simple;
	bh=zEnsLco/i4Sdzv8gNmSqT++qYunHzQEnSm2ZFgLCMHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Jq6aCxMgoSMuAXJr6UGSsbSVaD2aYkKwjZBMw0Gg455dfhBhHZ4IpFDIj+Mi1FmiJVf4t1xDUyet8sdgWciW9cYdAyWZTOimqWJ826jzEweWLYzQexB6gbpVGcP5Pt27sB3fRYIjv2CQ743HA63zAhob7VZKPEN+ZBryeesb8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OFDLO9mV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OFDLO9mV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UHxCou023436;
	Tue, 1 Jul 2025 05:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F5KR9L
	wLopyF5gzEhDITkIAj43MeLzDziCwEgwJVI/I=; b=OFDLO9mVqj0mOWT7072U3P
	LqEZzgpMvJGbQ5bYcz8wKO7FszPt1ip1wYjwUKtvH9/kd3bYIbbt7I1GCqhHILoF
	w2A99fsidO6q0Ykn743z3X0yAu1aJy8byeoUUGS2bpcr2HUvy5q46QQ1Vbu0OIKn
	dCXuXnKPrR0oPwx8AUb/vFXirkjwM+taHhCDrHdcqjwUrGzOaNzXrNChnZsRrh43
	VbRO0/HlCOryHBpsp/pcanK0u5GRHJwYCNPeuKkmhWLNvBxmNiEt06YzwQSMVAXk
	M1XPPR3G3Hvuq1xxCSfqcBaTY1IaL3LV8tjnpzCK39g9cQGBX3MjtdgkQ1JUnDvg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt5kjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:05:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5613r3se012054;
	Tue, 1 Jul 2025 05:05:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7ms1hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:05:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56155YN65833302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 05:05:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D095A58056;
	Tue,  1 Jul 2025 05:05:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F31358052;
	Tue,  1 Jul 2025 05:05:33 +0000 (GMT)
Received: from [9.43.22.142] (unknown [9.43.22.142])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 05:05:33 +0000 (GMT)
Message-ID: <79eaa2c0-65be-4370-b44f-2e8a1730b671@linux.ibm.com>
Date: Tue, 1 Jul 2025 10:35:31 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] chrt: do not try to interpret the --pid option itself
 as a PID
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-2-bensberg@telfort.nl>
Content-Language: en-US
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250630084052.11041-2-bensberg@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8izTTp8uvBKmhNy3HYMTOsoypgnIdUot
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=68636ca1 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=LnwSgR3hlBWB0PiE:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=MP4aM1IlAAAA:8 a=mx1feVkCXIZ8ZGpxIVUA:9
 a=QEXdDO2ut3YA:10 a=cNL50C5G4f5gRYKddA97:22
X-Proofpoint-ORIG-GUID: 8izTTp8uvBKmhNy3HYMTOsoypgnIdUot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAyMSBTYWx0ZWRfX8ezd9OzglGeT DH78xf+1ibc+pyGiI7chuEbybghvJY1q2qn6yh5skjgYh0e6fHtzYA3aOgRiuRzpucnik33WtDf ebVXoxMNYCkxfOhM30l3wBWyRmW7zd6bQFnJiwIUFSaH07sWVZlcYKRL8E0nZWCrYn9Il9swUmv
 KZqDX/bXtm1w875ks3sKtEZ49rZH/Xu8FHP2WrZISEZyOnn2QJuIoBbNgdhDpa7GfikMadCttCl 8xrXqYH2CK7QgUNrklyGe/V8glxU0BZBZRWODOW/JWogjsZx68W6QaaoKOGanyWtdVmc6VLHzpa D0UmfRmIJwCvAkL0jLOgN56dtozCM84vlV/2b+XBYbFFEouo3m9xgu+RxU9QrWJRCpAjg3f8IFP
 +3zPB7+WM+U9k1scdZyN61JKC6IXTm1VThFZV62jxugTcGF1uaMAOwWPd8Jjd91Bwef6N17c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010021

On 30/06/25 14:10, Benno Schulenberg wrote:
> When not specifying a PID with --pid, `chrt` would report:
> 
>   chrt: invalid PID argument: '--pid'
> 
> That was silly.  After this change, `chrt --pid` will report:
> 
>   chrt: too few arguments

IMO, the current message is already helpful, and I'm not sure
the proposed one is much clearer.

Maybe something like --pid requires an argument would be clearer?

Also, I noticed that currently more than one pid can't be passed
if someone wants to update the custom slice for multiple pids at
once. I can look into adding support for that if it's helpful.

Thanks,
Madadi Vineeth Reddy

> 
> CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  schedutils/chrt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
> index 4c45eae80..8ed4d69f3 100644
> --- a/schedutils/chrt.c
> +++ b/schedutils/chrt.c
> @@ -474,6 +474,8 @@ int main(int argc, char **argv)
>  			policy_given = true;
>  			break;
>  		case 'p':
> +			if (argc - optind == 0)
> +				errx(EXIT_FAILURE, _("too few arguments"));
>  			errno = 0;
>  			/* strtopid_or_err() is not suitable here; 0 can be passed.*/
>  			ctl->pid = strtos32_or_err(argv[argc - 1], _("invalid PID argument"));

