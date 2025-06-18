Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E162F0031
	for <util-linux@vger.kernel.org>; Wed, 18 Jun 2025 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264924; cv=none; b=ED9rRY/MpjRAzd8ZySWKZMoA1cbZx2lzDisa11YXaiBmucZQkJ6+ErVBuO5RKlKR0+/+gtXUFkZzly7Szl1yyOZrP/enL/5sL75muhOErEZQo5eh7vwQD4gVRKGjw8UJbFfauPyDpU6ej431auArL/W2X2/T475ssbaXlceEafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264924; c=relaxed/simple;
	bh=+HrXkz/8XqK1gv84BkX+caCzA+e3fJbyN3vxqN3ZcUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4R4Nxo6IEdCydMCKvfg6WcK7upY8CfRqvOz9RnnQRcVL5iZVO9k8H6TJjqllQytllcZym+m4Lf2YivfRptFewrYQCECmxq9sIDumWCRfYPuP5MdR6RGyQ/gSFumO0hppX2rU7GbfCEkA87WPrXQqcTM0TTkhaf054UM/0ytUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i8fm5sNg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i8fm5sNg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IDnq1E017922;
	Wed, 18 Jun 2025 16:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=odQOxd
	XVTehXO8GNOBZKYHCfG7sTYT82zdHvrh5YUns=; b=i8fm5sNgjTyvNRZ11prDKk
	7HDigfPo77aMfYMpqs8KZNFDAgYLERF3S+CnIeS+3Fp6N4q2LCbTudHGxjzesKlO
	9DmLRVP/hlEtQn5XD+r0Vcate92wwa/+kZXdWMtk4C2PTeiJBmrf3LEclsE+1bJ2
	4pVlBFlZS6xEQowegzAHW6g0uwq5N/OocAsrbz/OVtY+8Hma35VVd5F3SzlR3NLB
	LfGC0bWT+P7fkdTdTh8u/woOx3D5TI+PB3tSIALbxLGMyYouetdYsx9kT2pX9LBZ
	6UFoux4PW6vtoStyqZLfFWbbuOnhj1er2HK4Gmahyi2/OH2W90s8rBGtwXhcYJww
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktrapj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 16:41:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55IFxqJI000752;
	Wed, 18 Jun 2025 16:41:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdp9ukc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 16:41:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55IGfnnI25559730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 16:41:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 210F858059;
	Wed, 18 Jun 2025 16:41:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C9D658053;
	Wed, 18 Jun 2025 16:41:52 +0000 (GMT)
Received: from [9.43.73.30] (unknown [9.43.73.30])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Jun 2025 16:41:52 +0000 (GMT)
Message-ID: <d3cfa396-a89f-4ff0-8424-318ed0b3c2be@linux.ibm.com>
Date: Wed, 18 Jun 2025 22:11:50 +0530
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
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <8197c011-67ff-4c84-b46a-304faa6678d6@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y6-YQbMmd97UqrWjOGT4R8O4_ljPUOAF
X-Proofpoint-ORIG-GUID: y6-YQbMmd97UqrWjOGT4R8O4_ljPUOAF
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=6852ec53 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Mjjd2qAICxlk9Ks3v4wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEzOCBTYWx0ZWRfX77e7ECeLmd7p znMA2Us/pjZH806iXLXy8P2M3SP8fZEyT8+Tp7x7hYDvCuCvNSHraIqEl+Pt9fNpbJkv/CgQ/bx HK/Z9ZrFS4bFAWFSGC4xJRLuS2J56E3ct1lVwpJ/gNtkfI1bl1tQ47Xye9zHTD8oPF6gOi0nAD1
 td6gns0K/tupwRC5nXoafd4/9i4pKqImwq9aQ6XGs74Z7ZsDgF77O0dzrNChbeD8X86Tft0iWSg BLWVvNu67FO9Dbf0fY5v9tET+ExPkhlr4eP8jzi9VyoKZ85xOCwRFHIp3v0JTZy2sdd3mAS++iD 7yHOciEyi8jqcuo1Srv8Cb5RQ3TNNKEgWhB5TByDkY7Ajnx88XJltLXRoDqRhZOlvM5tJxPbwgh
 wcp2sStNaVa7Tp2DRE/7zhLkXwM7R5XKZ39X3v/WdB5uN2S41b9DKV4s5hLb5nPOF6Un6lZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=804 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180138

On 18/06/25 17:59, Benno Schulenberg wrote:
> 
> Op 18-06-2025 om 11:51 schreef Madadi Vineeth Reddy:
>> On 18/06/25 14:48, Karel Zak wrote:
>>> On Wed, Jun 18, 2025 at 10:18:29AM +0200, Benno Schulenberg
>>> wrote:
>>>> 
>>>> Get policy: chrt [options] -p <pid>
>>> 
>>> I really don't like the use of "-p." We should use "--pid"
>>> everywhere (in --help, man page, and examples).
>> 
>> I can spin off a separate patch to consistently use --pid instead
>> of -p in the help text, man page, and examples.
> 
> It should also drop the "[options]" part from the above:

Agreed.

> 
> Get policy: chrt --pid <pid>
> 
> As Karel says, specifying an option like --other or --fifo should
> always be understood as a modification request, not as an info
> request.

Yes, my only concern is ABI shouldn't break for existing users
who might be giving options and retrieving current settings.

So, my thought is just to make priority argument optional for
policies that don't use it and keep the existing behavior as is.

I can post another patch after this discussion that removes
"[options]" for querying current settings and the issues due
to changing existing behavior could be discussed there.

Thoughts?

Thanks,
Madadi Vineeth Reddy

> 
> 
> Benno
> 

