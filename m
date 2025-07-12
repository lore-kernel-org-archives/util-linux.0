Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92E8BEC
	for <util-linux@vger.kernel.org>; Sat, 12 Jul 2025 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752337778; cv=none; b=Vhl+073HuTifZFUi49zr0uN9yOMFqMS7+1WcHznvaerJ1PgY+CJ5vXCu8t99DBSvwTeOnVfg0kslyi6bKp+np2VN3umoateJZSeOreRgOkWQ0cCRcbBaeXM+s6JfhWdjVcX1DMw0KPyLeh8sNT/d9PTWvUcvc+y/u5nNiKeyQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752337778; c=relaxed/simple;
	bh=Qt+IeYGo3R+1cGj7UFVz4aQymVxIK5QL36BJdA3Ld3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9wKtLT637NUIcSDgM/loC+uU/bFPW+SjnS9pzrqvdm2pWSTXL9Zf+OcfhbWCjvajomLDeVzTgRZYLfbpowNptgDXxr+aUIxUHifvudODd8AbkulcU/qj/e0qJ+p0/XxrE9PefNM2v8+qTDA70AkSx2RGfgAfus+61xd6Fb4m9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WLTXklag; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WLTXklag"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56CFHlc4020220;
	Sat, 12 Jul 2025 16:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QgKZJz
	eTQAveCQkMgqUwRzUCvRFUyjb6FlpHxk01kMg=; b=WLTXklagvsmi0PZvODtjoa
	3F1iEy6ifQ642WK6mClgfFQsxy8Aeam8nW8hit1YR7RbZdSqegfsISlc83JMyiHL
	fLyv2vGBwADBV9/kDHlm38LjVeETIbzVD+5todzHTXsSzeWqBwP3GnNNeKg/YzgS
	leAuFuwRX0EhzixPixJ/sWnIhQ9UWPWCWClB1TAQISjwQExTm6ZyTADbNwnFQJ8S
	Bh0nov5ZKELU6E5z+QgW3wqyVY7zm2Rztncb9f98pGfSUhZVzPe97UXDVBJG1L2S
	QEUmZFvbXfoPrq92f+sdglLRCInNyWEFO98QnFEcUFmmAg3XA4u+tcfJgP/T2snQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cj44x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 16:29:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56CBabwI024330;
	Sat, 12 Jul 2025 16:29:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32yfe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 16:29:28 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CGTSeD31982296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 16:29:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 106AF5805A;
	Sat, 12 Jul 2025 16:29:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80D9558051;
	Sat, 12 Jul 2025 16:29:25 +0000 (GMT)
Received: from [9.43.77.79] (unknown [9.43.77.79])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 16:29:24 +0000 (GMT)
Message-ID: <7ed788ae-8bfc-4879-bdcb-6c7231f53b04@linux.ibm.com>
Date: Sat, 12 Jul 2025 21:59:23 +0530
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
 <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>
 <25e238da-af73-42fa-ad18-8d9e77d33bab@telfort.nl>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <25e238da-af73-42fa-ad18-8d9e77d33bab@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sqDlvO1HnbCpZcs2FzgIX8DPbNY3jkjM
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68728d69 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=N9IN2yx3jJwHv3qN95oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sqDlvO1HnbCpZcs2FzgIX8DPbNY3jkjM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEyNiBTYWx0ZWRfX9E/XIXe0+q26 JH479zrW56VfBFqjTfKVXeRyPunlYpcrHWI+6EbTTj0EXHKIBIpGpYgHMi3ZL3Hhu/ytf5kcS4u 9C401U6CvbG2tYqgQG2J4kVKt0UrEU08i/hqpaAolx3y7570Py32srai9aoVbH4SYq8bMo+h3Ce
 U1VeapvaSLJPE5PMaofSQ+UemWCP+FtSQLSGpbJlREB4p67s21SPq/BFR7POfS1nWW65ZI97+cl xzgzsXuATCEC2gBtOYSN/bZNi1Rz+gIbuEMfhy7oDWhcHmZDVAniZU4qI4eE64MSKq2jD0mMb9s XMOdAuGSto8+W8hma7ojBwTXAT69etGTosuBkb+I+DyI6P4VSIBwXEWXZX1nAaW2xzcJrupLIjU
 HI4dFzusTi0UP4gM+VhLxh4OeiAYW506ur/v2GaUt3zPHdWxiw8/B6ctu0eWGB2CXG5IGlaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=470 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507120126

On 10/07/25 13:41, Benno Schulenberg wrote:
> 
> Op 09-07-2025 om 20:45 schreef Madadi Vineeth Reddy:
>> Could you spin off a patch to make sure the priority argument is
>> optional for policies that don’t need it, even when --pid is not used?
> 
> No.  You broke it, you fix it.
> 

Sure, I’ll send a patch. Thanks.

Thanks,
Madadi Vineeth Reddy

> 
> Benno
> 

