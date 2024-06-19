Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC67E0EA
	for <util-linux@vger.kernel.org>; Wed, 19 Jun 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785203; cv=none; b=NTdOuqzHzETLBnP3x64OVDvXxNduC5WAsjwSTF0ESaCt8u0kOPWxz9/cBcOVfjuAcq2RkiHSa0/h4qe6ftkzcOiTQXnGOsC4MpQdJZw/vsN9z3HSvGOEBZoy43HDzcW8Gg6NY+u/yWP0XnDP4c1ZGznWa3aqw+b7rLxC3EcR/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785203; c=relaxed/simple;
	bh=Jx2EVBeZB18zwZDplLplUDUBBBslw8efkhsIuDi8dVk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yfu+qRPThlIHz5qODwgLaGzCPZjIw5tPqMLNXJYoVPjA8k6LFxpzqM1ivBZ9Gb4s1ceuRj4mGfrxZyWOSgLPVHR7T+KVxqq3PeQa7KKSXxb2dNoimy8K++h3GfLhIz6k/IWr4TIK6UtVPjy8uWFRSmeMAbl34cTNkhnZoiEM/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N3sNa-1sSbxA2JF2-00wmQp; Wed, 19
 Jun 2024 10:19:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 0/2] unshare: manage binfmt_misc mounts
Date: Wed, 19 Jun 2024 10:19:49 +0200
Message-ID: <20240619081951.656640-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ya8GBOjTRH8lKd6TzNM3v05mLl2kQ780WFosOMGARGRLqPfJ0tn
 HZnSTktvAIeFBKdf/+hQGiZtCsNEaN2CN4NvanflIb5/U4yJPrReDsOElohWg+8a/BWj1wL
 dUqksiBpF91oJhufNURKpbomsskbcPtwG/k3/owwrQ0wLXq0K0NeIuzLuTfMohUXft6osab
 oIoNgNq3Z8E0Ee4oIoSAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WK4UoldBbNs=;Fc2J3cG7NZ7YpHZuPcqfkYCptdD
 YGemzJe87chnlabsMMLJ8/jrnZwZ6omXtyUvA7Qv8MZBIM3LhBQU7nN0J0k/ImkmVPB7j12Cq
 6wePe79LEHvEP/rQVhoVTUwr+Lu3M2Vj8YtaBDoDxXk6Dl2GYN2A/cg+2xYQGSM6tYS1J2DbO
 Z9N05wv635ZpodbBl3xMUKW8Y9fUs0J0zdF0dw1Ds0JfCnEfkCucoyFMCNp5IMbpYHEbIrkWm
 nAn6gGT03CC+6hetESNb8WvXYxXxKtj8cZlAuRlEgrbRiy2Fo67t4f/L4jZj90Co+1IzKY2gb
 WCFOTP43UFCebN82EFkB/KT7h+ioDderMDvubs8Gow2xJ2Z2O0jr0m0KJAR/C3USnziC1PGbA
 9iEQpNzXv0zXIGw5jbKh8MVzoGbmz7TbKgc+/GXZBpax66x5H1fiM0b5KTHeW1NnLJJbs2oX/
 wKImTKdnHXr8GiBLVIYUtIa7lTHI87Ys/IODT6Y+X4ylzGb0/8TeDfpIW1g9q+P9AMIAa7WvQ
 aHSPqkXcMFLSz0zVxBIUkPKqD2KvVjCUYbsogngsYHATLdS7azeg/W+doeFpZhEAkVKM77RU8
 yXCThKaRiLQ8tT5a1nj5ZH1+GaMegt8sYM5D5H8NF4mU/VtX9ynFIUJBQ7YTo9J7imgzI+nMo
 87z0COKV0stLuSvpwHkcYZtW8TNgCiBWPaD0/mvU+pBUrXHJfp9BFoAIPd07fsegaHF7iBezC
 AaZli1KC/VEUe8xgDaZr1S4PLK+/WfUHeptWoch19w6oZwkUk2dZt4=

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

v3:
  - update man page
  - load interpreter before the chroot only if there is the a chroot

v2:
  - use <binfmt_mnt>/register rather than _PATH_PROC_BINFMT_MISC_REGISTER to load the interpreter

Laurent Vivier (2):
  unshare: mount binfmt_misc
  unshare: load binfmt_misc interpreter

 include/pathnames.h      |  1 +
 sys-utils/unshare.1.adoc | 21 ++++++++++++
 sys-utils/unshare.c      | 71 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 1 deletion(-)

-- 
2.45.2

