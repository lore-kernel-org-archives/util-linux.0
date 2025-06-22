Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB5167DB7
	for <util-linux@vger.kernel.org>; Sun, 22 Jun 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750588588; cv=none; b=M7YxyVCppOTC/QON+M1XtdmqZ+SKa6DnvE6OGFbGM2MifRoxDRHG2UMRmNZXDkxEEkpZDWeZ9RgRxp6sZDHsXKzfv89NRNxzoTDfSrHNqrWqIc0s9Ez8l9Vio5Ndr0tIB3OXd3RY7Yk3iEdDraM3FjiSSxrd28BaJoLibHE3JvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750588588; c=relaxed/simple;
	bh=Hxe/6yNvT02j36wC5bSR/rErPMCarkBGnaHcWadxuzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VCTPa8pwgQuvoiiWGr0/eRyYGF5Si2dmWg8wYOSo7KcBiqyLv9b9LeJavEH7bdybE8v3ARyGq4FjFSxLToPESC0qtiTGaNvNdxQIySqNpMezu0CTWFBZnyQN8IRIyRiyfrtCqwLrqOvOvH8iKZUZ81boTg4HvGR8m7aeNANZmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=GqdWl+iN; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="GqdWl+iN"
Received: from localhost (ltea-047-065-176-090.pools.arcor-ip.net [47.65.176.90])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.1/8.17.1.9) with ESMTPSA id 55MAaC08010811
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Jun 2025 12:36:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1750588572; bh=Hxe/6yNvT02j36wC5bSR/rErPMCarkBGnaHcWadxuzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GqdWl+iNiW2uQrO3UIurxDVxXchg0+1hSpPv9qf+Z7Hy2NnOShqapw0v/GMvMziXL
	 OlBRHCFb0MRoPIAs/so5IVZgY/TKLptGOY4SH4U8c7TslD2oIf3VhE01xc4RJcKq31
	 fwjfQFNBuUwoO179175hSTKuTGxvnDEArD85bHPc=
From: Dirk Gouders <dirk@gouders.net>
To: util-linux@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Subject: Re: [PATCH] rename: change "expression" to "original"
In-Reply-To: <1038hjr$5nr$1@ciao.gmane.io> (Nuno Silva's message of "Sun, 22
	Jun 2025 10:15:39 +0100")
References: <20250621232642.17613-2-contact@hacktivis.me>
	<1038hjr$5nr$1@ciao.gmane.io>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 22 Jun 2025 12:36:12 +0200
Message-ID: <ghjz54vzab.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Resend with Cc address from original posting:

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
