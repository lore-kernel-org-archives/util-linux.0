Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E917736
	for <util-linux@vger.kernel.org>; Sun, 22 Jun 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750587352; cv=none; b=FMK82jq54HkRjelqcQLsdGMmgELTJfuDEpcN/xiGhiasIVZMBM2r7n9QflpkMXyWMCb1HHbq4uCvS7wVa+u4Jf4SiJ9s9UGB4RcEGLL6msQ3MTaI/nomnu25u9uOZ//zHv6MHUlUV5KwEzOAWwkgI1DkBoNbL0x5XtJBZ4MCp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750587352; c=relaxed/simple;
	bh=R91m7vrDhOZaWWyosswcioNBx+rQpQ5No1HgZzm8RTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=trvWQD3W0ASBoIdBB5bcI7TDz5VsXuaoK8WAF7ya9XlIit6qfBNg5oEusiHKp+zEGk20NptqvTrkuObm63ponfPFYEUgZc2xANJvZpdv3sgC2v6z4i/OXiXiCuVfE5UBip4Gjsms2yaheKjEKp3etFJwj1peuBIVBhFTnOKlSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=O6ti8sbJ; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="O6ti8sbJ"
Received: from localhost (ltea-047-065-176-090.pools.arcor-ip.net [47.65.176.90])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.1/8.17.1.9) with ESMTPSA id 55M9nb9f008428
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Jun 2025 11:49:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1750585778; bh=R91m7vrDhOZaWWyosswcioNBx+rQpQ5No1HgZzm8RTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=O6ti8sbJMZsvBXPjMAdRFCWXK4522lGySkbPICiH+TbMZgNXmjUgRPtbwH+pH7nYs
	 elo/IrpQ3+xTKjSvibfsnjgRwVMJit3Ko/TFj2zGd+ZOXzwTpbKrcQCsE0OzwVxzBP
	 1uacS8tqVjARICeQNYgvbOoaQ53uG7AeLOdEk0ik=
From: Dirk Gouders <dirk@gouders.net>
To: util-linux@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier"
 <contact-BazVNOuc66DwXD0AkxfrAg@public.gmane.org>
Subject: Re: [PATCH] rename: change "expression" to "original"
In-Reply-To: <1038hjr$5nr$1@ciao.gmane.io> (Nuno Silva's message of "Sun, 22
	Jun 2025 10:15:39 +0100")
References: <20250621232642.17613-2-contact@hacktivis.me>
	<1038hjr$5nr$1@ciao.gmane.io>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 22 Jun 2025 11:49:37 +0200
Message-ID: <ghpleww1fy.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nuno Silva <nunojsilva@ist.utl.pt> writes:

> On 2025-06-22, Haelwenn (lanodan) Monnier wrote:
>
>> As rename(1) doesn't uses an expression (like regex or glob) but
>> rather a substring.
> [...]
>> -*rename* [options] _expression replacement file_...
>> +*rename* [options] _original replacement file_...
> [...]
>
> Oh. I was aware of there being at least two different "rename" utilities
> on Linux systems, this one from util-linux and a perl-based one using
> regexes, but I hadn't noticed this wording in the online manual and
> usage output.
>
> Yes, this change probably helps telling it apart from the perl-based
> rename.

In case this change will be accepted, how about using other terms for
both, "expression / original" and "replacement"?  Could be that it is my
individual difficulty but I would way better understand something like:

*rename* [options] _string_1 string_2 file_...


Anyway, I guess the following should be fixed, regardless:

+If the _original_ is empty, then by default _replacement_ will...

=>

+If _original_ is empty, then by default _replacement_ will...

Regards,

Dirk
