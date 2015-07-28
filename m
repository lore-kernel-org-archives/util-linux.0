Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37998 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbbG1Xtv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Jul 2015 19:49:51 -0400
Date: Wed, 29 Jul 2015 01:49:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Robert Urban <urban@unix-beratung.de>
Cc: util-linux@vger.kernel.org
Subject: Re: Feature request: write out buffer to typescript on SIGTERM
Message-ID: <20150728234948.GH6865@ws.net.home>
References: <55B6B370.5020602@unix-beratung.de>
 <20150728083932.GG6865@ws.net.home>
 <55B7DA01.6080204@unix-beratung.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B7DA01.6080204@unix-beratung.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 28, 2015 at 09:37:37PM +0200, Robert Urban wrote:
> Um, I cloned git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
> yesterday, built it, and tested it. If I send it SIGTERM, it prints "Terminated"
> and disappears. The typescript file is empty.

Try it again :-)
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
