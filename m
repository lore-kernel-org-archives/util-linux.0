Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C14E73AC
	for <util-linux@vger.kernel.org>; Mon, 28 Sep 2026 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608787; cv=none; b=qOyC6UJHjRWlqws9tYa5anfhM0YhMPZEAxkBPgfWwJgSfYlDrUcHNblGYMyjMwT894xUqrS1RRKL9LcGx4ZsQ6ZP9aZSlSV++K2IxcLYXw201PKnZuRscp64j7e4mj+c7IVHRSkAWgRnqZQJ9VJga/rpyzwWwT4y0bfylwE7LiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608787; c=relaxed/simple;
	bh=qFYBnXNYmhhsHxNx2COBADOmOdhhnVq5vY9GOOKIOJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N33jEXk5YfKE2zV+3nECxOFJy6s9/Tr0rpUSKc2porOO0B8myQ0h7QAiH3pp81Zj25yELvVI4L+Vtqhqq04VPB++aaJgxgmDu5ULN1WUoE9tYXs2hMP7QHHnexVmXfHHFyoJpal+I7YanCBRkm5UlZAdbM3FAIy7bk38PDD4g9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mcv3pLez; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mcv3pLez"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc79f8a6170so657020a12.1
        for <util-linux@vger.kernel.org>; Mon, 28 Sep 2026 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790608784; x=1791213584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2+B+TCtU6LhjPX3KEHp5ZhDWyuT2oD8RctAdhdkStc=;
        b=Mcv3pLezAFyOR8F75xJ+N1J+sl5iObide+S4U96tO+DgnijX5Dmv30l2bJPwN1+1O/
         aDuzJbHgkNaz0lfw14o/KwYbNznQUu7xfoxAvpVI93mnAYbKzBCw1eNQDku74CY+HfZZ
         PW4KSnS4CPVrTmns0V/auUXCoQVjg+oAMiGULt1W0MA2xWn7cLmEQSDCHD855uvtV9X3
         gmimRXAP+b8P5tg4Y1swbLZRAvkFTJbDFLJEEFCREXen1/VjjyUloPUHnLfUPQXAU4AV
         74V9RqUw2P+Fwuuwm6XSQxgYih2pRhfqAVjfgoKGuEwYAv6/0uviPGmqijunI+77tcYn
         bP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608784; x=1791213584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2+B+TCtU6LhjPX3KEHp5ZhDWyuT2oD8RctAdhdkStc=;
        b=PC3VBPhM9RnYWU9O4h66vudt9qrg9CNlx8xJzR7ENmzgwKmd0X9fZz8kZhHsimmITs
         UZcGEWhYHUgFchM0GQaTq5GHtZwqYSLadvHGv7U6zKNvKLB0lQobDbiwLta4xBcNY6S9
         Wq5s4ioejwDiasZYzt8W6193ieipH4IkGZ55LTlg4vK1j4YFY+eG33oPu4qhJPjWARa2
         bEShjRk1lHMUDobwCs76ykq4RZjV+r4v/IKEXe8LsJIG5tSICxOSwmS+3B0Z5oGACGVI
         YHooZckWQyAs0GDZ9iteGqnGuAZyXVhQqiMYFNuaRQp6yGZdkCbxpiEXTkkkTmny4Pfc
         YeQw==
X-Forwarded-Encrypted: i=1; AKwUvBzeq3AFG0b9pzWxpVJGNqu2Pj83hbbIavjVQoF46TjrnoO+DQRn4o5SDPsm4Kx+5FM/DiYH9jLXbjMn@vger.kernel.org
X-Gm-Message-State: AFq9FYJHmZzYJKIJ0eNM1AkTuf3gbLYP9/hPAh6rgXx0mQ7czKspqL3m
	73Alfx5JjkH+MGVnjieaWWHgQmcefXcyD3bLVSeMj24wGlc5YgV7mwnB
X-Gm-Gg: AYBFou2UmwrLUlo2zqdoVfQrq9U029YHDeMDiJp48N5UddC+oerygKlNpkZ3uzZniQe
	qh7xB0Gz85m5RKL3FNPlbGOSKQF3dGZ72D7yfAWNfjsly/mTiMelNmni/LskvSEDHR/uT/P72Lw
	ToUs4D+wvQI1WmVc1c08w2L+/sOMIUayOyJRe2PkYUswT5cbhpwgxHb9jJTM2XMhPwFu7RdKXhi
	E5MS+1kUf2v3ZcNz9ChQfpsWpYInCRE8hVxxr1M/vIAE/pC7bdO2TtW7UVNSpOqnfFMduDcGl9T
	pz/Ayq5VL5PRjZLzPmU7/Z7rSW6GFg2HOdUV1of4zWEqDtXzZU4LkkDffw0qNs5+i9SzR303A3Y
	gD8Y1f9JQMRzcWnIr3rBQNUwUH2WWNba5Fl205ucX9MBoVy1a1HQFHXgvftG7FM9SpWWq+8XUVH
	qAckUmFMpKnpZ9P/OBkR0vHWTzTNYEQUfdKb9rZt8aEvj7cuHXD6Wcsw0TJAD+QWbHr2L7VA9K6
	NJYVKvUwlTimUecsaWu0B8lUI5w1Vad6cdepYxgeLVW5XFaoyui7v7sEcyJWF5hNquLveC2m1XL
	Z56z/uJjwUGsFE7W+06WE7HSB+/Gu9zXWwEmg7FErK/ts/nfvL3dJshMTnc=
X-Received: by 2002:a17:90b:3908:b0:3a0:c20b:2fdf with SMTP id 98e67ed59e1d1-3a0c20b3132mr6450444a91.17.1790608784281;
        Mon, 28 Sep 2026 08:19:44 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9feddd0sm7247965a91.2.2026.09.28.08.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:19:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-api@vger.kernel.org,
	Alejandro Colomar <alx@kernel.org>,
	linux-man@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	util-linux@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate offload
Date: Mon, 28 Sep 2026 23:19:34 +0800
Message-ID: <20260928151934.2686418-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arn4xOIxFRD8qY_x@infradead.org>
References: <20260926045517.3458413-1-matthias.goergens@gmail.com> <arn4xOIxFRD8qY_x@infradead.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph,

> Either way block devices must be safe to be called from paging paths,
> not just for swap but also for file system based paging.  So this is
> a bug in the implementation, and not something worked around in the
> swap code.

Agreed that a backend used for paging has to make progress under
pressure, and the zvol example was a poor lead.  The series isn't
meant to excuse a backend that can deadlock; that would still be a bug
to fix in the backend.

What I'm after is different: backends that are correct but need
memory to accept a write, where the better policy is to use them for
cold-page offload when memory isn't tight and keep pressure reclaim on
areas that don't need to allocate.  Two in-tree examples: zram
allocates on writes and fails with -ENOMEM, with no fallback, while its
logical size still shows free slots; and filesystem swapfiles must
give up copy-on-write, checksums and compression today, because swap
writes bypass the filesystem.  I'll make that the case for v3 instead.

Thanks,
Matthias
