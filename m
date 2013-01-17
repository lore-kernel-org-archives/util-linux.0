Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18499 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab3AQMw1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Jan 2013 07:52:27 -0500
Date: Thu, 17 Jan 2013 13:35:03 +0100
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH] unshare: Add support for the pid and user namespaces
Message-ID: <20130117123503.GB3096@x2.net.home>
References: <876234812z.fsf@xmission.com>
 <20130111161320.GA16206@x2.net.home>
 <8738y7jpqp.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8738y7jpqp.fsf_-_@xmission.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 11, 2013 at 02:53:34PM -0800, Eric W. Biederman wrote:
>  sys-utils/unshare.1 |   19 +++++++++++++++----
>  sys-utils/unshare.c |   27 ++++++++++++++++++---------
>  2 files changed, 33 insertions(+), 13 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
