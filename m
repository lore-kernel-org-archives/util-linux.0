Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03250246BAF
	for <util-linux@vger.kernel.org>; Fri, 27 Jun 2025 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013506; cv=none; b=Y+l0fmEiOMgCAFPZJcVa6szgcB2kn5Umt8V4Hy9ldCgYsRKK9OdJ2q6SJQCvYOqOZoY6tSH6N8pwoqsHL+1pypGXpq2c2ga72RSPvr22vE/Kavt6tqU4LUEWvf0E8j5RudWnZszp6v8qIZ8b3StHzM5N5ujfRIbwl8J+UmkHLM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013506; c=relaxed/simple;
	bh=4k1dn4PGnYJqQDQBywSQGGqA4z2gbrW3Cc3XldC5cn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SRG6YFBV0Mfgp0FXIUAerrVFM0IHyDXmqdmyCWoyCdu/xkGHP0ugc1pujcAFb2RHTgWnihQSRJRQl2ddhMymQIh8j1MKfYjrp96UB/b/7jmqTyds9C0gFqZvfUYXmEOK2I2GVOMcZdjcygTIVtO6TflH5TXlhmcUKfoZyomSXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bc7mQ2Dz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bc7mQ2Dz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QK6W2I019605;
	Fri, 27 Jun 2025 08:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qi6VFI
	ZriOMKrvA+enzi/Bnf0HfJB9EHvUTCGTDM2xc=; b=Bc7mQ2DzzfMVppc8mobbbX
	wqXTUuK5hhw8kNKVXibRf4DeDueV3wkjkXQKZptG6FSe7+DfRisuNSmEpm12On+O
	fk2nD6/jCsPXFFgCbxBsMIf2a30ffhRqohoTNctybdcGoBusIpZggIQQ8VnaV/q/
	09NbPaEt/1MK45P0wmNpheR/oWYVYAVpCApokZFxZnEFz5yWCF7QNjRvRAl/C9yi
	C9z+AvJSKJrTNjFTAeJ6l2VYfWN9GQtgLYuBmSfV6Br0QYfXTpSS+AoHiZ9SwYs/
	HsaiIT4vqoGNh72w9KmJ75KGiWE5p7g/eOCqyuJSp8EvsE+TujJcrPBcJuJmRdHQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3kmny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 08:38:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55R5JqdJ002471;
	Fri, 27 Jun 2025 08:38:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jmk4xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 08:38:18 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55R8cHWt26804838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 08:38:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE99058052;
	Fri, 27 Jun 2025 08:38:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF47D58062;
	Fri, 27 Jun 2025 08:38:15 +0000 (GMT)
Received: from [9.204.206.228] (unknown [9.204.206.228])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 08:38:15 +0000 (GMT)
Message-ID: <9a721a20-0836-44db-b0cc-7d48f853318c@linux.ibm.com>
Date: Fri, 27 Jun 2025 14:08:14 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chrt: when more than one argument, interpret first
 argument as priority
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
References: <20250626112743.9862-1-bensberg@telfort.nl>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250626112743.9862-1-bensberg@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685e587a cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=MP4aM1IlAAAA:8 a=765ZioaZg6bK_Dl5C4UA:9 a=QEXdDO2ut3YA:10
 a=cNL50C5G4f5gRYKddA97:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA2NiBTYWx0ZWRfX9b0Iwz8ImPwL veDXp3TqgPZsCc4onOdA3Pl2fTJOJ+Ja6Y6AH0DHvgSu6nqFqEpfWfg2nZJ0eLDaL+cvkCSiFoV /61Cpe37jreMq7Dj+aknGGhiVhXry1d/Gnxucn55wrnKmY/Uawg/D+stR7RDMADE6C+JGsr33A2
 1hSUv44vj2grxGNCndcZpbUv4Vq7+/9XmGo0PHnTTi/vD6IfcBcUk/AI7PWV8292M5VQmYFR0G4 H5aQzdS8NvLRs9xa0kFtbPK8t0fMdR2PqpaLweXpVKsZwpKLhoD8pWROEeSGHWXj3ESXtzvHLVi a6R/YEZqpHG6KY/tGzBqSGZ5Xox8xosIjG6qsE/CdnNSiCi/Ixo34uuvZXOcwQarAVGasJfhPL0
 384qWxvWBJVNGB2CXV+DEFabB1XVui7BR8k72hXlt3ClyqXqtWe9X1F2Fh+MEuTQqYfhu8Gx
X-Proofpoint-GUID: IB51GClSIFEcmy5yvra1y6Nvi_lA5dKj
X-Proofpoint-ORIG-GUID: IB51GClSIFEcmy5yvra1y6Nvi_lA5dKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_03,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270066

Hi Benno,

On 26/06/25 16:57, Benno Schulenberg wrote:
> The first argument is a priority not only for `chrt --pid <prio> <pid>`
> but also for `chrt <prio> <command> [<argument>...]`.
> 

Good catch. SCHED_RR is indeed taken by default when no policy is given.

We could address this by initializing `need_prio` to `true` by default,
and then setting it to `false` in the corresponding switch cases for
policies that don't require a priority.  

This change could be added to your patch like below:

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 0bcdd1a1e..02b202ff4 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -399,7 +399,7 @@ int main(int argc, char **argv)
 {
        struct chrt_ctl _ctl = { .pid = -1, .policy = SCHED_RR }, *ctl = &_ctl;
        int c;
-       bool policy_given = false, need_prio = false;
+       bool policy_given = false, need_prio = true;
 
        static const struct option longopts[] = {
                { "all-tasks",  no_argument, NULL, 'a' },
@@ -437,6 +437,7 @@ int main(int argc, char **argv)
 #ifdef SCHED_BATCH
                        ctl->policy = SCHED_BATCH;
                        policy_given = true;
+                       need_prio = false;
 #endif
                        break;
 
@@ -444,18 +445,19 @@ int main(int argc, char **argv)
 #ifdef SCHED_DEADLINE
                        ctl->policy = SCHED_DEADLINE;
                        policy_given = true;
+                       need_prio = false;
 #endif
                        break;
                case 'e':
 #ifdef SCHED_EXT
                        ctl->policy = SCHED_EXT;
                        policy_given = true;
+                       need_prio = false;
 #endif
                        break;
                case 'f':
                        ctl->policy = SCHED_FIFO;
                        policy_given = true;
-                       need_prio = true;
                        break;
                case 'R':
                        ctl->reset_on_fork = 1;
@@ -464,6 +466,7 @@ int main(int argc, char **argv)
 #ifdef SCHED_IDLE
                        ctl->policy = SCHED_IDLE;
                        policy_given = true;
+                       need_prio = false;
 #endif
                        break;
                case 'm':
@@ -472,6 +475,7 @@ int main(int argc, char **argv)
                case 'o':
                        ctl->policy = SCHED_OTHER;
                        policy_given = true;
+                       need_prio = false;
                        break;
                case 'p':
                        errno = 0;
@@ -481,7 +485,6 @@ int main(int argc, char **argv)
                case 'r':
                        ctl->policy = SCHED_RR;
                        policy_given = true;
-                       need_prio = true;
                        break;
                case 'v':
                        ctl->verbose = 1;
@@ -530,7 +533,7 @@ int main(int argc, char **argv)
 
        errno = 0;
 
-       if (need_prio || argc - optind == 2)
+       if (need_prio || argc - optind > 1)
                ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
        else
                ctl->priority = 0;

Let me know if I am missing anything.

Thanks,
Madadi Vineeth Reddy

> This fixes an oversight in recent commit e7a2d62434.
> 
> CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  schedutils/chrt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/schedutils/chrt.c b/schedutils/chrt.c
> index 0bcdd1a1e..4c45eae80 100644
> --- a/schedutils/chrt.c
> +++ b/schedutils/chrt.c
> @@ -530,7 +530,7 @@ int main(int argc, char **argv)
>  
>  	errno = 0;
>  
> -	if (need_prio || argc - optind == 2)
> +	if (need_prio || argc - optind > 1)
>  		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
>  	else
>  		ctl->priority = 0;

