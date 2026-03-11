Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D461EEA3C
	for <util-linux@vger.kernel.org>; Wed, 11 Mar 2026 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235505; cv=none; b=klGfHd+mqQ9RmNN7+3hdLddcaL+jhueSdENRPKVEo/2O8RZxMgnxH5xV/z5CVVTZHMkNCOFP70bFnd4wbNZ4l8FTYBysqrx4ZIjrKhmrdsAMj+msIP9yQv7sBaHP3yTGqFcxVU734ng199eL6OLt1OA4XLjMDHrtWUWCh8i5G14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235505; c=relaxed/simple;
	bh=mdQnsatKo8r7NRXQ57Avq2JFkm6aImDfhsJ8Gk6EWNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2H4MG+XEeXv+9aD15zOrnocTcFRpPXLWleUkbSJhxKW7bVpyWdZcM971TFrvnk9MX6TAFjGmatwjoo8yyT4sDNTXTHZGV4gcZYUGvkdsAEj4KsweCxfNJISE82vi0hV9gYcvbZflCPrT45C9ezgJUhFocwtHuImvZgYa3Ovuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3Ai5J/d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3Ai5J/d"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B0vK293844583;
	Wed, 11 Mar 2026 13:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wzm+SA
	Ikpvdvlp0hrp67KHE2h7F2ERpRAnMmO7wfpoI=; b=S3Ai5J/dgocz140Ll5FU0i
	DNSn5UYs0SrAUmGWs4xhaqsTtPRn9gYkXwmu25tTAcZcuDhYQKrDvAOGnXZHkCH1
	eIK2jjy/JRXqYMDLA0i/B/Ea9ZZOc+X25tRHMeVEno+uVfa1Yu85pTsc/haalo2E
	lD47fAargePoW3woOyEz8pcs37ojVK31BBkur36q58XXw8trRZ5otbCJDLuo+Vp9
	oVtBB6+goPPTMtHkz6vgXCiTGXvdKT8VlhNwkOsIZsZUWAQKwedDj+w1HK6M7gmd
	vooikLteIuwvBANh/cFZSOnqN8CmSYaAmsOjH/hON2NJbbc7Ngf5LWdPSZYaGaCw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunfhge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:24:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BD3RJx015720;
	Wed, 11 Mar 2026 13:24:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1225bm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:24:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BDOong50397480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 13:24:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A57E20063;
	Wed, 11 Mar 2026 13:24:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2ABE2005A;
	Wed, 11 Mar 2026 13:24:49 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.87.159.145])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Mar 2026 13:24:49 +0000 (GMT)
Date: Wed, 11 Mar 2026 14:24:48 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] lsmem: (man) correct the markup of column names, and
 improve some grammar
Message-ID: <abFtIOGI3eO0Sskk@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20260307114308.7517-1-bensberg@telfort.nl>
 <20260307114308.7517-2-bensberg@telfort.nl>
 <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <d6fywjkl5vvef3uyshxi477fe6vtnzygb7sjsy5mecs7c546gd@cy73pfohzucq>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6fywjkl5vvef3uyshxi477fe6vtnzygb7sjsy5mecs7c546gd@cy73pfohzucq>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LxPZpuovOvZPtyt3XYSvlyq3VkmKksuE
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b16d24 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=xw421vrlQ2ej2UKS-o0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExMCBTYWx0ZWRfXzjzoMj1u1v6i
 +JXwoodpD1Wqc+UbdL68VzpB1lCViBq/kx5daA9OyE109t/R1ZCkc8Ob3LCMYnu1Hc3U88qigUZ
 lYOn6yP158qEjs4ckiuISDX1TI81sNSENezPClwE/GX5SUMHdLGyxYq8ZB09sOwqgym1p+8wEp2
 o/TQ3xD3femClzUTKZDdkDIReCmI/KPVW3Ki/Rq527swbM3nq2PS8BtE+G1Iv/pTveIDNb6gVSC
 lgApJkmaV77XbYKdZrzz2YEe77TcO3bzaKiw6uX8ZPYdQVBFLxV8gmvZno04vECNLiECfjYZNYW
 1DKYU/THn+ftR5np+5OfEwYtuwqDiiRPKFFfGXrICuNAqvNLCideUiCSlOxkcSsVD+hf1nCRuZj
 gGf5cLwpZcefKwHeqB/DyRS2CDNiDnOhbi2oOHBDH/hJafNvY8slSsr1R2b7hpIGejPIFcJ3EgV
 OvKxHse5kzGn4HwwQgg==
X-Proofpoint-ORIG-GUID: LxPZpuovOvZPtyt3XYSvlyq3VkmKksuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110110

On Wed, Mar 11, 2026 at 01:27:03PM +0100, Karel Zak wrote:
> On Mon, Mar 09, 2026 at 01:36:32PM +0100, Sumanth Korikkar wrote:
> > How about the following?
> > Example STATE, CONFIGURED, MEMMAP-ON-MEMORY states:
> > STATE   | CONFIGURED | MEMMAP-ON-MEMORY | Description
> > online  | yes        | yes              | Memory block is configured with memmap-on-memory enabled and online.
> > online  | yes        | no               | Memory block is configured with memmap-on-memory disabled and online.
> > offline | yes        | yes              | Memory block is configured but currently offline.
> > offline | no         | yes              | Memory block is deconfigured and was previously configured with memmap-on-memory.
> > offline | no         | no               | Memory block is deconfigured and was not previously configured with memmap-on-memory.

Hi Karel,

> I personally prefer structured information like lists or tables and
> dislike large text blocks ;-) 

I chose a table because I felt it would show the state combinations more
clearly. But I understand it does make the text heavier.

> However, in this case, I'm not sure if the description adds anything,
> as it repeats what is obvious from STATE, CONFIGURED, MEMMAP-ON-MEMORY
> columns.

Thanks for the feedback. In that case, we can drop the
table and keep the sentence which was proposed earlier.

> What I find relevant is "previously configured." Maybe add a sentence
> stating that CONFIGURED and MEMMAP-ON-MEMORY for _offline_ blocks show
> the previous setup.

For offline blocks, only the MEMMAP‑ON‑MEMORY value reflects the
previous setup or the initial default.  If this value isn’t changed
during the next configuration, it will simply be carried forward and
used again.

An offline but configured block is possible.
chmem -c -b <blockno> -m 1

Thanks & Regards,
Sumanth
