Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22749 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753873AbaAFLw2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Jan 2014 06:52:28 -0500
Date: Mon, 6 Jan 2014 12:52:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: libmount: skip tabfiles-py when pylibmount is
 disabled
Message-ID: <20140106115226.GE14933@x2.net.home>
References: <1387756892-25074-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387756892-25074-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 22, 2013 at 07:01:32PM -0500, Mike Frysinger wrote:
> The default configure disables python support, so this test fails by
> default.  Add a simple check for module availability.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  tests/ts/libmount/tabfiles-py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/ts/libmount/tabfiles-py b/tests/ts/libmount/tabfiles-py
> index 64e8911..b89fb5b 100755
> --- a/tests/ts/libmount/tabfiles-py
> +++ b/tests/ts/libmount/tabfiles-py
> @@ -12,6 +12,8 @@ ts_init_py libmount
>  PYDBG="$PYTHON -m pdb"
>  TESTPROG="$TS_HELPER_PYLIBMOUNT_TAB"
>  
> +$PYTHON -c 'import libmount' 2>/dev/null || ts_skip "pylibmount not compiled"
> +

Hmm... in function ts_init_py() is

    [ -f "$TS_TOPDIR/../py${LIBNAME}.la" ] || ts_skip "py${LIBNAME} not compiled"

and it works for me:

    $ ./ts/libmount/tabfiles-py te     libmount: tab files-py... IGNORE (pylibmount not compiled)

fixed by:

   commit f48145b500cc214746ae5dca997098ad22f41ead
   Author: Karel Zak <kzak@redhat.com>
   Date:   Thu Oct 3 16:20:38 2013 +0200

    testsL fix py<libname> check


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
