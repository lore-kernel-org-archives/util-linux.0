Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7664381EA7
	for <util-linux@vger.kernel.org>; Sat, 26 Sep 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790417804; cv=pass; b=dS+mNiRz6GCJbZWnHK2jwqj6X/sTGBEO5SGl8prVOpthCqpnanxSH0pwgc5XWI8Lw0wHVwFH5NVTPuTNfctCceaB6PQ8Q3yjjTqQI0F0c4GLpnLLmyHAD1s6MUCfaV2SV0Kddfl0eKYEZ+2ntZducvICqRBAWAmRReg9dSjQKkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790417804; c=relaxed/simple;
	bh=DlFYvFJLECsxFthzw/eFkvSmzedTUmwOpzdBKfUM0K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNfyDUqlH9XyG4hKgsN/k39GRALd1AeJ9YYs7RuXgxSjLMr4tEfN9C63Tiq53NDhyUKRL4WIxDrXoH/nzbnLnb48a2EedrwcZOxed3JSSs0Y2U27Y+14uIrqBbfUcRmrQ7g2pSc/9yE8P6CQpE/WHnBYPNKNyyPYgit1AyRiD8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFrqVxqy; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFrqVxqy"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2946aa0d5aso377339966b.0
        for <util-linux@vger.kernel.org>; Sat, 26 Sep 2026 03:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790417801; cv=none;
        d=google.com; s=arc-20260327;
        b=TJqdp9HKprXtGJl1WppQ7/hMbuZ/K92Lq7NMGun4+1kshJPiVJMMAUZw5M+G7I3fZw
         PVuvrt5xxyB3XQa/3wk1eTFyQ4LFDLil1kj1cME7bsJ/p+eZMgq68ZB1IzbI8hdyG3dD
         RVSXYU4FoOK3PuM8uHBou8kuI+E05C5zP5bFDma/bYrWsVR9l/c9TpJeDlflw83vuFE/
         aDSYNG2dV3x1TJmDa4kTYo7sCGbTlZeshcq0ZUzqVS5igRzn9f29n2nffj2gX6pbZt9x
         qrNX9jcOmrNDyPfokvfveY57cqhW+DUeKuydyId1t6RwZCcmLTzOa2hGNi9+aZNK2LVA
         bxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nuUo8zdKSoKE11B/ziniOjON7mdE/CfW6nfGNWVjAv0=;
        fh=XpgTqjLdx48d6mfn5Ot3cy3pROhhGxDouxAkD1GxCOs=;
        b=NEco6Vn5AEn+uDh4UstZaVOx5xGJ7lAGnqOq8ojUhV2LbIngd1Zfhe5mzXHuM4BXzs
         GOdBC9ZHYs6gBiVpW7q32xMQ3Jtc90txBPA7HcAmjSym6lTyIg1fgMsZRQN+5dVRVh89
         vRUdiTssSgjBZV/Ygl9QZWeiFnvBjpCsK9FhXjcjJ09u3c012kPnO+2tMyI2fwWUKP6P
         vZXng94MsRkFgT8JbF8Um/3Rns7eUgp08VaojHD5prI4IJeguoeMDStbwkZM8j4DsFRc
         823oNKfAZTPzpWiwr4rWOF13oREsZEDhzuC1D3U3EFeYloTN7ECPsGcJRxR+x6fBMCvb
         zC1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790417801; x=1791022601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nuUo8zdKSoKE11B/ziniOjON7mdE/CfW6nfGNWVjAv0=;
        b=LFrqVxqyv19kzRnHMAXhI4vAik/aMNgEsVTx/84IesLwhxI7w5kcphx7vTNr58KQP0
         LglTxfx1s/rQs1AxvYmLUpRQYCm2Lp7Cv9igFQ3wNeNpzNemzkmJgb5lUXceKTbkEQVd
         ue6Dy28OjDCgXTKFM5d28OCJ4CmegTTe7AkpBS0HofQ2GN6ZXBBWEta+Hvf77O5qRFzD
         ce1oQxToFYp3oIinFdBqmrJeoNzqadISTAz4RAGHvggGMaepTGJTGQRZvoh/Luu6kQML
         1j/tz19Go6qEO5Ku5KMz7XjE3W5VfNjj2Vff7qdjtUbY41Uo3UXOsM5oWg9RJorWKQTh
         7Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790417801; x=1791022601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nuUo8zdKSoKE11B/ziniOjON7mdE/CfW6nfGNWVjAv0=;
        b=hip/JWuX6tX9d59Z1N9miAwFdxyntO4ybzy3DaC3rZy62HhdrKT/JFmHr58XyBr4ek
         J2prM4PXmTW3or019OoujKo/MjIs7FuPwKJzJQWPFHt398WH60l8fgUuTcnji8hQgRxF
         /BoPnRJ9zPzc2AXmvqfDwidAG2xIXul/wk3VQiHLKVqYj5IfBvB9mt1FrWKSrgmwBHDG
         7wIrLYOIpoPsC6JR/rQ6nJiHYkEl4O9RCplg8MomcZAM91887xriLPYQio7vAwUiPnY8
         zDGaY4LYCEuhpQ3XnBbd8CgHDu8fPHybpaa0/bqmjugUvz8ULkl2BlADNdKyY9+tp0Ol
         S7Aw==
X-Forwarded-Encrypted: i=1; AKwUvByGANbuZozdsFYOXwEIrCN+QswLPZkbAom74Zf1YTRFDjf3ywRXUjtzZYb2qr6faf1D1EVYPBfAXPuF@vger.kernel.org
X-Gm-Message-State: AFuF++n7nyPYb9vfQeEjHDRMVMR2QIIzQ1fsqq9q7jmFBCLbqqr0hSvk
	Nhl5TKH151/io9reR4A6gc/K2ZFVFJzHHajWIx+GkJwJvC1oTo+kqb8e7NvhyJXkxLIAGpmc2d8
	C3W8txiVd3pux7DPzjZbYoYgJ711/CtY=
X-Gm-Gg: AYBFou17RHOeiNK7/OyJ6ULX1xt3/DgtTvdsOBbkFl1EXAow1ty3zeXG4PkFr2zrWfH
	6foCuh1LTpqxm+b+m1d2fPpbv9/SavvChqBFO2QuPUEFZ4+t93Iiq096S/a3+POJZxUEoRH9Uhu
	73WFDhiH7WrtLsG7M5zkTY4zJcPlWy0xoOehGS0AFsnhGTxYgQCmpqmGpitUDu0cdKnSqcARleb
	0P0TGwNqISE0EEXnqn0zshtwlEUEe5MomZPsmbrtlPJY9AlWV/tWI+YNFT0+LMiMCeBtlIA3bNy
	Bkjr6Di5v3ufNTOQlq9pUxY8rHAx5Fmr+mBWd2S5v1ykbhviYk98UH0c47C429h3ko0ViUQTJKF
	qEVf4LE4vMYw=
X-Received: by 2002:a17:906:dc89:b0:c26:3341:b8f6 with SMTP id
 a640c23a62f3a-c2ac23a79a0mr705591166b.31.1790417800888; Sat, 26 Sep 2026
 03:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926045517.3458413-1-matthias.goergens@gmail.com>
In-Reply-To: <20260926045517.3458413-1-matthias.goergens@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 26 Sep 2026 18:16:03 +0800
X-Gm-Features: AclHuK-9Dsy7rrAClr-629S5BXo_K2Hom1PYuYOl9rMJseRXC4FOvcoZCXsi7Gw
Message-ID: <CAMgjq7B7jem_dwtUEX7ZJPQm_pKBegR6WS9+B7nFp-gZugpUng@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate offload
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Baoquan He <baoquan.he@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>, Barry Song <baohua@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-api@vger.kernel.org, Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
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

On Sat, Sep 26, 2026 at 12:55=E2=80=AFPM Matthias Goergens
<matthias.goergens@gmail.com> wrote:
>
> This RFC adds offload-only swap areas for deliberate cold-page offload to
> backends unsuitable for pressure reclaim. ZFS zvol swap has documented
> deadlocks under memory pressure [3]; compressed swap is another target
> because writes may need memory despite free logical slots.
>
> Explicit proactive reclaim can use these areas alongside conventional
> swap, ordered by priority. Ordinary reclaim cannot initiate non-zero
> writes to them, including through retained swap entries. Conventional
> capacity is not reserved for emergencies. Operators choose the policy;
> the kernel does not measure headroom or make an allocating backend safe.
>
> TMO/Senpai [4] and DAMON_RECLAIM [5] are related cold-page reclaim
> approaches. This RFC admits offload-only swap through memory.reclaim and
> per-node reclaim, but not DAMON. Other related work includes per-cgroup
> zswap writeback control [6], Virtual Swap Space v4 [1] and swap tiers v10
> [2].
>
> The util-linux companion [8] proposes swapon --offload-only and an fstab
> option. Older swapon silently ignores the fstab token, so persistent
> activation needs discussion. Apply the separate i915 fix [9] first to avo=
id
> a pre-existing folio-lock leak when shmem writeback is skipped.
>
> The series fixes zram selftest device tracking and error reporting, adds
> the swap policy with DRM eligibility checks, and tests routing, workingse=
t
> activation and retained-entry write refusal. It is based on mm-new at
> 995829088503.
>
> Feedback is particularly welcome on:
>
> - Activation-time eligibility versus backend placement or migration:
>   is retained-entry refusal, with possible reclaim churn or OOM,
>   acceptable without migration?
> - Eligible-capacity accounting, including overcommit limits and OOM
>   scoring; cache recovery, cluster invalidation and workingset activation=
.
> - Persistent activation and visibility: current swap listings do not
>   expose the policy.
>
> Validation includes x86 builds, affected arm64 MTE objects and builds
> without swap or memory cgroups. QEMU tests covered routing, retained-entr=
y
> recovery, data integrity and cleanup, with negative controls for write
> refusal and teardown failure.
>
> I have also been using this policy on my own machine with experimental
> bcachefs swap support, with no problems observed so far. Deliberate stres=
s
> testing is confined to VMs; I do not deliberately stress-test this machin=
e.
>
> Changes since v1, incorporating Sashiko's public review [7]:
>
> - Improve selftest isolation, retained-swap measurement and memlock skips=
.
> - Track allocated zram devices, wait for udev probes and report cleanup
>   errors without deleting data through a mount that could not be released=
.
> - Clarify activation, capacity reporting and conventional fallback limits=
.
>
> [1] https://patchew.org/linux/20260825153238.2695446-1-nphamcs@gmail.com/
> [2] https://patchew.org/linux/20260713025644.170839-1-youngjun.park@lge.c=
om/
> [3] https://openzfs.github.io/openzfs-docs/Project%20and%20Community/FAQ.=
html#using-a-zvol-for-a-swap-device-on-linux
> [4] https://engineering.fb.com/2022/06/20/data-infrastructure/transparent=
-memory-offloading-more-memory-at-a-fraction-of-the-cost-and-power/
> [5] https://www.kernel.org/doc/html/latest/admin-guide/mm/damon/reclaim.h=
tml
> [6] https://www.kernel.org/doc/html/latest/admin-guide/mm/zswap.html
> [7] https://sashiko.dev/#/patchset/20260914104501.3960616-1-matthias.goer=
gens@gmail.com
> [8] https://github.com/util-linux/util-linux/pull/4633
> [9] https://lore.kernel.org/all/20260914105606.3997649-1-matthias.goergen=
s@gmail.com/
>
> v1: https://lore.kernel.org/all/20260914104501.3960616-1-matthias.goergen=
s@gmail.com/
>
> Matthias Goergens (4):
>   selftests: zram: track owned devices and report cleanup failures
>   mm: restrict offload-only swap to proactive reclaim
>   selftests: zram: cover offload-only swap policy
>   selftests: zram: cover retained offload-only entries
>
>  Documentation/mm/swap.rst                     | 105 ++++
>  drivers/gpu/drm/i915/gem/i915_gem_shrinker.c  |   2 +-
>  .../gpu/drm/i915/gem/selftests/huge_pages.c   |   6 +-
>  drivers/gpu/drm/msm/msm_gem_shrinker.c        |   2 +-
>  drivers/gpu/drm/panthor/panthor_gem.c         |   2 +-
>  drivers/gpu/drm/ttm/ttm_backup.c              |   2 +-
>  drivers/gpu/drm/xe/tests/xe_bo.c              |   2 +-
>  include/linux/swap.h                          |  29 +-
>  include/linux/vm_event_item.h                 |   1 +
>  mm/memcontrol.c                               |  20 +-
>  mm/page_io.c                                  |  24 +-
>  mm/swapfile.c                                 | 123 ++++-
>  mm/vmscan.c                                   |  31 +-
>  mm/vmstat.c                                   |   1 +
>  tools/testing/selftests/zram/.gitignore       |   2 +
>  tools/testing/selftests/zram/Makefile         |   4 +-
>  tools/testing/selftests/zram/README           |  20 +-
>  tools/testing/selftests/zram/config           |  10 +-
>  tools/testing/selftests/zram/settings         |   1 +
>  tools/testing/selftests/zram/swap_offload.c   | 425 +++++++++++++++++
>  .../selftests/zram/workingset_offload.c       | 207 ++++++++
>  tools/testing/selftests/zram/zram.sh          |   9 +
>  tools/testing/selftests/zram/zram01.sh        |   9 +-
>  tools/testing/selftests/zram/zram02.sh        |   9 +-
>  tools/testing/selftests/zram/zram03.sh        | 174 +++++++
>  tools/testing/selftests/zram/zram04.sh        | 164 +++++++
>  tools/testing/selftests/zram/zram05.sh        | 447 ++++++++++++++++++
>  tools/testing/selftests/zram/zram_lib.sh      | 189 ++++++--
>  28 files changed, 1926 insertions(+), 94 deletions(-)

Hi Matthias

That's a lot of changes for a rather limited usage. IIUC what it want
to archive is, for different kind of reclaim, swap operations should
only go to certain devices?

This really sounds like another usage of the swap tiering design: A
default per-cgroup tier setup, and a one time tier limit during
proactive reclaim.

Just like we already have a "swappiness=3D" parameter in the reclaim
interface, perhaps adding a "swap.tier=3D" would be better and much
cleaner to achieve the same goal? Based on Youngjun's work here:
https://lore.kernel.org/all/20260916183437.2946306-1-youngjun.park@lge.com/
