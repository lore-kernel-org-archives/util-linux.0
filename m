Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70882284672
	for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766512865; cv=none; b=Yw0nfMRkI/SzmvW/40llQE1L9LDLzN5hTNp5kHEhAJ1P39iN24i9WlmwlAmKViJ0JfJVyslPTrQgndxxDWvCDr80UD4gMpCaKQTt+ukpNkHrePCFx3tCCqOMdwCkGnR2rJ6VRMRdkA32KwR5rvhMIO4gj2v8yjrSmZ5rQrH4Ay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766512865; c=relaxed/simple;
	bh=OgjxIBxN4JspVj3ElcCFqAHY7pb7Sw94/dl2dV9Wcvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYcrB/CwOH3afeYJbs16H9QNxhqncDYS/yYTI+Q0AngxRm6/69Ty6YdZXwGIHi/Sx/E1wQAl0CqBkkDJ+flkdhcRh+H+P5R5IwJ0js9wuZGO2FkTWhhDShALWyvqfTUMFqTBkBifn1F+4rfS98+hO57ipjUCyNOSIs2HGwpSZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiz8ukvg; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiz8ukvg"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b22b1d3e7fso511181785a.3
        for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 10:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766512862; x=1767117662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCmEz44bkwzkSby/06GcUCg/Yhmg3lJ+o+Wcul7K1WQ=;
        b=aiz8ukvgXs5YaCTJ2XfyQRhkOpV+3ZA7IRi1qoYNXoXROYKGm8RgnFR3VOtdUEq98s
         K3VDelmj1Ltr1kmm4l9ub2P19IIszrCXkPTofFHLaYXN5HfpXHio8Bnxj6XGaCPKEf6d
         2ZMYtSsbwPjWr3wZ93Jyo8RKOEwVb7vZqxq7qYqhchmRDvRtytMd1/rv2KcKGEAA5pIE
         hJGACfApObeoUzZq11rybHYggnXCUrkYPS0S+skVeAk/4RYW1ow+XODJRzXS/+xiqJHk
         Tq7VmY8Xl3rt+qExVPxiR962IWNGpfU5IDdWhx7ySPyIt9y1HphgApyeQWN2mOocV3/s
         aDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766512862; x=1767117662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gCmEz44bkwzkSby/06GcUCg/Yhmg3lJ+o+Wcul7K1WQ=;
        b=M+1MBWUa7G3h5oMU0N9Z5qrRrz5r4ccAkb564zg0xuFtNpWA2Eo3ruUTRsBKTpBj3p
         wKy2L/Z+U9CDOtPrKgvGsdIFoqAgoqHuEEV8TV6bPZDskHgunh7DF6pGynOGKNf5fp2t
         6mnoA/AKebcAQrXJzIJ6L0z1SiOXrINtrsQJhRvaJ9HFFPQVALjPPIaDKPrPxut3dCsX
         CsOtAcYg3vtif4LHjmy/OBOAKt9Z5ScKQQANfn+nuuwIkEXPhrWVowiju8JgAUi3FWbI
         bQcTonO/Gq1KpLRn69SEmHFknJyDA3gEt/h0KfQkMq4SWSyJsxsla/C8dANvvmwOFKuZ
         86ag==
X-Gm-Message-State: AOJu0YzHakxN8YPH120OycHbAIzneBvRAMpmLCQ2cXD7hd2lu2wxWpwX
	7VFbzFFVxHKghrpuMgSQKwlXl3umOszK3XoBHC7bNqpYifoWJkqC3S7Asf9IBA==
X-Gm-Gg: AY/fxX7NBv8y7E6xx75pcmo4xVj+RtoCH/8qRVRmVLn6CMAQFihf/r/H7EcuUNCfWzx
	RATvLB29W2bbNlykSBnDhURVGlKyUVUjze4784czIaWqed4rDQGY5Gdrf6byJ6/IHTnEDUb8whw
	KyicH+SxvO2s2Hh2KF+CjdoxoitKmbw/DYkw1tsy/EFOjEMLIlAg4q4zbOpzsg4f1kbJYZu9Q7n
	UDq/Tkrq69zg/e5XESs6lbSRvWIGOgORMO4rsmCJycCNN0FBp5KzxKU04ieiSvFJH92Tj7T+9cQ
	D8BtJnM+ya6O6RQeBvDdjnG5aYj3Iauwr4V0WKJkK6rRIp/EgPtJg5WZBpL8jlt229d7VOk1cEm
	oteNEMAL8eM513XaMkxRmDb+A745++TWKEmNW6ATgVbtsawDA9WIu923ASwbqWt1VEQCjHqTfON
	CusI9rQ3jPg6ZQKHGhM1K2xjdQwHy3RGNb87CWVsE/fFuBbv/m7OAY+bQPZA==
X-Google-Smtp-Source: AGHT+IHG2Wk916C8QkbTm6H+YFxpErrVJeeiXNEeATbq5K2ZJymTeuKBzS9uhDA27+jAY+3NLCCJpw==
X-Received: by 2002:a05:620a:2988:b0:8b2:da84:7810 with SMTP id af79cd13be357-8c08fa9f7b1mr2412880385a.45.1766512861732;
        Tue, 23 Dec 2025 10:01:01 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e3d4sm1105444185a.13.2025.12.23.10.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:01:01 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v4 0/4] libuuid: Fix pre-1970 UUID timestamp overflow
Date: Tue, 23 Dec 2025 13:00:51 -0500
Message-ID: <20251223180055.2396-1-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9c4332f5-7aad-4804-b8f5-783e06572533@t-8ch.de>
References: <9c4332f5-7aad-4804-b8f5-783e06572533@t-8ch.de>
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

