Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:61855 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbcCWJkr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 Mar 2016 05:40:47 -0400
Received: from tenfore.site ([77.12.236.151]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M8mCe-1ad8Rb2NrA-00CABd for
 <util-linux@vger.kernel.org>; Wed, 23 Mar 2016 10:40:43 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] setarch: test improvements
Date: Wed, 23 Mar 2016 10:40:42 +0100
References: <1458665593-7963-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458665593-7963-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603231040.42461.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 22 March 2016, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> As discussed this patch-set tries to fix tests if --uname-2.6 is not
> supported and to debug systems where --uname-2.6 even segfaults.
>
> Ruediger Meier (3):
>   build-sys: ignore vim .swp files
>   setarch: add "exec" message to --verbose
>   tests: improve setarch tests regarding --uname-2.6 issues
>
>  .gitignore                  |  1 +
>  sys-utils/setarch.c         |  7 ++++--
>  tests/expected/misc/setarch | 19 +++++++++++++++-
>  tests/ts/misc/setarch       | 54
> +++++++++++++++++++++++++++++++++++++-------- 4 files changed, 69
> insertions(+), 12 deletions(-)

Please don't merge yet. I've made some cosmetical updates and push it 
later on github after all tests are finished again.


