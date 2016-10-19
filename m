Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943959AbcJSPJa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 19 Oct 2016 11:09:30 -0400
Date: Wed, 19 Oct 2016 12:23:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Gustavo Zacarias <gustavo@zacarias.com.ar>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/crc32: prefix public functions
Message-ID: <20161019102357.c4lryfirgu6p3ybg@ws.net.home>
References: <1476132864-9526-1-git-send-email-gustavo@zacarias.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476132864-9526-1-git-send-email-gustavo@zacarias.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 10, 2016 at 05:54:24PM -0300, Gustavo Zacarias wrote:
>  disk-utils/fsck.cramfs.c         | 12 ++++++------
>  disk-utils/mkfs.cramfs.c         |  6 +++---
>  include/crc32.h                  |  4 ++--
>  lib/crc32.c                      |  4 ++--
>  libblkid/src/partitions/gpt.c    |  2 +-
>  libblkid/src/superblocks/nilfs.c |  6 +++---
>  libfdisk/src/gpt.c               |  2 +-
>  7 files changed, 18 insertions(+), 18 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
