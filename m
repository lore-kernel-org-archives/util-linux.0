Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49351 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754351AbbAZKmR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 05:42:17 -0500
Date: Mon, 26 Jan 2015 11:42:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Yuri Chornoivan <yurchor@gmail.com>
Cc: util-linux@vger.kernel.org, Yuri Chornoivan <yurchor@ukr.net>
Subject: Re: [PATCH] Fix various minor typos
Message-ID: <20150126104211.GI6354@x2.net.home>
References: <1422083931-24410-1-git-send-email-yurchor@ukr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422083931-24410-1-git-send-email-yurchor@ukr.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 24, 2015 at 09:18:51AM +0200, Yuri Chornoivan wrote:
>  Documentation/releases/v2.25-ReleaseNotes |  2 +-
>  disk-utils/fdisk-list.c                   |  6 +++---
>  disk-utils/sfdisk.c                       | 24 ++++++++++++------------
>  libfdisk/src/gpt.c                        |  2 +-
>  misc-utils/whereis.c                      |  2 +-
>  5 files changed, 18 insertions(+), 18 deletions(-)

Applied, thanks.

> diff --git a/Documentation/releases/v2.25-ReleaseNotes b/Documentation/releases/v2.25-ReleaseNotes
> index f4faf7a..d9b9ce4 100644
> --- a/Documentation/releases/v2.25-ReleaseNotes
> +++ b/Documentation/releases/v2.25-ReleaseNotes
> @@ -203,7 +203,7 @@ cal:
>     - mention where Gregorian reformation happen in September 1752  [Sami Kerola]
>     - remove optional from short arg -w  [Tommi Kyntola]
>     - remove unnecessary static variables  [Sami Kerola]
> -   - remove unnused structure and definition  [Sami Kerola]
> +   - remove unused structure and definition  [Sami Kerola]

Benno is right, this is generated and the change will lost after
ReleaseNotes update for -rc2.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
