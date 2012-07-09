Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44529 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755205Ab2GIPFi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Jul 2012 11:05:38 -0400
Date: Mon, 9 Jul 2012 17:05:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Sami Kerola <kerolasa@iki.fi>, kerolasa@gmail.com
Subject: Re: [PATCH] Fix typos found by misspellings
Message-ID: <20120709150521.GC21787@x2.net.home>
References: <4FEAF265.5040000@bernhard-voelker.de>
 <4FEB0AF8.2070109@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FEB0AF8.2070109@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 27, 2012 at 03:30:32PM +0200, Bernhard Voelker wrote:
>  Documentation/releases/v2.18-ReleaseNotes |    2 +-
>  NEWS                                      |    2 +-
>  config/texinfo.tex                        |    6 +++---

 I have removed this file. It seems like an unused legacy.

>  libmount/src/context.c                    |    2 +-
>  libmount/src/fs.c                         |    2 +-
>  login-utils/login.c                       |    4 ++--
>  login-utils/su.1                          |    2 +-
>  sys-utils/chcpu.c                         |    4 ++--
>  8 files changed, 12 insertions(+), 12 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
