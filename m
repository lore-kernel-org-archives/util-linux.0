Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFBD319873
	for <util-linux@vger.kernel.org>; Thu,  8 Jan 2026 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897102; cv=none; b=gT4dKlxOx2EO7Ha7IZEyuE/bezgeHZg51Xhs7wPtqRwEMDYRuCy1/dCCcyFxg1AEf8dG+FKnqCWaRSAUbzMmgMigYLoz/0TCQU41LcZanqlrGsv8ZtKwMvCE+bSZMhbbxMHdjbDdnlA4bSsIS1TGK/vNN7XDIoK5XJLs2SaIt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897102; c=relaxed/simple;
	bh=cX3WhOaN8GNu5ovbXoNmO1faxwY79NZjlcSRWsPftj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWuSxYMMcT/Fda6jEsV50qXVUMXJQInkqvL9LgODhE3ZJgiH8TMecwAElgy8OJXGuAshLT/2oqlG/igrweKBFsrIB6oXt2OYMhTEncTJKQFRZtq5JGAnnkuY4pTx+RQV6gkK4YdXXOZtyyTIZG93lzNor/OKZZ9Z47sHUido0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ehty7qe3; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehty7qe3"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5634feea416so1307540e0c.2
        for <util-linux@vger.kernel.org>; Thu, 08 Jan 2026 10:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767897100; x=1768501900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zo0BkMdvjZXrMJ6sWuZT2Ow64+wwaeZstpTDWuxz9SE=;
        b=Ehty7qe3qXm/8iE66PpQ0ZCD5KGVB12dHCznttWjN9SPjCNwn50GKed8BpO/jCdNv9
         OkV9xBbnEHorTyiDy/gYvB0Qusd6TkQBxgsN4tRc2GDG8GaFI56JH0lQJFCSlHnZ6jsf
         5FwHAcONU/Gi1ec+ztA339Psnsjj5TkPLcGIWcBKnVRSWAR4B7Pe7ituPhQGFnppBIqo
         v3te/rTIlSFrbbLWRJs/BlJHjuW4IB76CflV4bpUyc0+PKXqvlIXVd/htT+p5jFTJMJt
         GC022es8PzyAZJ7bz6RaKenKYAWMu23EiWun5zt5IsvN+e/3n9v5belKYlYovltwuS/Q
         HGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897100; x=1768501900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo0BkMdvjZXrMJ6sWuZT2Ow64+wwaeZstpTDWuxz9SE=;
        b=VNZt3uzmd5CXtOFjdwh7hJL8joJ5Lhe4V26LbMkA8khCaUxyvs56SWllceXxCEZ0tO
         oU3KKQrnTZiZfY3JRdUEhISj/F83O9VMaDpNlPHAGJgaHqIOhF64w374bnQIT/h4N6AZ
         sU5VERDzifO+6ZEWI1iF9x0nNkP6UQcVZYcHNKjvqTk6sbTCRbg+D0vjLJ9acADBtvxK
         0jd9WaWYmPyJeDEzhR7ZoQdd8LJUMX1MurF9PdcAjAs28u+dvYnsPYN7y4s9pDI1Z/LR
         6KvrwjYFRI9rEDffBbsj45yjAT5n0ok9Jq+gs70l5vebU/pL8T2TGOC2oVir4jUP9/LF
         MV8g==
X-Gm-Message-State: AOJu0YwSMZazuUSnnQdm3ma/sZtrBz4OF1TQDKwIc23FEXzXpCgHulsp
	X0iMEYQHOmSLd7YfMqVsFSR+zPKWO1jSx48/iBORPf3ZrILH/oKbMFRmNoOCkQ==
X-Gm-Gg: AY/fxX6apiA7gSc/qlv+rfHaPFlR/58Y4ERElbilmXo8CWgxN134nuW8mVjbXbm8+UR
	f8Yi8HVJ+lpXe3hbDI2pDvU650aeC/oHvtlzK6fKyJTz0GWa57dfFJ+8z/LnMcG59bR0vhG4omN
	7ONyP/R2mSW1mKpKCvjPQUV8phUDDcBCbl9TwvwCQC6jnLAKGRc33aRwaf+UbB1bLmGBspVHtVT
	vDURbakQKP3EwZFUzWhrBywXnDaDa/gWj9PWht5SnMk2nbwqhJJVvxP8J+E/yud0c8no62wjaPZ
	/LAUluT6KseFJ6ifwbLLnRMXaFHCXca4sDdN1f0IrH1CpBi3S8wxy9hPnf74USaUWQEyWLxokLw
	4NM3168gA2FG4Qxs4G4Zv2MA0DR10WhMUW3KsOGVJphzItpvLawkjV4pFeMcs0veFur1nI1zC3t
	xXeeCGR7/w2iwn2xVy
X-Google-Smtp-Source: AGHT+IFOutp6xnolm5NBnWFNdA5ATBc9Mrox5gvWikvdVGl4eaBv4EcjsPiEp6c1T5Vp5/rJuNnVKg==
X-Received: by 2002:a05:6122:3654:b0:563:5e42:4731 with SMTP id 71dfb90a1353d-5635e424a8cmr665276e0c.15.1767897099308;
        Thu, 08 Jan 2026 10:31:39 -0800 (PST)
Received: from penguin.lxd ([155.117.189.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a1ea753sm7087287e0c.4.2026.01.08.10.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:31:39 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH 0/5] unshare: fix signal forwarding to child processes
Date: Thu,  8 Jan 2026 13:31:29 -0500
Message-ID: <20260108183134.23980-1-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bug where unshare with --fork was not properly
forwarding SIGTERM and SIGINT to child processes, causing premature
termination during system shutdown.

The problem occurred because the parent process was blocking signals
instead of handling and forwarding them. When systemd sent SIGTERM
during shutdown, the parent would receive it but the child would
continue running until the kernel forcibly killed it. This resulted
in scripts being unable to handle SIGTERM traps properly and perform
cleanup operations.

The fix replaces signal blocking with signal handlers that forward
SIGTERM/SIGINT to the child process, allowing proper signal handling
and graceful shutdown. The waitpid loop is also updated to handle
EINTR interruptions from the signal forwarding mechanism.

Kiran Rangoon (5):
  unshare: add global child_pid variable for signal forwarding
  unshare: add signal forwarding handler
  unshare: replace signal blocking with signal handlers
  unshare: store child PID in global variable
  unshare: handle EINTR in waitpid loop

 sys-utils/unshare.c | 47 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

-- 
2.47.3

