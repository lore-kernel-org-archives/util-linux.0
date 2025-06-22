Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC951422AB
	for <util-linux@vger.kernel.org>; Sun, 22 Jun 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750584056; cv=none; b=TEQrtgI94TbeNa4hQXP8WLCwD7eikP3v1yVqx326auIdzXBu2wnbS9JLPfyM/VrUl5FZDpEdbdSwJz/nV19LD/5sJhE/W9Q+bjuHSvkP4qEwVtJltykpbK6SAAz4OTkVdFHMxDhVzmQVHWt3u1v/y1xaAnTKOJ7U51N5GnnCYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750584056; c=relaxed/simple;
	bh=KI5N/b+x5M505TRv7ibMClXiZJcN0krDUeHKxWstqBI=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:Cc; b=k+1SzGg6Ks1rZh85Ybvfk/tFH9vatnyUdyl8/QDa3z578rJsrTIwCjcnColH6OBZHsKizEhKY/pOBwkndtju28XFWCSaTTRH/LBqhhL5qllIMubFnT6XRBmd4UskTLzguZs42c2azVrjNAuaJtBmVyn3EGvBtJ5Zp7ODsBUuJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ist.utl.pt; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ist.utl.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcuu-util-linux-ng-3@m.gmane-mx.org>)
	id 1uTGng-0001dh-Oy
	for util-linux@vger.kernel.org; Sun, 22 Jun 2025 11:15:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: util-linux@vger.kernel.org
From: Nuno Silva <nunojsilva@ist.utl.pt>
Subject: Re: [PATCH] rename: change "expression" to "original"
Date: Sun, 22 Jun 2025 10:15:39 +0100
Message-ID: <1038hjr$5nr$1@ciao.gmane.io>
References: <20250621232642.17613-2-contact@hacktivis.me>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cc: "Haelwenn \(lanodan\) Monnier" <contact-BazVNOuc66DwXD0AkxfrAg@public.gmane.org>

On 2025-06-22, Haelwenn (lanodan) Monnier wrote:

> As rename(1) doesn't uses an expression (like regex or glob) but
> rather a substring.
[...]
> -*rename* [options] _expression replacement file_...
> +*rename* [options] _original replacement file_...
[...]

Oh. I was aware of there being at least two different "rename" utilities
on Linux systems, this one from util-linux and a perl-based one using
regexes, but I hadn't noticed this wording in the online manual and
usage output.

Yes, this change probably helps telling it apart from the perl-based
rename.

(I don't recall what made confusion more prone in the case of this
utility, was it that some distributions installed the perl one as
"rename"?)

-- 
Nuno Silva
Who hopes the Cc works properly.

