Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB433B96C
	for <util-linux@vger.kernel.org>; Thu, 13 Nov 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049102; cv=none; b=ihDHN4QISTmA2pGkHIZYM7h79ABjnxMAKTNW7X5cW3fk4LSnvdZx7RhutO3UFjT2AjCP25g13VN96MynlucLiWT7HQrMrtpfFnANXnOIV9gvXakaA+xwsGSPC3V8hhw5jeonbhM0pJ6y0X1554ZlTzvzSskDr5ss5riVH18Yv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049102; c=relaxed/simple;
	bh=R/EoolTkdrdoOgyrlNZ/W9pCgiCdQ+3xf+9JV0MbTdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu2Vye2uphXYoMhzaoodvyyNWSZKKn+nFjuIMr2GlT1zQ2xxo0QZjmTbboJbIUeYrrOaHoTqZ9fCwbdFn4njVLU7UfOz3Lw78Usnyf68ynblH1svwYM+yvt8gzYAlVIQnM8E8oRDdi2k7NZ2FnqpWsNqtQugzaFNjnYs5LOWpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=UHdPo1DA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="UHdPo1DA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1763049097; bh=R/EoolTkdrdoOgyrlNZ/W9pCgiCdQ+3xf+9JV0MbTdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHdPo1DAyfW1Ik+2FMID7S4T/Ojcte6yOf/5szRi6c3Hksblk2U1V17KUFZ8J3lI/
	 wID+QLW46mxE6C+P4r7izzu8ZOtfgoVW75DDRDn9bvT2Yn6B5RufUk3nYhsXAw/ort
	 RUwMtjiReeWGwWJnxecePPyw13t2IrzHXvgMEQqs=
Date: Thu, 13 Nov 2025 16:51:37 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Sami Kerola <kerolasa@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: Fwd: lsclocks and tai
Message-ID: <79700eae-3f55-4c0c-969b-d6d8499294a7@t-8ch.de>
References: <CAG27Bk3UdZkP8e8dYuKgpowODu3+1KWg1hqLZDf5o832YWuxVA@mail.gmail.com>
 <CAG27Bk33x9ztXSX7AJb_=5QVJRY3ir0ZppMSOgVUS0XnagrvFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG27Bk33x9ztXSX7AJb_=5QVJRY3ir0ZppMSOgVUS0XnagrvFw@mail.gmail.com>

Hi Sami,

On 2025-11-04 13:58:35+0000, Sami Kerola wrote:
> Meanwhile. There was a workplace discussion about TAI and I noticed
> unexpected lsclock.
> 
> $ lsclocks -o ISO_TIME,NAME | grep tai && TZ=right/UTC date --iso=ns
> 2025-11-04T13:58:14.176151344+00:00 tai
> 2025-11-04T13:57:47,177638531+00:00
> 
> One would hope above timings always match. If I force the timezone for
> the lsclock output will match, but this has downside of all the other
> listings use TAI zone.

I can't really follow what you mean with this. The only difference is
the printed time and that is expected, as TAI is (currently) 37 seconds
behind UTC.

> $ TZ=right/UTC lsclocks -o ISO_TIME,NAME | grep tai && TZ=right/UTC
> date --iso=ns
> 
> Perhaps the realtime outputs to use local time, and TAI to be always
> right/UTC. Any thoughts?

TAI does not have any timezone at all. Realtime does have one. For PTP
and RTC clocks it may depend on circumstances. Currently everything uses
+00:00 for consistency.


Thomas
