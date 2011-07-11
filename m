Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34398 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab1GKKko (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jul 2011 06:40:44 -0400
Date: Mon, 11 Jul 2011 12:40:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: add support for books
Message-ID: <20110711104035.GH5214@nb.net.home>
References: <20110705112909.GA3450@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110705112909.GA3450@osiris.boeblingen.de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 05, 2011 at 01:29:10PM +0200, Heiko Carstens wrote:
> This patch adds support for books in cpu topology output. 

 Thanks!

> Please note that I assume that other programs that get fed by the
> output of lscpu actually parse the last comment line and react in a
> sane way if new entries appear in the cpu list.

 Never assume anything :-)

> Also the readable output is changed from
> "CPU socket(s):" to "Socket(s) per book:" or simply "Socket(s):" in the
> absence of books.

 You're right, the "Socket(s)" is probably better. Unfortunately it's
 not backwardly compatible (for people who use "lscpu | grep ..."), so
 I'll add a note to the ReleaseNotes...

> @@ -732,7 +750,7 @@ print_parsable(struct lscpu_desc *desc)
>  	"# The following is the parsable format, which can be fed to other\n"
>  	"# programs. Each different item in every column has an unique ID\n"
>  	"# starting from zero.\n"
> -	"# CPU,Core,Socket,Node"));
> +	"# CPU,Core,Socket,Book,Node"));

 It would be better to use

    # CPU,Core,Socket,Node,Book

 to keep it usable for stupid scripts where the header is not parsed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
