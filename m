Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26571 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbaESJ5U (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 May 2014 05:57:20 -0400
Date: Mon, 19 May 2014 11:57:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/17] setterm: correct usage() bright color argument
Message-ID: <20140519095711.GJ26357@x2.net.home>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
 <1400421941-14244-12-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400421941-14244-12-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 18, 2014 at 03:05:35PM +0100, Sami Kerola wrote:
>  	fputs(_(" -foreground <default|black|blue|cyan|green|magenta|red|white|yellow>\n"), out);
>  	fputs(_(" -background <default|black|blue|cyan|green|magenta|red|white|yellow>\n"), out);
> -	fputs(_(" -ulcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
> -	fputs(_(" -ulcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
> -	fputs(_(" -hbcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
> -	fputs(_(" -hbcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
> +	fputs(_(" -ulcolor <bright> <black|blue|cyan|green|grey|magenta|red|white|yellow>\n"), out);
> +	fputs(_(" -ulcolor <bright> <black|blue|cyan|green|grey|magenta|red|white|yellow>\n"), out);
> +	fputs(_(" -hbcolor <bright> <black|blue|cyan|green|grey|magenta|red|white|yellow>\n"), out);
> +	fputs(_(" -hbcolor <bright> <black|blue|cyan|green|grey|magenta|red|white|yellow>\n"), out);

 too many duplicate information, it would be better to use 

     _(" -foreground <default>|<color>\n")
     ...
     _(" -hbcolor <bright> <color>\n")

 and describe below in usage():

    _(" <color> means black, blue, ...")


 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
