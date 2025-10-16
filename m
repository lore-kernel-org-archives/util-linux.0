Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B131AF06
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616299; cv=none; b=He5Rbdegw8mjwXtrYKTEp6M7Miterzs6mwggkf/PlNG0TcUFee/F8Xwz2lBnmIb7olzNeGWuDgMC6eNrmR5VTxyqU0u/AUDsMJGwIz7IKCkW3K2Ei2h+9cMI7KwNg3GNWqBBr0jnS7O0Bc8my7+nKH49emJ1byOVg/P/GuWWi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616299; c=relaxed/simple;
	bh=TrMMYFnKy4xREUBHDoGz6YHVn7yg9iJ0kqN4OK+OPxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiJE/qX9Ll0MDwUsNgYFt5fgCptSn0fhmPfgorjQ5acrftLvpmPsewfEv0UZUPdpllLqAbuAABxiFLwkjwgql+3dkjS3OvkqheG4+uFYU2v34UIcCPuX+urDpgdVMiHncmgp3+6FEoIzmWrY9F6XUS/0m1bdzRYVLXthksdNBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d0fS7r4k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d0fS7r4k"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GBAHJ7021634;
	Thu, 16 Oct 2025 12:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=P+A56IFPCkquiffXt+CcUgx9pyf6I3
	g8pfsa8VKgU1M=; b=d0fS7r4kRDsxmTkGJtdnBiBnXb13yJpLjPogqow6qOek2W
	ghktTcWBNm2cLnlhkl/jUHyyEdWlMGupG56C4hnbZvOWUO4ZEG0aj6xKP0/pruPc
	rr2FnlL3b82RieZpUH1YOFFRuOtlAwbgrPFJQYGBK0y0lQRZPVF7qia1UyP0cmc8
	/rNfqZe6yCGGBI7YbL5iHSXKVYaQPajvhcgF8005v5I5uG1abgkogWLdbrjsGT4x
	0mPWDZhTgL9oL333shMKND9M233xW53+mWY1BbAxCfvrVpA43zHAl3ZlFwW7DO5M
	5/yu51B8rfxrBiIN1Fbfl50By4qg2ZiQOnS34E+g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey92guy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 12:04:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GA4q2F018823;
	Thu, 16 Oct 2025 12:04:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jmwkjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 12:04:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GC4qa960621070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 12:04:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 768EF2004E;
	Thu, 16 Oct 2025 12:04:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4645520040;
	Thu, 16 Oct 2025 12:04:52 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.63.51])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Oct 2025 12:04:52 +0000 (GMT)
Date: Thu, 16 Oct 2025 14:04:50 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/6] lsmem: add support to display dynamic
 (de)configuration of memory
Message-ID: <aPDfYpjNGCqU_vkV@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20251016101701.552597-1-sumanthk@linux.ibm.com>
 <20251016101701.552597-3-sumanthk@linux.ibm.com>
 <irmgnf4pymv5mjk25fhkdyxobdpe5k5mgd5n4wh6n5wufyp2gs@md2vikulk3jy>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <irmgnf4pymv5mjk25fhkdyxobdpe5k5mgd5n4wh6n5wufyp2gs@md2vikulk3jy>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rQjk_iL4m-f6YWZA9fePNziL7MFmpkUv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX891s5Nf1lbhY
 zlcVwtyz6GbMEYzVTozG+AEl+9AvowhdfQ33rEpwu+M469ybUZ4RbBMJhwEtJO+nYDlSjy9DZp2
 PbgrYmgv7Pmq0JzWj1gm9LnXOp1/8lWT6IOrZHaE12BHucXszDqMEQ2jC76WSR7W+BtH3OSQ20x
 9k113Blc3mpck6AnzGbzLp4PWnudICclfMFZk1c6DQ5nC5YrMaBV2Wg8e2VT4Cvd6PeNSALinFJ
 TdL2ESnvk4BivlYpZwUh4tXJz6lUR0GHs+VZsn9iHstxXeHduuDlQKqeVdv2SYujcfOuYSxyML+
 Tk7JqbGB3+EejvoBW7CyecGkLdHe9zwIfR6/6r6iiwJqVGejSU66syl7+c5xUcOF1wA8spX9ckD
 wSjiDRJnSIVIME2O3kifoeU7un3O+w==
X-Proofpoint-GUID: rQjk_iL4m-f6YWZA9fePNziL7MFmpkUv
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f0df67 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LSBAfAdigWB3tUgep8cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

On Thu, Oct 16, 2025 at 01:11:09PM +0200, Karel Zak wrote:
> On Thu, Oct 16, 2025 at 12:16:49PM +0200, Sumanth Korikkar wrote:
> > +static bool skip_memconfig_column(struct lsmem *lsmem, int i)
> > +{
> > +	struct coldesc *ci = get_column_desc(i);
> > +
> > +	if (!strcmp(ci->name, "MEMMAP-ON-MEMORY") || !strcmp(ci->name, "CONFIGURED")) {
> 
> Using column name strings seems fragile. It's better to use column ID
> macros to ensure the compiler verifies them.
> 
>     int id = get_column_id(num);
> 
>     if (id == COL_MEMMAP || id == COL_CONFIG)  

Sure.

> > +		if (ul_path_access(lsmem->sysmemconfig, F_OK, "memory0") == 0)
> > +			return false;
> 
> Do we need this access call? It seems like a duplicate of
> lsmem->have_memconfig, which you initialized in read_basic_info()
> using the same access() call.

Right. I will use lsmem->have_memconfig.

> > +static void read_memconfig(struct lsmem *lsmem)
> > +{
> > +	char dir[PATH_MAX];
> > +
> > +	if (ul_path_access(lsmem->sysmemconfig, F_OK, "memory0") != 0) {
> 
> The same applies if (lsmem->have_memconfig) is sufficient.

Noted. Thanks
