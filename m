Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38216A923
	for <util-linux@vger.kernel.org>; Fri, 20 Jun 2025 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397600; cv=none; b=NIvey2r+QVpmGVySweVuYRzZawnetd6tSMj2duLLhCmCX19pUmQHdcNof6+9tax2+YsnwBUTrketz0f3WQ4oXUc42Hcs5CvOAwzyH/OzfhDA4l4CXthE7r+/FHI4ni3vNnH9rmUbpWq+ED5P0k1nU8IGIMhwxx72coGOmWyS+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397600; c=relaxed/simple;
	bh=nwDD+QneY+zlGG/5mc64z8teMQAdIonhPlk2qja+Kw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaB2Dq5vLW1hPc1EDlx8mH4SEt2Sm/Wz+0d0ExW73ulTUIzK43FEQYZLK+SjX2duqcKri3T6h0xMuD2QCK3k+okOG0KLnIN+G+P/Y7nIg27ysIGhT8BgdVxFrrcGmQ05n1bBKet9GscMAi0gT1t5Cy5a3c7zCTvesC72Q6GBfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ef8hh3Z1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ef8hh3Z1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JJJv3G017154;
	Fri, 20 Jun 2025 05:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f1xeuH
	N/HiqZM93KoZIXDIkuSgcsRVj4k7Zo4gzR8Zs=; b=Ef8hh3Z1qSow0qIZB99FWM
	p1At+N8VtpgC+e1EOWJHP2jYojRhnlA7Lz3q578uOAh6AF4YSRWEAa3VboDlQozS
	HkbPCE3XhJye8wiavBK8hoWtyRn6goQLT0RVoMa2+L96I8nU8p9LIT2lu1dXFrfN
	cJBi6IG9UYDTpeoFKE0tV/3ubEePLM8jFSLr1/4HwE1KnFwCpr1pkoBghmtwvJ2p
	v0bhHSYLqvLSzXQC+F7Ec9gyx/SGA68cMowNCX2k9rMkR+j5nhCRjZJ59YaF8gUx
	Pq4ZC+PujB52nJhc4aZTqm//sdUqMjJJSx+e5PfBKTp1SEcKMp6lUciwHM0F+aoA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygns56p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 05:33:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55K4g5M4021671;
	Fri, 20 Jun 2025 05:33:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47cahwddnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 05:33:10 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55K5X95O7733584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 05:33:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 796BB5805B;
	Fri, 20 Jun 2025 05:33:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8656558058;
	Fri, 20 Jun 2025 05:33:07 +0000 (GMT)
Received: from [9.43.9.19] (unknown [9.43.9.19])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Jun 2025 05:33:07 +0000 (GMT)
Message-ID: <0cb78aa7-4695-4b48-97f8-22dea3d9a697@linux.ibm.com>
Date: Fri, 20 Jun 2025 11:03:05 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
To: Benno Schulenberg <bensberg@telfort.nl>, Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
 <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
 <bbd6aabd-707d-4fee-b80c-36749cf7c531@linux.ibm.com>
 <8197c011-67ff-4c84-b46a-304faa6678d6@telfort.nl>
 <d3cfa396-a89f-4ff0-8424-318ed0b3c2be@linux.ibm.com>
 <41499ee7-7d8f-4143-b560-1b02f2d1f00c@telfort.nl>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <41499ee7-7d8f-4143-b560-1b02f2d1f00c@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAzOCBTYWx0ZWRfX0XsTyJvrh+Xw vAYCdb2BF6shdMZXig5O8GMOFjWnFo8k6D/TK+J6u9iNGk2yQzVHe4piIDzowjYZ04QyresOJ17 26F8w5CXcuRbaTIrio5Qo7Shj1QhUuHAMTGKNY28F4rsKz3+0VlnXH98TtL9P8hEyWCREz99mMd
 wdiwEwruml2rz+PtMkfy42IQn4CjDV2tqp3Sq0luRxoWR1xyC2bx78oZM7G7vCIJqptdBMfzbGX mEqBSvWGxPAZS7au0L5AMnJWljp6k2lZrIJvLS84pP1bGnk1XE2CVLBVNtcMKU6tOeGBPBoO+jO z0TahfFgBcXWOgW3NPJ+k99EL+it5WEP5RiDbWB2hy1fVao+5XB6jm2M6FWPIqEBTrZr9b7sYp0
 4fKxgHxffg6g9B1xN4fnNBbL2dng4O0Z2xywgIcDu+/U4QHZzAhDN//0F8kb7xHcXiRDRHGB
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=6854f297 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=1MzE_Ic2X6CiAdAugPQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Jt5bjXXseVl-bLnTJ2kiWxIOdLdS-Gd_
X-Proofpoint-GUID: Jt5bjXXseVl-bLnTJ2kiWxIOdLdS-Gd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_01,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=938 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200038

On 19/06/25 19:45, Benno Schulenberg wrote:
> 
> Op 18-06-2025 om 18:41 schreef Madadi Vineeth Reddy:
>> So, my thought is just to make priority argument optional for
>> policies that don't use it and keep the existing behavior as is.
> 
> That's not possible.  Currently, doing something like
> 
>   ./chrt --idle --pid $$
> 
> just reports the current policy and priority, and does
> not change the policy (because the priority is missing).
> After your patch, doing the same command reports nothing
> but _does_ change the policy.  You could still make it
> report the current settings, but that would give the
> wrong idea, because it would be the _old_ settings.
> 
> So, as Karel said, silently ignoring the policy option
> when no priority was given was ugly.  Too ugly to keep
> it that way.  As Karel implied: break compatibility and
> do the sensible thing: whenever a policy option is given,
> act upon it -- and when a needed priority is missing,
> error out.
> 

Sure, that makes sense. I will send a patch with these
changes accordingly.

Thanks,
Madadi Vineeth Reddy

> 
> Benno
> 

