Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2A3783D7
	for <util-linux@vger.kernel.org>; Mon,  9 Mar 2026 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048039; cv=none; b=QJhnzSuq1r1Je/w6z1K2A2lBKIu3otBg7fTTgvj071SW52uoRmeQBPdDr+PVkGt11XHPwlGvngYO7qzr/m/wRpxqgzMYmpoiufdn7X979nxKPTh+oaF8gZt+bw7EGtxxnnNGg5YNz/hq02xcRQS6RRkquuIkEltfKUQ+L1zVrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048039; c=relaxed/simple;
	bh=Jk1ujMH8TfU1kIzwqLth8cf3qt9zqwQZRcVgsn/XR38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meknMENpBnl0792VBkpEbXcwBd7NJeYEas2wIifcdlj89gfHRggqmkauPp9KSGcGFRH9bIpKLKnoMvYWrOzBG0zxB54okhc5vgQQ103KaQ70MTd2VjN0oSMKmJx12ZPZTNrHlI0UNc7bgqrYCWY57J4rI8TkYgCihHLwJqh6SXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EI0l86xt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EI0l86xt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6291DQgS1808765;
	Mon, 9 Mar 2026 09:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xA5sIHwj8QToQ+5jFhJI+oA3vcA5pt
	24qatATqrZheg=; b=EI0l86xtwBcNQTAQTJ6nkNbTIlJ9DTF1ke4OV2RstSd+UK
	bXmC1OlSgsa2nOVVGJ2SATACvAjIRtKbHxUhW5B5H26LZwjZ5GpL2icrcEKPodTn
	4iTYe/6lDqN80pet+aksg1taunfMIdyNH7nrwIdlsD+OzclLJA1J8NDAtkSQe2f1
	lGAkMzW8OyxHUJgC5rjqMA9hc/S2PR/2MwGVcgZ6S2f7QUkljtLRApW01s3F2ZYC
	IkywbrO1bWUzJcwkS+N9wMop5H1Eb6K2GTcm5xZochmZRa41GkrJX3rzGIeW0q8o
	762p1xXhi39XWZRQ77pikWoeQyk8cLurWKmIbtzA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcyw5v3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 09:20:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629679pp015750;
	Mon, 9 Mar 2026 09:20:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs121v2te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 09:20:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6299KUEv61014288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 09:20:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA8082005A;
	Mon,  9 Mar 2026 09:20:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EFC72004E;
	Mon,  9 Mar 2026 09:20:30 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.87.129.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  9 Mar 2026 09:20:30 +0000 (GMT)
Date: Mon, 9 Mar 2026 10:20:29 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] lsmem: correct the grammar of an error message
Message-ID: <aa6Q3V0XuO1C9MiH@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20260307114308.7517-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307114308.7517-1-bensberg@telfort.nl>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA4MyBTYWx0ZWRfX9BD2rWa9muXh
 NdU8+wHqJp0hpzDhJ0v6yZdjwrIN5Udl2W1NQiNwMV6dYJsvUqnOzSXCl2jEJNqiFdwvF35owhL
 44tqkEAvGlyXDtzvZ+3m6dzCJMMLrppZcy4854tCnpUdVkCu5IVRlWSV6CHaVs8O3kgl5ZMGbpb
 gg9UUjhYHiHOXKon1fjxo2qFza8EXYcAQGmcCPK5J8YsKcZFWVQYq/ytu3dvhWjHS+BSKlLfval
 4hTP8/gcldGkUfCapA2qP+HPjaW0F2V+KfhP1kb2REsh4ISyhpc0KHcT8nSY/8gFbX4rtvxIFpx
 s82XQNkw7JVxl10qsU5dYRLMnlC02dMbyXLK0I4vNhE7re6UJNEPfAzj+pRSwsGoSbaC3si3P/P
 VOO7hKemRZiEvj58I+9AXzE2TP6m7AZ6+aY5c7+IiFsG1IftT4J8jCNj8GbBq9TObO/qRqg0ihj
 OauV6w18cYIZKZ+h5xw==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69ae90e1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=MP4aM1IlAAAA:8 a=ltKeov7SimRHU_tSWTQA:9 a=CjuIK1q_8ugA:10
 a=cNL50C5G4f5gRYKddA97:22
X-Proofpoint-GUID: Y8QBffCxKzDrNv6u_ldqB7gBF-h4EKO8
X-Proofpoint-ORIG-GUID: Y8QBffCxKzDrNv6u_ldqB7gBF-h4EKO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090083

On Sat, Mar 07, 2026 at 12:43:07PM +0100, Benno Schulenberg wrote:
> That is: make the message identical to its twin nine lines back.
> 
> (The spello was introduced by commit 92d018a105 from five months ago.)
> 
> CC: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>

Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

> ---
>  sys-utils/lsmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
> index b74c95d43..aee68a171 100644
> --- a/sys-utils/lsmem.c
> +++ b/sys-utils/lsmem.c
> @@ -819,7 +819,7 @@ int main(int argc, char **argv)
>  	/* open /sys/firmware/memory handler (optional) */
>  	lsmem->sysmemconfig = ul_new_path(_PATH_SYS_MEMCONFIG);
>  	if (!lsmem->sysmemconfig)
> -		err(EXIT_FAILURE, _("failed to initialized %s handler"), _PATH_SYS_MEMCONFIG);
> +		err(EXIT_FAILURE, _("failed to initialize %s handler"), _PATH_SYS_MEMCONFIG);
>  	if (prefix && ul_path_set_prefix(lsmem->sysmemconfig, prefix) != 0)
>  		err(EXIT_FAILURE, _("invalid argument to --sysroot"));
>  
> -- 
> 2.53.0
>
