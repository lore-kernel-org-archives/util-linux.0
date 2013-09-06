Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:41860 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab3IFSLx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 6 Sep 2013 14:11:53 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm2so1251673wib.4
        for <util-linux@vger.kernel.org>; Fri, 06 Sep 2013 11:11:52 -0700 (PDT)
From: Gabriel de Perthuis <g2p.code@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Rolf Fokkens <rolf@rolffokkens.nl>, util-linux@vger.kernel.org,
        Gabriel de Perthuis <g2p.code@gmail.com>
Subject: [PATCH 0/2] Deal with incorrect checksums
Date: Fri,  6 Sep 2013 20:11:27 +0200
Message-Id: <1378491089-1135-1-git-send-email-g2p.code@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is to avoid exposing backend devices that are supposed
to be used through a stacked device.

Good magic / bad csum superblocks are still exposed to wipefs.

Prompted by the bcache patch.

Can be pulled from https://github.com/g2p/util-linux/commits

Gabriel de Perthuis (2):
  libblkid: Abort after an incorrect checksum
  wipefs: Also wipe superblocks with bad checksums

 libblkid/src/blkid.h.in                 | 1 +
 libblkid/src/blkidP.h                   | 6 ++++++
 libblkid/src/probe.c                    | 7 +++++++
 libblkid/src/superblocks/lvm.c          | 9 ++++++---
 libblkid/src/superblocks/nilfs.c        | 3 +--
 libblkid/src/superblocks/silicon_raid.c | 7 ++++---
 libblkid/src/superblocks/superblocks.c  | 9 +++++++++
 libblkid/src/superblocks/via_raid.c     | 4 ++--
 misc-utils/wipefs.c                     | 3 ++-
 9 files changed, 38 insertions(+), 11 deletions(-)

-- 
1.8.4.25.g05e4ae6

