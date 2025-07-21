Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FC149DFF
	for <util-linux@vger.kernel.org>; Mon, 21 Jul 2025 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112649; cv=none; b=q9LbmwPLzSQBbCMPiHPVgLvcD2DsrpOZh6c8789sg/VE/M+1O1XqrBkgcuxnFkzHod82nWPlItBpv/8hJr8hW0qx7l397CyCZdQGlRH6ODKCCqd3JgNGxADJpJZKkRiM6ApsPW6PWSlJRfm/MXuyUjK6YjapCZDeg3gxsCCocqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112649; c=relaxed/simple;
	bh=kDxUWq2fj0wwMwruwTkJa51sE4g5BBLHX96WxETiBX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cte1iAM6LbjhGiQlsZWc/90KPMEn8NqOj/ounLmi43bx16XjBSZ0KLTtzsQyM9tZq4dtr5pDwNIouoI51pZy+cR3mG/d2BE3NYXKRq/vXRIfHrSPDmA3hNcMibaPlFENQgaXWhzkLPxmYxuRX46001sus87BVgqIP4TXaeQ8Hgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bPfGUOoR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bPfGUOoR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LD0f5d004604;
	Mon, 21 Jul 2025 15:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+bsSn1
	2WpWD4HIMs1d5yLLnIrl22ugUMl6TruhJwmIw=; b=bPfGUOoRfwP6gWGQ2z67ua
	OgkVNL5jLF6oEnokrLBbp64RfbTp97p80GnjSHZaQkBfK+PdfZSVnwuI00yFqeeY
	0mD5gp7VWwN6udy7rgp0BzqqJE4bwRfAksG6hZrCWxEq4fhTJnL6T40mZ83zT5H9
	E2L15DKeOzRUdXnrANy7JrvOaD2yeEsYkbbt+TmTTK6hFkvGE2iG+t/+f91Yxmu4
	o6GNxCCODaQ0C3B50BjGDqwzBBTqq66mWO9XGEpcGEo/QjM/Xd8IyKXA0Cerl8nm
	RYiFJKUkAiAz05pPC4t1eHnh/NX7crkwBCkM0JK2pbxceOD7hMqcz4SmRWIwyroA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v9kgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 15:44:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LE0FPS024738;
	Mon, 21 Jul 2025 15:44:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd26j31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 15:44:00 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56LFhxaI27525598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 15:43:59 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 559EA58056;
	Mon, 21 Jul 2025 15:43:59 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 400385803F;
	Mon, 21 Jul 2025 15:43:57 +0000 (GMT)
Received: from [9.43.100.32] (unknown [9.43.100.32])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Jul 2025 15:43:56 +0000 (GMT)
Message-ID: <dadc4295-fea1-4faf-ba0b-ad5ce7060c7f@linux.ibm.com>
Date: Mon, 21 Jul 2025 21:13:49 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_chrt=3A_Allow_optional_priority_for_non?=
 =?UTF-8?Q?=E2=80=91prio_policies_without_--pid?=
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Benno Schulenberg <bensberg@telfort.nl>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250718190439.85359-1-vineethr@linux.ibm.com>
 <eu5csrk3f4jmwf7olhle3ukcxvdcofhgk7etss6dko3h364qhn@bxaakyetv7uk>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <eu5csrk3f4jmwf7olhle3ukcxvdcofhgk7etss6dko3h364qhn@bxaakyetv7uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8ClRruGQ-ujkEcqCXzSSFfMH3Vo6oEsr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzOSBTYWx0ZWRfXwLrnDGSeo1Ao
 9Wmq3uH5yyxALohapyFOT3XcU8o7i6QY7bvHwXnjVCVpRp9MB3tcZKnlQOlA7X+RNlREXRn8WNu
 xvTWAdf31xaAXuuxJODV1cT3fyv0jUoGl7IArbfDqv2Hu5ViUYdwyXF0X1XczRUkm1LpLGZoOl6
 hy4wN5W9f/F4rG0AJOnEdH5E5tZ7FMz+Wzds+8Bk3z0t0qRGxAlENtKXmLom/Cu/HeTSGrD778R
 Gbo/f/IQKkQ8jVKjKxLhvOMDMecFpGIhqf0A7s401zkt3Hb1Fq2GyKp7IL8OLeSoR7hx9Acf+bE
 Void+guNxWeAymGsWaSciLt2O23lz0C//sq227meDAOM0MWnLnPLew/zNevS3iCbNJ3ALrXxFSA
 kaiJC/ShJ1e4C5e7H3ZLPOTf/R17qku212rujM/vb50IBHQUCfU2XwkiqQqUKs1yoqqVyqTT
X-Proofpoint-ORIG-GUID: 8ClRruGQ-ujkEcqCXzSSFfMH3Vo6oEsr
X-Authority-Analysis: v=2.4 cv=JJQ7s9Kb c=1 sm=1 tr=0 ts=687e6041 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=5KLPUuaC_9wA:10
 a=YbWhKl2qCjIfhjeoUrIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210139

Hi Karel,

On 21/07/25 12:31, Karel Zak wrote:
> On Sat, Jul 19, 2025 at 12:34:39AM +0530, Madadi Vineeth Reddy wrote:
>> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
>> index 10ba7fbf6..44b9b9e20 100644
>> --- a/schedutils/chrt.c
>> +++ b/schedutils/chrt.c
>> @@ -395,6 +395,18 @@ static void set_sched(struct chrt_ctl *ctl)
>>  	ctl->altered = 1;
>>  }
>>  
>> +static bool is_number(const char *s)
>> +{
>> +	if (!s || *s == '\0')
>> +		return false;
>> +
>> +	for (const char *p = s; *p; p++) {
>> +		if (!isdigit((unsigned char)*p))
>> +			return false;
>> +	}
>> +	return true;
>> +}
> 
> It seems you can replace this function with isdigit_string() from  
> include/strutils.h.
> 

Will replace it.

>> +
>>  int main(int argc, char **argv)
>>  {
>>  	struct chrt_ctl _ctl = { .pid = -1, .policy = SCHED_RR }, *ctl = &_ctl;
>> @@ -503,7 +515,7 @@ int main(int argc, char **argv)
>>  		}
>>  	}
>>  
>> -	if (argc - optind < (ctl->pid == 0 ? 1 : 2)) {
>> +	if (argc - optind < 1) {
>>  		warnx(_("too few arguments"));
>>  		errtryhelp(EXIT_FAILURE);
>>  	}
>> @@ -527,7 +539,10 @@ int main(int argc, char **argv)
>>  	if (ctl->verbose)
>>  		show_sched_info(ctl);
>>  
>> -	if (argc - optind > 1) {
>> +	bool have_prio = need_prio ||
>> +		(ctl->pid == -1 ? (optind < argc && is_number(argv[optind])) : (argc - optind > 1));
>> +
>> +	if (have_prio) {
>>  		errno = 0;
>>  		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
>>  	} else
>> @@ -568,9 +583,19 @@ int main(int argc, char **argv)
>>  		show_sched_info(ctl);
>>  
>>  	if (!ctl->pid) {
>> -		argv += optind + 1;
>> -		if (strcmp(argv[0], "--") == 0)
>> +		argv += optind;
>> +
>> +		if (need_prio)
>> +			argv++;
>> +		else if (argv[0] && is_number(argv[0]))
>> +			argv++;
>> +
>> +		if (argv[0] && strcmp(argv[0], "--") == 0)
>>  			argv++;
>> +
>> +		if (!argv[0])
>> +			errx(EXIT_FAILURE, "Missing command to execute");
> 
> You need to use _() for translation, ideally with string already used in  
> other tools. For example, _("no command specified").

Sure. Will fix it in v2. Thanks for taking a look.

--
Madadi Vineeth Reddy

> 
> Thanks!
>     Karel
> 

