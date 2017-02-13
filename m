Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbdBMNTa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Feb 2017 08:19:30 -0500
Date: Mon, 13 Feb 2017 14:19:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] pull: blkreset and blkreport polishing
Message-ID: <20170213131928.oqvmjt5oqyuasjn4@ws.net.home>
References: <20170211141052.26154-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170211141052.26154-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 11, 2017 at 02:10:49PM +0000, Sami Kerola wrote:
>  bash-completion/blkreset | 34 ++++++++++++++++++++++++++++++++++
>  sys-utils/blkreport.8    | 29 ++++++++++++++++++++++++++++-
>  sys-utils/blkreport.c    | 43 +++++++++++++++++--------------------------
>  sys-utils/blkreset.8     |  9 ++++-----
>  sys-utils/blkreset.c     | 17 ++++++++---------
>  5 files changed, 91 insertions(+), 41 deletions(-)
>  create mode 100755 bash-completion/blkreset

Thanks (and thanks for bash-completion).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
