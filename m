Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42759 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbcDVJfo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Apr 2016 05:35:44 -0400
Date: Fri, 22 Apr 2016 11:35:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/5] getopt: fix memory leaks and integer overflows [ASAN
 & valgrind]
Message-ID: <20160422093542.q22msg25nc26nedp@ws.net.home>
References: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
 <1461098145-2988-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461098145-2988-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 19, 2016 at 09:35:45PM +0100, Sami Kerola wrote:
> The getopt(1) is short living command, and one could argue ensuring all
> allocations are freed at end of execution is waste of time.  There is a
> point in that, but making test-suite runs to be less noisy with ASAN is also
> nice as it encourages reading the errors when/if they happen.
> 
> Reviewed-by: Yuriy M. Kaminskiy <yumkam@gmail.com>
> Reviewed-by: Karel Zak <kzak@redhat.com>
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/getopt.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
> index 2cff2eb..dc2a976 100644
> --- a/misc-utils/getopt.c
> +++ b/misc-utils/getopt.c
> @@ -86,6 +86,7 @@ struct getopt_control {
>  	int long_options_length;	/* length of options array */
>  	int long_options_nr;		/* number of used elements in array */
>  	unsigned int
> +		free_name:1,		/* free up argv[0] after printout */

 I did a change to the code, it seems more elegant to keep pointer to
 the 'name' in the control struct than maintain free_name flag and
 call free(argv[0]).

    https://github.com/karelzak/util-linux/commit/e402d6d3b149c34faa5abd5a0cef8284b4ae1af3


  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
