Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbbG1Ijf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Jul 2015 04:39:35 -0400
Date: Tue, 28 Jul 2015 10:39:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Robert Urban <urban@unix-beratung.de>
Cc: util-linux@vger.kernel.org
Subject: Re: Feature request: write out buffer to typescript on SIGTERM
Message-ID: <20150728083932.GG6865@ws.net.home>
References: <55B6B370.5020602@unix-beratung.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B6B370.5020602@unix-beratung.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 28, 2015 at 12:40:48AM +0200, Robert Urban wrote:
> is there a good reason why script does not flush it's typescript buffer when it
> gets a signal such as SIGTERM?

Not sure if you're talking about the current script(1) in git tree
(it's a new version) or about the original version.

I have improved sensitivity to the SIG{TERM,INT,QUIT}, now it properly
terminates the session and close the files. Previously it called
abort() (the version in git).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
