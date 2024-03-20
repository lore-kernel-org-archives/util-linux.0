Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F085C70
	for <util-linux@vger.kernel.org>; Wed, 20 Mar 2024 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972629; cv=none; b=DJCWRUxXrJWe86edjv/PZa0ilvpoBC2jmkd1GSnPYWk9EMWCw1G1vdyesxtyI/jFGcWAnK8GUu2MY7Zpgz/WuMwqMbEG5dE16VOWUcs4Z27vhk1T8AMMFGY56MSIevgm5Xx3jimSt7pxgU4W/J1vwBbmLJjNkwjVxKrzCpgZzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972629; c=relaxed/simple;
	bh=69bN3MgityuBtpvsAgAXagwPvWOMUhoUwzJmdqR8er0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C73qM9z3PK2aUI/uzLp23F0PH31iqgrDtIcpNVhbJXt+zASgZdL3Q5pCdWio4RRZgbDB34V7DNbrEGZomrpgCjGQ0dx4BLQZKGoCakYMlu8ssj8OsGN9VvBMPaUMr7+xmpJrf6O8W4aRHXhQOdWV9OniqBd4cz6Sr/IEJjfY6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=bCv/GUil; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="bCv/GUil"
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 427283C0140A0;
	Wed, 20 Mar 2024 15:10:27 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id wd64pYJJM46P; Wed, 20 Mar 2024 15:10:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id DEC7F3C0140A4;
	Wed, 20 Mar 2024 15:10:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu DEC7F3C0140A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1710972626;
	bh=53dNscFbpWPr2qXrhA+NTEzYWA9iYoyOSfG9vgTei34=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=bCv/GUilduMZ/MR6Lstn9y407OuMP4Cu57VZoepOOBbOlgDSq779nDwFC86QAgc/x
	 81byGbbte/fDyyj1n7B2jT1adVzzNdfsXvhkvK1PxVkQBoLMXNVSIq4U6rgFAAuBsB
	 dNOe2zBQAfx+D4DsgE8YrUPIQifDRx4VUKGAfCHzP9Y739+8lnlCPPMb+YCT17HiC1
	 Snyu1Qog5m/SjimWUn+io0uWf8ChNFrk3ebpZNcrnmoHQGAnVQZhQcwuHLdFvvo6GI
	 ZQ3quwXlSAX1b151N5Se+u74J3XZNFY5ekjMsDmcII9QVeFJ9LSBpa/+t3B77Vu3mq
	 IRt25y1raD/xA==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id tZGSG9PYpaTX; Wed, 20 Mar 2024 15:10:26 -0700 (PDT)
Received: from [131.179.64.200] (Penguin.CS.UCLA.EDU [131.179.64.200])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id B049E3C0140A0;
	Wed, 20 Mar 2024 15:10:26 -0700 (PDT)
Message-ID: <5db5740d-307f-4d6f-91a4-8451bb24e11a@cs.ucla.edu>
Date: Wed, 20 Mar 2024 15:10:26 -0700
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
Content-Language: en-US
To: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
Cc: 69532@debbugs.gnu.org, Petr Malat <oss@malat.biz>,
 Rob Landley <rob@landley.net>, util-linux <util-linux@vger.kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Karel Zak <kzak@redhat.com>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
 <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
 <5308840a-9de4-33d0-2520-5f3addc9718c@draigBrady.com>
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <5308840a-9de4-33d0-2520-5f3addc9718c@draigBrady.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/17/24 04:32, P=C3=A1draig Brady wrote:
> I think the --no-copy situation is brittle, as scripts not using it now
> would be atomic, but then if we ever supported cross fs swaps
> it may become non atomic. I'd at least doc with a line in the --exchang=
e
> description in usage() to say something like:
>  =C2=A0 "Use --no-copy to enforce atomic operation"

But --no-copy doesn't mean atomic operation; it simply means don't copy.

On systems that don't have an atomic exchange, we can emulate "mv=20
--exchange --no-copy a b" with three calls link("b", "b.tmp");=20
rename("a","b"); rename("b.tmp","a"). This wouldn't copy, but it=20
wouldn't be atomic.

Although atomicity is important, currently the coreutils documentation=20
doesn't cover it and the code doesn't always handle it well. For=20
example, if A and B are regular files "mv -b A B" briefly has a moment=20
when B stops existing. To my mind this is a bug: an existing destination=20
shouldn't stop existing merely because you're replacing it. At some=20
point this stuff should be documented better and this (and probably some=20
other) atomicity bugs fixed.

One thought I had while looking into this was that we could add an=20
--atomic option to mv and ln, such that the command fails if the=20
destination cannot be updated atomically. That would be a stronger=20
option than --no-copy. (In some cases we could support --atomic even for=20
'cp', no?)

Anyway, for now I installed the patch with some minor changes to the=20
documentation's --exchange section to try to document this tricky area=20
more clearly. Here's the revised doc section. It also incorporates your=20
later suggestion to mention both data and metadata.

----

@item --exchange
@opindex --exchange
Exchange source and destination instead of renaming source to destination=
.
Both files must exist; they need not be the same type.
This exchanges all data and metadata.

This option can be used to replace one directory with another.
When used this way, it should be combined with
@code{--no-target-directory} (@option{-T})
to avoid confusion about the destination location.
For example, you might use @samp{mv -T --exchange @var{d1} @var{d2}}
to exchange two directories @var{d1} and @var{d2}.

Exchanges are atomic if the source and destination are both in a
single file system that supports atomic exchange.
Non-atomic exchanges are not yet supported.

If the source and destination might not be on the same file system,
using @code{--no-copy} will prevent future versions of @command{mv}
from implementing the exchange by copying.

