Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54764 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab1FNMYb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jun 2011 08:24:31 -0400
Date: Tue, 14 Jun 2011 14:24:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Josiah Worcester <josiahw@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] Build with musl libc
Message-ID: <20110614122427.GH14293@nb.net.home>
References: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 08, 2011 at 04:52:42PM -0600, Josiah Worcester wrote:
>  fdisk/fdiskbsdlabel.c        |   34 +++++++++++++++++-----------------
>  fsck/fsck.c                  |    2 +-
>  hwclock/cmos.c               |    7 ++++++-
>  lib/tt.c                     |    2 +-
>  login-utils/checktty.c       |    7 +++++--
>  sys-utils/flock.c            |    2 ++
>  tests/helpers/test_sysinfo.c |    2 +-
>  text-utils/display.c         |   32 ++++++++++++++++----------------
>  text-utils/hexdump.h         |    4 ++--
>  9 files changed, 51 insertions(+), 41 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
