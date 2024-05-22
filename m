Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4828F0
	for <util-linux@vger.kernel.org>; Wed, 22 May 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716409214; cv=none; b=orS0tfTRzb34xVb5DwClHYoxqn/KMIp9J4Wo4xpfrrD62Pzf/nnaMkzAoSDtwRFSC17puzSuQFLEiIYULln7WPrBAxDFPJyqvYN7sI04YEwlSzBSWSceRIjYmnXfR2DeM+jifGDBvgL6UJqyXHMGhiHhqic36KItOHHd04zBC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716409214; c=relaxed/simple;
	bh=ekVyCrdgtYak0qDNLFex7kaTofapF3SW6hCZULDPEOo=;
	h=To:From:Subject:Date:Message-ID:Mime-Version:Content-Type; b=UEj5tizW+LvUtRUqj3DnE4MwqT2y5/nkPhx6NJWuEbouCRzgctHNW8zWqyjfWTPo4Y7u+IQ7JamHd6WnrImhb8rj9OdU8G2lOG7eybrt+5sVny/9pwsS0kx8xzzBXfK7gCiTMcjnkZWkQ5qFru2Pqgp7bUPLM9rXq25yV/TXdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcuu-util-linux-ng-3@m.gmane-mx.org>)
	id 1s9sMY-0006Ye-PD
	for util-linux@vger.kernel.org; Wed, 22 May 2024 22:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: util-linux@vger.kernel.org
From: Vladimir Smelhaus <vl.sm@email.cz>
Subject: Cannot mount overlay fs with long lowerdir paths
Date: Wed, 22 May 2024 22:07:09 +0200
Message-ID: <v2lj9d$h9p$1@ciao.gmane.io>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla Thunderbird
Content-Language: cs, en-US

Hello,

mounting overlay fs doesn't work if the command line with referenced lowerdir paths is longer than "something". The change occurred somewhere between versions 2.38.1 and 2.40.1. Tested on Debian with kernel 6.7.12 and 6.8.9, kernel version has no effect. I 
never encountered any limit before, until now.

Regards

Vladimír Šmelhaus


