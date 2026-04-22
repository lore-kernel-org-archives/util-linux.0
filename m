Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EB2475F7
	for <util-linux@vger.kernel.org>; Wed, 22 Apr 2026 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.76.87.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776882314; cv=none; b=c9CV8b6SnrA6iTuMjpLQuAAw1P7J6aoVfVIEaGT3ltqeeEppsegggWafcG/98Wg5ydlQhHghRn9TMSWf02d4NXLdCzG5VRV34pFKSxa/TzI/LzA7kul3Vrf7n3VXCkXeKWyWEXVjXdUQ9cuS3qRDojkISJEtb/9yNEpNkRquavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776882314; c=relaxed/simple;
	bh=KRDRPwUZD2rekaXYxxpGut0Z33q6rHj/ap6kWFx0/IM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLkoFM8bUlBPAeaSWHV78glPNKCob7YFmLfFL2uDnsMxhzccf34hQ4SKRK+EfyD8gbfxplRTYGCExYJPZ9EO0JopoTOYPHYkHWeMK+GJUgEKYdMdrqW9CcsVrwTBsOmQ4Rl1oEX+9CDKP32hd6k7nuv8XHuzDq5l2kJYbTjXrK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net; spf=pass smtp.mailfrom=smrk.net; dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b=jCF6EMSM; arc=none smtp.client-ip=45.76.87.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smrk.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b="jCF6EMSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
	t=1776882302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vl9H+RsW+/eM38MjQyWWeVKLp7tLg+Ng/gMzjR+8GGY=;
	b=jCF6EMSMHienhOggbvaiRhhf4zgrcLe/Z0ydgxjV+Z7a79/IsQC6UHZ0GdkfRJBbirdZD8
	w38dgiJM3KYNqWoEzHFsgMAbqpZ23/QRKhttq7M8RjbTHBfy6xn/Z+YQ3zDG9ZZ+DIXxY4
	NomdQ58rYouVPTz29QpmVj7bXaq/rjyxWJZ2E8/dKta+ZG5Z/fxOBoEVelh3YL7oCVVHKS
	4Fm50MN/aV6j5tWfGSVIZhGcgpyV8VgCBkmCZ93O8HbYsij3JxI8AXKdTUre4RBZjn11PB
	gRE+E2wOYeT5puCoUtbQ7OcQOAdylZl6yYKa+JyYR/7OxwYec4fAy1D1PTlltw==
Received: from localhost (<unknown> [192.168.5.2])
	by smrk (OpenSMTPD) with ESMTPSA id 00a8d2a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 20:25:02 +0200 (CEST)
From: =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To: util-linux@vger.kernel.org,
	Benno Schulenberg <bensberg@telfort.nl>
Subject: [PATCH] copyfilerange: (man) fix swapped offsets in command example
Date: Wed, 22 Apr 2026 20:25:03 +0200
Message-ID: <20260422182503.1111558-1-stepnem@smrk.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <bd1c4673-ab3a-4934-a7d1-8113a48c9811@telfort.nl>
References: <20260420180528.943663-1-stepnem@smrk.net> <bd1c4673-ab3a-4934-a7d1-8113a48c9811@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---

On Wed, 22 Apr 2026 08:17:46 +0200
Benno Schulenberg wrote:

> The convention for the subject line when man pages are affected is:
>
>    program: (man) description of change

Interesting.

I did recheck both Documentation/howto-contribute.txt and recent man
page commits before sending the patch, and, having failed to identify
clear guidance, went with the pattern that made more sense to me.

That said, I see now that, had I gone more quantitative about it, I
might have picked the one you prefer :-D

; git log | grep -c '(man): '
21
; git log | grep -c ': (man)'
289

Unfortunately I didn't.

In any case, if the preference is felt strongly enough to require
rerolls just for that, I believe it would make a great addition to
howto-contribute.txt (or at least applying it consistently in the actual
project commit messages; the most recent '(man): ' is from 19. 4.).

Thanks,

  Štěpán

 misc-utils/copyfilerange.1.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/copyfilerange.1.adoc b/misc-utils/copyfilerange.1.adoc
index 303a1a7b25e2..89b95e9516fa 100644
--- a/misc-utils/copyfilerange.1.adoc
+++ b/misc-utils/copyfilerange.1.adoc
@@ -71,7 +71,7 @@
 
 copyfilerange split-first-mb join ::
 
-copyfilerange split-remainder join 1M::
+copyfilerange split-remainder join :1M:
 ....
 
 == SEE ALSO

base-commit: fff8c59c75355d365a69f86719e7bd7818c1daf4
-- 
2.53.0

