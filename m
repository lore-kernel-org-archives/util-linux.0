Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932728Ab2AEQa2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Jan 2012 11:30:28 -0500
Date: Thu, 5 Jan 2012 17:30:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lscpu: fix compiler warnings
Message-ID: <20120105163026.GE11073@x2.net.home>
References: <1325716139.7056.1.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325716139.7056.1.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 04, 2012 at 11:28:59PM +0100, Davidlohr Bueso wrote:
>  sys-utils/lscpu.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

 Good catch. Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
