Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23616 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798Ab2JBIDO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Oct 2012 04:03:14 -0400
Date: Tue, 2 Oct 2012 10:03:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sys-utils/ipcrm: avoid 'uninitialized' warning
Message-ID: <20121002080308.GA6877@x2.net.home>
References: <1346850721-27107-1-git-send-email-mail@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346850721-27107-1-git-send-email-mail@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 05, 2012 at 03:12:01PM +0200, Bernhard Voelker wrote:
> * sys-utils/ipcrm.c: Initialize what_all to ALL.

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
