Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3A43E48D
	for <util-linux@vger.kernel.org>; Sat, 28 Feb 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772284120; cv=none; b=bvAnz/RlIgCmmhT7NdPskztzQZYeAxvIWwx7g9AAxOBpf21gZv1ymaVWqXlEnIRxpbTa/Dj9LjExvTIaXqD7yKHJxllG1lip5EuqJBhHhQg2xSncZcN05RS0wvrGyk52+5ouFNwOOwHy38FMDYQw8miH7SWibDLzwcc2GwbvtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772284120; c=relaxed/simple;
	bh=TZcDD0mnK2Dru6DKit0yXssoyornXjRWGFCuM4BKm8g=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:Cc; b=YE22IcmKh9zE441pMJXLwbUQDcPT/LzUUnSmgU33LIgeJsIK0xpdsi8WoKrz2WxMpY3OjlyqBHtzqUqkys/MRFY8n8MW0Y0xS0YgFm/17EtMkzbkSFjqFFBIf9qmTq/svpUBXApaYnH097fYgorPmvziLyLHc7fFBGQ7MsDXxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ist.utl.pt; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ist.utl.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcuu-util-linux-ng-3@m.gmane-mx.org>)
	id 1vwJyg-0000HY-KH
	for util-linux@vger.kernel.org; Sat, 28 Feb 2026 14:03:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: util-linux@vger.kernel.org
From: Nuno Silva <nunojsilva@ist.utl.pt>
Subject: Re: [PATCH] findfs: (man) improve the markup, the layout, and the wording
Date: Sat, 28 Feb 2026 13:03:20 +0000
Message-ID: <10nup2p$o2$1@ciao.gmane.io>
References: <20260228115245.9553-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cc: bensberg@telfort.nl

On 2026-02-28, Benno Schulenberg wrote:

> Mark NAME as a placeholder instead of a literal, and rename it to
> TAGNAME to make it clearer what "tag" in the description refers to.
>
> Indent the list of possible tags, to make it clearer where the
> description continues.
>
> Drop the angle brackets around placeholders -- those are used
> in --help output, but in man pages it is just italics.

My apologies if I'm missing some convention from util-linux itself, but:
from a quick check, it looks to me that italics is used for such
placeholders in IEEE 1003.1. Any chance this is or was a de facto
standard to denote placeholders? Or something done this way for
consistency (not that I've done a survey of how common this is)?

(Also see "Utility Operand" and "Utility Option with Option-Argument" in
the table at [1], at the end.)

[1] https://pubs.opengroup.org/onlinepubs/9799919799/frontmatter/typographics.html

> Also add a missing section header.
>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
[...]

(diff snipped as what's above is IMHO sufficient context for my reply)
-- 
Nuno Silva

