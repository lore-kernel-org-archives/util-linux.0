Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34404 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbbCCL44 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Mar 2015 06:56:56 -0500
Date: Tue, 3 Mar 2015 12:56:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/12] script: add struct script_control and remove
 global variables
Message-ID: <20150303115645.GQ8046@ws.net.home>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
 <1424616169-693-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616169-693-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:42:39PM +0000, Sami Kerola wrote:
>  int main(int argc, char **argv)
...
> +	if (optarg && !(ctl.timingfp = fopen(optarg, "w")))
...

> +	if ((ctl.typescriptfp = fopen(ctl.fname, ctl.aflg ? "a" : "w")) == NULL) {

 Does it make sense to open the files in main() and then later close
 it in doshell()? What about add "typescrip" and "timing" filenames
 to the control structs and open the files later in do_io() ?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
