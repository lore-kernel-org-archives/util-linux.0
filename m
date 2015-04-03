Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59832 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbbDCJv0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Apr 2015 05:51:26 -0400
Date: Fri, 3 Apr 2015 11:51:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Jann Horn <jann@thejh.net>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux: wall security issue: unprivileged users can suppress
 banner
Message-ID: <20150403095124.GB3923@ws.net.home>
References: <20150327182707.GA9561@pc.thejh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150327182707.GA9561@pc.thejh.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 27, 2015 at 07:27:07PM +0100, Jann Horn wrote:
>  term-utils/wall.c | 80 ++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 47 insertions(+), 33 deletions(-)

 Applied with a little bit different implementation of the growing
 buffer.

     Thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
