Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44330 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab1JQJQ1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Oct 2011 05:16:27 -0400
Date: Mon, 17 Oct 2011 11:16:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lib/strutils: add default value to parse_range()
Message-ID: <20111017091623.GM9667@nb.net.home>
References: <1318624335.1923.14.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318624335.1923.14.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 14, 2011 at 04:32:15PM -0400, Davidlohr Bueso wrote:
>  include/strutils.h |    2 +-
>  lib/strutils.c     |    7 ++++---
>  partx/partx.c      |    2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
