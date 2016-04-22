Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbcDVJcZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Apr 2016 05:32:25 -0400
Date: Fri, 22 Apr 2016 11:32:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] pull: couple clang scan-build fixes
Message-ID: <20160422093223.osczikneotrhfmw7@ws.net.home>
References: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 19, 2016 at 09:35:40PM +0100, Sami Kerola wrote:
>   build-sys: test functions does not return void
>   libmount: fix memory leak
>   setpwnam: fix memory leak
>   lib: avoid double free in loopdev.c
>   getopt: fix memory leaks and integer overflows [ASAN & valgrind]

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
