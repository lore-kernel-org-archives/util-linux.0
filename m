Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46877 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489Ab2HFNkf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Aug 2012 09:40:35 -0400
Date: Mon, 6 Aug 2012 15:40:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] pull: release preparations, umount.8 and vipw fix
Message-ID: <20120806134025.GC24621@x2.net.home>
References: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 04, 2012 at 09:33:35AM +0200, Sami Kerola wrote:
>  .gitignore                                |   4 +

 now we call test/run.sh only, so I have modified the gitignore patch.

>  Documentation/TODO                        |   9 --
>  Documentation/releases/v2.13-ReleaseNotes |   2 +-
>  Documentation/releases/v2.14-ReleaseNotes |  10 +-
>  Documentation/releases/v2.15-ReleaseNotes |  10 +-
>  Documentation/releases/v2.16-ReleaseNotes |   6 +-
>  Documentation/releases/v2.17-ReleaseNotes |  12 +-
>  Documentation/releases/v2.18-ReleaseNotes |  12 +-
>  NEWS                                      |  42 +++----
>  login-utils/vipw.c                        |  12 ++
>  sys-utils/Makemodule.am                   |   2 +-
>  sys-utils/umount.8                        | 175 ++++++++++++++++++++++++++++++
>  12 files changed, 239 insertions(+), 57 deletions(-)
>  create mode 100644 sys-utils/umount.8

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
