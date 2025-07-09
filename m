Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC201FAC37
	for <util-linux@vger.kernel.org>; Wed,  9 Jul 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086732; cv=none; b=FwDqlsgb4wP3ved5MbXZaBBxqBI2GFrTIEm8GRyGfV5wX4AlHrnRKLS84h6t1hQ+xOV5jB+h9Mx1/C+wnr0poOS0KCAKppV11obzSZKxYrkUv++OxQXKbcv9rxxW21vKltKLlM8Zag8vsUNqLgKfJjPlFeW1P9HNPhh5jTGQId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086732; c=relaxed/simple;
	bh=Sa2FKz9QG04M7E5IvsFq8vHHdeNCgm7Rg3AC7EQDJkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G15l3Yvkq8tYfs0D1wQjwU4WRw7C2Btf3EXmPppLL6znudV76iG0HMuCGb65EGL6Kv6r4CWojRiAzTDdtXEoI5S1dMuWnvpEZ2Xo5Y8/ddUi8SFEVS1Cgd8p/nPb640Ew9IhE6XK+tenr4zfFenRM3R3CSg65xPQPhaBVLZ1TSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A13cM4gR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A13cM4gR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569I9spw025140;
	Wed, 9 Jul 2025 18:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rDdjXP
	tcf5vV4Ub6f6kmsA63XcCbWr4jzfqTDclBmgo=; b=A13cM4gRghSKClG4xzbMcn
	kf1YjrhjzxRGaPpKrxzQaTAm521CN0cNL5rwi/UIA+gwwtkLuRSNPyZtLi9BZjMB
	mkRK/eEPP1dGF5BabmuaZTfUd9LajHaiq0oWPwU4gOKozdZJfLoDmoeGWiMHlFQI
	s7tOqQRkhDjcHmS6TR3ZdVPDx8FMBnQbr2xBzubEj4HRPEICP+6dhZkIEZNvjkab
	2tGcb4pXJ+JqKlISLddbsv9XuG8x/05mmdylYqf+xT5LQuXR0nS0KvO5Mzv8nIKu
	Ic/SFYdKcHWUdF+UMbZsun9c380Li2J9zoLTzF8XZ30Q6tbgq61KcIPhDpsYQxZQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnf8my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 18:45:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569HkP3D010832;
	Wed, 9 Jul 2025 18:45:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes09t01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 18:45:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569IjMMA23790140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 18:45:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34A2D58056;
	Wed,  9 Jul 2025 18:45:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 717795804E;
	Wed,  9 Jul 2025 18:45:20 +0000 (GMT)
Received: from [9.43.126.152] (unknown [9.43.126.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 18:45:20 +0000 (GMT)
Message-ID: <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>
Date: Thu, 10 Jul 2025 00:15:18 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chrt from git segfaults
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
 <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
 <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=686eb8c4 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=iObk0NvmZsUdKNLco8sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: e6ySbAYFSbcDM8xma6qBFUHG1K2uMZII
X-Proofpoint-ORIG-GUID: e6ySbAYFSbcDM8xma6qBFUHG1K2uMZII
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2NSBTYWx0ZWRfX3h1rIZFSAKMc fiwoHywtevSGdVj/ss6/zfl7Za12BhfWlDcFOxBcRp9TVUPzZwTYqdcC2C0K3aBld7XyVJskuB3 G3SDAhXGw87vkUP0/3ZPmcCuJOKC8THh46wmzCt534AgjtCm2OpFWvtiKjhfHWZZRJCSdu2eVNm
 gR5JL3I7laTUmeEHC0X6HYU8SV+Vn8i+sEvfHejJpZnDQsiKd5r1OcS4egkD/0Je/yriKKzhoHL Cpt8jYPjAZd1Np8n8N+Bu/M6lzF15KeuRmPu51n3g36MWxsaSKcO+vj7RUohPCIq2I4udffmubP 21abCbKvboJKtKcDhSiPzlk/b9GKmrR7LV05WGd/XqXhxN6ovriDM90t9W4aYZuzHumcHKykGgH
 WttqQdVI3KCI+c/JoTtWPu+thAhMKP7MtFO+YRL1U20B6llRG0mbwCyrCZrKjtpjrejhGD8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=568 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090165

On 09/07/25 12:42, Benno Schulenberg wrote:
> 
> Hello Vineeth,
> 
> Just in case you missed the bug report buried in the previous message:
> 
>> With current git, running `./chrt --other ls` says here:
>>
>>    Segmentatiefout (geheugendump gemaakt)
>>
>> Running valgrind on it gives:
>>
>>    ==38370== Invalid read of size 1
>>    ==38370==    by 0x10C6EB: main (chrt.c:574)
>>
>> Pointing to: if (strcmp(argv[0], "--") == 0)
> 
> My patch will prevent that case from occurring.  But if instead it
> should work, something needs fixing.

Could you spin off a patch to make sure the priority argument is
optional for policies that don’t need it, even when --pid is not used?

Thanks,
Madadi Vineeth Reddy

> 
> 
> Benno

