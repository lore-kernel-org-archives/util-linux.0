Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756346AbdGCO3d (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 10:29:33 -0400
Date: Mon, 3 Jul 2017 16:29:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/6] path: add some standard functions
Message-ID: <20170703142926.czaqja7if3vej77a@ws.net.home>
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
 <1499082781-16968-3-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499082781-16968-3-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 03, 2017 at 01:52:57PM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  include/path.h | 15 +++++++++++++++
>  lib/path.c     | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/include/path.h b/include/path.h
> index ae36d7f..30c1133 100644
> --- a/include/path.h
> +++ b/include/path.h
> @@ -3,6 +3,11 @@
>  
>  #include <stdio.h>
>  #include <stdint.h>
> +#include <dirent.h>
> +
> +/* Check your code: Absolute paths must be used with path_* functions! */
> +#define PATH_REQUIRE_RELATIVE(path) \
> +	assert( *path != '/' )

 #define assert_abs_path

or something else with "assert" :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
