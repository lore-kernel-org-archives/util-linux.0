Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8BA7346F
	for <util-linux@vger.kernel.org>; Tue, 11 Jun 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095400; cv=none; b=jCjHm8iIQ24foWA+CQARNZ6J26HLMNnN9b2VtsfKoR3o2PkiNX37pxtZnThD+We+vqvI5e+GRZcBViir83Uh5d5njl9PnRIUUlfVQcNV2aR68nmx+Vu8BIDqiNdLp1aH/Y507I75IaBcjNQTqfHp+xRWfgeH4E1gG44gJ59O6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095400; c=relaxed/simple;
	bh=qB3h0LeaNFi+glvMFcls1D8tLKMCigQ8VeO6fqD3T44=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NL7UTJ8Cu10lBXV5fpiyj1ZsHUvK6tsvKr/dTLXgN5mky6bpMCwmZhBpMHpytzyJZOcTZV9zRJia3C1r7rYVgpMyDW0O+aLL/gl+2gmedMNQsO3BlhxLa5zhIh/WBf8uFd2OrgGvdCI/jdzpsvEtGqUcD1yv04b1VI0gqcgQreo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MzQwa-1sdAup1eTo-018JBg; Tue, 11
 Jun 2024 10:43:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 0/2] unshare: manage binfmt_misc mounts
Date: Tue, 11 Jun 2024 10:43:12 +0200
Message-ID: <20240611084314.183913-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YWGtk6rd+h++MgbgKHsAt8Lur+ULRzwnaE9bpAhP4mJLCW/8ulA
 RgvkzxPbIC8L1r3BLC9qHk9xWllj5MRjjpXM08GpZOEVd2YLGEC8Y59kYcnkon6WxCp/UKk
 B2dN6t90Z5d3+U88lV6HXYcwi9xA0lS3zUQCzw6FoMIJPORW+QKp8UO8l2NQS34qD0L6x+n
 a7PUNclG98u3XJd6mrJwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sLqMm7flJIU=;El6DwtHXIZS43/DHFvdl3ALaoER
 iDBpKvd4Z+O5zOWGj0EFv7+sr/LzWalg/A81sqydUAuuBt5Nrb3fWJxULdJzz6PntHAcEXH9G
 /UAmnzWhiEUoHwo9ZQAN2f/Jw3/bP2bS2z0sJJm2IdWlDiJgmd0xxCidVzUtYSWbBqxcQaGRO
 hjOsN3TG6WWTuvy483L9tlP+plZvMBrVzFCRCpwAhaQ41EsylGdXqz3dv7o2rTXMsya4KmX2H
 CDWiCGjbfhPe9UhnX3Gk4x4l+8HyUnqYXwqravs42MlunyJgi2D5CBJd6qhjHmUa3VXKXf8O3
 FXnO/sLxF4TB2y8qAKv7Ms8n0ZwfonjsG/JrsYmvUWuJyUBLyLy+LRKZg/nhbNfIn5F0oh1ki
 oRJ+MkRxO87oi+Xi3CVnBr5gMvi0sxufaXHZ54rwMmYxXNs+rV0EG58qT79Q13ZanNs+foPXk
 7YvRDw0Vjrw2KuIvu4zaHC/WRCsHiAavIULGqr4lg8D7J8XBRlajYtpFxAoZEgONNIzjfOoK1
 E34eyxNvBdhr1M/FPUumVw8pBG4LUQ64mSA7nT7U2Q7nYskI9d+R7Eq1NwybVbG9hZCCJ7it1
 yamygtKEnJEbod8745/axZlzmEijOET79CN0wgYyIS8VbdTJwI/GQDREdweGRv0dPvfqlL1P0
 LQT38/f0PsYp7nFL6el4gVSXPrkrhnws6d8iJJ9lwUzF2o8i6BWhdHel4vB4+K05bc+eUmC5R
 4Z8qOvHKL3yGliNMhs8RVMGdDvPfKg/0AYwPRfUHmwHA9ILnoC3xyo=

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

v2:
  - use <binfmt_mnt>/register rather than _PATH_PROC_BINFMT_MISC_REGISTER to load the interpreter

Laurent Vivier (2):
  unshare: mount binfmt_misc
  unshare: load binfmt_misc interpreter

 include/pathnames.h      |  1 +
 sys-utils/unshare.1.adoc | 13 ++++++++
 sys-utils/unshare.c      | 71 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 84 insertions(+), 1 deletion(-)

-- 
2.45.2

