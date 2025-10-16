Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB432143A
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616509; cv=none; b=o8rXLlVkaY09jz9lv/PW7+3gCWh+6la3ZoB1StI+6t+ig0lxKXgKO0ENdp4GrSAKOEo+ew+/EZVCHVjYXF25f7IRouW09ZtcODHyTtR2CBZ7PEU3WIS/X6MJ+0nVwwaapAFX09GncwZdeXRf3xxkYFNsZXZxVansuphbTma60KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616509; c=relaxed/simple;
	bh=aOM1AmgR1sHl3fz51imrN6vkW/erfUaVZQRoinNwGUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz9niSUNK7JMz8EyuEyLN6WgVPfS1AS3+FphJaZX3zJ1rNz33Z9ulbTB7/9z8d4IiMYQVhb3Lk6yKU3dULw06Hpo5MH1jhA0+4ZB3bTBpPAc3A5jsjsOMyFCPJXNCXXzhRqBJbCtZrzDLWCBFyoHHzA6HDMdlOGwqhNYYy/lEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h+fz1FMS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h+fz1FMS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G1nous021708;
	Thu, 16 Oct 2025 12:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uE8f71kQEg7v1v7myQS8EvDDYUDaaZ
	V5azCp38yW5Vk=; b=h+fz1FMSB7TpqzhDdKTWOVpQwDUD+EdkbItrlWK9ZcT1lm
	fk1tlr19g53tEjj4fTdCRuzTa2q9awrQEtWGPG4/9pYI3E7Pt/YJZFXrz0OLWHEB
	3uPZ8sVfdXm7Hvg23Kap24otlAbZQqEK/wBvNFGSmG+Gpr9ehzZLk/t+sSKs8HLN
	0TBdShilGv9c2pRqwFqUgbAY8fg1S2ahhIBIsaAt88xAL2UBAq3WpoHK7hBS9RKP
	RLxGFTWzYugT9obXYKQNHRQMbZJ/XSoAi08Yvv+s3Vt4f2S4c9/+X7nQ/h/FZtTi
	mZW1GU34ERzLbw2MbW5Nmb5udFz6UEAqC+p9SI1g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey92hgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 12:08:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GB02jY016759;
	Thu, 16 Oct 2025 12:08:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32k5h14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 12:08:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GC8MG837814556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 12:08:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EA4E20049;
	Thu, 16 Oct 2025 12:08:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E051420040;
	Thu, 16 Oct 2025 12:08:21 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.63.51])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Oct 2025 12:08:21 +0000 (GMT)
Date: Thu, 16 Oct 2025 14:08:20 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/6] chmem: add support for dynamic (de)configuration of
 hotplug memory
Message-ID: <aPDgNBMT7gJykEor@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20251016101701.552597-1-sumanthk@linux.ibm.com>
 <20251016101701.552597-4-sumanthk@linux.ibm.com>
 <atjssajbhhcun7nknnuuz3cvttzw5hhvfvvzkm6ls5aiayxhll@gwzakxqonpob>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atjssajbhhcun7nknnuuz3cvttzw5hhvfvvzkm6ls5aiayxhll@gwzakxqonpob>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vUfyvOzeWxqK0Wtun3H0oT4aoJI-U0WN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXyqhHT1S67z9w
 JUE2UNSLlLpinDIRqWSQ3eYwpKv/B1p26av5ECHzqZVPYUUniTDEVxTVX70sGTwR0IzJPOXhsaQ
 39jmkvPN46Eb0QAjBIe1QOXnEGFlH4S8m64R15GVk3IJ3DziPjrYLmtK8YVnosQakVxT+dWBngB
 7EZQEycaD3RAWJcuPKeKgWvE8bB+in/YDBc+1hYUj8q8YLIMrZnyn41ehHO0a7WMrSh15y6ZcSq
 p3mmMOcxivDNzb+Ze2G1PmR0lMQJVqbziHk8jTokhxLqgGX4Y1rQf4cOxlL70Hry2jl+SmtSoxg
 oaHQwm4OLzYeZVhTX7xiP1a576PIzDBCgw/HBfCS3xOYJjw37Uroq5zgUmqgiL6B01WAvx/gg4a
 ZyC6RvuSfteKJxXk5DzR6B+2nmR/aw==
X-Proofpoint-GUID: vUfyvOzeWxqK0Wtun3H0oT4aoJI-U0WN
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f0e039 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WBcR6tEeQgd7OD5LQHQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

On Thu, Oct 16, 2025 at 01:39:51PM +0200, Karel Zak wrote:
> On Thu, Oct 16, 2025 at 12:16:50PM +0200, Sumanth Korikkar wrote:
> > +
> > +static int chmem_set_memmap_on_memory(struct chmem_desc *desc, char *name)
> > +{
> > +	char str[BUFSIZ];
> > +	int rc, index;
> > +
> > +	index = strtou64_or_err(name + 6, _("Failed to parse index"));
> > +	idxtostr(desc, index, str, sizeof(str));
> > +	rc = ul_path_writef_u64(desc->sysmemconfig, desc->memmap_on_memory,
> > +				"%s/memmap_on_memory", name);
> > +	if (rc)
> > +		warn(_("%s memmap-on-memory failed"), str);
> > +	return rc;
> 
> It seems that str[BUFSIZ] and idxtostr() are necessary only in case of
> an error. How about:
> 
>         index = strtou64_or_err(name + 6, _("Failed to parse index"));
>         rc = ul_path_writef_u64(desc->sysmemconfig, desc->memmap_on_memory,
>             "%s/memmap_on_memory", name);
> 
>         if (rc) {
>             char str[BUFSIZ];
>             idxtostr(desc, index, str, sizeof(str));
>             warn(_("%s memmap-on-memory failed"), str);
>         }
> 
> Note that BUFSIZ seems excessive.

Noted. I will use the above convention.

> > +static int chmem_config(struct chmem_desc *desc, char *name, int configure)
> > +{
> > +	int mblock_configured, memmap, rc, index;
> > +	char str[BUFSIZ], state[BUFSIZ];
> > +
> > +	index = strtou64_or_err(name + 6, _("Failed to parse index"));
> > +	idxtostr(desc, index, str, sizeof(str));
> > +	rc = ul_path_readf_s32(desc->sysmemconfig, &mblock_configured, "%s/config", name);
> > +	if (rc)
> > +		goto out;
> > +	rc = ul_path_readf_s32(desc->sysmemconfig, &memmap, "%s/memmap_on_memory", name);
> > +	if (rc)
> > +		goto out;
> > +	if (mblock_configured) {
> > +		if (configure) {
> > +			if (chmem_memmap_on_memory_option_enabled(desc) &&
> 
> The name is quite long. How about renaming the function to
> chmem_memmap_enabled()?

Agree.

> > +					memmap != desc->memmap_on_memory) {
> > +				if (!desc->is_size || desc->verbose)
> > +					fprintf(stdout,
> > +						_("%s must be deconfigured before using -m option\n"), str);
> > +				rc = -1;
> > +			} else if (desc->is_size) {
> > +				/*
> > +				 * Allow chmem_onoff_size() to proceed with
> > +				 * configuring different memory blocks when the
> > +				 * current block is already configured.
> > +				 */
> > +				rc = -1;
> > +			} else if (desc->verbose) {
> > +				fprintf(stdout, _("%s already configured\n"), str);
> > +			}
> > +			goto out;
> > +		} else if (ul_path_readf_buffer(desc->sysmem, state,
> > +						sizeof(state), "%s/state", name) > 0 &&
> > +			   strncmp("online", state, 6) == 0) {
> > +			if (!desc->is_size || desc->verbose)
> > +				fprintf(stdout, "%s must be offline before deconfiguration\n", str);
> 
> Here, the _( ) is missing for the message.

Will add.

> > +		if (!desc->is_size) {
> > +			if (configure)
> > +				warn(_("%s configure failed\n"), str);
> > +			else
> > +				warn(_("%s deconfigure failed\n"), str);
> 
> It's a detail, but I would suggest a different code pattern:
> 
>    warn(configure ? _("%s configure failed") :
>                     _("%s deconfigure failed"), str);
> 
>  Note that warn() (err(), ...) appends \n to the output, so do not use
>  it in the string.

Sure. I will integrate it in next version. Thanks.
