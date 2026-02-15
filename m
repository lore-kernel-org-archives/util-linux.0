Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00417279DC2
	for <util-linux@vger.kernel.org>; Sun, 15 Feb 2026 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771144482; cv=none; b=lOvWCl1RT8jWTogGKEwvlxFOo+MzVDTjUQICHw7cXOQjAGP6Coeg0pSDvNH6h63osM5+chkR9EN3OmkG6eSnSrEJTVtcJCSuoRbeOqB8NONDJItp/9L+XFZkXV8F2p8fpqHeH8OaVi4e1edrdhVczSoTSTtfB7m8k0tEas2emdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771144482; c=relaxed/simple;
	bh=aDheW/VQ3pU2GXXH6hZlLeYPCjWtolXw3Zz4YLdWKIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hSjc3nFnBd49BES9hvIeKMjOUhxPVORuMxXnpMBxjleT3ah00uTloaxrxFqxjCDv7g2DjB4Gp8qZq1FZm1GbJoTsYVlO3/rAhc9Rwbmtn4HDPZ+sb9tiwmc102HMEk+rpT3aniNSwlTBkwA++5mzhaU+CHDtuJNve8gSAgSRldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJhFgVrX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJhFgVrX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so17781665e9.3
        for <util-linux@vger.kernel.org>; Sun, 15 Feb 2026 00:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771144479; x=1771749279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxOIDAoXiT8jwwvpZ7Wiv1o0m0jQpEybtRXCHeu85Jc=;
        b=SJhFgVrX1Vy8Kzf0SslYb6/bNdzyOiMsMJab8YOHPGHXUMhY/d3iFcOuDoymtrlsna
         nHfreUgFPj9iYlOZ/ufROJ4K5yRk8f0mEE8xb3f8mXQnMZZ0mvdbTFla+r3lY+ya8o5e
         cw6AnyVwdu7cqrc61ygaexWkMV10i1qgoB5UgFviGFwejjyUY33vZ3V4dN2apb2bF4oA
         VvsDCTc1aqF1aGo1tJ+5YSYUhHDuqPpvU4OxdOMqC0tqXl9U+eQf+VOiYmDSvT/FFIur
         wXkYBlUfrkxrjoAFNmLW7Nf3Z7b5PR9aeV9lXvBIRkp5DpZmjSh+kGlMTx+a0Y6tqXfo
         WnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771144479; x=1771749279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RxOIDAoXiT8jwwvpZ7Wiv1o0m0jQpEybtRXCHeu85Jc=;
        b=sz4cfH0p1+SS84sx9NQilmpdye3KPaSNneakVeBcuSvPB8aVtVsG6WvAACvTfOnS9A
         Hclv/95304yH0WOTBKG6Dh8fZhZeUPkG9Au3eFfX2ZmMqlBjvcmTgCe3WuW4ntyO1lu7
         kRw75SfX/doNRgcjn8cPwyQEm3MPxskHtImnjTPOYkUcNImV1NHHQAwn1s2BOzzfTTIY
         WVXrJ95Ma/xSdmm8ThrWypuGp7qTuyBly5MkDpt7MWtjP9pId8y6IsZFxiGK1I893Ask
         5qhkqpj/uFuvrsO1KmxXqMgi0QCnj6H5AkserYUbsbzIKGtyA/ied6Giex4wdUoqlXvt
         7b4Q==
X-Gm-Message-State: AOJu0YzRMz1+UElgLdJwaxzKwIAcbPcaWvYKlgQ4n2T/c2+MH+Amtqa8
	gJXm0goon7TehesNjzcYb1I5LiynNYS8dinVoadkwpE4mSbOfldgp6w/3/8d8FBFQp8=
X-Gm-Gg: AZuq6aKOGyMgzxNo4zxEtJOY9ToFGwrsWKcBqAmTF6hvj5c9HvHG8UD8ERmNGZKZVKq
	sRTbkQVhglu3BCY++nw15cqp7Th+PgpzMTa74SmucjDwsCuNJ0vw/Ae/d1U0+xAROJiRdF6y1xI
	5Cgl7wgbt/r/gV5kH4IsNyunoV4Y6772KpKqw93NTJf8149jam2k0FgHJbn/FFhTGNRUHY4LMch
	ahPEVQK5oUXLSadMFSXcZXNb62CcuKNAn6GcLMrPWh6FUsWOGLEguIc9cBZ8kEKpoaIa3DVcKDP
	buKjVMZqaZD/uUSX7Gdxv7uO3DrxPQlfcjsx8COfqjZZ135bDG7TEhazV7kw+Ck9j04fTAS3i3E
	zF/0LAlIlHqwNURQQlnfNWhsYLkZhqh+i5juF1bv192zsROigxQBEMx1YJ0jtOPw4VzLKwQ1BPY
	w8Rq4sobaH7OHu6/fCbl5mNHaV
X-Received: by 2002:a05:600c:c04b:20b0:483:7eea:b185 with SMTP id 5b1f17b1804b1-4837eeab9e2mr41409835e9.16.1771144478845;
        Sun, 15 Feb 2026 00:34:38 -0800 (PST)
Received: from system.. ([178.131.176.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483709fdd39sm93326795e9.0.2026.02.15.00.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 00:34:38 -0800 (PST)
From: sina-abroshan <sina.abroshan@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	bensberg@coevern.nl,
	Sina Abroshan <sina.abroshan@gmail.com>
Subject: [PATCH] lsblk: improve error reporting for invalid device paths
Date: Sun, 15 Feb 2026 12:04:17 +0330
Message-Id: <20260215083417.185974-1-sina.abroshan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212112423.2400888-1-sina.abroshan@gmail.com>
References: <20260212112423.2400888-1-sina.abroshan@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sina Abroshan <sina.abroshan@gmail.com>

Differentiate stat() failures from non-block-device cases,
so users get accurate errno-based error messages.

Signed-off-by: Sina Abroshan <sina.abroshan@gmail.com>

---
v2:
 - Use tabs instead of spaces
 - Drop unnecessary _() around "%s"
---
 misc-utils/lsblk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 3d2bc21a6..6a8769bc7 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1797,7 +1797,12 @@ static int __process_one_device(struct lsblk_devtree *tr, char *devname, dev_t d
 
 		DBG(DEV, ul_debug("%s: reading alone device", devname));
 
-		if (stat(devname, &st) || !S_ISBLK(st.st_mode)) {
+		if (stat(devname, &st) != 0) {
+			warn("%s", devname);
+			goto leave;
+		}
+
+		if (!S_ISBLK(st.st_mode)) {
 			warnx(_("%s: not a block device"), devname);
 			goto leave;
 		}
-- 
2.34.1

