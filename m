Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6B1E498
	for <util-linux@vger.kernel.org>; Mon, 10 Jun 2024 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041147; cv=none; b=ePTCjgBRTM4MYob1rQftLE24k3PW8dsndENJn8pfc8U5qfXU029fMsNnmWS0o40dqq0e+4s3Utw0QEhTpUK+On7iAsEidD+U9ovnCjb6A+BlyBjTp9ctw7JGkJDsYxXY4B6uqgjb69OCf9wmImPDHuGUQF+/f3SVTzMbVBUkEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041147; c=relaxed/simple;
	bh=zY++lof2csJdX19fR+I/hCtX4uwL3aKt81rf5JEW8/g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u18b+1J59UQX1rV5dIyetu+LWdsuU61+SEmZYRvsSVV0cmMbuIMb/W4mA9JV1ylAUpOfe05GIzO+erTDL9mvArbKzZUBNTtXnNMPYUtZrBbMt9spS7vUlk+/noD4aqGKP76t44LUsH5D46lTw2D31r/J6A9iWxHwCPmx8O4jg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N3Kc6-1sP96C2Txq-015lgR; Mon, 10
 Jun 2024 19:33:50 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 0/2] unshare: manage binfmt_misc mounts
Date: Mon, 10 Jun 2024 19:33:47 +0200
Message-ID: <20240610173349.115913-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X5gVhCRU0Sw1F9N0Z0F3PTFR4U/b6si/YnFcAqaAlK+P6VbvtL2
 BAplpCO4nviZaXRWu7WYNoJdvB0ePhxkwvrcgNLPOwTdgFIWrF7pJXlySYf0OMkwFTQ/dUq
 nksVIUbC340Z4B1TcWR8PMSMDr3o43Vuqv2wtYncQkRapjlRR0Eg90DQuj5qlMDM7npXlyr
 nnndy51HrMa1iqIORRelw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iXMjhc0Fyfc=;p+BUq/uThhW+GgngZbNxoVSi+Xp
 56uujuy2SKB5CbLYzBuYjMBOciesLrOThpM19RwP5Bn+Y2IwmnyoNXedaBOD6KPKguI4cQF8I
 U1YfXtf7S0r7KYUYZZs1GvKjg1vMPt9Iwv/0xxr6ZthITv5TjF56Zc5HauzE3CyVChK6AuS09
 TjXCv8CaZYDyOK0iUeBRHUGBTj/Xuv1yGLnfc4XbSSXqPBuK+wGYPJUzuhrs+2c28/DAJqlHm
 EERcZEK4t4nwZvXzqHF45u3ipZvXqVUzsTcRXzHw+r86KVlkm849PAn9zZjvg+RfHwkEKn44U
 3v7hSbgVHrqJefmpF3OJq9+zMC/ltJbjWR1chqswK02KVE8bWr1ZpzTbV/p4wSz4J4mrDpfZi
 NpgsZC51DfqA0/qYfAAHqgN6oLDBbG7EVxfqXZBXWJAb1zWF0oLdWyWePaMKVpWd4diN7yrgd
 O1jH7RnFg7KFsd2B/GDH0LnTVaiAdv1DEXCH6mmZEzaABzecWQcBTgNjXP2A13SeyI/KCphWt
 i79nrXD965WaqUS2MFp+s2HM2zgqrwVbvN4mYYPcgwZGbE+gZmYzCVLQWNfPu6o/ZizeCnrww
 7FZLlJZFb9PwOZIH7BBxOjJAJ3lWWlfqsr3fOVM6JEV4vWHO1T3aImUeRoQa8TQLgr+MDuSiU
 6z6rczXkSLtlbxD0zWyvwo1ZArdy32VTrqf1Ec83PlRZu842BoxZO4Lcb8wD5V0i3jeYkgDzg
 PSj64PP9e4WZ98t0K2lwWkREq8DXBkGw/jEBbtBoLkt7EAR4aFabjA=

Since linux v6.7 and
commit 21ca59b365c0 ("binfmt_misc: enable sandboxed mounts"),
binfmt_misc can be mountable in a non-initial user namespace by
a non privileged user.

Extend unshare to manage it:

- add --mount-binfmt[=<dir>] to mount binfmt_misc filesystem, this
  results in clearing inherited interpreters from the previous namespace

- add -l, --load-interp <file> to load a binfmt_misc interpreter at startup.

  The interpreter is loaded from the initial fileystem if the 'F' flags is
  provided, otherwise from inside the new namespace
  This makes possible to start a chroot of another architecture without
  being root.

For instance:

  With 'F' flag, load the interpreter from the initial namespace:

    $ /bin/qemu-m68k-static --version
    qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
    Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
    $ unshare --map-root-user --fork --pid --load-interp=":qemu-m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\x00\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/bin/qemu-m68k-static:OCF" --root=chroot/m68k/sid
    # QEMU_VERSION= ls
    qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
    Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
    # /qemu-m68k  --version
    qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
    Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers

  Without 'F' flag, from inside the namespace:

    $ unshare --map-root-user --fork --pid --load-interp=":qemu-m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\x00\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/qemu-m68k:OC" --root=chroot/m68k/sid
    # QEMU_VERSION= ls
    qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
    Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers
    # /qemu-m68k  --version
    qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
    Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers

Laurent Vivier (2):
  unshare: mount binfmt_misc
  unshare: load binfmt_misc interpreter

 include/pathnames.h      |  2 ++
 sys-utils/unshare.1.adoc | 13 ++++++++
 sys-utils/unshare.c      | 64 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.45.2

