Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0578F4F;
	Sun, 22 Mar 2026 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774180064; cv=none; b=UQ1sqMaEUaiZMch317ECwCSGePlwzVZo+pW+3ranhDU+Iro5O3BQBEFyk79e6ZeP4isg92DnMsndDeMLPa1MpVwdttLXUO9ZlVUeHf2XRgP6n9N9eTJi1NbtBIc8OwaOim23z7vN2RmjSRmsfZI5ojmweYQEsV2W8q1N7bXzJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774180064; c=relaxed/simple;
	bh=AU2Fa0P7Cgq6/tXGq76ITNQfsi8b5PvDOJe85GVB7nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQc/U/bLhPsS0afd/4D3snk0n/2rPCbgRNM9AE6sncy5aB0zKNF8lZQ1avlYQipIVgF13Fj8lTSGyD4YXsE91xbjZk6SrDku5kToM8oHtbnE/wpFoLzq43KpdSTsbzWcA5xeP5L4S/JhKiDiFbO18noTQdZ39PwWsUPtKhRM91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wL/ZDJCd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wL/ZDJCd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wdswsvh/qjG6LMb+gNwEFa3/fTzcV89pe0MkygpRQWM=; b=wL/ZDJCdWVe/PRtHROIOBnKe9G
	+3oGpmEiHydAtA0e1KguCnpLvJHm9GvUEGHRPA2hfBYlsaN+0Z2T2IYaf3CyavQyUHdsx2q+PaLqp
	FCpfRtet3wKrCv4xgDB5Y1jRnn4JGarAK1hYt7BvG2V6zkkNElriyQ27mFWXRFAE8InAdEPjOCywA
	jDTR0ahwcdnedaPkQXugFIhCVPeU9ZPEB/DS0SJ4GZWdQhXmUtyCZvuOk1N1FA6OPEKojmiEF6DhC
	nYDTWvUTosTvy6VMxpjLC/bcZI4OH6IEdrXMhC68wSciB4fd0A59kJ64MaMNbdq5Ucb2IJHRPaX2x
	9KpKT9zQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1w4H7u-006j9b-Ed; Sun, 22 Mar 2026 11:37:49 +0000
Date: Sun, 22 Mar 2026 12:37:47 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Karel Zak <kzak@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org, Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>, 
	Helmut Grohne <helmut@subdivi.de>
Subject: unshare regression in 2.42-rc1
Message-ID: <ab_SfC1JDOhNmg6D@zeha.at>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
X-Debian-User: zeha

Hi Karel, Christian,

Debian CI found a regression in the unshare command when using 
--map-user with numeric UIDs. This worked in 2.41 and earlier:

% unshare --version && unshare --user --map-auto --map-user=65536 id
unshare from util-linux 2.41.3
uid=65536 gid=65534(nogroup) groups=65534(nogroup)

And is broken in 2.42-rc1:

% unshare --version && unshare --user --map-auto --map-user=65536 id
unshare from util-linux 2.42-rc1
unshare: failed to parse uid '65536'

Note the following (true in both cases):
$ grep 65536 /etc/passwd
%

I suspect (but did not verify yet) this was introduced in
commit 0a7fb806118bc4418e231081bd13c69bbc31b988
> unshare: use the new ul_get{grp,userpw}_str() routines
> 
> This change refactors get_group() and get_user(), so that it
> uses the new routines ul_getgrp_str() and ul_getuserpw_str(),
> to simplify the code and remove the overkill mem allocations.
https://github.com/util-linux/util-linux/commit/0a7fb806118bc4418e231081bd13c69bbc31b988

Thanks to Helmut Grohne for reducing the failed debvm CI run to the 
short unshare command.

Best,
Chris

