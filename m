Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15813 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443AbaIVLVa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 07:21:30 -0400
Date: Mon, 22 Sep 2014 13:21:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/5] libmount: only invoke loopcxt on linux
Message-ID: <20140922112121.GG5366@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411083397-8056-5-git-send-email-andreas@fatal.se>
 <1411083397-8056-3-git-send-email-andreas@fatal.se>
 <1411083397-8056-2-git-send-email-andreas@fatal.se>
 <1411083397-8056-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 19, 2014 at 01:36:33AM +0200, Andreas Henriksson wrote:
>  libmount/src/cache.c | 2 ++
>  libmount/src/tab.c   | 2 ++
>  2 files changed, 4 insertions(+)
 

On Fri, Sep 19, 2014 at 01:36:34AM +0200, Andreas Henriksson wrote:
>  libmount/src/Makemodule.am | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
 

On Fri, Sep 19, 2014 at 01:36:35AM +0200, Andreas Henriksson wrote:
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


On Fri, Sep 19, 2014 at 01:36:37AM +0200, Andreas Henriksson wrote:
>  misc-utils/logger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


 All applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
