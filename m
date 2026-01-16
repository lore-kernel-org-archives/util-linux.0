Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90533A9F0
	for <util-linux@vger.kernel.org>; Fri, 16 Jan 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583218; cv=none; b=Fh+cuh4RkEB6Gyny/QdV+1LWFmGv/tazz9tCljQdMh2YRI1qde5A8au3pzfnuxmfSWuCaHWtqjsb3OqZOzsiYAusPrANtXjUrMGU4rPrbHgSjhRnZx4wCWAmIoNFZBfJ9MUEbn81m3dUG3ZJXkueU5dJdCX/gcOY5ppvNX4/5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583218; c=relaxed/simple;
	bh=ZmT9Ct2MF2cX3fV6faC8J+UUtPMsbfRyeTTDuQdLrwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3CY/kNAlKTplzp+nRX3LaR58UCXsAFVK0vjjOiVbSagyLt2nv/ThJfd9WXisezcdh9swdS2qQ9dkfErz60qXAZu7OGXKpFUzF0yynFqQbC8h+aBOmjJtCHs7Ek/ypVMIMJTNMJ066/dxcp27NnPfG0a5k0Tsy4KFIj3RIU9pdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUuIfTjZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUuIfTjZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso8217685e9.2
        for <util-linux@vger.kernel.org>; Fri, 16 Jan 2026 09:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768583215; x=1769188015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COicBgzb+5S9F2Rg/jta84dMB87qDTugvcPjR969Isc=;
        b=RUuIfTjZU5Go9nlR1VSR3/Du5OzF7ZKsdD9nsY7JenCMjf8jogFtZfX6Gts0kMA6te
         jAvzuSOBMaWJ65BkJ4FELJhZJ/QsPhunugAHrliFY8feQUj6exVJ2XgyW4YYouMsRIOE
         w62c9oVCB2H6MX2AYm27CjbW5fprMvyb4Q29xfd/epJx04Qjj9OoGhASzJX1i1TE1Hj6
         50Nkr9nPGGZ+VxH/lAyDaF2QnXgKuUSyrIXQUHLLJfBB6RyCrZLruVMNEw7+aGfjKjZ6
         XPqrY6WR40yLVXU4Ws5LXJ1qlwyurJP7WKw8t3Qm2ouQlPYZX1VmSbJLV8IeSZGsTISn
         6m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768583215; x=1769188015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COicBgzb+5S9F2Rg/jta84dMB87qDTugvcPjR969Isc=;
        b=eqPbSESxrqZXl5JGfDbplGtsB7U/mI8CGVj9Y5ZR4NJhgOh+QLhWFxPLkXqZSJRqYw
         EhwOvo8xF+Es/X+nbiofk99FLn1YX3zLQ6CzHiw2ojbQ5Zf7HtHz8yG0eSus/t3xyOxO
         FRntXJ5NhDfIsk5TdL6TuF0vMwsb502Edh8OR964lEnEoW8heMBkBljC2uJwj1vHgZGw
         OBFkP2bimwqg8dhkjTlaOlJZRzZhV5CNjUl3xdSSOQiDir22+wKPPRgCbXlH6XpaRLfl
         c8oed41lh7RQYGQhX9Sm79Ey7inOdRTQqBIrZ5ACi9vS+jCUG6grzdLrnwOf0QUok4Mk
         WlAw==
X-Gm-Message-State: AOJu0YxAmSZeDZ6krr8/E+jviTsXwWgULihOpMGMnMqw5j14gLD41U0o
	sPr86YuShkerAq4gRxBIVIjAqF3/tpV/KyOI3fXcUN5TYtsB8dlgTC0EfuVykEKK+X4=
X-Gm-Gg: AY/fxX69jk+qpHectRXE0KC+C90JxqpTWyu/3r71Qzl4IbIrjmbMNQ+MdNWsfN0g+6g
	es4apDmptt5YuJ134jd22oyJV5OvOCBiytqGYNlICQrgWGVPV8TJHAMvJ/X5iUnQ07QKjhoU3VF
	ts3g8o3b1fm3j/kjA7B7mrdkrUbLwA5kB4B9l+TYGpcsu3OxBeLU/U+8Z4D4osPu41sc6y/xq8j
	pdxbnD7wzS7258+2b87D5tKh8CfQWi0+VmFEizlCbQWq5Dr8t44x7vMcfqf7G6Rzsl7igizyRw5
	i6WGBepgzJC7MO+i6RgXh0ACKVRP+w2pnKjvQiVux2e2/uvoxrnh+uN4H8wqv2pAGdxZ/kZQq96
	pbXeoOKex4bAZBY7TkNaias9is1I9s+BIgn1JB0Re93z7bplUml3E9Er3BbuMOdJMRgfj6Ptv1z
	/llvf/N3WiaYmY+cAa
X-Received: by 2002:a05:600c:4451:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-4801eb0eeb8mr40062035e9.27.1768583214717;
        Fri, 16 Jan 2026 09:06:54 -0800 (PST)
Received: from penguin.lxd ([149.102.244.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm6526709f8f.42.2026.01.16.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:06:54 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH V3 0/4] unshare: add --forward-signals option
Date: Fri, 16 Jan 2026 12:06:44 -0500
Message-ID: <20260116170648.26439-1-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113172942.10678-5-kiranrangoon0@gmail.com>
References: <20260113172942.10678-5-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new --forward-signals option to unshare that forwards
SIGTERM and SIGINT from the parent process to the child. This allows child
processes to handle graceful shutdown during system reboot or service
manager termination.

Changes in V3:
- Add bash completion for --forward-signals
- Add usage text in help output
- Fix code indentation to match project style
- Improve test synchronization (replace fixed sleep with adaptive polling)
- Add namespace capability checks in tests to prevent CI failures

Kiran Rangoon (4):
  unshare: add --forward-signals option to argument parser
  unshare: implement signal forwarding when --forward-signals is used
  unshare: document --forward-signals in man page
  tests: add tests for unshare --forward-signals

 bash-completion/unshare                       |  1 +
 sys-utils/unshare.1.adoc                      | 13 ++++
 sys-utils/unshare.c                           | 64 ++++++++++++++--
 tests/expected/unshare/forward-signals        |  1 +
 .../unshare/forward-signals-kill-child        |  1 +
 tests/ts/unshare/forward-signals              | 73 ++++++++++++++++++
 tests/ts/unshare/forward-signals-kill-child   | 74 +++++++++++++++++++
 7 files changed, 222 insertions(+), 5 deletions(-)
 create mode 100644 tests/expected/unshare/forward-signals
 create mode 100644 tests/expected/unshare/forward-signals-kill-child
 create mode 100755 tests/ts/unshare/forward-signals
 create mode 100755 tests/ts/unshare/forward-signals-kill-child

-- 
2.47.3

