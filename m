Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab1I0NHe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Sep 2011 09:07:34 -0400
Date: Tue, 27 Sep 2011 15:07:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] libmount: fix use of logical '&&' with constant
	operand
Message-ID: <20110927130731.GD19994@nb.net.home>
References: <1316096266-14692-1-git-send-email-cosoleto@gmail.com> <1316096266-14692-2-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316096266-14692-2-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 15, 2011 at 04:17:46PM +0200, Francesco Cosoleto wrote:
>  libmount/src/context_loopdev.c |    2 +-
>  libmount/src/context_mount.c   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
