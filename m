Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3361 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932233Ab1I1Wka (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 28 Sep 2011 18:40:30 -0400
Date: Thu, 29 Sep 2011 00:40:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] ipcrm: add static keyword to some functions
Message-ID: <20110928224025.GI19994@nb.net.home>
References: <1317219931-20496-1-git-send-email-cosoleto@gmail.com> <1317219931-20496-3-git-send-email-cosoleto@gmail.com> <1317219931-20496-1-git-send-email-cosoleto@gmail.com> <1317219931-20496-2-git-send-email-cosoleto@gmail.com> <1317219931-20496-1-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317219931-20496-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 28, 2011 at 04:25:29PM +0200, Francesco Cosoleto wrote:
> Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
> ---
>  sys-utils/ipcrm.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

On Wed, Sep 28, 2011 at 04:25:30PM +0200, Francesco Cosoleto wrote:
> Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
> ---
>  sys-utils/ipcrm.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

On Wed, Sep 28, 2011 at 04:25:31PM +0200, Francesco Cosoleto wrote:
> This makes error messages print 'id' instead of 'key' using id options.
> 
> Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
> ---
>  sys-utils/ipcrm.c |   23 ++++++++---------------
>  1 files changed, 8 insertions(+), 15 deletions(-)

 All applied. Thanks for review!


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
