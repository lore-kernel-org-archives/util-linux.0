Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9D33A9DA
	for <util-linux@vger.kernel.org>; Tue,  3 Mar 2026 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542334; cv=none; b=sVvrG/Hp8WBlFo36R8Wz34poV+JV/3I8wxoSw4gj3UcpWHsm+xDAVfCcjCMQpjEwcL21HUGaoYwru5Xz0mI0EjtwB+aEsgFDU6QCYC475o/EwpEfXXmAdzK7c303ahgH8VBuA+xU6/5r/+Nt+8PVhkd7E56uIG5ZAvbj1Ozh2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542334; c=relaxed/simple;
	bh=oufqNj+9ooHL6c8AAopFS8qTqsUZFHrx37SHhvky5gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXkzne2NMm2rxkO26oJbm6uxnIJB/yGrXfA6dA/hQn53XI6V5+9S9Ee0jIe5zut8stMAZXfMop23Uj36GnbWj871gCh33F/4BM7zQssJX8MKHS5/WI78u6Mhr/5UPfjSLNLMPReYCHDEyxoow9PMLmR5dsOthSq4N9MPUobWyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MqXOuDJu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MqXOuDJu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6237YdIK2139963;
	Tue, 3 Mar 2026 12:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YVVj7sDeRgGefXEmFWe4/1lNMC8nC/
	bh9NMczjizBh4=; b=MqXOuDJuOTspD/CXfT1lmreyhGQsScROBirxp93XiPFir+
	OYtPT7JFJtNN6UPnF1OxGp1tXhDKTgFGvgmffEx0QtlvwHK5XqLB4vKxtbtD303Q
	5uw20MfaV7T1asuQByG0G75vvtmzLBhZCvNi4S6x5BwOIbc8I+6MYWERr0i+uEqW
	FigQaXtpVVZgCwr38F/jal3GVq9p7GgdsKwCWumNMEJwYUrqj3WjpCzKnh/BaDoV
	ig16BTNYvkdTwWfjuGdy6VTg0x9L5rhq6NX08DdfKA5HwtK7mBjblR4WV53WvauN
	NpOrtMnvHLGsPBe/UfHknrd79VBVaqMr79+uHGeA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmjq0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 12:51:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623AYoUr010335;
	Tue, 3 Mar 2026 12:51:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k2526-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 12:51:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623CpvaK27525848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 12:51:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7A172004B;
	Tue,  3 Mar 2026 12:51:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EFEF20043;
	Tue,  3 Mar 2026 12:51:56 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.89.211])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Mar 2026 12:51:56 +0000 (GMT)
Date: Tue, 3 Mar 2026 13:51:55 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: Chris Hofstaedtler <zeha@debian.org>, debian-loongarch@lists.debian.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.42-rc1
Message-ID: <aabZa8JtR4C-7qMd@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
 <aaP6atFYpVqulTO1@zeha.at>
 <aaVVg4PhVKkdL2C5@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <aaWzysmPNrkPm4p1@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <pj7nqvgvazvimjhx7r3j7qt7zi2hvziv3bxjwnsaxpy45zjpxc@eimfo2zs6p5t>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pj7nqvgvazvimjhx7r3j7qt7zi2hvziv3bxjwnsaxpy45zjpxc@eimfo2zs6p5t>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5OSBTYWx0ZWRfX73PZxR2EtqBZ
 DQxRaUtwh1IOx80F7GpcsrzS24Mnnr2o7iJSMBDbE2zR7yg8aNDZYWov8klNomOAbeVQjqIDnZv
 Qgxa61TjT/Xy6B09lLubuGNrONaex36iVwtJ3HuqAGy9dmJ5E8OfZ/LJby6lRNZN7zU6oOsQQXL
 Ug9ORngZdDYDOow3Sr+OtBmesuc2e5099hEZVzIswMhhCYgzpNC4HCID96Lsbu1DQA0y8CXE/Rr
 WiegFhURDaazBcq0YSLN1p6Cn8+VzOr/B676EAX2k8hvyabPNvBPuVBVyJXMPs0/9V4cFv0u684
 eTbQrsrSkeu8CpiBCgLmKDTuBwoLgYDwcD4oRvXqe2yjbYzSZhnYa0Tlwh8X5K+VzX/2WzfZCH7
 h1kLjuRw3Hta7OhrCgLZ8yEgU7Ajn/Cqsob7rU38aP3QNgDvnB4OoJwuhCTO82Jz73eGGsA1j5v
 BG52URmZ9WE9fenphxA==
X-Proofpoint-ORIG-GUID: R88c21fdtMFMdwhQzFq5KnlO4rTAv801
X-Proofpoint-GUID: R88c21fdtMFMdwhQzFq5KnlO4rTAv801
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a6d96f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=-_-wvB4sAAAA:8 a=20KFwNOVAAAA:8 a=UO2WENG5SyYg7u0SALIA:9 a=CjuIK1q_8ugA:10
 a=7Iv3sj8nvKRcHYe3V-K9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030099

On Tue, Mar 03, 2026 at 11:08:00AM +0100, Karel Zak wrote:
> On Mon, Mar 02, 2026 at 04:59:06PM +0100, Sumanth Korikkar wrote:
> > * When --sysroot is used, do not read /sys/firmware/memory
> >   (used on s390). This makes sure lsmem reads only the memory
> >   directories inside the given sysroot, so the directory list
> >   is correct.
> 
> Hi Sumanth,
> 
> Thanks for looking into this. I think your patch is a workaround
> though. It bypasses sysmemconfig and memmap_on_memory when --sysroot
> is used rather than fixing the root cause.
> 
> The real problem is that --sysroot prefix was not applied to all sysfs
> paths. The sysmemconfig handler was never prefixed, and print_summary()
> used raw fopen() to read memmap_on_memory, completely ignoring --sysroot.
> 
> I've pushed different solution fix to
> https://github.com/util-linux/util-linux/pull/4090 
> 
> This way all sysfs reads go through the prefix, and tests produce
> consistent results regardless of the host system.
> 
>   Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>

Hi Karel,

Thanks for fixing it. I tested the pull request and it looks good to me.

Best Regards,
Sumanth
