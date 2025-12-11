Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D325B30D
	for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466419; cv=none; b=XSBL6Xbav3SKbKZajMBk5Wi2vA6KeVJZf/piuasZR1+lal1Ri8o3SlB4PGulufmiThNzn6q7guwKTZ+nw+li5OWCur1UkI21eN0AuFNmufph7ohnCR0uCDH9/spyBox/W2oA2yl8c2GPhtiNKkvO2lnrskbReqfnJfjN7Kc/GDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466419; c=relaxed/simple;
	bh=aLQ6TLCwv2bYO9SiRB/LN2mU4V3qBORVK173eNGXMaE=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To; b=d4040vmVhLEQxhMSN2QE5UAYWoSCOeOPCEO1ssML6eNhCwHRXMWpR3knie78W3s6PuJ+aNYufSs9vK5t+dilNvVGmQGJYD+OV32CP+8uuKt9HFhiecdFF1ulivHFEBxn3tNq8snkcqtiNV0yPHe2FM52acUJlvQdU+QBN5R+sxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tge5rcY1; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tge5rcY1"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c0224fd2a92so186316a12.2
        for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765466416; x=1766071216; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLQ6TLCwv2bYO9SiRB/LN2mU4V3qBORVK173eNGXMaE=;
        b=Tge5rcY133sp2cIKuI1fVvpAseYWQAYdGd1wA0HQBomy9/NuorWXEqpt42hIZrPMRm
         WgzxMZ3HOvpnDOXJt0aH+1V0TiduBoHPITWY62broOp5dB2fW7ZAMSjhF9SYnoNHfxKM
         wcNoaZ1Oy+6lSracWlXGT4Uc18QdDHhVYlGPih/TZElOjjLkjlMDLIUDScWLDcJwdHAE
         74FSNVi6m34Pbi0J952kbXGY0Ejfp6bEWvIB9tuEf92rJwmiCXMcZLMEzZG64/c6HZbi
         SnBfppuS7ECZC0F8x5rr/ThpAEnOklA8kQ4gqH8OqXCp9UjvtXpOgV0yS1GmCoA6+O7n
         M4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765466416; x=1766071216;
        h=to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLQ6TLCwv2bYO9SiRB/LN2mU4V3qBORVK173eNGXMaE=;
        b=Vg+xP6Ryb4rWazCQ+zzqAGPSxn4A5WTEfRIyudz6IyVmcwAk/IkktKy780khWEboak
         2hPzp0nj5NCCCkH5aShr7gmkRJYMkwivQfBsN9eL08FklE3AksEwFRcS8S1dDu1KywaB
         tkgGpdCO/hDm7LREFWw2/VXjVJ1Wr1feZN7Hu9TpNrZn1aIt2frK5LOaqmYqdCA9xDK9
         SLu4uEYPhr/UEnR451aTSqdMmdqHlrx3FAgcfd3JN+AMzgQ1eTngdME+7e/JntLVDeBP
         /bupCQhRUaN1xkCU8Pmm/OMixdlasMDgEw9te2ArxZC2WiDJdf58R1gVlI0UwvHqZRhZ
         nuAQ==
X-Gm-Message-State: AOJu0Yy1IH4jYMNtUZSYNaa7/kmGuk7gdbu27U4ry/oZ4VbUBGxDmZL1
	CL9exG8YaUbOSPORtaJs+CzUVJm+NNDmEuvHwEfyAb5pfMVbHg8kXkcZ8gOFVZMj
X-Gm-Gg: AY/fxX4SVPp0tLhVQRzo7zAgozLzZ4ZQOzf0sGWg/KNs3E/OrK37IgtPILcIvk2vt/A
	jxoE3+YmeIxN/nnzA21JQA6+kNJHb+nyNuDqj90ddRs9UPFfqp6kKo1/oksZt/4CvfYoMHJJuF8
	slH0XyJ6BDWtoUvyKJ6hyATOTXLK+dM+9qL0oTa6HICM8AUoPLn/LWNqTtgkNlsGLUHfN8EXSOe
	jLzvvKsJzMV4VH8WRP88TVPvY1vNZK4W2mtyBFgZ5TQ4Ia/ml2UpKVRT6MqsYIkyYFohb/zYkbc
	1i7AhyZEvifp8YM73TrfTV+zDvHBal+VpoeD0cTyy8kncbaSh+rfBLDL3avOrLSaiZ6fWcKDllK
	a1JoHWo452msjlldZKmWWAxetBO5qfrwuw682Szg26NMq3bFeqdJgL75y9NHwq/WKc+e72Gpobr
	zpr9bIjftEMnCP/IKELhGLNJXBg0Cj
X-Google-Smtp-Source: AGHT+IEPT5aPUpoHztItAAxw5/kNiJ6H6PPz/6Ej+2vFAAV/ShyUhK56drVY1oaT/Hz1ODbBqqRPvA==
X-Received: by 2002:a05:7301:4e47:b0:2ac:1958:f7b9 with SMTP id 5a478bee46e88-2ac1958fe51mr1638788eec.5.1765466416262;
        Thu, 11 Dec 2025 07:20:16 -0800 (PST)
Received: from smtpclient.apple ([76.88.87.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac191ba0fesm6103947eec.3.2025.12.11.07.20.15
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 07:20:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Anthony Rossomano <trossoma2@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Partition incorrectly identified as LUKS
Message-Id: <4C27EBF0-B758-4528-903C-9199916EB6F9@gmail.com>
Date: Thu, 11 Dec 2025 07:20:04 -0800
To: util-linux@vger.kernel.org
X-Mailer: iPhone Mail (23B85)

OS: AlmaLinux 8.9
util-linux-2.32.1-44.el8_9.1.x86_64

LUKS image is stored on XFS partition. When secondary LUKS signature winds u=
p at one of the offsets checked by libblkid partition then we have the side e=
ffects of partition reported with crypto_LUKS fstype, no by-label link creat=
ed by udev, mount requires fstype, etc

Don=E2=80=99t think that this has been addressed upstream but need to confir=
m.

Also looking for input about possible workarounds.=
