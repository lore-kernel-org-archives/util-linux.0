Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988B145348
	for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766514141; cv=none; b=N9V/u39DGcUsWSwYNeDWhKWXfkZxBg3QI81PMCjhKPB96OiyKh9qRsaqBPgKBViCePsINZnnPBt7QldvADa5enaHZTUtPM+3i9+0D/1ilgKlBzOtX8SFvLlxHXgP//exIk0LCyCPEXmJySAQuKoU9m3H6jHQ+PvdYyv9urFVVHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766514141; c=relaxed/simple;
	bh=BCmBchsE088DBULTMog8p6lYPFZAhmHEEDAApseVbeM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UYrAImEZdMO81gPiTuI3ESuMAKwwUUZG/BGmLPY9rKKvGEegt1YYONehGvZDI8dKjIPSpxyk6sUqdmlTxH2piybZ1KNoIm3AQRYmbAKqlIrXhB9BKgHXiHSREcjAgRtwV4aAdu/YZH6jeQPfLuslvv2+BivRSld07/p6LbSgoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=foZUlmff; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="foZUlmff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1766514131; bh=BCmBchsE088DBULTMog8p6lYPFZAhmHEEDAApseVbeM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=foZUlmffDDJtTl1uAoIpUWnn4YiNDlRq2cMukLtLdsX02Rk80Bdgi7NaSrklkZ2gu
	 YV4Z6EZdZvYdt0DFFZ7RYqdFdEbP8kRRVnTFHcPjyJsOOwgXVNr7rgCOJSCt/0oQ9B
	 ObmuvzZm9bvCe+UPNgv7LPTMMfw4fMWi2tcLDG3I=
Date: Tue, 23 Dec 2025 19:22:08 +0100 (GMT+01:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Kiran Rangoon <kiranrangoon0@gmail.com>
Cc: util-linux@vger.kernel.org
Message-ID: <6da17fce-947d-49e1-8907-de3a6091bee1@t-8ch.de>
In-Reply-To: <20251223180055.2396-1-kiranrangoon0@gmail.com>
References: <9c4332f5-7aad-4804-b8f5-783e06572533@t-8ch.de> <20251223180055.2396-1-kiranrangoon0@gmail.com>
Subject: Re: [PATCH v4 0/4] libuuid: Fix pre-1970 UUID timestamp overflow
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <6da17fce-947d-49e1-8907-de3a6091bee1@t-8ch.de>

Dec 23, 2025 19:01:03 Kiran Rangoon <kiranrangoon0@gmail.com>:

(...)

>> > This v4 patch series addresses all the feedback points above:
>
> Kiran Rangoon (4):
> =C2=A0 libuuid: simplify gregorian-to-unix offset calculation
> =C2=A0 libuuid: refactor gregorian_to_unix to populate timeval directly
> =C2=A0 libuuid: fix timestamp overflow for pre-1970 dates
> =C2=A0 tests: correct UUID timestamp test expectations
>
> libuuid/src/uuid_time.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +++++++-=
-------
> tests/expected/uuid/uuidparse |=C2=A0 5 ++++-
> tests/ts/uuid/uuidparse=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> 3 files changed, 14 insertions(+), 9 deletions(-)


Thanks!

For the series, given it passes CI:
Reviewed-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
