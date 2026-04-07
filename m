Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62A93A1E8C
	for <util-linux@vger.kernel.org>; Tue,  7 Apr 2026 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549885; cv=none; b=EzHcFVkT1rOn1hX+gioWaSGM8v7Fgjlw7TRu9690hsd0JnAZO8hHF9lJAUvQV+LAyJYRvrsVJH5Bxf+9jWPbzqg+Fq01NBysXBEt5bd3q5rL2ryOsrpHtl14z2XF+RhKqIhdhypor51KVJVC8SMtq0MtguGhcXXBbdhQQE/v1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549885; c=relaxed/simple;
	bh=nP3gGtqPX6SV46g9C0kx7xIxkUX2FJs9d/BkKNbH5P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Og2usy0dy9iYAsKkFADye8PyfexnFNqhpatRNkPqvvr+dx6ippO6IY2kNQdStuzEDDqwiVLzvLDc6tYZu5EyvO6Aghz6sMBUECIOcLGzaLGEqR0fjqlEMT9ys8Z3qK5+maPgcauQRY8ymRaxDgPhMnregSAf3avusEoMBeEwHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XX//Mp4o; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XX//Mp4o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jEHtA66g6zC6Rf49yNKSZRiqPPWkaLp5T+XFy89pPqM=; b=XX//Mp4oMVKBdfi1hCgpRMB9W9
	rk1YZqXR7LyhMLsmCe85SzGpZs3PdrcxsPmw+JDwDO8laTsQAezsAgltWItTboEp5M968A+GcSSPw
	7TB09TDpgo1KoBn1NHD0wRr0RolqUO0E7SzStDAskh2zPxDTSvdEKW3IVlXL4dk8nYv7VQixG1Vg6
	U5+1jmAzZFWIDHqnPMzC07vee6oqPeVcjPfgiKnBAWf12FZ5eIScm9Jgm0GLxoG8z+SWAHChmibGS
	5R9L68ihdZhle8KM6AhJkMPZofYbZdQ96efa9idT/eBkzlebKm2ClnVT6SPC0NPctepPZwWc9sB5y
	NnHi6M6g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <zeha@debian.org>)
	id 1wA1d6-007VSp-0w;
	Tue, 07 Apr 2026 08:17:47 +0000
Date: Tue, 7 Apr 2026 10:17:45 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: Evgeny Kapun <abacabadabacaba@gmail.com>, 1132887@bugs.debian.org
Cc: util-linux@vger.kernel.org, wanbingjiang@webray.com.cn
Subject: Re: Bug#1132887: script: "script file -c command" stopped working
Message-ID: <adS9qeW8w0bmUukR@per.namespace.at>
References: <88e0b54d-3c86-46ca-ab3f-e116073216d6@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88e0b54d-3c86-46ca-ab3f-e116073216d6@gmail.com>
X-Debian-User: zeha

Hi,

thank you for the report, CC'ing upstream.

On Tue, Apr 07, 2026 at 07:07:59AM +0300, Evgeny Kapun wrote:
> Package: bsdutils
> Version: 1:2.42-1
> 
> If I run script(1) as "script file -c command", it returns an error:
> 
> script: unexpected number of arguments
> Try 'script --help' for more information.
> 
> It used to work in earlier versions, so now scripts that rely on the old
> behavior are broken.

Can you check if reverting this commit makes it work again?

| commit 7268e79bc5365034a6e5b38ac5d9bf635e2dafc2
| Author:     WanBingjiang <wanbingjiang@webray.com.cn>
| AuthorDate: Thu May 29 16:39:46 2025 +0800
| Commit:     Karel Zak <kzak@redhat.com>
| CommitDate: Tue Jun 24 12:00:33 2025 +0200
| 
|     script: support non-option argument as command
| 
|     [kzak@redhat.com: - don't use POSIXLY_CORRECT, use "+" in getopt_long(),
|                       - use strv_join() rather than local concat function]
| 
|     Based-on: https://github.com/util-linux/util-linux/pull/3599
|     Fixes: https://github.com/util-linux/util-linux/issues/3481
|     Signed-off-by: Karel Zak <kzak@redhat.com>


Best,
Chris

