Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3093DD879
	for <util-linux@vger.kernel.org>; Sun, 27 Sep 2026 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790530451; cv=none; b=FbvPSxP1XFEQ1oqcYp67Mo54ERssuKIUYq4NMKPvtHuOBVrt1Uv4EOIPJZmnXYANo9XoCFdOlvg5r/f7Gpy+ny7eJ1Jkp6EHdm2hxaFMiRMaxTsqr8dH6WNrd/q/UKQku8QRWxkWA4f9Yq6or7+cGRaexSPZsFbTrAI49Qvd6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790530451; c=relaxed/simple;
	bh=j2J2wAxTXsNGTyd5388EcZwWhFZ3wYnSEUCo7yrCp9U=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DzWyq/6u5bwwvGmsZtysDKf99750qmEcSQ2FvsOQ11ccquvFXxZA1rUU7lZ7Nc1rS+S5Xf+ce3+jwYxv2SaXylGi5cuKEoMyuRTmNKMKKD258VXHelyEAViQsOqhtWR6nIKXbd73KySRyL/Eptz9gIOV2mH7qNHzExUrf5kQZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=WmzQ6NYk; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="WmzQ6NYk"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b46bc1282so255287a34.1
        for <util-linux@vger.kernel.org>; Sun, 27 Sep 2026 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1790530448; x=1791135248; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuL0v1f3+J9yyQw0yqK0TvcdFgWSs593LTmvyHRza0g=;
        b=WmzQ6NYkam5yMDW7bRj4CGT1ZrpCjEHZS1N8Clae2dDKbn75eRImj0Yo8kofaKpocK
         Y6A55C7nNaTui67pr1OMJbIkgP5Uciihbem9jrIuF5HHoy7Qpc0m2TwtAJnjq3oK58Ph
         BvbiaM8BHfGKPiXSoSra51LDFJCMKYXyHn1J9fLGHCG4cnS8MVzcYBl63CNlgRZWdZCK
         MEaIrV5d5kJBiDkcpJmaCPGC0MLMYsYnl5JO6A82I6ED/MSVSMFBHDYF4Xk1pCDnGfpp
         o4Mb9lKNn8CafXD56eM1x8xIrEN/nPb/aYO/fZ5EKB5mTSqZE00C3XeQ3ugRF8X6sBPN
         egOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790530448; x=1791135248;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MuL0v1f3+J9yyQw0yqK0TvcdFgWSs593LTmvyHRza0g=;
        b=oNyBl5vFHxYsLoX2JgoDWTXomvksBQWpJ673c2NYZ9NM3Ao4vq9x0wUC/ukDHjbo1U
         KEaHWa39oJBvgjj72bclRNZFsNRnIfvmvBlTRYkSgJ6jNRC7qjJDfjPzHJ5uk7dV/BWg
         4urCbhuB2Lmxy7QwI4g/eDk8FM1F1aF1Cp3calsCrivN/52yM+y+W5xsXzn2vFVkwYwD
         BMSxu8aXUb7TceGF3CIMomnejP7spDLEUNrBC8nOwa2lcdEr11Y6R6iWvUpb7Xl7Mopr
         LhXbspyUfG93MvP3Z7E19OXmGtX/6Qj6TFDMQ0vF5FMQw0xi+/GbQ7tyV6Ze8nxlxAWw
         NWfA==
X-Forwarded-Encrypted: i=1; AKwUvByMhOd1wBmlOR5tJ+tb+mt9bVGo8oWs/nEWVX9Kz7eP5U6p1dXbZHoc1HMwe58YdcIoObq4mtCFy1iZ@vger.kernel.org
X-Gm-Message-State: AFuF++nVwF9UmBZQYdM+B6OUjZ/Amw+gXRNkvjpD6PVIniGML59ZTb/y
	2lTprcbtj+UhTI06qjoO8cMsmURA11Kulf+4QQqdiAjAkomIFVuB4sJ2QSRehcw5tQ==
X-Gm-Gg: AYBFou04WTE+YCoZzxRKpzXHVkimG0SZMiKldoKhIOoLFtfeb4BlNlyJgO+wH8UEtOJ
	QZSWyqla5WqipWJt4K0lQpcM0LYucGmclhlwCY2LAJahFeTbQa8qM1KQrIhTfH9WTGAV9zCRPYN
	EbBn8r7OqnUcCF04s2LCP+zp6PY3WftazhEaOcOYZxS4CFgkBDyHRsQsR9bafN1BLiSGLK8l0VN
	u+6e7KuGxHyCwyvg8YGGr0C03ZuwORttykguG7jjaU/S2JzuvxSMzlMquRCE7U+RHRAC57GFr6s
	GryCY65abgDvOCOF0paBdl+UUqWyqOuWJ5XBkGKiSEWFROYiVlDOGPgGpKaABMadGwQolJ8IMKG
	NUzVcbSES2MjSgYeblc8Ta9es7Y4AtcD0kabqPZKc5Rv0iP6kEF6oJRILqrGI7Ui2WXIrcwPKeZ
	D3L0JRx7hV5zrkr/k1/hKcOHXs4klrZiiqpjNj1TgR4Uj3tnoNWOqETD3tIxjqFhP9NoHfU2Uaf
	PGRCsJaxItpkLfJIL8joC+VW7kntQ==
X-Received: by 2002:a05:6820:820:b0:6cd:3ffc:64d2 with SMTP id 006d021491bc7-6d5bac3e146mr7371645eaf.77.1790530448403;
        Sun, 27 Sep 2026 10:34:08 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:5ba1:a8b2:19d5:7f67:de2b:c3a5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d883394af1sm2755239eaf.13.2026.09.27.10.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:34:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate offload
Date: Sun, 27 Sep 2026 10:33:53 -0700
Message-Id: <3FDF3191-94A5-42B3-A33E-12021344D7BD@amacapital.net>
References: <20260926045517.3458413-1-matthias.goergens@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosry@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-api@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
 linux-man@vger.kernel.org, Karel Zak <kzak@redhat.com>,
 util-linux@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Vivi Rodrigo <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Rafael J Wysocki <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org,
 Matthias Goergens <matthias.goergens@gmail.com>
In-Reply-To: <20260926045517.3458413-1-matthias.goergens@gmail.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
X-Mailer: iPhone Mail (23G90)



> On Sep 25, 2026, at 9:55=E2=80=AFPM, Matthias Goergens <matthias.goergens@=
gmail.com> wrote:
>=20
> =EF=BB=BFThis RFC adds offload-only swap areas for deliberate cold-page of=
fload to
> backends unsuitable for pressure reclaim. ZFS zvol swap has documented
> deadlocks under memory pressure [3]; compressed swap is another target
> because writes may need memory despite free logical slots.

This seems unnecessarily annoying to configure. It seems to me that you=E2=80=
=99re creating a bizarrely named administrative flag that means, roughly, =E2=
=80=9Cswapping to this location may allocate memory=E2=80=9D.  Why can=E2=80=
=99t the kernel figure this out itself?


For that matter, how well does this even work in practice?  If I configure t=
wo swap devices, one =E2=80=9Coffload-only=E2=80=9D and one conventional, it=
 seems like the relative fullness of the devices will be mostly an accident o=
f what triggers swap as the system is running. If the conventional swap fill=
s up, is there a means to proactively empty it?  Under OOM conditions, will a=
nything preferentially kill tasks that reference memory in conventional swap=
?

Is the locking and recursion structure of the mm code such that we won=E2=80=
=99t have deadlocks where cgroup triggers swap to an =E2=80=9Coffload-only=E2=
=80=9D device, which allocates, which causes memory pressure, which then tri=
es to swap more to conventional swap?  (Maybe this works fine.)

For that matter, if the system is under overall memory pressure, why do you c=
are what triggered the particular swap operation that is being processed?



The remainder of the writeup is IMO somewhat incoherent.  To the extent that=
 AI was used, can you read it and make sure it makes sense?

And the first few hundred lines of patch I skimmed seem like incomprehensibl=
e churn.  Adding =E2=80=9Celigible=E2=80=9D to a bunch of calls does nothing=
 to explain what=E2=80=99s going on.

