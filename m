Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47707 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901Ab3AQMgD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Jan 2013 07:36:03 -0500
Date: Thu, 17 Jan 2013 13:35:52 +0100
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 0/5] nsenter review comment fixes.
Message-ID: <20130117123552.GA3391@x2.net.home>
References: <876234812z.fsf@xmission.com>
 <20130111161320.GA16206@x2.net.home>
 <87fw27jq29.fsf_-_@xmission.com>
 <201301111845.16591.vapier@gentoo.org>
 <20130114082846.GA16421@x2.net.home>
 <87a9s8lkbq.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a9s8lkbq.fsf_-_@xmission.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 16, 2013 at 04:33:29PM -0800, Eric W. Biederman wrote:
>  include/namespace.h |   43 +++++++++++++++++++++++
>  sys-utils/nsenter.c |   94 +++++++++++++++++++++++----------------------------
>  sys-utils/unshare.c |   29 +---------------
>  3 files changed, 86 insertions(+), 80 deletions(-)
> 
> Eric W. Biederman (5):
>       nsenter: Enhance waiting for a child process
>       nsenter: Properly spell significant in a comment.
>       nsenter: Add const to declarations where possible.
>       nsenter: Replace a bare strtoul with strtoul_or_err
>       unshare,nsenter:  Move the old libc handling into a common header namespace.h

 All applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
