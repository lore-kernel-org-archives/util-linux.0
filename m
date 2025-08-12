Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706A22172D
	for <util-linux@vger.kernel.org>; Tue, 12 Aug 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039175; cv=none; b=IBCH5nCnrMIfcUUWZ2GhAW35H+vnoBjAq10JXdOwPq/va+/EXipkgW8f5gajN5JZB/SRSnLDw/glIXE/tYOZac9N/TteFAVoJAuszVbmnU7SSy8OFs4TTO5/IP9rro4fMpQHkupBSNtmJGaDZONKGD7QLik+2GtXdh01k940Sgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039175; c=relaxed/simple;
	bh=F+5mGWVRNxISH0E30jDqcYp5dAtZ2dIuSgtDSY9gW/8=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:Cc; b=hheVzkLCl556h+avorHbkYj2L+7yfbSMZIzWtbhLBiwEuT1PQzIfercC3XDpolYFuE7QfaIUV6woMLHrxwlcDVFzqp/6OHCmSis8tckhhjPWq7hWI7KppWNCSj3RGiF1KZ/TqM+eauT2UILEoRhtli68wkQPLlbd/jvxfE2NSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ist.utl.pt; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ist.utl.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcuu-util-linux-ng-3@m.gmane-mx.org>)
	id 1ulxrP-0004bF-1S
	for util-linux@vger.kernel.org; Wed, 13 Aug 2025 00:52:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: util-linux@vger.kernel.org
From: Nuno Silva <nunojsilva@ist.utl.pt>
Subject: Re: [PATCH] swapon: (man page) add details about fstab configuration
Date: Tue, 12 Aug 2025 23:52:45 +0100
Message-ID: <107ggju$gvo$1@ciao.gmane.io>
References: <2k6jk47pv3rgp4djrfhs6tdddhfmbjoz2jmofzf6owxnpfuvq2@bkt6bw6bldj5>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cc: kzak@redhat.com

On 2025-08-12, Karel Zak wrote:

> The fstab(5) man page already describes some basic aspects of "swap,"
> but it makes sense to be more specific in the swapon man page and
> describe everything in one place, serving as a normative reference for
> what is expected on Linux in fstab for swap.
>
> Fixes: https://github.com/util-linux/util-linux/issues/3667
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
>  sys-utils/fstab.5.adoc  |  2 ++
>  sys-utils/swapon.8.adoc | 47 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
[...]
> diff --git a/sys-utils/swapon.8.adoc b/sys-utils/swapon.8.adoc
> index a25309d18..f4516c66a 100644
> --- a/sys-utils/swapon.8.adoc
> +++ b/sys-utils/swapon.8.adoc
> @@ -30,6 +30,7 @@ Calls to *swapon* normally occur in the system boot
> scripts making all swap devi
>  
>  *-a*, *--all*::
>  All devices marked as "swap" in _/etc/fstab_ are made available,
> except for those with the "noauto" option. Devices that are already
> being used as swap are silently skipped.
> +See *FSTAB CONFIGURATION* section for more details.

Should this be "See the *FSTAB CONFIGURATION* section [...]"?

At first sight, it sounds/looks better to me with that "the".

-- 
Nuno Silva

