Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] lscpu: add drawer support
Date: Tue, 14 Jun 2016 09:22:33 +0200
Message-Id: <1465888954-62716-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Hello Karel,

the recent IBM z13 machines added yet another cpu topology level which
is called 'drawer'. I'd like to have support for this within lscpu as
well. The kernel patch that makes the new sysfs interfaces available
will be merged during the next merge window. Therefore the first
kernel release that contains the required interfaces will be v4.8.

So this patch that adds support to lscpu comes early.

The two required kernel patches are currently available at

git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git

within the features branch:

    topology/sysfs: provide drawer id and siblings attributes
    s390/topology: add drawer scheduling domain level

(also part of linux-next).

Please consider this patch for inclusion.

Thanks,
Heiko

Heiko Carstens (1):
  lscpu: add drawer support

 sys-utils/lscpu.1 |  5 ++++-
 sys-utils/lscpu.c | 51 +++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 47 insertions(+), 9 deletions(-)

-- 
2.6.6
