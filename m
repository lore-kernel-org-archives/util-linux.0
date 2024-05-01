Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9833E1
	for <util-linux@vger.kernel.org>; Wed,  1 May 2024 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714538362; cv=none; b=I/jTzez0zHn5Frg4K0dfqq4cCdTq2BNyYC0GOhzzfH1S80MyST/QwVrqCdh/sNbuvMJs3T0qee2JAbatv1PJvyPtT4qLjNET6d9ilu9mFWusXJbpBxZIf0t3zy6koxhF5srA+4L+2iNcSWjiV/Y5vAftSr+QDuxJBtPgSGorYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714538362; c=relaxed/simple;
	bh=Nn77CCOWuEnVYsMpU+WenW8j1EYkTDjD2MvRukSPdsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDJMxzbLKUu63TUY8XrDODcEII9wrSstcC4dG8noJjwgueJ3n9lV8ZezdwDRljisPkFa6KK1V8blV8JXXvfh/VdzN08t+1wC1gdyBIM5UQaSz2/in6djyY6GseK0gO+W+00ghK98MVlZZJQd1tlKeCzYy7f5QsTMAAJBOpSHSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=XAUhbByx; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="XAUhbByx"
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 4414VvRn019125
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 1 May 2024 06:31:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1714537920; bh=XpVw7LrNM1n2hr5MHBMWkCBFtV1sb/Bf/bf/BO9xiMU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XAUhbByxIUB7hStaeO6To6sGYBIhrOnuz8b3IJODQ27SypM0+00VbFH692k+g0AqO
	 +Jc+oV8b60XrpEJ5BKLPhb98GVRsP9twgs+PrSpeoqnLxPNpS4SeVUdB0SlDKSOtVm
	 uZy8hUVjF45W1xp7PMg7PFk0UMfmsRwmgqihksJQ=
Message-ID: <fa4da8a2-010c-4bed-9d62-a0fee7646bf3@ans.pl>
Date: Tue, 30 Apr 2024 21:31:54 -0700
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: umount -r broken due to "mountinfo unnecessary"
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <315f1f43-013f-48c9-9016-474dc9d53a04@ans.pl>
 <20240423083358.2k532xl557meewws@ws.net.home>
 <1350349b-8465-4ce6-8dc9-55a32b84dc39@ans.pl>
 <20240424101535.4tvyms63egfwlw46@ws.net.home>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <20240424101535.4tvyms63egfwlw46@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24.04.2024 at 03:15, Karel Zak wrote:
> On Tue, Apr 23, 2024 at 07:35:18AM -0700, Krzysztof Olędzki wrote:
>> When is the next release planned?
> 
> I plan to release v2.40.1 next week.

Thanks you! However, the patch is still missing in the stable/v2.40 branch. Sorry for the noise if this WAI, just don't want it to be accidentally missed.

> 
>> Also, do you expect a backport to stable/v2.39 and v2.39.5?
> 
> I have cherry-picked it to stable/v2.39. Currently, I have no plans
> for v2.39.5.

Understood, thanks!

BTW: v2.39.4 tag seems to be missing? https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tag/?h=v2.39.4


Krzysztof
