Received: from out-2uec-a113.jellyfish.systems (out-2uec-a113.jellyfish.systems [63.250.43.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66C3DDDDA
	for <util-linux@vger.kernel.org>; Sat, 19 Sep 2026 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789818519; cv=none; b=Ro8lOGB9MfydGZ01J1SiChW9Mk4j/LTSkPFdO+FnbXblF5Akxyz2cBekoKMz1VFlDJDs00SvJpCJeXgvSKH/hrOK3ho0Z1R/4q/OH9AQXFRRY75oGo99Pd4JSR7OKZ71yYQ5TZUntP8DvRfs0jng0xXFoTQOGTFQmNhs+ygEJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789818519; c=relaxed/simple;
	bh=TlZ3pXChpht2/y2yRtS9T3REic3ve9HPpIwbhbh18yg=;
	h=From:To:Cc:Subject:Date:Message-ID; b=GaqEVDItuh7uLm3DUUR42N5fyWtrGLa5JgPUFcWKO9i7G8o4phDies+8Zx1P2AII2JvK40B7UfN9LUuHExX4z5dJYNIrRAa08DZR4qjaiU1v+K4uMKAGKo/ZtqNcZ/Xa48JjeVOS/fD5UNBSBJR8NsWMB3XvrN/8C8d6mPjX/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=HFqjngim; arc=none smtp.client-ip=63.250.43.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="HFqjngim"
Received: from [172.20.10.14] (unknown [39.144.124.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hn76d33WRz2x9B;
	Sat, 19 Sep 2026 11:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789818506;
	bh=bD13aBJC3uYZ3iPblZUuZgFSIG5IzpFlFx+/nqUSkJE=;
	h=From:To:Cc:Subject:Date:From;
	b=HFqjngimjYJmXTcgFltU0oBqZxMm8uX8P85Ct/DiYkNVXumOEPT1EooAmU/rSnxBs
	 SdxVynMldqHXAlwdSY35acP/Zg9q4cBxxATARbhm0w/FT7cofxHS1x8cnaii2CuHNP
	 2xtH6qZpeVSEVYi++65cVB7F0YVP7kIHaGLgaJrCneGmrqsix6hQm+P5tiLTky6GBG
	 G73JX6B4CBLl78YNz+NKMREZFLujlaknSonykThoMi9b9gDxTqZCHQOCa0jUKNbVHp
	 PU73ckzszryhoqp729kljgBGIjfctO8K6JGPZdpvE0gDR6r6ygYPSDAJt/m/e4cQyJ
	 0clSRq5TCvNoQ==
From: Tianyi Chen <hi@tychen.cc>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [RFC] libmount: explicit loop direct I/O requests
Date: Sat, 19 Sep 2026 19:48:23 +0800
Message-ID: <178981850377.1262776.17938790502420524863@tychen.cc>
X-Envelope-From: hi@tychen.cc
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

Hi Karel,

Following https://github.com/util-linux/util-linux/issues/3464, I'd like
to implement X-loopdev.direct-io=on|off with these semantics:

- Omitted: preserve existing behavior, including reuse of either mode.
- Reused device: require the effective mode to match; do not change it or
  create another overlapping mapping.
- New device: read back the effective mode and fail on a mismatch or query
  error rather than silently accepting a fallback.

Failure cleanup would release only resources acquired by this mount,
without detaching reused devices. This would not add live mode switching
or remount reconfiguration.

Does this behavior and option name look reasonable?

Thanks,
Tianyi
