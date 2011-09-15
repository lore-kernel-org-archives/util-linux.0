Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 0/6] more lscpu and chcpu changes
Date: Thu, 15 Sep 2011 08:52:28 +0200
Message-Id: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

just another batch of small changes to lscpu and chcpu.

The only thing that is planned that should follow are man page updates
to both tools. However I'd like to let a technical writer over here to
review and fix my changes before sending them.

Thanks,
Heiko

Heiko Carstens (6):
  lib,path: move path access functions from lscpu into lib/path.c
  chcpu: convert to use lib/path.c
  chcpu: provide better user feedback
  lscpu: fix -e output
  lscpu: add --offline option
  lscpu: stricter command line parsing

 include/path.h        |   17 ++++
 lib/path.c            |  217 ++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/Makefile.am |    6 +-
 sys-utils/chcpu.c     |  122 +++++++++++--------------
 sys-utils/lscpu.1     |    9 ++-
 sys-utils/lscpu.c     |  237 ++++++++++---------------------------------------
 6 files changed, 348 insertions(+), 260 deletions(-)
 create mode 100644 include/path.h
 create mode 100644 lib/path.c

-- 
1.7.5.4
