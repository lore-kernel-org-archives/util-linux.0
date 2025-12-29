Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352615B971
	for <util-linux@vger.kernel.org>; Mon, 29 Dec 2025 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980269; cv=none; b=kxVxPQckCpczUwSVhrAHDlBnX8vpK4oZqs1bjeOWimeH6xlPew6LHxjLICDScPBctWIUW8sCJklsqz2VClPgOB2RT0Vv32QDUhWdXpnbkQqCI6T0m4MMzbaMI8Xfci6WsjRDD7hXKDjSpQS7R2ooMrimUITmlBO7SainMH8yQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980269; c=relaxed/simple;
	bh=OgjxIBxN4JspVj3ElcCFqAHY7pb7Sw94/dl2dV9Wcvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gO7pi5z/nO5MkGjwfEZi84oRt5ujY5dtUFmuUHk2chhHB9kUqhHYMmTfHQx1Wgua0WHeX40p6farn5IQO2wM4ex6V724uKUxY4VEbvWR+MyW/t8GqDiKjmPK4nweQwROg0jGlkATbWzo6VAwWm4XqkjGhGSS+cwTIxtAnrKNWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpk8p/Ol; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpk8p/Ol"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b5ed9e7500so592897985a.0
        for <util-linux@vger.kernel.org>; Sun, 28 Dec 2025 19:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766980265; x=1767585065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCmEz44bkwzkSby/06GcUCg/Yhmg3lJ+o+Wcul7K1WQ=;
        b=Bpk8p/OlzUDMB6Hx4J45V5mwPPeN30zJnt/sDRS2yWibVC1B3Fp8kayMDvC2/4ie2z
         J1Av6ykLA1a/c3ay32U4hDRH8/T0HuOOeCgxqZFf/FHklsqyuW74y6RQW5vXrDqH/5+J
         J7GdhQBRDDa5bzwcdp1fSR9IdVU4tFuCWTA7Q4ScdEhUf9BlxNIzEpSZeqLQdWVJfJE0
         pvIeKktCzK+YPW7rvNJaBc18cZzARrQ9MWwa+I312yr7iM0oRpRWVkTqc+3uInNM2QP4
         xSZUFwQ/YHcJl66VZWpECwgkX3ukoFmwimL1bjj+fqMbAn788zvPxvExWsU/s2jo+I/z
         kNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766980265; x=1767585065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCmEz44bkwzkSby/06GcUCg/Yhmg3lJ+o+Wcul7K1WQ=;
        b=RPL6czSbAlDkkOpYy+iIcyda9NqcMGX/8zblIkDjWf9lQQVdUa2rzTVp7zr7bPlGy2
         nuzHcWUiOoxLFZRB21j/MwOU7gQbj6LAgoF74/L6vSCbEXnQzED9hdYV99bB2PdJ5HXE
         MbB7FT5wsKFHM+dZETxNQV2HHvMNk2CJFa+33RkmYR1ZZx/6HL5xpuUwr6cgPNPT7kag
         AYutcfz7H+xIV3rSumPYj9GlHKwtTyFSk0YNOw3mC2N0Pu3QCwXhd8AqhSN0U0PWtVzV
         sgabO77p1B9qaiIx4h04B8egHHVbCBtXkMUjTTKFY/JfoUGNMkMOXirEiOHKV8J3Rvhh
         RkiQ==
X-Gm-Message-State: AOJu0YxWTrHZ3CtdGr40fT1v+4nYOil6xb3WbEOCKSXpPDTtL4dhl1Pe
	lNbns2/SgQ8UgVg53rO95+dCqnfEZDO8H08hlQgVdebBy2F1c991C/P7ndL7hQ==
X-Gm-Gg: AY/fxX6rTO8Hc5DS4K2AzMgnZvp5AolbkTxi8SoV0Lvq2m1sOoUiTTo4IcRMk5zUAmn
	7uxQA3r8emSD1Qc2ClnC9ZmYwnEoA5eH5IFaanTxLO3wff1aqNYd9gHAnPT7zYxfUixKSaXDQNY
	pGu1ytwJ+tlJPSemO3gceM2Tumk5Ze46kBaSEEP/e9KQjphy/LzCgjhc/EUVpD4lROUwyb811+8
	lK1Imq8ikffr430C1uDiGwskVGb7O4JO0x+Tr6jACcyS9FSbKlyxDqzlm1rFKcIrP82+HdptRf6
	rxGYaECKAR/BXemlGEeUoo76v5xP0oYbaPlrKJVQ7ReAWjP27P+Vf5zLo6NkUUvYKZf1jnpdaEU
	VCJ3gqNHvmwjxrSVbuGM/TMAXaqBgGO6paYv7lLxM4VE7k9yZBBecHsjEqoVGqRsSxu4IuIAM2d
	ksi5jUo6dcnc8ymqc=
X-Google-Smtp-Source: AGHT+IEIT7kti4MOVJRj7cezJz2GUyXzxfrfiCWaseFf6HWWar6jdpFG1+qVpoDMPc1LJ4ejmQ54Bg==
X-Received: by 2002:a05:620a:1901:b0:8b2:ec5c:20bf with SMTP id af79cd13be357-8c08fbecac6mr4445865485a.29.1766980264990;
        Sun, 28 Dec 2025 19:51:04 -0800 (PST)
Received: from penguin.lxd ([146.70.202.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e3d4sm2245401385a.13.2025.12.28.19.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 19:51:04 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v5 0/4] libuuid: Fix pre-1970 UUID timestamp overflow
Date: Sun, 28 Dec 2025 22:50:56 -0500
Message-ID: <20251229035100.5778-1-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 2025-12-18 16:31:21-0500, Kiran Rangoon wrote:
> > I revised the code in response to your feedback.

> Thanks!

> > > Looking at this more closely: __uuid_time() is directly exposed to users
> > > of libuuid as uuid_time(). This means that any change of the function's
> > > contract would break all external users and should be avoided at all
> > > costs.
> >
> > Reversed the change there.
> 
> Your new revision is based on top of your old series.
> Instead it should always be based on upstream code.
> In this case the util-linux master branch.

Fixed in v4: I rebased directly on origin/master instead of building
on my previous patch series.
>
> > > Fortunately it turns out that the timestamps embedded in UUIDs
> > > only use 60 bits. This means that the calculation can be performed in an
> > > int64_t without any risk of over- or underflow. Please try to implement
> > > it that way instead.
> >
> > I'm using signed int64_t here as suggested.
> >
> > > It might be useful to change the signature of gregorian_to_unix() to
> > > "static void gregorian_to_unix(uint64_t ts, struct timeval *tv)".
> >
> > I revised the code to use a struct timeval now.
>
> That looks good. However that refactoring should be in its own commit.
> More on that below.

Fixed in v4: The refactoring is now in its own dedicated commit (patch 2/4).
>
> > > Also please perform each logical step in a dedicated commit.
> >
> > > I made two commits, one for the code change and the other for tests, but
> > > if there is a way you would perfer me to do it I could change it.
> >
> The test is a bad candidate to split out. After each commit the
> repository needs to be in a consistent state, which means that the code
> builds and the tests pass. As the code change breaks the existing test,
> the test needs to be adapted in lockstep.

Understood. In v4, the test updates are included with the code changes
that require them, maintaining repository consistency at each commit.
>
> I see the following commits:
>
> 1) Switch to the simpler constant definition
> 2) Pass 'struct timeval' to gregorian_to_unix()
> 3) Fix the overflow, adapt the existing test
> 4) Add a hand full of additional testcases.

Implemented exactly as suggested in v4.

> Also this patch now lost its useful commit message which got replaced by
> our discussion. This should not happen. Each commit should explain why
> it is being done.

Fixed in v4: All commits now have proper descriptive messages explaining
the rationale for each change.
>
> > +     const uint64_t offset = 0x01B21DD213814000ULL;
> > +     int64_t t = (int64_t) ts - (int64_t) offset;
>
> Whitespace corruption?

Fixed in v4: Proper tab indentation is used throughout.
---

This v4 patch series addresses all the feedback points above:

Kiran Rangoon (4):
  libuuid: simplify gregorian-to-unix offset calculation
  libuuid: refactor gregorian_to_unix to populate timeval directly
  libuuid: fix timestamp overflow for pre-1970 dates
  tests: correct UUID timestamp test expectations

 libuuid/src/uuid_time.c       | 15 +++++++--------
 tests/expected/uuid/uuidparse |  5 ++++-
 tests/ts/uuid/uuidparse       |  3 +++
 3 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.47.3

