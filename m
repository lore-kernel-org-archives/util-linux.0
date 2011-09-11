Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] lscpu: remove unneeded file
Date: Sun, 11 Sep 2011 08:23:35 +0200
Message-Id: <1315722215-4224-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

As noted by Sami I accidentally added a garbage file.
Just remove it again.

Cc: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 tests/ts/lscpu/bla.tar.gz |  Bin 2573 -> 0 bytes
 1 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 tests/ts/lscpu/bla.tar.gz

diff --git a/tests/ts/lscpu/bla.tar.gz b/tests/ts/lscpu/bla.tar.gz
deleted file mode 100644
index 9432cbd5e4cb843477b7e97c173ffbc28a8c24b0..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 2573
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
YdqM(ctoHev{vcn|aE>&j7BElkPcZb)mH+?%

-- 
1.7.5.4
