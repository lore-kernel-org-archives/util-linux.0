Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FF264A83
	for <util-linux@vger.kernel.org>; Fri, 27 Jun 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020749; cv=none; b=svt0elsgc1LtwohhsoNLNtmT17oZJPnigeo8rDOeWC+UVZElyWQg7WHyEoeOrmH68JB3M1SeS8y/ZSdk/BtJtZ6UQ9nLbcxYPB1kdZPHKKsWmpk1s1izutM8pKNMUq9Zxur4LUjobVcNF8JbvKebxBihCC21EUI1riHH41dBTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020749; c=relaxed/simple;
	bh=p6HZ1aMeHrazvnv1kwka6JTSSGeo5DRSlDOvsinuLo0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FpG18w+H4RGSpkyFXYJSujQzhtWwImEMFTx/mNcvuwKS+f862RD7JtkxT5rKRga8IESNQYG2zYQsNn5Xu3f0bQXRgubs9eJ6Zv5BVvfWlKC9/5v7TZGwI4bFKvgKHmroCNQ82uNWztXrlpBtdXKnOqStjgQvHWnMXFFD5xR1yv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7CFUTkN; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7CFUTkN"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso9125a12.0
        for <util-linux@vger.kernel.org>; Fri, 27 Jun 2025 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751020746; x=1751625546; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p6HZ1aMeHrazvnv1kwka6JTSSGeo5DRSlDOvsinuLo0=;
        b=y7CFUTkNNcG4DWklsqcKmZ0Hf3oXXEKNt5GQP+mJ/bIkbYlWoyH3Q0yiqbaW4GRiW8
         Ak27wikcSFDdIdJvVUU4pNXhCO4jd4owQZVmXVsgtWXWoQ2o8QQQgQ+DvuSpXhTBeb8D
         FtHyaxJdIuhWqLyfIOlCaZ6v/hUyXjj8XGUCnr8mZAWStb2or0XVcBkJJniZ8tLHnwCS
         90u15bc7cdPO5KazcCHvROafvtKtX5EBleBdZd6qnkqEv8alOTUDscory05GkT/gE8ru
         CmKADUUGwbyIOCO6ct+I2H9ez47GpyPldTelhPThWUxU5yLCVpbn8FFhsVvITD+/+um8
         7iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751020746; x=1751625546;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p6HZ1aMeHrazvnv1kwka6JTSSGeo5DRSlDOvsinuLo0=;
        b=E7VmQGr9smxrKwmncmf4FT0f4laowRDHq2XGIM2jsoxwg96IxNrGX4NC0dmXMffv6p
         5kBQlyZzlx8qmCv7M0yKdddhTsy8PkeKHJJD5qv5sdM6zLxGXmVKF8xvXiG5cACV9A31
         TLjqqLbI9av8N0Zix9DVImENW0b7E2aPDyLLYHSO/e4jfh4xdvC7O6DLviKVZj6vfbPu
         k5WK3QCTk6BAGwKhqBuNVnEWLerhoIDkfiP0FJBQIX2QDa5zhRCu6/BRBmT+i+IWrcN/
         /8VdEeSuzFM7L/oOL/YHTwf20dHCEOGf+bglNDDCgYqID6ZdAy+lP1byKQXgqMEaEH2F
         fkJA==
X-Gm-Message-State: AOJu0Yxzuhhs9SulabK+G4zjWCPefh06Ou6gNrAkgzzLXveJII72i64J
	5w4nwGX7nPMyIpleHRRZVTM4fkuBApULZ5tVNNtFigUsxfdbedtOj1NbZsfvNB/R/NA5gOmiztN
	hmdIdgociir5m2GVXJPeYt7lGFub6VOrDeW/1In/SCi12l/NVXgJwMFlmCQU=
X-Gm-Gg: ASbGnctUb7TA7xb+8RRM2oIAC1dtH7fsqAklC1C6YJP8WkemvTE0DaR+LxNXWEISmaY
	5hNyv0EcTtBASQ5e9Ao0dhWQbtQ4+zTzC+Nvv1VsDsVOb1+NWZE9ZvriZusZy550YKIyrbjiGHv
	bokjJVL3OVTcL5e8OhltTOY4o/chJMiml4EGKNts4hEjdvu2k9qWhIYhCrpGT5mqCEgI55eZ2N
X-Google-Smtp-Source: AGHT+IFHFMdDpg1/LbzOYeMVYBEtOMeFqVNrkFPCJ/yT6xayoqukvfvCtXCp1/+sUAK/9XJvS+8uiInqTdbzLbIHlNA=
X-Received: by 2002:a05:6402:4490:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-60c88091aadmr80651a12.0.1751020745795; Fri, 27 Jun 2025
 03:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesse Rosenstock <jmr@google.com>
Date: Fri, 27 Jun 2025 12:38:54 +0200
X-Gm-Features: Ac12FXzl163GCGgzxKHVj7rIWv-BNqqztH4tKv2AoWayC0y5xKqxw2EMbc2p3IA
Message-ID: <CAMZQ0r+p--qJmjEFSTby67Rmb364A48gH9W_4RQrr+wwkJkdRw@mail.gmail.com>
Subject: [PATCH] gitignore: Ignore tests/diff/ and test/output/
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These files are auto-generated and clutter git status.
It's even worse with jj, which will auto-add them.

https://github.com/util-linux/util-linux/pull/3630

Signed-off-by: Jesse Rosenstock <jmr@google.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 8764bbe3f4..305e651532 100644
--- a/.gitignore
+++ b/.gitignore
@@ -66,7 +66,9 @@
 syscalls.h
 tags
 test-suite.log
+tests/diff/
 tests/failures
+tests/output/
 tests/run.sh.log
 tests/run.sh.trs
 update.log
