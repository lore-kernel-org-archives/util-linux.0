Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 0/6] more lscpu updates
Date: Wed, 22 Jun 2016 09:25:55 +0200
Message-Id: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Hello Karel,

I have a couple of additional lscpu updates which are on top of the
two drawer patches which I sent already. Given that you didn't apply
them yet, I could also merge them with this series and resend.

Please let me know.

Thanks,
Heiko

Heiko Carstens (6):
  lscpu: fix typo in summary output
  lscpu: show static and dynamic MHz (s390)
  lscpu: show machine type (s390)
  lscpu: show additional caches (s390)
  lscpu: update s390-lpar-drawer testcase
  lscpu: fix MMHZ column entry within man page

 sys-utils/lscpu.1                            |   9 ++-
 sys-utils/lscpu.c                            |  92 ++++++++++++++++++++++++++-
 tests/expected/lscpu/lscpu-s390-kvm          |   1 +
 tests/expected/lscpu/lscpu-s390-lpar         |   1 +
 tests/expected/lscpu/lscpu-s390-lpar-drawer  |  10 ++-
 tests/expected/lscpu/lscpu-s390-zvm          |   1 +
 tests/ts/lscpu/dumps/s390-lpar-drawer.tar.gz | Bin 18125 -> 18131 bytes
 7 files changed, 107 insertions(+), 7 deletions(-)

-- 
2.6.6
