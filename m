Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65232 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab2FOL0t (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jun 2012 07:26:49 -0400
Date: Fri, 15 Jun 2012 13:26:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] partx: use -s option for default output
Message-ID: <20120615112645.GA9266@x2.net.home>
References: <1339505406.17574.1.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339505406.17574.1.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 12, 2012 at 02:50:06PM +0200, Davidlohr Bueso wrote:
> It's been around a year and a half now that partx was rewritten, 
> and the legacy output should no longer be default.
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  partx/partx.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)

 Applied, all hate from users will be redirected to mailbox :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
