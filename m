Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43130 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbaJAK33 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 06:29:29 -0400
Date: Wed, 1 Oct 2014 12:29:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 20/23] libsmartcols: add explicit column flags default
Message-ID: <20141001102918.GN26272@x2.net.home>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
 <1411933916-30576-21-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411933916-30576-21-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 28, 2014 at 08:51:53PM +0100, Sami Kerola wrote:
> Useful when initializing without any specific action in mind, or when
> reseting flags later on.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  libsmartcols/src/libsmartcols.h.in | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/libsmartcols/src/libsmartcols.h.in b/libsmartcols/src/libsmartcols.h.in
> index e612560..1699a4a 100644
> --- a/libsmartcols/src/libsmartcols.h.in
> +++ b/libsmartcols/src/libsmartcols.h.in
> @@ -78,6 +78,7 @@ enum {
>   * Column flags
>   */
>  enum {
> +	SCOLS_FL_DEFAULT     = 0,	   /* use default functionality */

 it would be better to use

    SCOLS_FL_NONE

>  	SCOLS_FL_TRUNC       = (1 << 0),   /* truncate fields data if necessary */
>  	SCOLS_FL_TREE        = (1 << 1),   /* use tree "ascii art" */
>  	SCOLS_FL_RIGHT	     = (1 << 2),   /* align to the right */


    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
