Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:51485 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757455Ab2CEUol convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Mar 2012 15:44:41 -0500
Received: by obbuo6 with SMTP id uo6so4549464obb.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 12:44:40 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1330976334-10751-14-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
	<1330976334-10751-1-git-send-email-kerolasa@iki.fi>
	<1330976334-10751-14-git-send-email-kerolasa@iki.fi>
Date: Mon, 5 Mar 2012 21:44:40 +0100
Message-ID: <CAG27Bk0=y3o8naGbDJ_1UgJc8eotMfgLHATvoqjc0Zs+Cn6Q+A@mail.gmail.com>
Subject: Re: [PATCH 13/17] pathnames: clean up various user database paths
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 5, 2012 at 20:38, Sami Kerola <kerolasa@iki.fi> wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  include/pathnames.h            |   17 ++++-------------
>  login-utils/setpwnam.h         |    2 +-
>  tests/expected/paths/built-in  |    8 --------
>  tests/helpers/test_pathnames.c |    8 --------
>  4 files changed, 5 insertions(+), 30 deletions(-)

The original patch is incomplete. I missed a line removal below. Patch
is fixed in my git.

diff --git a/tests/helpers/test_pathnames.c b/tests/helpers/test_pathnames.c
index 962fe5a..ebd5249 100644
--- a/tests/helpers/test_pathnames.c
+++ b/tests/helpers/test_pathnames.c
@@ -54,7 +54,6 @@ struct hlpPath paths[] =
 	DEF_HLPPATH(_PATH_GSHADOW),
 	DEF_HLPPATH(_PATH_GROUP),
 	DEF_HLPPATH(_PATH_SHADOW_PASSWD),
-	DEF_HLPPATH(_PATH_SHADOW_GROUP),
 	DEF_HLPPATH(_PATH_WORDS),
 	DEF_HLPPATH(_PATH_WORDS_ALT),
 	DEF_HLPPATH(_PATH_UMOUNT),

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
