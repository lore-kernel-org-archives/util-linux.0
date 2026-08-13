Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC42483BDA
	for <util-linux@vger.kernel.org>; Thu, 13 Aug 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637389; cv=none; b=eEHrLSXDLhjLl8ia+BYSGPa7uVSRF/fx3YZ5Yt97mZn6/3CQQC3k1x5m4ULdWWza5bORF56Cw0CkWWcXGzhTi9BmrNyy5Zn3Q7EbYHSmU8jjAZtQdTYeObTB+RtJa1ozIhqs5tjH8mW8YfqDrIV+/MgIo3atYRTxyRDveXfHCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637389; c=relaxed/simple;
	bh=9SlB2LPEAFpE8bE3QoCJHQ1VQu6PT3Lvg8JCVmEFj80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2+Q1eA9CZITJZKZndEG86BgdLZAHvEC91/DtnBkC6ObK1OQY48Nnk6BEIDyXQs9eTXotQJTvTcsCC44mCJxMxM7Nsv9JtkttV2B47r7ITWQdda7O9t/z25Mofvd6iDCUTWeFjNYFGt4FiYEkdBWbkH9ZdSp/56gfmJbSwNBLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=v1BBmDw3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="v1BBmDw3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=erSLgReKQMxS/iwdXxp/P9tpZ4a63w5olq43/0KiG74=; b=v1BBmDw3t0HSCVxP0s77YYYt2L
	JQDQrC1c1nZx7mFlyZtlkCCwlVzPtNyv3TmgYhTMAzNXjRDB36e3aHjzFiMCd2PFFradA+SoqCD0b
	cYEpyus+nX5yoHSqOHqJ/0YeHUYOPk5BtYBl0YC/ZzzU9MGTEP8unStMGD5IwgDQ2enqv026YU5e4
	ViU1EcS20UDluuytKR7gxlyONHdm3jHg0N0xlb0x2JMYfby06KCM+MV2PUqVnTbtj3uSWrNbJ5OWD
	WL/CIYKeLdFKFrJeQVm4702Yu8FnpUIieOU+z9gUHMKg83nH5Bd5+ZA4Q6Ngol15dB2VD8m8Dbbs/
	zz2abqvA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <zeha@debian.org>)
	id 1wuXzp-005ELj-38;
	Thu, 13 Aug 2026 16:09:34 +0000
Date: Thu, 13 Aug 2026 18:09:32 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: =?utf-8?B?SXbDoW4=?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFC] pack/unpack: generic archive creation and extraction
 utilities
Message-ID: <an3rySqcIaOIlkTU@zeha.at>
References: <20260813144535.79126-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813144535.79126-1-ivanrwcm25@gmail.com>
X-Debian-User: zeha

* Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com> [260813 16:45]:
>I realize an optional libarchive dependency may itself be an important
>consideration, so feedback on whether that would be a fundamental
>obstacle would also be very welcome.
>
>Before attempting to adapt anything to util-linux conventions or
>preparing patches, I'd like to know whether commands with this scope
>are something the project would consider in principle.

Purely with my Debian hat on: please put this either into libarchive 
or just a new tool. Adding a dependency from util-linux to 
libarchive is (from my PoV) not a great idea, especially when the 
tools can easily live in another place.

IIRC libarchive's "tar" can already unpack zips and so on...

Best,
Chris

