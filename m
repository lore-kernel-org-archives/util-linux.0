Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7ED3AEF33
	for <util-linux@vger.kernel.org>; Mon,  9 Mar 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059804; cv=none; b=Ygf8oRZsjabFvE92PkwdWlTYXpp8wavTY4IR2oWjIyu97oGHGe0FJgldcQFzSbWFQNHBgUVNtANvI9S37xA0TX5cE0h7BeSEuny2bxmG+Vb68wDZjFQsal9Ye6/cNYpl89wJjeIYxl+0DqEzblc1a+bb4JsOCoUN1/9a1zgfn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059804; c=relaxed/simple;
	bh=4IW6CJXO10DQ2MKT3BebdM3PezxGOVDNVkbej0/kPHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAxckxbkBM0Jwor/71p48DyAgnmFlditZo9c9cQh/WAM2gaNZ5D91S2S+gUdye16YKvgH8igPY/H9BzY0i6ou/q+kOAGcn9lUK0d0gs06c8MzAA9QUTImtieTbaKAF1p6jW4FsZGIizu8oPANu6owPZEBD2us6c3g96/cmSP+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ejeg+rtH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ejeg+rtH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628Mw2ii1505945;
	Mon, 9 Mar 2026 12:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QMYtt4
	tyZ705iWR44ghXb/Vo55CqUt6yvM+ucihoFq4=; b=ejeg+rtHHGAlusgoqwVaVT
	TSvxmNt8fn2zAv2lglNEKW+55/1TnNx20AnBZQILpSwJIqqJhajIiWYe3ioJqtil
	p1PDEii+0OiTrsndZYmn1ouMIu0UKFSEj1fQAwbSPDgF3KFuQEPuvjN/Dxs8t9+d
	QB3zq44bn8W4FRS/vqIOiK7Z7Z1BQmSKmOTcTk2Iy+6FR95BDJeJ7LWH6rMZbRu+
	ptbu/L/HOyxKeN9Qtb5NDc5Di3i/x3MvRQKxeugsZICxGmP/uGGru/uE7JJEqJw0
	p1XtotcLj/yt8P62MW4qGB0VEm1Ly091kLqIbBG6j3Q1gJONYYdEKGKIxmD9C9ew
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1me8gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 12:36:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6298fC16029714;
	Mon, 9 Mar 2026 12:36:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6uhht3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 12:36:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629CaXox15532438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 12:36:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACEE420043;
	Mon,  9 Mar 2026 12:36:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C30D20040;
	Mon,  9 Mar 2026 12:36:33 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.22.252])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  9 Mar 2026 12:36:33 +0000 (GMT)
Date: Mon, 9 Mar 2026 13:36:32 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] lsmem: (man) correct the markup of column names, and
 improve some grammar
Message-ID: <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20260307114308.7517-1-bensberg@telfort.nl>
 <20260307114308.7517-2-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307114308.7517-2-bensberg@telfort.nl>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69aebed4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=aiemyM5sCrUorxW0dGYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNSBTYWx0ZWRfX4mPo4g/QJXtc
 0jNlYTwr1eJ4qNWDrffJoSh9nZUk8kUzgIlJode6biJ28MsP2933vPe39TCfVPwzfNPEq3Az3r0
 JJbIdxqzKSAEWLdzpLIbKOsigB/n9OOoJM0QMdwXYuhhis2lagJlFkJ67cEqE+8YJPF4b+VT/hm
 9l4dseCWwJwffQ9UQAaGITMuZPDmqTN6n1P+vAlpx0JaQC9cF/HX7pgVUuJxJHUgMt7kiKKVdSz
 CTqYlWLqNDZciMeoN0Lj3tUVJBuTL5zV66MNxHtJMzyHfgtaCBUxOqY5CHqrCCNjRKeZm0wINBu
 d8f5GUVfbcaqm0igiNptpfPiylsBLlzk4Ieq5ldvx5YAwIvbShL6X0zZJ1pIUf3x6hq5GPCkTuO
 36o4qJjj/GdEEB/nQxVkbgXPRtdZpVlX4Bu1DFTLZ3BgVf9ETOfT81nKTMbOFrPSecdiNiistmS
 +aO8FgHgItaH+/tAYTA==
X-Proofpoint-GUID: H_SVZYGbiQkuqB8NvNTiGn2j6vy81wk5
X-Proofpoint-ORIG-GUID: H_SVZYGbiQkuqB8NvNTiGn2j6vy81wk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090115

Hi Benno,

On Sat, Mar 07, 2026 at 12:43:08PM +0100, Benno Schulenberg wrote:
> The column names should be marked in bold and not in italics, as they
> are literal values, not placeholders.
> 
> Also, indent the list of column names, to make it clearer where the
> list ends.  And add the missing markup for "RANGE" and the missing
> name "REMOVABLE".

Some of the changes introduced here are independent of commit
6f1e4ff054. But, looks fine to me.

> Furthermore, drop the small table, as it held nearly no information
> and was confusing: the explicit numbers in the BLOCK column gave the
> impression that block 0 can only be online, block 1 only offline but
> configured, and block 2 only offline and deconfigured.  The content
> of the MEMMAP-ON-MEMORY column being always "yes/no" was useless.
> Leaving out those columns left only STATE and CONFIGURED, where the
> values implied that memory can only be online when it is configured.
> This information can be conveyed in a single sentence.
> (The table was added in commit 6f1e4ff054 from five months ago.)

The table is useful because configuration and deconfiguration support on
s390 is still relatively new, and it documents the possible state
combinations. This helps users interpret what they see in lsmem output.

* The intention is to show possible memory block states. If the term
  “BLOCK” is confusing, it can be removed.
* The table illustrates whether a memory block is configured with
  memmap‑on‑memory is enabled (yes/no). This can be explained separately
  if needed.
* Users may configure a memory block with memmap‑on‑memory
  enabled/disabled and bring it online in a separate step.
* Users may bring memory online in a single step, in which case the tool
  performs both configuration (if supported by the architecture) and the
  online action.
* Users may only configure memory and later deconfigure it again.

This is the main reason for providing the table to make these
transitions clearer to the end user.

How about the following?
Example STATE, CONFIGURED, MEMMAP-ON-MEMORY states:
STATE   | CONFIGURED | MEMMAP-ON-MEMORY | Description
online  | yes        | yes              | Memory block is configured with memmap-on-memory enabled and online.
online  | yes        | no               | Memory block is configured with memmap-on-memory disabled and online.
offline | yes        | yes              | Memory block is configured but currently offline.
offline | no         | yes              | Memory block is deconfigured and was previously configured with memmap-on-memory.
offline | no         | no               | Memory block is deconfigured and was not previously configured with memmap-on-memory.

Thanks
Sumanth
