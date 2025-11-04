Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CB32A3D4
	for <util-linux@vger.kernel.org>; Tue,  4 Nov 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264730; cv=none; b=eZvZoMtGrsSb4on3Ty0dpAam5pYY5WACyECZGUynmIC1yz7X7h4fCHeB5hXTaq+luBHAGPoWa94uyHNoV6ggXJ3AsuieKh5UM4ylKHwjNv7x7+cSWZc5S+jCGaFwMq728CI5vhd3MkdNS5oflZB5JigpvpxaihVpv38b/26fMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264730; c=relaxed/simple;
	bh=vF4V3H0/Me+AVFGM8Em89ck98VJgTc56MN3z0rHvylw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NRoNTpVM9h/wyQW8Le38MgCu/4yDEZCZMErm8L+tOBAdx9q2YZPy/HwJxXygJ3k2cQA4jd3+qNJlweT7LVuSQ8JPUjNxrmk2P3TpU1Qov1sod63dIWd+3PLW5Nz9RnNO30ttcD2Au70N+oHFREZtU9PljJEecGnp2K5sqW3nFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG+NvDE4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG+NvDE4"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aad4823079so2198446b3a.0
        for <util-linux@vger.kernel.org>; Tue, 04 Nov 2025 05:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762264727; x=1762869527; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EGZrDiiVuzW3MOw9EiUaEAQ51iX1kJrXk9SLyq1hk0=;
        b=nG+NvDE4mNzXDs4MKUImRZOrUnRrNLYeLUoN7NMph10gTidH6xdy9LKPjgIeaUI9pI
         iI/RFLkyZoUu2IPK8gNLpbcPc+TA8cULwJC9nF9LAwdhlpJ4q5kR9nFqZEPF7vdZBm1L
         fZBJsFI1WEFOtGlZp7Zn9sLR3oUGaTEfGW5ObWAgSXqyPMv0e3CCHcSEExibNguMLFBY
         +3HWgmEzYiA2Oqk2wHd9XMFbosaY+z0HxprmaQsB9otn984oEDAFtAY2h+M65dZ6gTwq
         dE8w4Z3ebzBL2TwGrtZM3pUd7sA0qPEc0Edf1kCkBrrjnLd6qJIZmj4CzskpOsC3WKfm
         cOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762264727; x=1762869527;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EGZrDiiVuzW3MOw9EiUaEAQ51iX1kJrXk9SLyq1hk0=;
        b=H+y4MS0isLRBFRKNaLMNybmTfg89q2ZwJIaGVWRlfG9DVIP5Qrh/jy/GtKAyQcy5zO
         xQCftSKXzVBW8UGlcNT5tLFQghVfCGtJewcVpw8ZJKKl1ZkFhHzZG9C/1ZtbfloQOSyi
         sieZl0skMCJxbJuy2DAAiBUXIxNldyEQgdOoCmp00WCEyxS7QAqNGEy4q94k2PkPrA1D
         hYFXU3QOKFd1khrTM+jnfwyrhPGYSxDyiy+jj2pfw3n13aUkT99gijUMpSr+B6zVrDwD
         Wx4N/gvzpIIvgvLf9w4LYp+6iKzOAKlr10Wfog72/sYd/KJawcLYWYjgCH+99vIjNLJm
         u0ew==
X-Gm-Message-State: AOJu0YxlMIuWgG4eWEX7cYbBgadn8PzeediGXQ0bkQ2RLo932QJkkXrr
	KqzTXwfFnNkvr8BQ+eU79WJggvq6bRqHfAFzB415Kj43OJfMZ7zUjmhtwEQegYfkUgeVlpDj0Kr
	nd/waDfG7SKM2+1/7oWYr357419pzASnuaAx8
X-Gm-Gg: ASbGncsOSz03uKCP3q/I0cksWUwOY8nKfK2FSMOadYtKJlAwd40PxZNV6Fowl7+Yesk
	b43mNMjgJqrEahf4/eKC74kHMj1hXTqIYCt+YCjnhP8Ixj39rZAXv8unYdClX+VwwAAVdrmYoUV
	EhjjzZ4pzVEhobYrIg31vG6fLZEsIqJpwnnDRXeTQ4tqfV3FKfdjVkvK6m39UvCFPJJxbeMpwpA
	ggjIdif0OHBvizxdtAZrCaHaee6BK2lmTtJnbeFPBo7ShcFNa9cdEsDNmEVP1ehbwX0iE4M23cR
	Hz+iqnM5yihYdxOWdNMAkNBez6P/fmuI9I6ooD26j84R
X-Google-Smtp-Source: AGHT+IEAFxlXkW9h3VB+LB/4XGsc/o1Q16SIRWf99pHNF4mBxn6xWtrkih8qb4ZVr+TBIg5GNpXl9RB5822sVOxSrik=
X-Received: by 2002:a05:6a21:e097:b0:33e:6885:2bbd with SMTP id
 adf61e73a8af0-348cc2d8fffmr23772348637.40.1762264726811; Tue, 04 Nov 2025
 05:58:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG27Bk3UdZkP8e8dYuKgpowODu3+1KWg1hqLZDf5o832YWuxVA@mail.gmail.com>
In-Reply-To: <CAG27Bk3UdZkP8e8dYuKgpowODu3+1KWg1hqLZDf5o832YWuxVA@mail.gmail.com>
From: Sami Kerola <kerolasa@gmail.com>
Date: Tue, 4 Nov 2025 13:58:35 +0000
X-Gm-Features: AWmQ_bkG2rum4dHHzQRqq_bM0Dj2-TTIkv0T3di6tznovZi-5moWcq0t3jicttU
Message-ID: <CAG27Bk33x9ztXSX7AJb_=5QVJRY3ir0ZppMSOgVUS0XnagrvFw@mail.gmail.com>
Subject: Fwd: lsclocks and tai
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Karel and other,

It's been a while since I have been active with util-linux. Everything
is ok, just work & life keeps me busy. Perhaps someday in future
things change (when retiring and there's more time for fun).

Meanwhile. There was a workplace discussion about TAI and I noticed
unexpected lsclock.

$ lsclocks -o ISO_TIME,NAME | grep tai && TZ=right/UTC date --iso=ns
2025-11-04T13:58:14.176151344+00:00 tai
2025-11-04T13:57:47,177638531+00:00

One would hope above timings always match. If I force the timezone for
the lsclock output will match, but this has downside of all the other
listings use TAI zone.

$ TZ=right/UTC lsclocks -o ISO_TIME,NAME | grep tai && TZ=right/UTC
date --iso=ns

Perhaps the realtime outputs to use local time, and TAI to be always
right/UTC. Any thoughts?

-- 
Sami Kerola
https://kerolasa.iki.fi/
