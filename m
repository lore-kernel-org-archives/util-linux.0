Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D747FB18
	for <util-linux@vger.kernel.org>; Sun,  4 Oct 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791137652; cv=none; b=dK01H/hbp9VKrDXslB/EUfWlnVLHYhuTGVN0jJUnqSIsNcoCjx6XM+YKsujrIuDmyftQNxagJ7/OqM2Tk1NVe0lTVxdoHwzW+c5gQv7Vef3cmG5XFFxKpchNtAh6glzuNtUNLcSn0vcrlW7R68vH8Hvf3YL9vm9C9zAdTsA/JeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791137652; c=relaxed/simple;
	bh=sjH5S0CNZClDmqdFY8S86gTYCINMCORIQDzBcILuZbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6YhtHsamHI8ZXTtcA426K6AqzPQ4jnqrEWIZtfi9Uiqo8s9/kDVhay63QckCIcO07DFyjkaFng+Ad48AybM/292X0/m6gJljmsL62QoZflmdUO1wRc/1uwN4JByDpiu0d0f4p4AxKV4QMccmXhyLBvoCp7UokUP08um2052T5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4Sa1s33; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Sa1s33"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a4c8262465so808857a91.2
        for <util-linux@vger.kernel.org>; Sun, 04 Oct 2026 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791137648; x=1791742448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zvp184+VDrAAELa45MrIVjzHZuD6h0h7teUaAj2z138=;
        b=K4Sa1s33e0topBLGrjJINZJoi62x44og/j03tLJmjWt2c/pJvzX2HTGqfrHcMxLOGo
         KxzYBuopU972XPuBVEcR0ycGt415fw4raN5VEPo2z6muL17lWZ/HIG88g123LWJTPd9Q
         rirdz9jjIW7qf6CNJ02pHhxBu7iA1urwiQXBk8Wvo5pIeMbSY2jZaZ/D1EBhVzv2BTh6
         jqs959cePI9HiTQN5HMLqSTDbZ4rKf638sNEpvZ7ucTiJSi0gF2+JfvYODsxEmFKBRLK
         o8+oSJ+fc86F3abO3LxElskwxBc8NX974Oso3GKIkN2Vqx+k+AED2wHfPestHNGGQ+cW
         BnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791137648; x=1791742448;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvp184+VDrAAELa45MrIVjzHZuD6h0h7teUaAj2z138=;
        b=ckQlj2whraugK8HkYayee4rSXvO22o3VGIEKm7nKXWKKSMgrlYD82VToP4GH1gGu1C
         tIyAAJQKEsfXYI2pm+2kuYlSNA2elwAO4ObZiYgb7eQ+Evn0P9fpn+9bUt/9t6orM6Lj
         tVdI7tX+shMBXNz1EyG0WR8137TO3050frERowCWfzXH0uy9aok933jL8gT+wYN/lDHq
         TrzCLa3LbhggpGLEUlNhwtcrmQDhoEcmvp9SK1JS3m0BNYMOCCzITM/NnurX6UkpOQtK
         Yx7kIDTlq89/JDJL36D15jrPzwNjyw4celkFs25XwC5vF+kexG1tSzOgFVNHNc6aOnkH
         dq6Q==
X-Forwarded-Encrypted: i=1; AKwUvBz5js4CXFEVi9mnqesKHlFD1GtrlFV9ruUoTF1cTjGGKEa8FQp2NklaoZSDM2Qyc3881wm1BSc0Yv/h@vger.kernel.org
X-Gm-Message-State: AFq9FYL/wLW/oJHNmAXF2cC3RBSJeyz8kw4X4SKorTf3YgUhVtbTOpOg
	vSS6hWE9suqSyPk0bfdeJqWU0a2blq74W0er4Dz/mDVUOXN9eDTTPkun
X-Gm-Gg: AYBFou01DH0Vk0KVfp8I7rNemabQWyM/iSOy8/BGyJsPwfuZh/xYGk4q74JjsIXg2+g
	ziGKsD9tpgv5fUHS7xHbFWWeDsILM42l/OLnt0uqQWO2lX6H6OHToIasisMgFtWLS0Bip+WW/wT
	mS5SuFE4taGLlQYNP6MqnOC9r+ceAwx2bA+4bm4QZvU2B6DdExf3tPQJADQY1Ysy5iSUgzjR8CK
	yveNGgf2A3YxgyAExLCN6h65IA4HEWpYma0oJ+DMj0AeTpVOZAJrDOdB2xpOYwThC9rqD6fI5LO
	LRnQYMAzupeqnMysmZ9ILhrbY+Ppc1OtyxNEcdt1q17H5uaxcH1k5EHLe/ibmuQpieIWhkkBgKw
	TWEeWCjEv+u1obCRNw1eMhTrDutmMXQVzu0SEtpjtHQFdrWjzzS6Jri6e3HyedRO+MbLY23Vud1
	kB8R2TnM6ytxklCkxsa5Svr+Qmh2Vk3dh1d8+L5oTOQKbyxs+wP9L7Mp90PekreztDcPwFdeliP
	iGZR8hVpPNUf33QfHXDxKKeGZc3Eys0MzEg2JkAwg==
X-Received: by 2002:a17:90b:4ac3:b0:3a0:a781:2c39 with SMTP id 98e67ed59e1d1-3a6ce3a978dmr7662178a91.7.1791137648512;
        Sun, 04 Oct 2026 11:14:08 -0700 (PDT)
Received: from gmail.com ([220.85.166.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d59f1cdsm7460304a91.0.2026.10.04.11.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:14:06 -0700 (PDT)
Date: Mon, 5 Oct 2026 03:13:58 +0900
From: Youngjun Park <her0gyugyu@gmail.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>,
	Barry Song <baohua@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-api@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
	linux-man@vger.kernel.org, Karel Zak <kzak@redhat.com>,
	util-linux@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate
 offload
Message-ID: <asKXZv5SxBtxQxqf@gmail.com>
References: <20260926045517.3458413-1-matthias.goergens@gmail.com>
 <CAMgjq7B7jem_dwtUEX7ZJPQm_pKBegR6WS9+B7nFp-gZugpUng@mail.gmail.com>
 <20260928151944.2686626-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928151944.2686626-1-matthias.goergens@gmail.com>

On 2026-09-28 23:19, Matthias Goergens wrote:

Hi Matthias !

> > Just like we already have a "swappiness=" parameter in the reclaim
> > interface, perhaps adding a "swap.tier=" would be better and much
> > cleaner to achieve the same goal? Based on Youngjun's work here:
> > https://lore.kernel.org/all/20260916183437.2946306-1-youngjun.park@lge.com/
>
> Thanks, I think that's the right base.  I tried it: on top of
> Youngjun's v11, a "swap.tier=" argument to memory.reclaim is about 40
> lines.  In a VM with zram at a higher priority than a disk swap
> device, and a cgroup whose tier mask allowed only the disk, ordinary
> reclaim in that cgroup stayed on the disk, while memory.reclaim with
> "swap.tier=" pointing at zram went to zram only.

There is an earlier attempt that may be worth a look.
https://lore.kernel.org/all/20260618044857.69439-1-jiahao.kernel@gmail.com/

If you go this way, the discussion in that thread worth refering too.

> What it doesn't cover yet is reclaim outside any configured cgroup:
> under global pressure, a cgroup nobody configured still reached the

Right, so for now every cgroup has to be set to exclude zram, unless
another idea or more code covers it.

> zram tier.  So for v3 I'd like to add a system-wide limit on which
> tiers pressure reclaim may use, on top of the per-cgroup settings.
> I'll wait for Youngjun's v12 and build on that.

I have looked through the whole series, and I will keep this use case
in mind while working on v12. :)

Also, to share what I had in mind, I was planning a sysfs interface
for each swap tier, /sys/kernel/mm/swap/tiers/<tier name> (exact
naming TBD). Maybe the system-wide limit could be handled there as one
of its use cases?

Let's discuss it in more detail after v12.

Thanks,
Youngjun
