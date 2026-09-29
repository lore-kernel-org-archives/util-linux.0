Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB423438BC
	for <util-linux@vger.kernel.org>; Tue, 29 Sep 2026 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641669; cv=none; b=lohh7G54jwavq03o0Ug3MEgpN/FsvrgXgqujMAAknr+e3OKuWJt0wy66TAFn5afSObroKEaMu8LrpNJ2fqre75C/WWOxr3ghAPT/jCbV1v5cyitBvQ+93wwZiz65sOQgqpUNeTxU0cFhJOwSdeKke5j6dQk7T6kxnzGww5Az82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641669; c=relaxed/simple;
	bh=pMvCDTEkuAALUIrceyZBHP9kCx7IfJSFKZfbXoVEGjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvx6Wm0LsjHmpM0ITOtk1d8iM/gDp6JsCyA1i0ysCb3XLRrYwg5gRKX1iPR01J2bQDHCfEi1Y+Bu/JuPVYyT7EStpFLl6HHqG3eK8aYBM+cRYPhf7lKG6TdebJ51eJ6gjXm8qbrCoEJZry4RqWnVxJiOUxi8RB5r+upd+Cstpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu5BxIpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu5BxIpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9B41F000FF
	for <util-linux@vger.kernel.org>; Tue, 29 Sep 2026 00:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790641667;
	bh=APJhL/UXcBCjjwICTLFT+qLin1KDXiRR0y2N5bPp8T8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Wu5BxIpwb/FW7a7LVMgUEWE126572fMwxWfDEmSurmLLgZKqLptJ2bkNEyksVOVSz
	 5ufScNK88XA1hwYooXSrAjSOXbMENJ2iJs9O9M7X918VxaFf3FFU+RgtileZfmuQMA
	 HVIRnOR/aY2Gu2Gkko7FskKtHz1H4U5zxj8jhGhVP2AikPDUSrzFGXQh13W8bxkt13
	 lTBun4ty7FNs3z4BauBl6P4qDCwvzR7uPgXTHpQfB0WOiJkiaReRD/TUKvaHMvwtIs
	 4MPqxMiNzixcmr1FUFDRMVTz4Itok5WLx3q236W6EcQzqmXVXa/LtOKJEke/zqFfr+
	 hhp0kOAXIyIOA==
Received: by mail-ej2-f38.google.com with SMTP id a640c23a62f3a-c2af9270c53so346518266b.1
        for <util-linux@vger.kernel.org>; Mon, 28 Sep 2026 17:27:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzx19acVT9audbdKJFNzNpQxNX1s4jdQs8ZfW6q5Ti9ed8FahrVy4+poyN1bsXGgONsUwSJco3Vpn09@vger.kernel.org
X-Gm-Message-State: AFuF++lXMdYsHtKsE43yhb3k5AX6beDIiLOEwxdU1eLj73eqH6iOMNG8
	jcxatdbrW3mpoGHCwjUc29N9NcAVkKvqOGxukqPRJvIew6p2ZhhAV11rr3HBlMJUYXun9c3VoYq
	+/f7CGsHksBJmFELtngs1SqVssvRnnItFb/1RequTLQ==
X-Received: by 2002:a17:907:a909:b0:c26:1649:47b4 with SMTP id
 a640c23a62f3a-c2ac53fbdb4mr1170576266b.42.1790641665270; Mon, 28 Sep 2026
 17:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926045517.3458413-1-matthias.goergens@gmail.com>
 <CACePvbWM8kMjtJbH4vc6Qt=TBZQ-0d-Yj9NOtkepZmtNN3wd9w@mail.gmail.com> <20260928151924.2686290-1-matthias.goergens@gmail.com>
In-Reply-To: <20260928151924.2686290-1-matthias.goergens@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Sep 2026 14:27:33 -1000
X-Gmail-Original-Message-ID: <CACePvbW=fZ3G1JwnbiRo+_qsteN2smbbf3jX0UPFmhVyWA5_6A@mail.gmail.com>
X-Gm-Features: AclHuK_oifA42INPrgsCc_iqlMTCQtFcDVPMyqJSWfGYorE6tGAaJtv8iXHRTRc
Message-ID: <CACePvbW=fZ3G1JwnbiRo+_qsteN2smbbf3jX0UPFmhVyWA5_6A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate offload
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-api@vger.kernel.org, 
	Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	util-linux@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:19=E2=80=AFAM Matthias Goergens
<matthias.goergens@gmail.com> wrote:
>
> Hi Chris,
>
> Thanks for resolving the conflicts yourself and reviewing it.
>
> > What is the high-level user-visible impact of this series?
>
> Being able to use more interesting swap backends and logic when the
> machine is not under memory pressure.  It is much easier to write a
> swap backend that may occasionally allocate memory than one that is
> guaranteed never to, so today such backends are either unsafe as swap

I actually don't know of a swap backend that absolutely will not
allocate memory on swap out yet. Some backends allocate more than
others. Because the proactive reclaim can write to the non-offloaded
swap backend. That brings me back to my original question, in what way
this series helps.

So the answer seems to be that previously, some backends were unusable
by swap, due to possible memory allocation. With this series, those
back ends are usable for the proactive reclaim now. It is a 0 to 0.5
improvement because direct reclaim can't use it yet.


> or ruled out (btrfs, for example, refuses swapfiles that are
> copy-on-write, checksummed or compressed).
>
> > I am curious: if we never run out of swap file space on the
> > non-offload swap area, does that mean we don't need this patch series?
>
> No: running out of conventional swap isn't the point.  Without the
> series, any active swap area may be written under pressure, so a
> backend that may allocate can't be used as swap at all, however much
> conventional swap there is next to it.

But proactive reclaim can also use the non-offload swap area. So if we
have plenty of non-offload swap area, both proactive reclaim and
direct reclaim can use that non-offload area. The value of this series
isn't apparent. If you don't have a traditional swap-capable backend,
then your non-offload area is zero.  That is considered a special case
of running out of non-offload swap area: never having a traditional
swap area in the first place.

>
> > However, direct reclaim can use both types of swap areas.
>
> In v2 it can't: only memory.reclaim, per-node reclaim and MGLRU's

Sorry I meant proactive reclaim can use both types, nothing constrains
proactive reclaim.

> debugfs eviction may write new data to an offload-only area; direct
> reclaim, kswapd, MADV_PAGEOUT and DAMON reclaim may not.  But I think
> your suggestion to flip it round is closer to what I want: mark the

Flipping it around might provide additional benefit. I know some users
maintain off tree patches to turn off zswap on the direct reclaim path
exactly because zswap might allocate more memory before it can free
some. If the kernel can be smart about it. It provides additional
value to the status quo.

> areas whose writes may allocate, and keep pressure reclaim away from
> those, rather than tying it to what started the reclaim.  I'll work
> that into v3, together with Kairui's suggestion to build on the swap
> tiers work.

Yes, I feel that cluster-level marking might not be needed, you can
remember which si has the offload flag. However the per cpu cache
needs to know which context might require using a different cached
cluster. That is the trickiest part. The rest of the patch is just
enough plumbing to preserve whether the swap-out context is proactive
or not.

Chris
