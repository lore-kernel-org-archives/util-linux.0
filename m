Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105A33F8B4
	for <util-linux@vger.kernel.org>; Fri, 13 Mar 2026 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390245; cv=none; b=cKcrlvkItG/xPeyOTwb5tmAPYT5cMN81ktRRIMl+LV5o58J2aiMcEoBN34Tik2TikZBtp/cDbXsrNFIz7BrcT7WS8K8+CPHHGvSc94tHRsfMDV3ZbPaAw9Pwv2WV/163hT+JfqxYKLo6aN1pDSx+gMxUxU3ON7CXoBP48N+9qcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390245; c=relaxed/simple;
	bh=BJNQ4RNDmkp2/9Hh1NulMOZDD6GT99l6OKw4RcAfZMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arjHy3MmPsYLcOhhDMx0JlhUo6tlHFXz72ILBFh23bt7I4fN5oQZEllsLAt+q8Vm2UXWqq+2+wbeVv254YAZUskQKG5fCsPf8E8ilKDxoDi9kowEA1hC3+b+ldFtvIWFY4kKyA3IyhtcgBLZXuVJWLIEA+kwQS/YES9nL/jvLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pUSmZlKN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pUSmZlKN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6aOKc2281597;
	Fri, 13 Mar 2026 08:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=w/2oxiJZMPWqG0a0nyiJb3Piwojoh2
	vgJFV35wkgUcs=; b=pUSmZlKNOUBSu2LKdU/sr2e7wjljgr4ZB3bU2d4eYGcoX4
	26Zdn64f4nYWE6VqqxPf3MRWnYtrtYzCaLVPx56gU/GaJDLhANXMmjKM0WM/Xduh
	s1WCevZl03ua0YsUUp0ZnKcz5CKrWlOwlBwNojxGFlSkzz+y2heVBuhu/Y2qV581
	7sMyx2LcIMiGqiJRMECiJ+8sd8Vx+aLKtEjma+ymTT/pSHu7PZgTEAH9k5AZcnzh
	79CspGczhKxdo8FdA7WID9oOf8+TpU/dzeKxDsRKWUm6ziEuHcDcqxk2o1nV4BgY
	k6aqBLrVQIXhfJaNFieNLTn3vneo1T6tGB+m5nRg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91pt11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 08:23:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D53mrm021245;
	Fri, 13 Mar 2026 08:23:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9nuar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 08:23:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D8NtXY46268732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 08:23:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A01FF2004D;
	Fri, 13 Mar 2026 08:23:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59BB42004B;
	Fri, 13 Mar 2026 08:23:55 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.62.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 08:23:55 +0000 (GMT)
Date: Fri, 13 Mar 2026 09:23:53 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] lsmem: (man) correct the markup of column names, and
 improve some grammar
Message-ID: <abPJmWYR91XVpqXB@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20260307114308.7517-1-bensberg@telfort.nl>
 <20260307114308.7517-2-bensberg@telfort.nl>
 <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <d6fywjkl5vvef3uyshxi477fe6vtnzygb7sjsy5mecs7c546gd@cy73pfohzucq>
 <06c01b55-64ed-4aa3-9c28-f450fd1141f7@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c01b55-64ed-4aa3-9c28-f450fd1141f7@telfort.nl>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3C_xEo6r06MILGtNOZXvgURgjrFbpiQq
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b3c99e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=4v62AK7itTIyUUblQjMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2MyBTYWx0ZWRfX91ar+Qg2Wr/b
 bnMCrDsJkDfDZM5m3w7l01d8FJiN6Jnr51wR3QlsExSlHz2Z47E78nbUNAJ4aH3eGDXQifKJVQE
 6iHVEnHoNfat/6giQ6ljVS/OVXi5Zgi2lL7IdnENhSwGCoZ2MucwJbP1NRdp7dR/AHa91zk4+SU
 SSMmxJoRKG//zRkY/vrBqowhq/HvPVhvh+Rsy8pe1W6rPu5yfEbRmhOQNwvRfXKdBSlMp/6+DSZ
 p7brHFFdye3KGWDbM6Y6DD8SMyeyVPh8Ic88wqwAdcFUuvMkdhd/iIevbb7ZpLLud7EcizYp9iv
 v+/z9xxebGN2hfYQslgNlkj+pFDHtVihLFBwfXdBTIEdhn+64ssh2SFZ5kUXYlC8cP88/QQ0oEs
 Rp/rq6g5mUBaFI5e0/xXRDrxPtyLO19GxsKKPVDfzVQ/m+FsI4Up9p0ICD2jDmxrF+tpBwZx2+F
 0suPO4aj889nAP3aO5Q==
X-Proofpoint-ORIG-GUID: 3C_xEo6r06MILGtNOZXvgURgjrFbpiQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130063

On Thu, Mar 12, 2026 at 04:59:29PM +0100, Benno Schulenberg wrote:
> 
> Op 11-03-2026 om 13:27 schreef Karel Zak:
> > What I find relevant is "previously configured." Maybe add a sentence
> > stating that CONFIGURED and MEMMAP-ON-MEMORY for _offline_ blocks show
> > the previous setup.
> > 
> > Benno, what do you think?
> 
> I think Sumanth has agreed that my original 2/2 lsmem patch is fine
> with him.

Fine with me. 

Thanks,
Sumanth
