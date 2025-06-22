Received: from cloudsdale.the-delta.net.eu.org (cloudsdale.the-delta.net.eu.org [138.201.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BCB19DF61
	for <util-linux@vger.kernel.org>; Sun, 22 Jun 2025 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.117.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750628098; cv=none; b=JNJJYNZjQLVE3UHgVABsrl2tzuTTNz+BYLdJxcNzjbwl7zQfYKJQRaQBACqxaqz9rcTYAuXC3jQNSaJ4p2P1DlKVHVOdxBE8uzvoA9ZworglLDmarqX4gU2+A3osTIIC6VXliVGES+fVsLjlYZ/17DNkOE/i0rNHLdEgHYnufPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750628098; c=relaxed/simple;
	bh=pmr7ZSA1uY3pi04U1CVlJ44pJyhkLIkhV9rCZiiSb7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC0f4OyVMMQ8jYUSYEP0s1IqgUIIa1bde88fs/qSNLzzZ/lGmktSitcNnSC+0+mKRKDxGto7OS24U9IJx3K2YknjT+dFudPfPmgt3QQXwEWjSd2nrEeZ/95rrgWLpN24DotwWQXMaOmm6tJxkMoNIU6INT/HaiCohU3XcAuIOMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me; spf=pass smtp.mailfrom=hacktivis.me; arc=none smtp.client-ip=138.201.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktivis.me
Received: 
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTP id b01b6c41;
	Sun, 22 Jun 2025 21:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=hacktivis.me; h=date
	:from:to:cc:message-id:references:mime-version:content-type
	:in-reply-to; s=20241213_132553; bh=pmr7ZSA1uY3pi04U1CVlJ44pJyhk
	LIkhV9rCZiiSb7Q=; b=m4GtAG+E/DSsPBpISVpiE2jbWhwZrhXHc9TMkumit3d8
	W4aAmFXLKKb7tXGBOf4zxExpiJFdovjj0y1eMNzkRxa1mMvLRMiT11+kSFBx33wO
	AYuFVvb9OF4XErZN5eZ9YiBpfYeYdg86NdL1jdy/mK0yd5wm4HpCfs6CqsPib8Ng
	kLmFN/J49Q0nxplW0QNrfWUASafmSEg3mTqxfSkANFLfsgv55HEpexNhBPtF97V7
	uekIHyD8TP+oUk/LsUUKbEZlj8bMsHEVTWZM53EiftsGQTsSJgrFiDTFmVlk4pTP
	bNhv6mk2admRnfiFoxtReTqePfrXwUeSeq7ZRIBvEcUtEChC7a70RlcjqTxicVix
	0OMopUPi11mgvHEQx1AIHpjDoxzr+ddiNQfAV8dfhGyjqoqz8Rddqr9ldtV0dycZ
	RYRmbohqr7KRwzH5WiWV7Q1Bn4LUV+teU1QY58ihC+WPZ/Nj3ylnwIyXcmwg4hwh
	dQnCQGUc4zDut871qs4ap8TJC9+qSRXFI+Hk9p9aw5dJHSk6E1hA5HfjI9dxiiKd
	b+/89uzPdjRgiqV0KBlM08ANd+I4qVlPmEYnDl3rYDkvBBk1y3yAKIzxO17wLr6g
	EN2y6+t6T/Pbr/oJsiZKc6rWsnKwVdyuN8g88/aPkaKB59urc3xUGYUImJqAWJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=hacktivis.me; h=date:from:to
	:cc:message-id:references:mime-version:content-type:in-reply-to;
	 q=dns; s=20241213_132553; b=wOKkps/qPFbb3QqCyK45y8rgplgFFGA4m3M
	buui3qCh6UpbL2iOsWjKdjsWgWQjH6Bqhpe+kyS8R9Cm9CcG0naZb84cQtRPJPou
	FEheKS6ZvmoiiDDCNoAgad63qogfISH/c1Pg7TPPfTEKZSuklZFRZ8rCGDKVENld
	En0XBlPmEe4HCi29P4l7E/c9GOr0y1MIOnU1cHUqNyuXgD2KoctP+cobHZRZAFUH
	R/ZghCIRwgFQsNzF7B2a/E/NZaw5hwSlkZdCjaIAm+mcoBHP2M+EJQVqcZaU5L/j
	UXeLmZovo7o7BQj7m1uYtTpKJMBBaa1hfnZWwVhmXOqgoDr8LBnX5YfAZeKeHGLv
	Kgq3JCDenD4JRLBmUsymTVLpHfsewzjabYOkm8lafycEg0P4ZEZ6DuLpjfIeD8T1
	1gsmcd2zkbKJKJ2q3MQzBL9YocA8TBZKaffmcSx3dI0zLQCUCQj28fhIK+1NKpS2
	PNOqukgOrNpyIY1eyKHBNYsYyvguT3m3G+WBdAjJRZVelZTSOThnHuxL+613a6Bp
	10HIAfO93X4BnnGpNJtzb3kqThVcLdxQ282bmrXsjCddfQLZwlzfIsa2xqwRVgQS
	5IFNXN7/VhuQ3p6z8QebAnvVg2s18cycpC9EaYbsT8zxTC3QwSgm9jpA5ipbJPI1
	NkUqtEDY=
Received: from localhost (cloudsdale.the-delta.net.eu.org [local])
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTPA id 6a73dbe1;
	Sun, 22 Jun 2025 21:34:47 +0000 (UTC)
Date: Sun, 22 Jun 2025 23:34:47 +0200
From: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
To: Nuno Silva <nunojsilva@ist.utl.pt>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] rename: change "expression" to "original"
Message-ID: <aFh298w6_1gLVs3a@cloudsdale.the-delta.net.eu.org>
References: <20250621232642.17613-2-contact@hacktivis.me>
 <87cyawp26b.fsf@ist.utl.pt>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87cyawp26b.fsf@ist.utl.pt>

[2025-06-22 10:23:12+0100] Nuno Silva:
>(Resending via mail only because the mailing list post with Cc hit an
>issue with Gmane, but was successfully delivered to the list.)

Ack, CC'd back the mailing-list so trail isn't lost

>On 2025-06-22, Haelwenn (lanodan) Monnier wrote:
>
>> As rename(1) doesn't uses an expression (like regex or glob) but
>> rather a substring.
>[...]
>> -*rename* [options] _expression replacement file_...
>> +*rename* [options] _original replacement file_...
>[...]
>
>Oh. I was aware of there being at least two different "rename" utilities
>on Linux systems, this one from util-linux and a perl-based one using
>regexes, but I hadn't noticed this wording in the online manual and
>usage output.
>
>Yes, this change probably helps telling it apart from the perl-based
>rename.
>
>(I don't recall what made confusion more prone in the case of this
>utility, was it that some distributions installed the perl one as
>"rename"?)

I know FreeBSD rename(1) is the perl one, and it seems like Debian
changed perl rename from `rename` to `file-rename` in bookworm:
Before: https://packages.debian.org/bullseye/rename
After: https://packages.debian.org/bookworm/rename

And has util-linux rename as `rename.ul`: https://packages.debian.org/bookworm/amd64/util-linux/filelist

Best regards
