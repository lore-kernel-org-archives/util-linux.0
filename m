Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:61130 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678Ab3FRIlq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Jun 2013 04:41:46 -0400
Date: Tue, 18 Jun 2013 10:41:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Richard Weinberger <richard@nod.at>
Cc: ebiederm@xmission.com, util-linux@vger.kernel.org, davidlohr.bueso@hp.com
Subject: Re: [PATCH] nsenter: Allow selecting the uid and gid to be used in
 the entered userns
Message-ID: <20130618084135.GA29243@x2.net.home>
References: <1366917100-10581-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366917100-10581-1-git-send-email-richard@nod.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 25, 2013 at 09:11:40PM +0200, Richard Weinberger wrote:
>  sys-utils/nsenter.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

 Applied (with some changes), thanks.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
