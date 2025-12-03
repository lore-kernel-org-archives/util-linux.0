Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253C2D6E73
	for <util-linux@vger.kernel.org>; Wed,  3 Dec 2025 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799971; cv=none; b=RIYcD2L9x6clpRo9tlIg848TgoN4kNwYS+l7wfNyryygLS7LNQiEIZHDwvEhep7JFoDqYu+sYK1DLMkioXxi96lm9QYTrrfBmcp7ZQnPjAyLRwp4qqNJZ2S+Xldgr982/1zXqd39niNX4/GFhFoeD3DWGfaNDyqg8tTBRIr5LsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799971; c=relaxed/simple;
	bh=zWXOuM3Rga5hVkRznzr61oqMITAgMYwy/Q3xA5Bapa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeTKl9/cXmNa2pqxOj3bgkAQOjCdDc6OkY63vEre5RT6SFacTWD8RiemuKefPJvj38PCSegTAbrP00lwvFq7ZFtP+kqd00Pqvg7wGM2Pmckuuq3jk8q7NWNWZvLvyNMwvpo+vIpkDXQ91Pk67/4Qai02AvOxNbBT8ZE2c09sIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=rU2b3CCm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="rU2b3CCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1764799967; bh=zWXOuM3Rga5hVkRznzr61oqMITAgMYwy/Q3xA5Bapa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rU2b3CCmNwHx6aVwUNRPp/UA6XoJc7CdB4eoPWqUI0PpCYF/mOKgFANKp3hcSzDrD
	 cxJUP6kPWfyyrJE8MVZhSqylpZSdLjcdBvC16U+aZlr4G4qawpnFc0fhKQkNIL8YaS
	 OAMS4U7FVluCPOGqNIpMIBD4PQFpZ+k6DzH5NgiA=
Date: Wed, 3 Dec 2025 23:12:47 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Alejandro Colomar <alx@kernel.org>
Cc: util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 0/1] Call prctl(2) with signed long integers, and
 avoid casts
Message-ID: <0ed6fa4c-7098-474c-99a5-f2c02879b119@t-8ch.de>
References: <20240601093150.16912-1-alx@kernel.org>
 <cover.1764794880.git.alx@kernel.org>
 <xfml2leih5xmokh4vhyyaarsq6ly7ehq5zfdjwwpkgnodiygwp@7tjm4lfqo6is>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xfml2leih5xmokh4vhyyaarsq6ly7ehq5zfdjwwpkgnodiygwp@7tjm4lfqo6is>

Hi!

On 2025-12-03 22:01:18+0100, Alejandro Colomar wrote:
> On Wed, Dec 03, 2025 at 09:50:27PM +0100, Alejandro Colomar wrote:
> > Karel reminded me of this old patch.  Here's a revision of the patch.
> > Major changes in v2:
> > 
> > -  Don't specify the 5 arguments unnecessarily.
> > 
> > BTW, I've developed a header file that might be useful for the general
> > public.  See in a reply to this mail.
> 
> Here it is.  I think it would be useful to provide this in some libprctl
> library so that everyone can use these, instead of raw prctl(2).  What
> do you think?  We could start by including this header file within
> util-linux, and then consider providing in a separate git repository so
> that distros can package it as a system library.

What about fixing raw prctl(2) in libc to avoid the issues you are
fixing in your original patch? prctl() could be a macro which counts its
passed arguments, dispatching to a set of inline functions which then in
turn call the underlying prctl() with the correct set of parameters.
This would be backwards-compatible and safe.

(...)


Thomas
