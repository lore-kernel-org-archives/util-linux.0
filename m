Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37892 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298Ab3AQMej (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Jan 2013 07:34:39 -0500
Date: Thu, 17 Jan 2013 13:34:30 +0100
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH] nsenter: new command (light wrapper around setns)
Message-ID: <20130117123430.GA3096@x2.net.home>
References: <876234812z.fsf@xmission.com>
 <20130111161320.GA16206@x2.net.home>
 <87fw27jq29.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fw27jq29.fsf_-_@xmission.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 11, 2013 at 02:46:38PM -0800, Eric W. Biederman wrote:
>  configure.ac            |   11 ++
>  sys-utils/Makemodule.am |    7 +
>  sys-utils/nsenter.1     |  101 +++++++++++++++++
>  sys-utils/nsenter.c     |  286 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 405 insertions(+), 0 deletions(-)
>  create mode 100644 sys-utils/nsenter.1
>  create mode 100644 sys-utils/nsenter.c

 Applied (and setns() stuff reverted from unshare), thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
