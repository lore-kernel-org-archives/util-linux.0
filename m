Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6012741AB
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616160; cv=none; b=AX8+KmZf3iAAqSKQe4DKxViLBHsGOHk0HHe7sKpIqKUmaN/U9YQzFTjfoky2FSBIBfJEwFe31M+KrRP87R3Nmm/q9FUZYwnd/JTm1RdYhBWVolxNawxS0SvG85nWXrzwiTFXVF0IF8kzwpTJMDv+beZjJqChEgCLax/wrVeEEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616160; c=relaxed/simple;
	bh=34OJ6V1pnz3leRJm+aSC5IXLqyvoUImujQja4GE3ZGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ky54H3FMiDsTQsiLuZTsz34V8YcmJqMLk2pwJrdhqjLHU2IppeoPAMYzj68z35qpCiXVUYawlX/rPLVLHEdM1xVtOpot8MLKbcZTmcdsXxRaIoGMRCe4+dG0jW2haAa+K6tzmiGJt9z3dTTphnJKu0W3muRbobjOuUqfgaoglpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MPvVA+46; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MPvVA+46"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GA9MaW002895;
	Thu, 16 Oct 2025 12:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/3eS97NVklPkCqUJzpzW6xh8xiWf/g
	r7PUorDtj4lqk=; b=MPvVA+46IbZCWbDEmOo+HL821UEoY1ZFdTfgRgh3F6m+y2
	PJ0U+myCw4TyY7gJNNVQYCfgHNt1+QK9eYRytoAipTZMkwnb6M6RDWC+lpy+zb2o
	7JcqNYtHUfSQ+9SLgptB+MaEw8j9LeTD9tLaONA5UIeawCGcT47h9+Wkscd5r/4z
	G2EsQ0Nd9BNrcn2CkwmM9FBNi/gk3DFhYOeaETbnzsZpqwxYJwL06otzvcs3K1KI
	xDoxJb1YDu3GT1mtE0bwQvzOiNhDdjyGIxNMtUfHTpNO6Z0tR1ZTfj84e/f/qhGI
	t5SgeCjnowhJBxW1d6dfny1QWBMp8AOCwaBA6zvg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpm7ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 12:02:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GB02hc016759;
	Thu, 16 Oct 2025 12:02:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32k5g7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 12:02:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GC2XC018809212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 12:02:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 932B32004D;
	Thu, 16 Oct 2025 12:02:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60B2120040;
	Thu, 16 Oct 2025 12:02:33 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.63.51])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Oct 2025 12:02:33 +0000 (GMT)
Date: Thu, 16 Oct 2025 14:02:31 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] lsmem: display global memmap on memory parameter
Message-ID: <aPDe12kiYg1II5po@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20251016101701.552597-1-sumanthk@linux.ibm.com>
 <20251016101701.552597-2-sumanthk@linux.ibm.com>
 <qdeva54xge5ksrhpwcfe4dd2wv6x5re2ue5fkcguffs2ebvwgk@hk5yjjhv7p2p>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qdeva54xge5ksrhpwcfe4dd2wv6x5re2ue5fkcguffs2ebvwgk@hk5yjjhv7p2p>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vqn3PPsn-8m8nXp3EkK8RAcUeQfScYJ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDEyNSBTYWx0ZWRfX2JjFFNZqdvD4
 I4vmiDoeATp3OSJm2hNY8gIHdwkFpiTR/DQ/zwTTHg/7IWbsucFhfRm8L+66yBTtRY/0kLbEqGo
 UTl2P909ARO9vN112q3kgiD+j8nNe+szqprkoRqUM5smpvJArK3jA98o2K5jWh9XKwgsqX5Bky6
 BGzge6SiIxeoBZAieUqfZmpM1FoK+LikHHyldQxNc8dj+zfcsmqKf55tg95kotckHsnzKeqg7Mc
 zs/EAuO8M9OxiVrclU/o8fgOH8fTGKCN1P+kS3WO/xE6uLLdtQB7667/0+1KTC+/nYY47Qd1993
 M1Wc+U9Kv9gaEbGjiAjpcXAZgr6qKjCvtKNN1DaQPY9L7z8uVfr/WMa4d9Wy/P7zPN+dOKois7/
 d1Haycp7CID9puBwQ2dr5vzL8/TlzQ==
X-Authority-Analysis: v=2.4 cv=R+wO2NRX c=1 sm=1 tr=0 ts=68f0dedc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HkbfsJhyaPTKcwa5SjIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: vqn3PPsn-8m8nXp3EkK8RAcUeQfScYJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510150125

> > +static int get_memmap_mode(char *res, char *src, int len)
> > +{
> > +	if (!strncmp(src, "Y", 1))
> > +		strncpy(res, "yes", len);
> > +	else if (!strncmp(src, "N", 1))
> > +		strncpy(res, "no", len);
> > +	else if (!strncmp(src, "force", 5))
> > +		strncpy(res, "force", len);
> > +	else
> > +		return -1;
> > +	return 0;
> 
> In other places, we translate these strings, so it should be
> N_("yes"), etc, and use _() in the final printf().

Hi Karal,

Sure. I'll add it.

> 
> > +}
> > +
> >  static void print_summary(struct lsmem *lsmem)
> >  {
> > +	const char *path = "/sys/module/memory_hotplug/parameters/memmap_on_memory";
> 
> We rarely use hardcoded paths directly in code in util-linux. How
> about adding #define _PATH_SYS_MEMMAP_PARM or something similar.

Noted. Thank you.
